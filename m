Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUA3Lvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUA3Lvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:51:55 -0500
Received: from ldd225.emirates.net.ae ([217.165.96.225]:772 "EHLO
	athena.localdomain") by vger.kernel.org with ESMTP id S262794AbUA3Lva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:51:30 -0500
Date: Fri, 30 Jan 2004 15:55:13 +0400 (GST)
From: Amit Gurdasani <amitg@alumni.cmu.edu>
X-X-Sender: amitg@athena.localdomain
To: Adam Belay <ambx1@neo.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: EISA ID for PnP modem and resource allocation
In-Reply-To: <20040130002602.GA13308@neo.rr.com>
Message-ID: <Pine.LNX.4.58.0401301539410.1201@athena.localdomain>
References: <Pine.LNX.4.56.0312261610200.1798@athena> <20031229143711.GA3176@neo.rr.com>
 <Pine.LNX.4.56.0312300338360.1163@athena> <20031229225037.GB3198@neo.rr.com>
 <20040104162654.A27227@flint.arm.linux.org.uk> <Pine.LNX.4.56.0401051713370.4783@athena.localdomain>
 <20040126192204.GA7280@neo.rr.com> <Pine.LNX.4.58.0401291043370.1164@athena.localdomain>
 <20040130002602.GA13308@neo.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:> It doesn't seem that the printk was ever called. Here are dmesg outputs with
:> and without isapnptools capturing an IRQ for the ISA modem. (I'm using
:> loadlin from DOS to boot Linux, incidentally. Would that make any
:> difference?)
:>
:
:Hmm, it looks like something strange is going on.  Perhaps the serial driver
:isn't matching to the device.

Well, it's certainly able to identify the device as a serial device. (I've
sent this message using the modem over a regular PPP link . . .)

:Could I see the output of the following:
:
:#mkdir /sys
:#mount -t sysfs none /sys
:#cd /sys/bus/pnp/devices
:#find */* | xargs cat       <------


Without isapnptools interfering:

[ amitg @ athena | ~ ] sudo find /sys/bus/pnp/devices -follow -type f -exec sh -c "echo ''; echo {}:; cat {}" \;

/sys/bus/pnp/devices/01:01.00/id:
AEI0250

/sys/bus/pnp/devices/01:01.00/resources:
state = disabled

/sys/bus/pnp/devices/01:01.00/options:
Dependent: 01 - Priority acceptable
   port 0x3f8-0x3f8, align 0x7, size 0x8, 16-bit address decoding
   irq 4 High-Edge
Dependent: 02 - Priority acceptable
   port 0x2f8-0x2f8, align 0x7, size 0x8, 16-bit address decoding
   irq 3 High-Edge
Dependent: 03 - Priority acceptable
   port 0x3e8-0x3e8, align 0x7, size 0x8, 16-bit address decoding
   irq 4 High-Edge
Dependent: 04 - Priority acceptable
   port 0x2e8-0x2e8, align 0x7, size 0x8, 16-bit address decoding
   irq 3 High-Edge
Dependent: 05 - Priority acceptable
   port 0x3e8-0x3e8, align 0x7, size 0x8, 16-bit address decoding
   irq 5 High-Edge
Dependent: 06 - Priority acceptable
   port 0x2e8-0x2e8, align 0x7, size 0x8, 16-bit address decoding
   irq 7 High-Edge
Dependent: 07 - Priority acceptable
   port 0x3f8-0x3f8, align 0x7, size 0x8, 16-bit address decoding
   irq 5,7,2/9,10,11,12,15 High-Edge
Dependent: 08 - Priority acceptable
   port 0x2f8-0x2f8, align 0x7, size 0x8, 16-bit address decoding
   irq 5,7,2/9,10,11,12,15 High-Edge
Dependent: 09 - Priority acceptable
   port 0x3e8-0x3e8, align 0x7, size 0x8, 16-bit address decoding
   irq 7,2/9,10,11,12,15 High-Edge
Dependent: 10 - Priority acceptable
   port 0x2e8-0x2e8, align 0x7, size 0x8, 16-bit address decoding
   irq 5,2/9,10,11,12,15 High-Edge
Dependent: 11 - Priority acceptable
   port 0x100-0xfff8, align 0x7, size 0x8, 16-bit address decoding
   irq 3,4,5,7,2/9,10,11,12,15 High-Edge

