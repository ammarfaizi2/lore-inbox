Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280795AbRKLORI>; Mon, 12 Nov 2001 09:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280797AbRKLOQ6>; Mon, 12 Nov 2001 09:16:58 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:7685 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S280795AbRKLOQo>; Mon, 12 Nov 2001 09:16:44 -0500
Date: Mon, 12 Nov 2001 15:16:40 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Stuart Young <sgy@amc.com.au>
cc: <linux-kernel@vger.kernel.org>, Gavin Baker <gavbaker@ntlworld.com>
Subject: Re: SiS630 and 5591/5592 AGP
In-Reply-To: <5.1.0.14.0.20011112101656.00a20630@mail.amc.localnet>
Message-ID: <Pine.LNX.4.33.0111121450460.15875-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Stuart Young wrote:

> At 06:59 PM 11/11/01 +0000, Gavin Baker wrote:
> >My new laptop has this combination and the sis framebuffer driver
> >mangles the display. The sis X driver produces a nice lavalamp style
> >pattern that fades to white, the kernel stays alive but the machine
> >needs a reboot to fix the display in both cases.
> >
> >Im guessing the lack of 5591/5592 AGP support is the problem, and I
> >was just wondering if anyone is working on this or should i go bug SiS?
> 
> You've got the same problem I have. There is something weird with the way 
> some laptops (and LCD based desktops) handle this display, and the only way 
> I've gotten around it is to use the VesaFB driver (which is heaps slower 
> than the accelerated driver), and then either use the FB driver for X 
> (which is buggy IMHO, crashes if it gets too much to do buffered up), or 
> disable the mode changes and use the SiS accelerated X driver.
> 

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 11)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 80)
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator (rev 01)
00:01.6 Modem: Silicon Integrated Systems [SiS]: Unknown device 7013 (rev a0)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:08.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
00:08.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D (rev 11)

The X server is Free86-4.0.3 (RH 7.1), Driver "fbdev", vga=0x317 as boot
param (VESA fb driver):

vesafb: framebuffer at 0xf0000000, mapped to 0xcc000000, size 8192k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at ca5b:0004
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0

I'm not able to run X at 24/32 bits depth with fbdev, and it works only at
8 bit without fbdev (native sis driver). I haven't tried the DRM module.

BTW, does anybody know which value I have to pass to vga= for
1024x768x24?

I've been using the fbdev for a while, no crashes so far.
Textmode (Alt-Fx) is restored correctly, too.

> Alan has new drivers in his ac tree. but I've tried them, and no luck. Give 
> them a shot and see how you go. You might be lucky.

I've been switch from vanilla 2.4.9 to 2.4.10-ac10, to 2.4.9-12 (RH update)
without any problem. It hangs (at PCMCIA initialization I believe) after
a warm reboot from Win2000, but it happens only by mistake, as I know I
should be cold rebooting it when switching OS.

> Out of interest, what model/manufacturer is the notebook? The machines I'm 
> having problems with are Clevo LP200S's, which is an upright LCD machine, 
> with the h/drive and power supply down in the stand/foot.

Mitac 7521.

> Once we get everything working with Linux, they'll suit the application we 
> have for them rather nicely. *sigh*

It does for me. 1024x768x16 looks fine at 14.1", and I have no real need
for 24 bits.

> Q: Slightly related, have you gotten the sound to work? Driver loads, I get 
> "Unknown Codec" and an empty codec value. Reloading the driver makes no 
> difference (even numerous times). Wondering if your system is the same...

Yes, all fine here with standard RH config.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it


