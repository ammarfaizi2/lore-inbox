Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266351AbUGPOOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUGPOOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 10:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUGPOOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 10:14:22 -0400
Received: from zone3.gcu-squad.org ([217.19.50.74]:2316 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S266351AbUGPOOU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 10:14:20 -0400
Date: Fri, 16 Jul 2004 16:11:32 +0200 (CEST)
To: bri@tull.umassp.edu
Subject: Re: PATCH: fixup EDID for slightly broken monitors
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <UMgqqv3P.1089987092.6514170.khali@gcu.info>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Brian,

What about fixing your screen instead of hacking fbcon's code?

If your EDID is held by an unprotected EEPROM, you should be able to
write to it using the i2cset tool [1] found in the lm_sensors package
[2]. Never tried that myself but I would definitely try that before
attempting to hack every piece of software which tries to read the EDID
data (framebuffer console, X, lm_sensors etc...).

How to proceed:

1* Make sure you enabled the I2C option of the radeonfb driver. I assume
you already did or I guess you wouldn't be able to access the EDID, at
all.

2* Find out where you EDID is. The radeonfb driver exposes 4 i2c busses,
out of which you really use only one (unless your screen has 2 inputs,
like mine has). Tool of choice here is i2cdetect [3]. Run with -l to
list the busses, then with a bus number to show the chips on that bus.
EDID will always show at 0x50.

3* Dump your EDID using "i2cdump <bus number> 0x50" [4]. I suggest that
you keep this preciously in case things turn bad.

4* Fix the broken bytes using i2cset <bus number> 0x50 <offset> <value>.
If I read you correctly, you need to do that twice, once with offset=0
and value=0, and once with offset=1 and value=0xff.

Of course I'm not liable if it breaks anything, never had to do that
myself, but my knowledge of the topic make me believe that it could work
(providing the supporting EEPROM is not write-protected, of course).

Shall it work, it looks like a nicer solution than your patch, with all
due respect.

Good luck.

[1] http://secure.netroedge.com/~lm78/man/i2cset.html
[2] http://secure.netroedge.com/~lm78/download.html
[3] http://secure.netroedge.com/~lm78/man/i2cdetect.html
[4] http://secure.netroedge.com/~lm78/man/i2cdump.html

--
Jean "Khali" Delvare