/sys/bus/pnp/devices/01:01.00/power/state:
0

/sys/bus/pnp/devices/01:01.00/detach_state:
0

/sys/bus/pnp/devices/00:0e/id:
PNP0501

/sys/bus/pnp/devices/00:0e/resources:
state = active
io 0x2f8-0x2ff
irq 3

/sys/bus/pnp/devices/00:0e/options:
irq 3,4,5,7,10,11 High-Edge
Dependent: 01 - Priority acceptable
   port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 02 - Priority acceptable
   port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 03 - Priority acceptable
   port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 04 - Priority acceptable
   port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding

/sys/bus/pnp/devices/00:0e/power/state:
0

/sys/bus/pnp/devices/00:0e/detach_state:
0

/sys/bus/pnp/devices/00:0d/id:
PNP0401

/sys/bus/pnp/devices/00:0d/resources:
state = active
io 0x378-0x37f
io 0x778-0x77a
irq 7
dma 3

/sys/bus/pnp/devices/00:0d/options:
irq 3,4,5,7,10,11 High-Edge
dma 1,3 8-bit compatible
Dependent: 01 - Priority acceptable
   port 0x378-0x378, align 0x0, size 0x8, 16-bit address decoding
   port 0x778-0x778, align 0x0, size 0x3, 16-bit address decoding
Dependent: 02 - Priority acceptable
   port 0x278-0x278, align 0x0, size 0x8, 16-bit address decoding
   port 0x678-0x678, align 0x0, size 0x3, 16-bit address decoding
Dependent: 03 - Priority acceptable
   port 0x3bc-0x3bc, align 0x0, size 0x4, 16-bit address decoding
   port 0x7bc-0x7bc, align 0x0, size 0x3, 16-bit address decoding

/sys/bus/pnp/devices/00:0d/power/state:
0

/sys/bus/pnp/devices/00:0d/detach_state:
0

/sys/bus/pnp/devices/00:0c/id:
PNP0700

/sys/bus/pnp/devices/00:0c/resources:
state = active
io 0x3f2-0x3f5
irq 6
dma 2

/sys/bus/pnp/devices/00:0c/options:
Dependent: 01 - Priority acceptable
   port 0x3f2-0x3f2, align 0x0, size 0x4, 16-bit address decoding
   irq 6 High-Edge
   dma 2 8-bit compatible

/sys/bus/pnp/devices/00:0c/power/state:
0

/sys/bus/pnp/devices/00:0c/detach_state:
0

/sys/bus/pnp/devices/00:0b/id:
PNP0501

/sys/bus/pnp/devices/00:0b/resources:
state = active
io 0x3f8-0x3ff
irq 4

/sys/bus/pnp/devices/00:0b/options:
irq 3,4,5,7,10,11 High-Edge
Dependent: 01 - Priority acceptable
   port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 02 - Priority acceptable
   port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 03 - Priority acceptable
   port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 04 - Priority acceptable
   port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding

/sys/bus/pnp/devices/00:0b/power/state:
0

/sys/bus/pnp/devices/00:0b/detach_state:
0

/sys/bus/pnp/devices/00:0a/id:
PNP0c02

/sys/bus/pnp/devices/00:0a/resources:
state = active
io 0x208-0x20f

/sys/bus/pnp/devices/00:0a/options:

/sys/bus/pnp/devices/00:0a/power/state:
0

/sys/bus/pnp/devices/00:0a/detach_state:
0

/sys/bus/pnp/devices/00:09/id:
PNP0f13

/sys/bus/pnp/devices/00:09/resources:
state = active
irq 12

/sys/bus/pnp/devices/00:09/options:
Dependent: 01 - Priority acceptable
   irq 12 High-Edge

/sys/bus/pnp/devices/00:09/power/state:
0

/sys/bus/pnp/devices/00:09/detach_state:
0

/sys/bus/pnp/devices/00:08/id:
PNP0a03

/sys/bus/pnp/devices/00:08/resources:
state = active
io 0x4d0-0x4d1
io 0xcf8-0xcff
io 0x480-0x48f
io 0xfff-0xfff

/sys/bus/pnp/devices/00:08/options:

/sys/bus/pnp/devices/00:08/power/state:
0

/sys/bus/pnp/devices/00:08/detach_state:
0

