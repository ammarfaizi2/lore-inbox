Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271229AbTG2FOj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 01:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271236AbTG2FOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 01:14:38 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:1499 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S271229AbTG2FOg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 01:14:36 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Tue, 29 Jul 2003 02:14:34 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: matroxfb and 2.6.0-test2
In-Reply-To: <20030729021321.GA1282@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.56.0307290141110.167@pervalidus.dyndns.org>
References: <Pine.LNX.4.56.0307281958410.193@pervalidus.dyndns.org>
 <20030729021321.GA1282@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Petr Vandrovec wrote:

> On Mon, Jul 28, 2003 at 08:34:40PM -0300, Frédéric L. W. Meunier wrote:
> >
> > My init script contains
> >
> > if lspci | grep -q 'MGA G400'; then
> > modprobe matroxfb_base
> > fi
> >
> > and /etc/modprobe.conf options matroxfb_base vesa=440
> >
> > After it the screen became corrupted with a dump of my last
> > shutdown. All commands still worked. I don't use fbset at all.
> > The logs don't have anything about matroxfb.
>
> Try building matroxfb into the kernel. I believe that current VT system
> does not take over console anymore if fbdev is loaded after fbcon, but
> I never tested it myself.

Thanks. It worked (and I don't see any screen corruption).

Maybe I'm missing something, but is there anything wrong with
video=matroxfb:vesa:0x1B5 ? I got

Kernel command line: BOOT_IMAGE=3 root=307 acpi=off noapic video=matroxfb:vesa:0x1B5
Console: colour VGA+ 80x25
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 800x600x24bpp (virtual: 800x65536)
matroxfb: framebuffer at 0xD8000000, mapped to 0xe0805000, size 33554432
fb0: MATROX frame buffer device
fb0: initializing hardware
matroxfb: cannot set xres to 800, rounded up to 832
Console: switching to colour frame buffer device 100x37
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 >
Console: switching to colour frame buffer device 100x37
matroxfb_crtc2: secondary head of fb0 was registered as fb1

and the monitor was black on part (a few cm) of the left side,
although everything was on the screen.

It worked fine with what I'm used to, 1024x768x32bpp;

Kernel command line: BOOT_IMAGE=3 root=307 acpi=off noapic video=matroxfb:vesa:0x1B8
Console: colour VGA+ 80x25
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x24bpp (virtual: 1024x65536)
matroxfb: framebuffer at 0xD8000000, mapped to 0xe0805000, size 33554432
fb0: MATROX frame buffer device
fb0: initializing hardware
Console: switching to colour frame buffer device 128x48
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 >
Console: switching to colour frame buffer device 128x48
matroxfb_crtc2: secondary head of fb0 was registered as fb1

and with the default:

Kernel command line: BOOT_IMAGE=3 root=307 acpi=off noapic
Console: colour VGA+ 80x25
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x65536)
matroxfb: framebuffer at 0xD8000000, mapped to 0xe0805000, size 33554432
fb0: MATROX frame buffer device
fb0: initializing hardware
Console: switching to colour frame buffer device 80x30
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 >
Console: switching to colour frame buffer device 80x30
matroxfb_crtc2: secondary head of fb0 was registered as fb1

BTW, I'm pretty syre I only got the following warning compiling
as a module (GCC 2.95.4):

  CC [M]  drivers/video/matrox/matroxfb_base.o
drivers/video/matrox/matroxfb_base.c:1230: warning: `inverse' defined but not used
