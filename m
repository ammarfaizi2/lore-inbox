Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbRFBViN>; Sat, 2 Jun 2001 17:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261562AbRFBViE>; Sat, 2 Jun 2001 17:38:04 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6404 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S261550AbRFBVh4>;
	Sat, 2 Jun 2001 17:37:56 -0400
Message-ID: <20010602132200.A186@bug.ucw.cz>
Date: Sat, 2 Jun 2001 13:22:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linux usb mailing list <linux-usb-devel@lists.sourceforge.net>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: *BAD* impact of usb on PCI performance
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I did some testing how does usb hurt rest of system; and it can be
pretty bad.

With Acher's uhci, even ifconfig up of usb-to-usb networking device
[plusb handled by generic usb-to-usb driver; see -ac series].
does 50% slowdown. When fsbr is being used, systems slows down by 350%
(running more than 4 times slower than normally. Ouch).
								Pavel
2.4.5: 300MHz, no usb at all (compiled out)
0.06user 3.25system 3.30 (0m3.308s) elapsed 100.00%CPU
0.06user 3.25system 3.30 (0m3.307s) elapsed 100.00%CPU
0.03user 3.28system 3.32 (0m3.323s) elapsed 99.61%CPU
2.4.5: 300MHz, usb ifconfig down [acher]
0.05user 3.28system 3.35 (0m3.357s) elapsed 99.18%CPU
0.03user 3.29system 3.31 (0m3.319s) elapsed 100.00%CPU
0.04user 3.29system 3.32 (0m3.325s) elapsed 100.00%CPU
0.01user 3.32system 3.32 (0m3.326s) elapsed 100.00%CPU
2.4.5: 300MHz, usb not plugged [JE]
0.06user 3.24system 3.30 (0m3.303s) elapsed 99.90%CPU
0.06user 3.25system 3.30 (0m3.304s) elapsed 100.00%CPU
0.02user 3.30system 3.33 (0m3.336s) elapsed 99.52%CPU
2.4.5: 300Mhz, plusb loaded and UP [acher]
0.03user 4.93system 4.99 (0m4.993s) elapsed 99.33%CPU
0.02user 4.94system 4.99 (0m4.991s) elapsed 99.37%CPU
0.04user 4.92system 4.99 (0m4.990s) elapsed 99.40%CPU
0.06user 4.90system 4.98 (0m4.985s) elapsed 99.49%CPU
0.04user 4.91system 4.98 (0m4.983s) elapsed 99.33%CPU
0.05user 4.91system 4.98 (0m4.985s) elapsed 99.50%CPU
0.06user 4.90system 4.98 (0m4.989s) elapsed 99.42%CPU
0.06user 4.91system 4.99 (0m4.995s) elapsed 99.49%CPU
2.4.5: 300Mhz, plusb plugged in [JE]
0.03user 3.29system 3.35 (0m3.352s) elapsed 99.05%CPU
0.02user 3.29system 3.34 (0m3.349s) elapsed 98.85%CPU
0.01user 3.30system 3.34 (0m3.349s) elapsed 98.84%CPU
2.4.5: 300Mhz, plusb plugged in and UP [JE]
0.04user 3.29system 3.32 (0m3.327s) elapsed 100.00%CPU
0.02user 3.31system 3.35 (0m3.356s) elapsed 99.23%CPU
0.04user 3.28system 3.35 (0m3.353s) elapsed 99.03%CPU
2.4.5: 300Mhz, plusb loaded and UP, fsbr forced ON [acher]
0.06user 14.39system 14.54 (0m14.542s) elapsed 99.37%CPU
0.03user 14.51system 14.62 (0m14.625s) elapsed 99.42%CPU
0.04user 14.63system 14.79 (0m14.798s) elapsed 99.14%CPU
2.4.5: 300Mhz, plusb loaded and UP, fsbr forced ON [JE]
0.04user 14.87system 14.98 (0m14.986s) elapsed 99.49%CPU
0.06user 14.85system 14.99 (0m14.994s) elapsed 99.43%CPU
0.04user 14.85system 14.98 (0m14.984s) elapsed 99.37%CPU

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
