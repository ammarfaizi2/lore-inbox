Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130861AbRAWUfT>; Tue, 23 Jan 2001 15:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131627AbRAWUfJ>; Tue, 23 Jan 2001 15:35:09 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:6151 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S130861AbRAWUe5>;
	Tue, 23 Jan 2001 15:34:57 -0500
Date: Tue, 23 Jan 2001 21:34:51 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101232034.VAA06711@db0bm.ampr.org>
To: vandrove@vc.cvut.cz
Subject: Re: display problem with matroxfb
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Petr,

I've tested the parameters you gave to me, with no success : all is right with
vesafb and wrong with matroxfb. vesa:0x105 does not work, the monitor is out of
sync (I've tried 0x305 too). 

Here are parts of the syslog at system boot for matroxfb and vesafb :

matroxfb: Matrox Mystique (PCI) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x13075)
matroxfb: framebuffer at 0xE7000000, mapped to 0xc8805000, size 8388608
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device


vesafb: framebuffer at 0xe7000000, mapped to 0xc8000000, size 8192k
vesafb: mode is 640x480x8, linelength=640, pages=11
vesafb: protected mode interface info at c000:7820
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 80x30
fb0: VESA VGA frame buffer device

After booting and having the display shifted to the middle of the screen, I've
played a bit with fbset and the -left, -right, -move, -match options. After a
while I got an 'acceptable' picture (some pixels missing on the left). At this
point, fbset -s  give me the following :

mode "640x480-60"
    # D: 25.176 MHz, H: 31.628 kHz, V: 60.243 Hz
    geometry 640 480 640 480 8
    timings 39721 50 10 32 11 96 2
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode
		    
I've replaced these values in /etc/fb.modes instead of the original values and
after login in the system, entering 'fbset -match -a' set the virtual consoles
correctly.

How can I pass the parameters at boot time ? 
I've tried :
video=matrox:vesa:0x301,pixclock:39721,left:50,right:10,upper:32,lower:11,hslen:96,vslen:2
... without any success...

--
Regards
		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
