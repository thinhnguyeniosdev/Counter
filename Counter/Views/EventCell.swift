//
//  EventCell.swift
//  Counter
//
//  Created by Nick Nguyen on 2/3/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit
import Foundation

class EventCell: UITableViewCell  {
    var countdownTimer : Timer?
    let dateFormatter  = Helper.createDateFormatter(format:" E, d MMM yyyy")
    
    
    
    private  func updateViews() {
        guard let event = event else { return }
         startTimer()
        
        eventNameLabel.text = event.name
        emojiLabel.text = event.emoji
        eventDateLabel.text = dateFormatter.string(from: event.date)
        eventDaysLeft.text = event.daysLeft > 0.0 ? updateTime() : "☑️"
        eventDaysLeft.backgroundColor = UIColor(displayP3Red: 38/255, green: 50/255, blue: 72/255, alpha: 1.0)
      
       
      
    }
   private func startTimer() {
    
    countdownTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(updateTime),
                                             userInfo: nil,
                                             repeats: true)
   
    }
    
    @objc func updateTime() -> String {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let diffDateComponents = calendar.dateComponents([.day,.hour,.minute,.second], from: currentDate,to: event!.date)
        switch Int(event!.daysLeft) {
            // MARK: - TODO 
        case let x where x <= 0:
            eventDaysLeft.text = "☑️"
             countdownTimer = nil
            countdownTimer?.invalidate()

            
        case 0...59:
            eventDaysLeft.text = "\(diffDateComponents.second!) seconds left."
        case 60...3599:
            eventDaysLeft.text = "\(diffDateComponents.minute!) minutes left."
        case 3600...86399:
            eventDaysLeft.text = "\(diffDateComponents.hour!) hours, \(diffDateComponents.minute!) mins left."
        case let x where x >= 86400 :
            eventDaysLeft.text = "\(diffDateComponents.day!) days left."
        default:
            break
        }
        return eventDaysLeft.text!
    }

    
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventDaysLeft: UILabel!
    
    
  
     var event: Event? {
         didSet {
             updateViews()

         }
     }
    
     
   
}
