Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUHREmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUHREmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 00:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267308AbUHREmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 00:42:00 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:59102 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267294AbUHREl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 00:41:57 -0400
Message-ID: <4122DDF1.5070306@comcast.net>
Date: Wed, 18 Aug 2004 00:41:21 -0400
From: Clem Taylor <clemtaylor@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: radeonfb driver doesn't properly configure DVI monitor (2.6.8.1)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an older Radeon 8500 LE on my dual Opteron box. The radeonfb 
driver doesn't properly configure the DVI monitor output on startup. The 
analog output looks okay, but the DVI output is covered with redish 
noise that gets progressively worse as the system runs. It looks like 
some PLL or DLL is not being configured correctly. The monitor reports 
the correct resolution and refresh rate, so at least hsync/vsync timing 
is correct. The right edge of the image contains a fixed pattern that 
moves with screen scroll. Also, the last 5-10 lines of the analog output 
contains a series of random colored characters. It looks like the text 
buffer isn't being fully cleared (the LCD panel I'm using is 1920x1200).

X (xorg) properly configures the DVI, but when I switch back to the 
console, the output looks less broken but still contains a fairly strong 
RGB noise pattern.

On boot the radeonfb driver reports:
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=275.00 Mhz, 
System=275.00 MHz
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type CRT found
radeonfb: EDID probed
radeonfb: ATI Radeon QL  DDR SGRAM 64 MB

Another curious point is that the DVI output doesn't work at all from 
the BIOS, which means I have to switch to the analog output to boot. I 
updated the firmware on the graphics card, but that made things worse, 
the noise problem showed up in the BIOS and starting X didn't fix the 
noise (so I reverted to the previous version). ATIs response to this was 
that it was a BIOS problem and then that the card was old.

Has anyone else seen similar problems? I haven't tried compiling with 
CONFIG_FB_RADEON_DEBUG, but I think that should be the next thing.

                  --Clem
