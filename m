Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131733AbRCOSoD>; Thu, 15 Mar 2001 13:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131748AbRCOSnw>; Thu, 15 Mar 2001 13:43:52 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:24901 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S131733AbRCOSnl>; Thu, 15 Mar 2001 13:43:41 -0500
Date: Thu, 15 Mar 2001 18:45:37 +0000 (GMT)
From: Will Newton <will@misconception.org.uk>
X-X-Sender: <will@dogfox.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: VIA audio and parport in 2.4.2
Message-ID: <Pine.LNX.4.33.0103151829040.1581-100000@dogfox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a Asus K7V motherboard and a SB 128 PCI soundcard.
The motherboard is vt82c686a based.
The SB is a ES1371/AC97 card, seemingly identical to the onboard sound on
this type of motherboard.
However, the sound rarely works, and there are problems with the parport
too.

Sound does not work (usually, I have had it work, but I can't reproduce
it). The parport behaves strangely.

Here is dmesg output:

Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: possible IRQ conflict!
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by
other means>
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: cpp_mux: aa55f00f52ad51(80)
parport0: cpp_daisy: aa5500ff(80)
parport0: assign_addrs: aa5500ff(80)
parport0: cpp_mux: aa55f00f52ad51(80)
parport0: cpp_daisy: aa5500ff(80)
parport0: assign_addrs: aa5500ff(80)
parport_pc: Via 686A parallel port: io=0x378, irq=7, dma=3
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: possible IRQ conflict!
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by
other means>
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: cpp_mux: aa55f00f52ad51(80)
parport0: cpp_daisy: aa5500ff(80)
parport0: assign_addrs: aa5500ff(80)
parport0: cpp_mux: aa55f00f52ad51(80)
parport0: cpp_daisy: aa5500ff(80)
parport0: assign_addrs: aa5500ff(80)
parport_pc: Via 686A parallel port: io=0x378, irq=7, dma=3
lp0: using parport0 (interrupt-driven).

I don't know why it prints it twice.

When printing errors are printed (buffer overrun or something like that,
it seems RedHat only logs these damn things to console).

Also if I try to disbale interrupt driven printing I get an error:

[root@dogfox log]# /usr/sbin/tunelp /dev/printers/0 -i 0
tunelp: ioctl: Invalid argument
/dev/printers/0 using IRQ 7


With sound, I get:

es1371: version v0.27 time 00:47:56 Mar  7 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
PCI: Found IRQ 10 for device 00:0b.0
es1371: found es1371 rev 8 at io 0xa400 irq 10
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)

Where the id field obviously should not be zero.

The IRQ, DMA, I/O ports etc. are all the same as they are in Windows, but
in Linux the sound doesn't work and the printer keeps hanging.

I also get spurios interrupts on 7 when the parport is not loaded.

I know other people are seeing similar effects with sinilar hardware, but
to my knowledge there have been no solutions put forward.

If anyone has any ideas I can try to diagnose this problem more clearly
or wants any specific information, please ask.