/sys/bus/pnp/devices/00:07/id:
PNP0c01

/sys/bus/pnp/devices/00:07/resources:
state = active
mem 0xe0000-0xfffff
mem 0x0-0x9ffff
mem 0xfffe0000-0xffffffff
mem 0x100000-0x7ffffff

/sys/bus/pnp/devices/00:07/options:

/sys/bus/pnp/devices/00:07/power/state:
0

/sys/bus/pnp/devices/00:07/detach_state:
0

/sys/bus/pnp/devices/00:06/id:
PNP0c04

/sys/bus/pnp/devices/00:06/resources:
state = active
io 0xf0-0xff
irq 13

/sys/bus/pnp/devices/00:06/options:

/sys/bus/pnp/devices/00:06/power/state:
0

/sys/bus/pnp/devices/00:06/detach_state:
0

/sys/bus/pnp/devices/00:05/id:
PNP0800

/sys/bus/pnp/devices/00:05/resources:
state = active
io 0x61-0x61

/sys/bus/pnp/devices/00:05/options:

/sys/bus/pnp/devices/00:05/power/state:
0

/sys/bus/pnp/devices/00:05/detach_state:
0

/sys/bus/pnp/devices/00:04/id:
PNP0303

/sys/bus/pnp/devices/00:04/resources:
state = active
io 0x60-0x60
io 0x64-0x64
irq 1

/sys/bus/pnp/devices/00:04/options:

/sys/bus/pnp/devices/00:04/power/state:
0

/sys/bus/pnp/devices/00:04/detach_state:
0

/sys/bus/pnp/devices/00:03/id:
PNP0b00

/sys/bus/pnp/devices/00:03/resources:
state = active
io 0x70-0x71
irq 8

/sys/bus/pnp/devices/00:03/options:

/sys/bus/pnp/devices/00:03/power/state:
0

/sys/bus/pnp/devices/00:03/detach_state:
0

/sys/bus/pnp/devices/00:02/id:
PNP0100

/sys/bus/pnp/devices/00:02/resources:
state = active
io 0x40-0x43
irq 0

/sys/bus/pnp/devices/00:02/options:

/sys/bus/pnp/devices/00:02/power/state:
0

/sys/bus/pnp/devices/00:02/detach_state:
0

/sys/bus/pnp/devices/00:01/id:
PNP0200

/sys/bus/pnp/devices/00:01/resources:
state = active
io 0x0-0xf
io 0x81-0x83
io 0x87-0x87
io 0x89-0x8b
io 0x8f-0x91
io 0xc0-0xdf
dma 4

/sys/bus/pnp/devices/00:01/options:

/sys/bus/pnp/devices/00:01/power/state:
0

/sys/bus/pnp/devices/00:01/detach_state:
0

/sys/bus/pnp/devices/00:00/id:
PNP0000

/sys/bus/pnp/devices/00:00/resources:
state = active
io 0x20-0x21
io 0xa0-0xa1
irq 2

/sys/bus/pnp/devices/00:00/options:

/sys/bus/pnp/devices/00:00/power/state:
0

/sys/bus/pnp/devices/00:00/detach_state:
0



If I get it to use isapnptools to enable the modem:

[ amitg @ athena | ~ ] sudo find /sys/bus/pnp/devices -follow -type f -exec sh -c "echo ''; echo {}:; cat {}" \;

/sys/bus/pnp/devices/01:01.00/id:
AEI0250

/sys/bus/pnp/devices/01:01.00/resources:
state = disabled

/sys/bus/pnp/devices/01:01.00/options:
Dependent: 01 - Priority acceptable
   port 0x3f8-0x3f8, align 0x7, size 0x8, 16-bit address decoding
   irq 4 High-Edge
Dependent: 02 - Priority acceptable
   port 0x2f8-0x2f8, align 0x7, size 0x8, 16-bit address decoding
   irq 3 High-Edge
Dependent: 03 - Priority acceptable
   port 0x3e8-0x3e8, align 0x7, size 0x8, 16-bit address decoding
   irq 4 High-Edge
Dependent: 04 - Priority acceptable
   port 0x2e8-0x2e8, align 0x7, size 0x8, 16-bit address decoding
   irq 3 High-Edge
Dependent: 05 - Priority acceptable
   port 0x3e8-0x3e8, align 0x7, size 0x8, 16-bit address decoding
   irq 5 High-Edge
