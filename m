Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUCOV7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbUCOV6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:58:05 -0500
Received: from main.gmane.org ([80.91.224.249]:36817 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262815AbUCOV4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:56:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Framebuffer with nVidia GeForce 2 Go on Dell Inspiron 8200
Date: Mon, 15 Mar 2004 22:56:48 +0100
Message-ID: <MPG.1ac04509fe5b83d7989685@news.gmane.org>
References: <c2o8sp$h3j$1@sea.gmane.org> <Pine.LNX.4.44.0403110112170.24760-100000@phoenix.infradead.org> <MPG.1aba630ad806a4c3989683@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-26-142.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 2. The VESA framebuffer does not work. Apparently, the card is not 
> > > detected as VESA-compatible. (I'm not 100% sure about this --how can 
> > > I check if this is indeed the case?)
> > 
> > Are you sure. Take a look at your vga= parmeter. What is its value?
> 
> I tried vga=ask, and no VESA modes are detected.

Ok, I'm stupid. I tried vga=ask, told him to scan, still got no VESA 
modes in the list, but thenand tried 318; it gave me 1024x768 (so did 
718 too, any reason why?). Can't get to 1600x1200, though (or at 
least I don't know how.)

> > > 3. The Riva framebuffer doesn't work either. It detects the video 
> > > card all right, understands that I'm running on a laptop and thus 
> > > with an LCD monitor, but as soon as I "touch" it (be it even just 
> > > with a fbset -i to find the information), the screen goes blank or 
> > > has some very funny graphical effects (fade to black in the middle, 
> > > etc). The system doesn't lock up (I can still blind-type and reset 
> > > it), but I can't use it.
> > > 
> > > Does anybody know what could be wrong?
> > 
> > That is a bug in fbcon layer. Now that I have my home system back up I 
> > plan to test my radeon card to track down the bug that was preventing the 
> > layer from properly resizing the screen.
> 
> Is there a particular reason why it would blank out even when just 
> asking for information, without changing any setting?

Now that I can work with the VESA driver, I'm feeling much better, 
but if I load the rivafb driver I *still* get the problem (I cannot 
touch it, not even with fbset -i). Using 2.6.4;

Just for reference, these are the logs from vesafb, rivafb and lspci:

>From vesafb:
===
vesafb: framebuffer at 0xe0000000, mapped to 0xd0807000, size 16384k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: protected mode interface info at c000:d6a0
vesafb: pmi: set display start = c00cd6e5, set palette = c00cd76a
vesafb: pmi: ports = b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 
c803 c903 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03 
vesafb: scrolling: ypan using protected mode interface, yres_virtual=
4096
vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0 
===

>From rivafb:
===
rivafb: nVidia device/chipset 10DE0112
rivafb: On a laptop.  Assuming Digital Flat Panel
rivafb: Detected CRTC controller 1 being used
rivafb: RIVA MTRR set to ON
rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-G, 
32MB @ 0xE0000000) 
===

In this case, fbset -i returns (well, doesn't because the screen goes 
black, but the computer is still fully functional):

===
mode "640x480-60"
    # D: 25.176 MHz, H: 31.469 kHz, V: 59.942 Hz
    geometry 640 480 640 480 8
    timings 39721 40 24 32 11 96 2
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

Frame buffer device information:
    Name        : nVidiaGeForce2-G
    Address     : 0xe0000000
    Size        : 33554432
    Type        : PACKED PIXELS
    Visual      : MONO01
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 0
    MMIO Address: 0xfc000000
    MMIO Size   : 16777216
    Accelerator : nVidia RIVA TNT  
===

In all cases, lspci returns this (long):

===
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
Bridge (rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP 
Bridge (rev 04)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 
Audio Controller (rev 02)
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 
02)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 
Go] (rev b2)
02:00.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M 
[Tornado] (rev 78)
02:01.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus 
Controller
02:01.1 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus 
Controller
02:01.2 FireWire (IEEE 1394): Texas Instruments PCI4451 IEEE-1394 
Controller

============================================================

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
Bridge (rev 04)
	Flags: bus master, fast devsel, latency 0
	Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [d104]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP 
Bridge (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) 
(prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at bf80 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) 
(prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1000 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) 
(prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=10, sec-latency=32
	I/O behind bridge: 0000e000-0000ffff
	Memory behind bridge: f4000000-fbffffff

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-
if 8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at bfa0 [size=16]
	Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 
Audio Controller (rev 02)
	Subsystem: Cirrus Logic: Unknown device 5959
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at d800 [size=256]
	I/O ports at dc80 [size=64]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 
02) (prog-if 00 [Generic])
	Subsystem: Conexant MD56ORD V.92 MDC Modem
	Flags: medium devsel, IRQ 11
	I/O ports at d400 [size=256]
	I/O ports at dc00 [size=128]

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 
Go] (rev b2) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00d4
	Flags: bus master, VGA palette snoop, 66Mhz, medium devsel, 
latency 32, IRQ 11
	Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0

02:00.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M 
[Tornado] (rev 78)
	Subsystem: Dell Computer Corporation: Unknown device 00d4
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at ec80 [size=128]
	Memory at f8fffc00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at f9000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

02:01.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus 
Controller
	Subsystem: Dell Computer Corporation: Unknown device 00d4
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

02:01.1 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus 
Controller
	Subsystem: Dell Computer Corporation: Unknown device 00d4
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10002000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

02:01.2 FireWire (IEEE 1394): Texas Instruments PCI4451 IEEE-1394 
Controller (prog-if 10 [OHCI])
	Subsystem: Dell Computer Corporation: Unknown device 00d4
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f8fff000 (32-bit, non-prefetchable) [size=2K]
	Memory at f8ff8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
===

Hope this gives some extra information on what might the problem be.


-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

