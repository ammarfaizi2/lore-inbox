Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbRACMtt>; Wed, 3 Jan 2001 07:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131766AbRACMtj>; Wed, 3 Jan 2001 07:49:39 -0500
Received: from ns1.megapath.net ([216.200.176.4]:25874 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S131709AbRACMt3>;
	Wed, 3 Jan 2001 07:49:29 -0500
Message-ID: <3A53187B.9030601@megapathdsl.net>
Date: Wed, 03 Jan 2001 04:18:03 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test11 i686; en-US; m18) Gecko/20001231
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>,
        David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Prerelease kernel will not hotplug a USB host-controller when it is inserted into a Cardbus slot.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Co.,

I am writing to let you know that in all test12-pre6+ kernels,
I get a "Bad PCI invocation" error when hotplug attempts to
handle the insertion of a USB host-controller into a Cardbus
slot.

I am aware that you most likely will ship 2.4.0 anyway, but
thought you should at least know about the bug.

I have tried your latest call_usermodehelper patch, Andrew,
which appears to have not made it into the kernel, but it
did not solve the problem.

What follows is test results from three configurations:

	prerelease with ds.o as a modular driver -- hotplug fails
	prerelease with ds.o in-kernel -- hotplug fails
	test11 with ds.o as a modular driver -- hotplug succeeds
					and usb-ohci loads

At the end of the message, you'll find the lspci output
for the BusPort Mobile generated using prerelease.

2.4.0-prerelease with ds.o built as a modular driver:
----------------------------------------------------

PCI: Enabling device 05:00.0 (0000 -> 0002)
PCI: Found IRQ 11 for device 05:00.0
PCI: The same IRQ used for device 00:04.0
Jan 3 03:22:27 agate kernel: cs: cb_alloc(bus 5): vendor 0x1045, device
0xc861
Jan 3 03:22:27 agate kernel: PCI: Enabling device 05:00.0 (0000 -> 0002)
Jan 3 03:22:27 agate kernel: PCI: Found IRQ 11 for device 05:00.0
Jan 3 03:22:27 agate kernel: PCI: The same IRQ used for device 00:04.0
Jan 3 03:22:28 agate /sbin/hotplug: Bad PCI invocation

2.4.0-prerelease with ds.o built in-kernel:
------------------------------------------


PCI: Enabling device 05:00.0 (0000 -> 0002)
PCI: Found IRQ 11 for device 05:00.0
PCI: The same IRQ used for device 00:04.0
Jan  3 03:55:14 agate kernel: cs: cb_alloc(bus 5): vendor 0x1045, device
0xc861
Jan  3 03:55:14 agate kernel: PCI: Enabling device 05:00.0 (0000 -> 0002)
Jan  3 03:55:14 agate kernel: PCI: Found IRQ 11 for device 05:00.0
Jan  3 03:55:14 agate kernel: PCI: The same IRQ used for device 00:04.0
Jan  3 03:55:15 agate /sbin/hotplug: Bad PCI invocation
Jan  3 03:55:15 agate cardmgr[402]: initializing socket 0
Jan  3 03:55:15 agate cardmgr[402]: socket 0: Anonymous Memory
Jan  3 03:55:15 agate cardmgr[402]: executing: 'modprobe sram_mtd'
Jan  3 03:55:15 agate cardmgr[402]: + modprobe: Can't locate module sram_mtd
Jan  3 03:55:15 agate cardmgr[402]: modprobe exited with status 255
Jan  3 03:55:15 agate cardmgr[402]: module
/lib/modules/2.4.0-test11/pcmcia/sram_mtd.o not available
Jan  3 03:55:15 agate cardmgr[402]:   Common memory region at 0x38e00:
Generic or SRAM
Jan  3 03:55:15 agate cardmgr[402]:   Common memory region at 0xe00:
Generic or
SRAM
Jan  3 03:55:15 agate cardmgr[402]: executing: 'modprobe memory_cs'
Jan  3 03:55:15 agate cardmgr[402]: + modprobe: Can't locate module
memory_cs
Jan  3 03:55:15 agate cardmgr[402]: modprobe exited with status 255
Jan  3 03:55:15 agate cardmgr[402]: module
/lib/modules/2.4.0-test11/pcmcia/memory_cs.o not available
Jan  3 03:55:16 agate cardmgr[402]: get dev info on socket 0 failed:
Resource temporarily unavailable

2.4.0-test11 with ds.o built as a modular driver:
------------------------------------------------

cs: socket c3105000 timed out during reset.  Try increasing setup_delay.
PCI: Enabling device 05:00.0 (0000 -> 0002)
PCI: Found IRQ 11 for device 05:00.0
PCI: The same IRQ used for device 00:04.0
Jan  3 02:39:52 agate kernel: cs: socket c3105000 timed out during
reset.  Try increasing setup_delay.
PCI: Setting latency timer of device 05:00.0 to 64
Jan  3 02:39:53 agate kernel: cs: cb_alloc(bus 5): vendor 0x1045, device
0xc861
Jan  3 02:39:53 agate kernel: PCI: Enabling device 05:00.0 (0000 -> 0002)
Jan  3 02:39:53 agate kernel: PCI: Found IRQ 11 for device 05:00.0
Jan  3 02:39:53 agate kernel: PCI: The same IRQ used for device 00:04.0
Jan  3 02:39:53 agate kernel: PCI: Setting latency timer of device
05:00.0 to 64Jan  3 02:39:53 agate kernel: usb-ohci.c: USB OHCI at
membase 0xc5867000, IRQ 11Jan  3 02:39:53 agate kernel: usb-ohci.c:
usb-05:00.0, PCI device 1045:c861
Jan  3 02:39:53 agate kernel: usb.c: new USB bus registered, assigned
bus number 1
Jan  3 02:39:53 agate kernel: Product: USB OHCI Root Hub
Jan  3 02:39:53 agate kernel: SerialNumber: c5867000
Jan  3 02:39:53 agate kernel: hub.c: USB hub found
Jan  3 02:39:53 agate kernel: hub.c: 2 ports detected
Jan  3 02:39:53 agate /sbin/hotplug: arguments (usb) env (TYPE=9/0/0
ACTION=add
DEVFS=/proc/bus/usb TERM=dumb DEVICE=/proc/bus/usb/001/001 HOSTTYPE=i386
PATH=/bin:/sbin:/usr/sbin:/usr/bin HOME=/ SHELL=/bin/bash DEBUG=kernel
OSTYPE=Linux PRODUCT=0/0/0 SHLVL=1 _=/usr/bin/env)

Here is what lspci has to say about the BusPort PCI entry when running
prerelease.  I checked the lspci output running under test11 and found
no discrepancies.

05:00.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
	Subsystem: OPTi Inc.: Unknown device c861
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
	<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 11000000 (32-bit, non-prefetchable)
	[size=4K]

00:04.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 007e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
	<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168 set, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable)
	[size=4K]
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt-
	PostWrite+
	16-bit legacy interface ports at 0001

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
