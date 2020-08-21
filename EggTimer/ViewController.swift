//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    let eggTimes: [String:Float] = ["Soft": 15.0, "Medium": 17.0, "Hard": 12.0]
    var player: AVAudioPlayer!
    var secondsPassed: Float = 0.0
    var timer = Timer()
    var selectedBoilTime: Float = 0.0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        selectedBoilTime = eggTimes[hardness]!
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < selectedBoilTime {
            self.label.text = "Boiling..."
            secondsPassed += 1
            progressBar.progress = secondsPassed / selectedBoilTime
        } else {
            timer.invalidate()
            progressBar.progress = 0.0
            self.label.text = "Egg is ready!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
