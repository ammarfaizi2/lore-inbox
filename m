Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUBOJRO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 04:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUBOJRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 04:17:14 -0500
Received: from av1-1-sn4.m-sp.skanova.net ([81.228.10.116]:24961 "EHLO
	av1-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S264391AbUBOJRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 04:17:11 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 2.6.3-rc3
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Feb 2004 10:17:00 +0100
In-Reply-To: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
Message-ID: <m2znbk4s8j.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Benjamin Herrenschmidt:
>   o New radeonfb
>   o Fix a link conflict between radeonfb and the radeon DRI
>   o Fix incorrect kfree in radeonfb

It doesn't seem to work on my x86 laptop. The screen goes black when
the framebuffer is enabled early in the boot sequence. The machine
boots normally anyway and I can log in from the network or log in
blindly at the console. I can then start the X server which appears to
work correctly, but switching back to a console still gives me a black
screen. Running "setfont" doesn't fix it. Here is what dmesg reports
when running 2.6.3-rc3:

    $ cat 263r3.dmesg | egrep -A 1 'Console:|radeon'
    Console: colour VGA+ 80x25
    Memory: 254460k/261632k available (2532k kernel code, 6388k reserved, 879k data, 148k init, 0k highmem)
    --
    radeonfb: Invalid ROM signature 0 should be 0xaa55
    radeonfb: Retreived PLL infos from BIOS
    radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=183.00 MHz
    Non-DDC laptop panel detected
    radeonfb: Monitor 1 type LCD found
    radeonfb: Monitor 2 type no found
    radeonfb: panel ID string: Samsung LTN150P1-L02    
    radeonfb: detected LVDS panel size from BIOS: 1400x1050
    radeondb: BIOS provided dividers will be used
    radeonfb: Power Management enabled for Mobility chipsets
    radeonfb: ATI Radeon LW  DDR SGRAM 64 MB
    SBF: Simple Boot Flag extension found and enabled.
    --
    Console: switching to colour frame buffer device 175x65
    pty: 1024 Unix98 ptys configured
    --
    Console: switching to colour frame buffer device 175x65
    input: PC Speaker

The same configuration works correctly using 2.6.3-rc2 and dmesg
reports:

    $ cat 263r2.dmesg | egrep -A 1 'Console:|radeon'
    Console: colour VGA+ 80x25
    Memory: 254544k/261632k available (2457k kernel code, 6304k reserved, 878k data, 144k init, 0k highmem)
    --
    radeonfb_pci_register BEGIN
    radeonfb: ref_clk=2700, ref_div=12, xclk=18300 from BIOS
    radeonfb: probed DDR SGRAM 65536k videoram
    radeon_get_moninfo: bios 4 scratch = 1000004
    radeonfb: panel ID string: Samsung LTN150P1-L02    
    radeonfb: detected DFP panel size from BIOS: 1400x1050
    radeonfb: ATI Radeon M7 LW DDR SGRAM 64 MB
    radeonfb: DVI port LCD monitor connected
    radeonfb: CRT port no monitor connected
    radeonfb_pci_register END
    SBF: Simple Boot Flag extension found and enabled.
    --
    Console: switching to colour frame buffer device 175x65
    pty: 1024 Unix98 ptys configured
    --
    Console: switching to colour frame buffer device 175x65
    input: PC Speaker

The FB related parts of my .config look like this:

    $ cat .config | egrep '_FB_|_CONSOLE|_FONT|_VIDEO' | egrep -v '^#'
    CONFIG_VT_CONSOLE=y
    CONFIG_HW_CONSOLE=y
    CONFIG_VIDEO_DEV=m
    CONFIG_VIDEO_SELECT=y
    CONFIG_FB_RADEON=y
    CONFIG_VGA_CONSOLE=y
    CONFIG_DUMMY_CONSOLE=y
    CONFIG_FRAMEBUFFER_CONSOLE=y
    CONFIG_PCI_CONSOLE=y
    CONFIG_FONT_8x8=y
    CONFIG_FONT_8x16=y

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