Dependent: 06 - Priority acceptable
   port 0x2e8-0x2e8, align 0x7, size 0x8, 16-bit address decoding
   irq 7 High-Edge
Dependent: 07 - Priority acceptable
   port 0x3f8-0x3f8, align 0x7, size 0x8, 16-bit address decoding
   irq 5,7,2/9,10,11,12,15 High-Edge
Dependent: 08 - Priority acceptable
   port 0x2f8-0x2f8, align 0x7, size 0x8, 16-bit address decoding
   irq 5,7,2/9,10,11,12,15 High-Edge
Dependent: 09 - Priority acceptable
   port 0x3e8-0x3e8, align 0x7, size 0x8, 16-bit address decoding
   irq 7,2/9,10,11,12,15 High-Edge
Dependent: 10 - Priority acceptable
   port 0x2e8-0x2e8, align 0x7, size 0x8, 16-bit address decoding
   irq 5,2/9,10,11,12,15 High-Edge
Dependent: 11 - Priority acceptable
   port 0x100-0xfff8, align 0x7, size 0x8, 16-bit address decoding
   irq 3,4,5,7,2/9,10,11,12,15 High-Edge

/sys/bus/pnp/devices/01:01.00/power/state:
0

/sys/bus/pnp/devices/01:01.00/detach_state:
0

/sys/bus/pnp/devices/00:0e/id:
PNP0501

/sys/bus/pnp/devices/00:0e/resources:
state = active
io 0x2f8-0x2ff
irq 3

/sys/bus/pnp/devices/00:0e/options:
irq 3,4,5,7,10,11 High-Edge
Dependent: 01 - Priority acceptable
   port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 02 - Priority acceptable
   port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 03 - Priority acceptable
   port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 04 - Priority acceptable
   port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding

/sys/bus/pnp/devices/00:0e/power/state:
0

/sys/bus/pnp/devices/00:0e/detach_state:
0

/sys/bus/pnp/devices/00:0d/id:
PNP0401

/sys/bus/pnp/devices/00:0d/resources:
state = active
io 0x378-0x37f
io 0x778-0x77a
irq 7
dma 3

/sys/bus/pnp/devices/00:0d/options:
irq 3,4,5,7,10,11 High-Edge
dma 1,3 8-bit compatible
Dependent: 01 - Priority acceptable
   port 0x378-0x378, align 0x0, size 0x8, 16-bit address decoding
   port 0x778-0x778, align 0x0, size 0x3, 16-bit address decoding
Dependent: 02 - Priority acceptable
   port 0x278-0x278, align 0x0, size 0x8, 16-bit address decoding
   port 0x678-0x678, align 0x0, size 0x3, 16-bit address decoding
Dependent: 03 - Priority acceptable
   port 0x3bc-0x3bc, align 0x0, size 0x4, 16-bit address decoding
   port 0x7bc-0x7bc, align 0x0, size 0x3, 16-bit address decoding

/sys/bus/pnp/devices/00:0d/power/state:
0

/sys/bus/pnp/devices/00:0d/detach_state:
0

/sys/bus/pnp/devices/00:0c/id:
PNP0700

/sys/bus/pnp/devices/00:0c/resources:
state = active
io 0x3f2-0x3f5
irq 6
dma 2

/sys/bus/pnp/devices/00:0c/options:
Dependent: 01 - Priority acceptable
   port 0x3f2-0x3f2, align 0x0, size 0x4, 16-bit address decoding
   irq 6 High-Edge
   dma 2 8-bit compatible

/sys/bus/pnp/devices/00:0c/power/state:
0

/sys/bus/pnp/devices/00:0c/detach_state:
0

/sys/bus/pnp/devices/00:0b/id:
PNP0501

/sys/bus/pnp/devices/00:0b/resources:
state = active
io 0x3f8-0x3ff
irq 4

/sys/bus/pnp/devices/00:0b/options:
irq 3,4,5,7,10,11 High-Edge
Dependent: 01 - Priority acceptable
   port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 02 - Priority acceptable
   port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 03 - Priority acceptable
   port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 04 - Priority acceptable
   port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding

/sys/bus/pnp/devices/00:0b/power/state:
0

/sys/bus/pnp/devices/00:0b/detach_state:
0

/sys/bus/pnp/devices/00:0a/id:
PNP0c02

