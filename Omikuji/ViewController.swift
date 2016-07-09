//
//  ViewController.swift
//  Omikuji
//
//  Created by miyamo on 2016/07/09.
//  Copyright © 2016年 Zombiyamo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var opeNum :Int?
    var playerArray :[AVAudioPlayer] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.adjustsFontSizeToFitWidth = true
        resultLabel.adjustsFontSizeToFitWidth = true
        bottomLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        let sound_data = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("chicken-cry1", ofType: "mp3")!)
        var audioPlayer :AVAudioPlayer?
        do{
            audioPlayer = try AVAudioPlayer(contentsOfURL: sound_data)
        }catch _ {
            audioPlayer = nil
        }
        if let audioPlayer = audioPlayer {
            playerArray.append(audioPlayer)
            audioPlayer.play()
            audioPlayer.delegate = self
        }
        topLabel.text = "明日の運勢は"
        
        opeNum = Int(arc4random_uniform(100))
        if let opeNum = opeNum {
            switch opeNum {
            case 0:
                resultLabel.text = "スーパー\n超ラッキー"
                bottomLabel.text = "クマァ!?!?!?"
            case 1...4:
                resultLabel.text = "超ラッキー"
                bottomLabel.text = "クマァ...!!"
            case 5...19:
                resultLabel.text = "ラッキー"
                bottomLabel.text = "クマァマァ"
            case 20...39:
                resultLabel.text = "普通より\nラッキー"
                bottomLabel.text = "クマァ"
            case 40...99:
                resultLabel.text = "平凡"
                bottomLabel.text = "クマ..."
            default:
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension ViewController :AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        playerArray.removeFirst()
    }

}

