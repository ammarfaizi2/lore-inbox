Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUECNeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUECNeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 09:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUECNeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 09:34:24 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:40712 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S263227AbUECNeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 09:34:22 -0400
To: linux-kernel@vger.kernel.org
Subject: 4x card in 8x AGP KT600 = locked solid (AGP bug?)
Reply-To: Ian McConnell <kernel@emit.demon.co.uk>
From: Ian McConnell <kernel@emit.demon.co.uk>
Date: Mon, 03 May 2004 14:34:20 +0100
Message-ID: <871xm1tz1f.fsf@emit.demon.co.uk>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to use DRI with a 4x AGP Radeon 9100 card in my 8x AGP KT600
motherboard, the screen goes black and the machine locks up solid - only a
hard reset reboots the machine. I can't find any error messages or Oops
logged.

With the latest BIOS and drivers, the card plays 3D games under Win2k ok.
However with debian testing, stock kernel 2.6.5 and XFree86 4.3.0.1, the
machine hangs unless I disable DRI in /etc/X11/XF86Config-4 with 
   Option          "ForcePCIMode"          "on"
then X works fine (using software GL)

I wasn't sure if this was a DRI or AGP bug, so I downloaded and installed
ATI's own 3d drivers (fglrx-4.3.0-3.7.6.i386.rpm). This time the screen goes
black and the X server sits burning 100% CPU, but I can log in remotely. I
cannot kill the X server (with kill -9 or ctrl-alt-backspace) and 
strace -p<xserver pid> just hangs with no output.

There is a thread of my experiences and more detail at
      http://www.rage3d.com/board/showthread.php?s=&threadid=33756033


So two difference implementations of DRI hanging makes me suspect that there
is a bug with AGP (Also the same video card, kernel and X worked well with
an older 4xAGP KT133 motherboard)

I'm using a stock kernel-2.6.5 with an AthlonXP 2700 and modules:
  via_agp                 5824  1 
  agpgart                28072  2 via_agp
  radeon                115184  2 

which show
  Linux agpgart interface v0.100 (c) Dave Jones
  agpgart: Detected VIA KT400/KT400A/KT600 chipset
  agpgart: Maximum main memory to use for agp memory: 439M
  agpgart: AGP aperture is 64M @ 0xe8000000
  [drm] Initialized radeon 1.9.0 20020828 on minor 0

The card is a Sapphire Radeon 9100 which supports up 4x AGP and the bios
R1.04 (dated Jan 20 2004) settings are:
  AGP Aperture 64M
  AGP Mode 4x
  AGP Driving control Auto
  AGP Fastwrite Enable
  AGP Master 1 WS Write Disable
  AGP Master 1 WS Read Disable
Changing the BIOS settings doesn't make any noticeable difference.

I've tried kernel-2.4.25, but that fails loading agpgart.o with
  Linux agpgart interface v0.99 (c) Jeff Hartmann
  agpgart: Maximum main memory to use for agp memory: 439M
  agpgart: Detected Via Apollo Pro KT400 chipset
  agpgart: unable to determine aperture size.



Is there any way to test AGP without using X? Any suggestions as to how I
can track down where/what is freezing the machine? How compatible is the
KT600 running in an AGP v2 compatibility mode?
