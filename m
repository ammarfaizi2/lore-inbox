Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbTEGCCb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 22:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbTEGCCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 22:02:31 -0400
Received: from mail.ideaone.net ([64.21.232.2]:56706 "EHLO arlene.ideaone.net")
	by vger.kernel.org with ESMTP id S262798AbTEGCC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 22:02:26 -0400
Subject: Re: 2.5 neofb screen corruption leaving X
From: Reid Hekman <hekman@ideaone.net>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0305061924560.7110-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0305061924560.7110-100000@phoenix.infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052273540.2102.8.camel@artemis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 06 May 2003 21:12:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 13:25, James Simmons wrote:
> > Description: The console is "blown up" upon leaving X with neofb
> 
> Do you have the UseFBDev flag set in XF86Config? This should fix the 
> problem.

I added it, but it doesn't appear to have helped. Setting X to use the
fbdev driver works as expected, but isn't as purty once loaded :-(

Here's the relevant section of XF86Config:

Section "Device"
        Identifier  "Videocard0"
        Driver      "neomagic"
        VendorName  "Videocard vendor"
        BoardName   "NeoMagic MagicMedia 256AV (laptop/notebook)"
        VideoRam    2560
        Option      "OverlayMem" "829440"
        Option      "UseFBDev" "1"
        Option      "externDisp" ""
        Option      "internDisp" ""
EndSection

However, the following now appears in XFree86.0.log:

(==) NEOMAGIC(0): Write-combining range (0xe0000000,0x400000)
(II) NEOMAGIC(0): Stretching disabled
(II) NEOMAGIC(0): Using linear framebuffer at: 0xE0000000
(--) NEOMAGIC(0): 1048576 bytes off-screen memory available
(II) NEOMAGIC(0): Using H/W Cursor.
(II) NEOMAGIC(0): Overlay at 0x1b5400
(II) NEOMAGIC(0): Using 106 scanlines of offscreen memory
(II) NEOMAGIC(0): Using XFree86 Acceleration Architecture (XAA)
        Screen to screen bit blits
        Solid filled rectangles
        Solid Horizontal and Vertical Lines
        Offscreen Pixmaps
        Setting up tile and stipple cache:
                8 128x106 slots
(II) NEOMAGIC(0): Acceleration  Initialized
(==) NEOMAGIC(0): Backing store disabled
(==) NEOMAGIC(0): Silken mouse enabled
(**) Option "dpms"
(**) NEOMAGIC(0): DPMS enabled
(WW) NEOMAGIC(0): Option "UseFBDev" is not used           <-- What's Up?
(==) RandR enabled
(II) Setting vga for screen 0.
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR

This is from RedHat's XFree86-4.2.99.901-20030213.0

I put the entire XFree86.0.log here:
http://dslstatic-236-77.ideaone.net/XFree86.0.log



