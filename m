Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSKMOuF>; Wed, 13 Nov 2002 09:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSKMOuF>; Wed, 13 Nov 2002 09:50:05 -0500
Received: from neptun.ecos.de ([217.7.64.151]:39919 "HELO lnx1.i.ecos.de")
	by vger.kernel.org with SMTP id <S261724AbSKMOuD> convert rfc822-to-8bit;
	Wed, 13 Nov 2002 09:50:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Harald Jung <jung@ecos.de>
Reply-To: jung@ecos.de
Organization: Ecos GmbH
To: linux-kernel@vger.kernel.org
Subject: cardbus card behind a pci to pci bridge
Date: Wed, 13 Nov 2002 17:50:22 +0100
X-Mailer: KMail [version 1.4]
References: <4.3.2.7.2.20021113133414.00b53b00@mail.dns-host.com> <3DD26382.692BD476@aitel.hist.no>
In-Reply-To: <3DD26382.692BD476@aitel.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211131750.22498.jung@ecos.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it seems that it isn't possible to map the memory of a pcmcia card or to read 
from it if it is behind a pci to pci bridge.
I know that there were some hacks/patches for problems like this, but none of 
these patches worked with the hardware i use.

It doesn't matter which kind of cardbus-adapter is use, so the problem depends 
on the chipset i use : 
it is an nvidia nForce 420 Chipset on an Asus A7N266 Mainboard.

There were some patches for the yenta driver but i think it could be possible, 
that the ds module has problems with this hardware enviroment, too.

I have tryed various memory windows for the pcmcia card, but it doen't find a 
clear memory window at all.


greetings,
Harald Jung

lspci:
<======
01:07.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
        Subsystem: SCM Microsystems: Unknown device 3000
        Flags: medium devsel, IRQ 5
        Memory at e5801000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=0
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        16-bit legacy interface ports at 0001
=======>

sylog :
<=======
Nov 12 17:38:59 tr rcpcmcia: /sbin/insmod 
/lib/modules/2.4.18/kernel/drivers/pcmcia/pcmcia_core.o
Nov 12 17:38:59 tr kernel: Linux Kernel Card Services 3.1.22
Nov 12 17:38:59 tr kernel:   options:  [pci] [cardbus] [pm]
Nov 12 17:38:59 tr rcpcmcia: /sbin/insmod 
/lib/modules/2.4.18/kernel/drivers/pcmcia/yenta_socket.o
Nov 12 17:38:59 tr kernel: PCI: Enabling device 01:07.0 (0000 -> 0002)
Nov 12 17:38:59 tr kernel: Yenta IRQ list 0000, PCI irq5
Nov 12 17:38:59 tr kernel: Socket status: 10000011
Nov 12 17:38:59 tr rcpcmcia: /sbin/insmod 
/lib/modules/2.4.18/kernel/drivers/pcmcia/ds.o
Nov 12 17:39:01 tr cardmgr[1012]: watching 1 sockets
Nov 12 17:39:01 tr cardmgr[1012]: could not adjust resource: memory 
0xd0000-0xdffff: Input/output error
Nov 12 17:39:01 tr kernel: cs: IO port probe 0x0c00-0x0cff: excluding 
0xcf0-0xcff
Nov 12 17:39:01 tr kernel: cs: IO port probe 0x0800-0x08ff: clean.
Nov 12 17:39:01 tr kernel: cs: IO port probe 0x0100-0x04ff: excluding 
0x170-0x177 0x200-0x207 0x330-0x337 0x370-0x37f 0x4d0-0x4d7
Nov 12 17:39:01 tr kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Nov 12 17:39:01 tr cardmgr[1013]: starting, version is 3.2.3
Nov 12 17:39:01 tr kernel: cs: memory probe 0xa0000000-0xa0ffffff: excluding 
0xa0000000-0xa0ffffff
Nov 12 17:39:01 tr kernel: cs: memory probe 0x60000000-0x60ffffff: excluding 
0x60000000-0x60ffffff
Nov 12 17:39:01 tr kernel: cs: memory probe 0x2012000-0x2012fff: excluding 
0x2012000-0x2013fff
Nov 12 17:39:01 tr cardmgr[1013]: socket 0: Anonymous Memory
Nov 12 17:39:01 tr cardmgr[1013]: executing: 'modprobe memory_cs'
Nov 12 17:39:01 tr cardmgr[1013]: + modprobe: Can't locate module memory_cs
Nov 12 17:39:01 tr cardmgr[1013]: modprobe exited with status 255
Nov 12 17:39:01 tr cardmgr[1013]: module 
/lib/modules/2.4.18/pcmcia/memory_cs.o not available
Nov 12 17:39:02 tr cardmgr[1013]: get dev info on socket 0 failed: Resource 
temporarily unavailable
Nov 12 17:39:30 tr cardmgr[1013]: executing: 'modprobe -r memory_cs'
Nov 12 17:39:30 tr cardmgr[1013]: exiting
Nov 12 17:39:30 tr kernel: unloading Kernel Card Services
====>

