Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTK2RK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 12:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbTK2RK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 12:10:58 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:35786 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263834AbTK2RKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 12:10:37 -0500
X-Sender-Authentication: net64
Date: Sat, 29 Nov 2003 18:10:35 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem Report 2.4.23 ACPI and ASUS TRL-DLS
Message-Id: <20031129181035.70262a07.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just found out that enabling ACPI (kernel 2.4.23) on an ASUS TRL-DLS board
leads to a failing boot, caused by not configuring the onboard scsi aic
interfaces. In fact they are simply gone from the pci list (no kidding).
Disabling ACPI leads to a perfectly working box with:

00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
        Flags: fast devsel

00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
        Flags: bus master, medium devsel, latency 32

00:00.2 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
        Flags: medium devsel

00:00.3 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
        Flags: medium devsel

00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at ef000000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at d800 [size=64]
        Memory at ee800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at febf0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2

00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at ee000000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at d400 [size=64]
        Memory at ed800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at febe0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2

00:04.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500] (prog-if 00 [VGA])
        Subsystem: C.P. Technology Co. Ltd RV200 QW [Radeon 7500 PCI Dual Display]
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 25
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        I/O ports at d000 [size=256]
        Memory at ed000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at effe0000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2

00:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
        Subsystem: Creative Labs SBLive! Player 5.1
        Flags: bus master, medium devsel, latency 32, IRQ 26
        I/O ports at b800 [size=32]
        Capabilities: [dc] Power Management version 1

00:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at b400 [size=8]
        Capabilities: [dc] Power Management version 1

00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 1234
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 19
        Memory at ec000000 (32-bit, non-prefetchable) [disabled] [size=16M]
        I/O ports at b000 [disabled] [size=256]
        Memory at eb800000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Expansion ROM at effc0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
        Subsystem: ServerWorks CSB5 South Bridge
        Flags: bus master, medium devsel, latency 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 8a [Master SecP PriP])
        Subsystem: ServerWorks CSB5 IDE Controller
        Flags: bus master, medium devsel, latency 64
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 9400 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at eb000000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
        Subsystem: ServerWorks: Unknown device 0230
        Flags: bus master, medium devsel, latency 0

01:02.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
        Subsystem: 3ware Inc 3ware 7000-series ATA-RAID
        Flags: bus master, medium devsel, latency 32, IRQ 17
        I/O ports at 9000 [size=16]
        Memory at ea800000 (32-bit, non-prefetchable) [size=16]
        Memory at ea000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 1

01:03.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH Fritz!PCI v2.0 ISDN (rev 01)
        Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH Fritz!PCI v2.0 ISDN
        Flags: medium devsel, IRQ 20
        Memory at e9800000 (32-bit, non-prefetchable) [size=32]
        I/O ports at 8800 [size=32]
        Capabilities: [40] Power Management version 2

01:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
        Subsystem: 3Com Corporation 3C996B-T 1000Base-T
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 21
        Memory at e9000000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

02:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
        Subsystem: 3Com Corporation 3C996B-T 1000Base-T
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 24
        Memory at e8800000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

02:03.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
        Subsystem: Adaptec AIC-7899P U160/m
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 22
        BIST result: 00
        I/O ports at 8400 [disabled] [size=256]
        Memory at e8000000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at efde0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

02:03.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
        Subsystem: Adaptec AIC-7899P U160/m
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 23
        BIST result: 00
        I/O ports at 8000 [disabled] [size=256]
        Memory at e7800000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at efdc0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2



If someone wants to give it a try, just send me ideas or patches.

Thanks,
Stephan
