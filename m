Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUBQUJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266624AbUBQUJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:09:12 -0500
Received: from Servers103.networldnoc.net ([209.63.232.103]:28177 "EHLO
	networld.com") by vger.kernel.org with ESMTP id S266622AbUBQUI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:08:59 -0500
Message-ID: <403274D2.4020407@networld.com>
Date: Tue, 17 Feb 2004 13:08:50 -0700
From: Charles Johnston <cjohnston@networld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en, pt-br, pt, es, ko, ko-kr
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.3-rc4 Massive strange corruption with new radeonfb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon bootup, radeonfb is obviously not initializing the hardware 
correctly.  Massive amounts of random-looking garbage, plus a weird 
effect I've never seen before, like someone pouring milk _up_ the
screen. (Yeah, it's the best I could come up with)

It's a Dell Inspiron 8600 with Mobile Radeon 9600 and 1920x1200 LCD.

Here's the relevant parts from dmesg:

radeonfb_pci_register BEGIN
radeonfb: probed SDR SGRAM 131072k videoram
radeonfb: mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=337.00 Mhz, 
System=243.00 MHz
1 chips in connector info
  - chip 1 has 2 connectors
   * connector 0 of type 2 (CRT) : 2300
   * connector 1 of type 4 (DVI-D) : 4210
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: Reversed DACs detected
radeonfb: Reversed TMDS detected
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
Non-DDC laptop panel detected
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string:
radeonfb: detected LVDS panel size from BIOS: 0x0
BIOS provided panel power delay: 0
Scanning BIOS table ...
Didn't find panel in BIOS table !
Guessing panel info...
radeonfb: Assuming panel size 8x1
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon NP  SDR SGRAM 128 MB
radeonfb_pci_register END

hStart = 664, hEnd = 760, hTotal = 800
vStart = 409, vEnd = 411, vTotal = 450
h_total_disp = 0x4f0063    hsync_strt_wid = 0x8c0292
v_total_disp = 0x18f01c1           vsync_strt_wid = 0x820198
pixclock = 39729
freq = 2517
post div = 0x3
fb_div = 0x2d
ppll_div_3 = 0x3002d
lvds_gen_cntl: 003cffa5


Obviously, it isn't detecting the screen size properly.  I even tried 
hard-coding the resolution in the detection code, to no avail.
Any suggestions?


Thanks.

Charles
