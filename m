Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130547AbQKLMT2>; Sun, 12 Nov 2000 07:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130546AbQKLMTS>; Sun, 12 Nov 2000 07:19:18 -0500
Received: from [194.213.32.137] ([194.213.32.137]:260 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130539AbQKLMS5>;
	Sun, 12 Nov 2000 07:18:57 -0500
Message-ID: <20001112005444.A165@bug.ucw.cz>
Date: Sun, 12 Nov 2000 00:54:44 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linux usb mailing list <linux-usb-devel@lists.sourceforge.net>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Something very wrong with time fbcon and FSBR
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I wanted to measure negative impact of FSBR on my system.

I did time cat /etc/termcap. I have fbcon, so it is quite slow
operation. It took 13 seconds.

Then I made system use the FSBR, and did cat /etc/termcap. It was
visually much slower, but it gave 13 seconds again. So I did the same
test again, it said:

0.00user 13.06system 13.38 (0m13.383s) elapsed 97.59%CPU
pavel@bug:~$

but measured with my wristwatch, it took over 50seconds!

Something is very wrong with either USB or fbcon. Okay, now I tried
without USB, it said 

0.00user 12.26system 12.33 (0m12.330s) elapsed 99.44%CPU
pavel@bug:~$

but took 28seconds of real time. So fbcon is making your watch loose
time. Oops. Oh, and fsbr makes system run at roughly half of normal
speed. Not good, either.

								Pavel
PS: fsbr means we make loop in descriptors, which then means uhci
hogging the PCI bus. Would it be possible to do some nop command (send
64 bytes to nonexisting device?) as a part of loop to avoid PCI
overload?
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