/sys/bus/pnp/devices/00:0a/resources:
state = active
io 0x208-0x20f

/sys/bus/pnp/devices/00:0a/options:

/sys/bus/pnp/devices/00:0a/power/state:
0

/sys/bus/pnp/devices/00:0a/detach_state:
0

/sys/bus/pnp/devices/00:09/id:
PNP0f13

/sys/bus/pnp/devices/00:09/resources:
state = active
irq 12

/sys/bus/pnp/devices/00:09/options:
Dependent: 01 - Priority acceptable
   irq 12 High-Edge

/sys/bus/pnp/devices/00:09/power/state:
0

/sys/bus/pnp/devices/00:09/detach_state:
0

/sys/bus/pnp/devices/00:08/id:
PNP0a03

/sys/bus/pnp/devices/00:08/resources:
state = active
io 0x4d0-0x4d1
io 0xcf8-0xcff
io 0x480-0x48f
io 0xfff-0xfff

/sys/bus/pnp/devices/00:08/options:

/sys/bus/pnp/devices/00:08/power/state:
0

/sys/bus/pnp/devices/00:08/detach_state:
0

/sys/bus/pnp/devices/00:07/id:
PNP0c01

/sys/bus/pnp/devices/00:07/resources:
state = active
mem 0xe0000-0xfffff
mem 0x0-0x9ffff
mem 0xfffe0000-0xffffffff
mem 0x100000-0x7ffffff

/sys/bus/pnp/devices/00:07/options:

/sys/bus/pnp/devices/00:07/power/state:
0

/sys/bus/pnp/devices/00:07/detach_state:
0

/sys/bus/pnp/devices/00:06/id:
PNP0c04

/sys/bus/pnp/devices/00:06/resources:
state = active
io 0xf0-0xff
irq 13

/sys/bus/pnp/devices/00:06/options:

/sys/bus/pnp/devices/00:06/power/state:
0

/sys/bus/pnp/devices/00:06/detach_state:
0

/sys/bus/pnp/devices/00:05/id:
PNP0800

/sys/bus/pnp/devices/00:05/resources:
state = active
io 0x61-0x61

/sys/bus/pnp/devices/00:05/options:

/sys/bus/pnp/devices/00:05/power/state:
0

/sys/bus/pnp/devices/00:05/detach_state:
0

/sys/bus/pnp/devices/00:04/id:
PNP0303

/sys/bus/pnp/devices/00:04/resources:
state = active
io 0x60-0x60
io 0x64-0x64
irq 1

/sys/bus/pnp/devices/00:04/options:

/sys/bus/pnp/devices/00:04/power/state:
0

/sys/bus/pnp/devices/00:04/detach_state:
0

/sys/bus/pnp/devices/00:03/id:
PNP0b00

/sys/bus/pnp/devices/00:03/resources:
state = active
io 0x70-0x71
irq 8

/sys/bus/pnp/devices/00:03/options:

/sys/bus/pnp/devices/00:03/power/state:
0

/sys/bus/pnp/devices/00:03/detach_state:
0

/sys/bus/pnp/devices/00:02/id:
PNP0100

/sys/bus/pnp/devices/00:02/resources:
state = active
io 0x40-0x43
irq 0

/sys/bus/pnp/devices/00:02/options:

/sys/bus/pnp/devices/00:02/power/state:
0

/sys/bus/pnp/devices/00:02/detach_state:
0

/sys/bus/pnp/devices/00:01/id:
PNP0200

/sys/bus/pnp/devices/00:01/resources:
state = active
io 0x0-0xf
io 0x81-0x83
io 0x87-0x87
io 0x89-0x8b
io 0x8f-0x91
io 0xc0-0xdf
dma 4

/sys/bus/pnp/devices/00:01/options:

/sys/bus/pnp/devices/00:01/power/state:
0

/sys/bus/pnp/devices/00:01/detach_state:
0

/sys/bus/pnp/devices/00:00/id:
PNP0000

/sys/bus/pnp/devices/00:00/resources:
state = active
io 0x20-0x21
io 0xa0-0xa1
irq 2

/sys/bus/pnp/devices/00:00/options:

/sys/bus/pnp/devices/00:00/power/state:
0

/sys/bus/pnp/devices/00:00/detach_state:
0



I hope this helps.

Amit

