Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUBQWXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266693AbUBQWWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:22:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:45219 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266669AbUBQWQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:16:41 -0500
Subject: Re: Linux 2.6.3-rc4 Massive strange corruption with new radeonfb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Charles Johnston <cjohnston@networld.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <403274D2.4020407@networld.com>
References: <403274D2.4020407@networld.com>
Content-Type: text/plain
Message-Id: <1077055997.1076.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 09:13:17 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-18 at 07:08, Charles Johnston wrote:
> Upon bootup, radeonfb is obviously not initializing the hardware 
> correctly.  Massive amounts of random-looking garbage, plus a weird 
> effect I've never seen before, like someone pouring milk _up_ the
> screen. (Yeah, it's the best I could come up with)
> 
> It's a Dell Inspiron 8600 with Mobile Radeon 9600 and 1920x1200 LCD.

Looks like the driver cannot find any info about your flat panel
in the BIOS ROM image. I suppose we can thank DELL for hacking the
BIOS in ways that aren't compatible with all others laptops...

Can you try commenting out the call to radeon_map_ROM() and let it
look for the RAM based BIOS instead ? Let me know...
 
> Here's the relevant parts from dmesg:
> 
> radeonfb_pci_register BEGIN
> radeonfb: probed SDR SGRAM 131072k videoram
> radeonfb: mapped 16384k videoram
> radeonfb: Found Intel x86 BIOS ROM Image
> radeonfb: Retreived PLL infos from BIOS
> radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=337.00 Mhz, 
> System=243.00 MHz
> 1 chips in connector info
>   - chip 1 has 2 connectors
>    * connector 0 of type 2 (CRT) : 2300
>    * connector 1 of type 4 (DVI-D) : 4210
> Starting monitor auto detection...
> radeonfb: I2C (port 1) ... not found
> radeonfb: I2C (port 2) ... not found
> radeonfb: I2C (port 3) ... not found
> radeonfb: I2C (port 4) ... not found
> radeonfb: Reversed DACs detected
> radeonfb: Reversed TMDS detected
> radeonfb: I2C (port 2) ... not found
> radeonfb: I2C (port 4) ... not found
> Non-DDC laptop panel detected
> radeonfb: I2C (port 3) ... not found
> radeonfb: I2C (port 4) ... not found
> radeonfb: Monitor 1 type LCD found
> radeonfb: Monitor 2 type no found
> radeonfb: panel ID string:
> radeonfb: detected LVDS panel size from BIOS: 0x0
> BIOS provided panel power delay: 0
> Scanning BIOS table ...
> Didn't find panel in BIOS table !
> Guessing panel info...
> radeonfb: Assuming panel size 8x1
> radeonfb: Power Management enabled for Mobility chipsets
> radeonfb: ATI Radeon NP  SDR SGRAM 128 MB
> radeonfb_pci_register END
> 
> hStart = 664, hEnd = 760, hTotal = 800
> vStart = 409, vEnd = 411, vTotal = 450
> h_total_disp = 0x4f0063    hsync_strt_wid = 0x8c0292
> v_total_disp = 0x18f01c1           vsync_strt_wid = 0x820198
> pixclock = 39729
> freq = 2517
> post div = 0x3
> fb_div = 0x2d
> ppll_div_3 = 0x3002d
> lvds_gen_cntl: 003cffa5
> 
> 
> Obviously, it isn't detecting the screen size properly.  I even tried 
> hard-coding the resolution in the detection code, to no avail.
> Any suggestions?
> 
> 
> Thanks.
> 
> Charles
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

