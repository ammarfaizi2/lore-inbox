Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265535AbUABPgo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 10:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265536AbUABPgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 10:36:43 -0500
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:21441 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S265535AbUABPgm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 10:36:42 -0500
Date: Fri, 2 Jan 2004 16:36:39 +0100 (CET)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Claas Langbehn <claas@rootdir.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0: atyfb broken
In-Reply-To: <Pine.GSO.4.58.0401021341010.3062@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0401021621160.15125-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Jan 2004, Geert Uytterhoeven wrote:

> > with 2.4.23 it does not work either.
> >
> > dmesg says:
> >
> > atyfb: using auxiliary register aperture
> > atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
> > atyfb: BIOS contains driver information table.
> > atyfb: colour active matrix monitor detected: CPT CLAA141XB01
> >         id=10, 1024x768 pixels, 262144 colours (LT mode)
> >         supports 60 Hz refresh rates, default 60 Hz
> >         LCD CRTC parameters: 15384 167 127 130 0 17 805 767 769 6
> > atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTAL,
> >        230 MHz PLL, 83 Mhz MCLK, 125 Mhz XCLK
> > Console: switching to colour frame buffer device 80x25
> > fb0: ATY Mach64 frame buffer device on PCI
> >
> >
> > When booting the screen gets slowly flooded with white.
> > X11 works anyway.
> >
> > dmesg's output shows different MCLK and XCLK with kernel 2.4.23
> > (see above).
>
> Does it work with 2.4.22 and earlier? Mobility support was changed a lot in
> 2.4.23.

Did this laptop work before? My first guess is no. Both 2.4.22 and 2.6.0
do not support LCD displays.

2.4.23 does, and is the only kernel that does have a chance of working.

In case 2.4.22 did work (possible since 720x400 VGA text mode is
converted in hardware to 640x400, and therefore very similar to 640x480
in timings), it will work very badly, the image is most likely not
correct and any attempt to switch video mode will fail.

The mclk/xclk settings in 2.4.23 are the correct default clock
frequencies (checked with ATi). Other kernel versions use
timings for an Apple Powerbook, which, because the open firmware
initializes a correct startup video mode and PowerPC specific code that
prevents switching to 640x480 will work with the original driver.
This Apple laptop is detected in 2.4.23 and still gets the original
frequencies.

Anyway, the frequencies are correct for your laptop, if the display is
fading white it means the graphics chip is operating correctly but
provide wrong video mode timings to your LCD display.

Daniël

