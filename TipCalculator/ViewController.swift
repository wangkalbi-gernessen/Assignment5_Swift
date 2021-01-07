//
//  ViewController.swift
//  TipCalculator
//
//  Created by Kazunobu Someya on 2021-01-05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var totalAmount: UILabel!
    @IBOutlet var billAmount: UITextField!
    @IBOutlet var percentageSlider: UISlider!
    @IBOutlet var percentageValue: UILabel!
    @IBOutlet var calculateTipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billAmount.placeholder = "Bill Amount"
        billAmount.textAlignment = .center
        billAmount.font = UIFont(name: "Georgia", size: 30)
        percentageSlider.setValue(50.0, animated: true)
        registerForKeyboardNotification()
    }
    
    fileprivate func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWasShown(_ notification: NSNotification) {
        guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardHeight = keyboardFrame.size.height

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }

    @objc func keyboardWillBeHidden(_ sender: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @IBAction func enterBillAmount(_ sender: UITextField) {
        if sender.text?.isEmpty == false {
            let value = Int(sender.text!)
            let amount:Double = Double(value!) * Double(percentageSlider.value) / 100
            let ans = String(format: "%.2f", arguments: [amount])
            totalAmount.text = "$\(ans)"
        } else {
            totalAmount.text = "$00.00"
        }
    }
    
    @IBAction func changeSliderPercentageValue(_ sender: UISlider) {
        let value = sender.value
        let toInt = Int(value)
        let toString = String(toInt)
        percentageValue.text = "\(toString)%"
        
        if billAmount.text?.isEmpty == false {
            let value = Int(billAmount.text!)
            let amount:Double = Double(value!) * Double(percentageSlider.value) / 100
            let ans = String(format: "%.2f", arguments: [amount])
            totalAmount.text = "$\(ans)"
        }
    }
    
    @IBAction func clickCalculateTipButton(_ sender: UIButton) {
        if billAmount.text?.isEmpty == false {
            let value = Double(billAmount.text!)
            let amount: Double = value! * Double(percentageSlider.value / 100)
//            let numberFormatter = NumberFormatter()
//            numberFormatter.numberStyle = .decimal
//            numberFormatter.groupingSize = 3
//            numberFormatter.groupingSeparator = ","
//            let formattedNumber = numberFormatter.string(from: amount as NSNumber)!
//            let toDouble = Double(formattedNumber)
//            print(round(toDouble!*100)/100)
            
            
            let ans = String(format: "%.2f", arguments: [amount])
            totalAmount.text = "$\(ans)"
        }
    }
}

