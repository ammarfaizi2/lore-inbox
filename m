Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVHXXZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVHXXZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 19:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVHXXZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 19:25:10 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:37564 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S932356AbVHXXZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 19:25:09 -0400
Message-ID: <430D01C8.9030605@ribosome.natur.cuni.cz>
Date: Thu, 25 Aug 2005 01:24:56 +0200
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050815
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: overlapping MTRR regions
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I tested 2.6.13-rc7 on nice server motherboard with 16GB of RAM ;)
http://www.msicomputer.com/product/p_spec.asp?model=E7520_Master-S2M&class=spd
and I see the following when acpi is enabled (haven't even tried
without):

# cat /proc/mtrr 
reg00: base=0xd0000000 (3328MB), size= 256MB: uncachable, count=1
reg01: base=0xe0000000 (3584MB), size= 512MB: uncachable, count=1
reg02: base=0x00000000 (   0MB), size=16384MB: write-back, count=1
reg03: base=0x400000000 (16384MB), size= 512MB: write-back, count=1
reg04: base=0x420000000 (16896MB), size= 256MB: write-back, count=1
reg05: base=0xcff80000 (3327MB), size= 512KB: uncachable, count=1
#

Is that correct? Please cc: me in replies.

phylo ~ # lspci
0000:00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 0c)
0000:00:00.1 Class ff00: Intel Corporation E7525/E7520 Error Reporting Registers (rev 0c)
0000:00:01.0 System peripheral: Intel Corporation E7520 DMA Controller (rev 0c)
0000:00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port A (rev 0c)
0000:00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B (rev 0c)
0000:00:05.0 PCI bridge: Intel Corporation E7520 PCI Express Port B1 (rev 0c)
0000:00:06.0 PCI bridge: Intel Corporation E7520 PCI Express Port C (rev 0c)
0000:00:07.0 PCI bridge: Intel Corporation E7520 PCI Express Port C1 (rev 0c)
0000:00:1c.0 PCI bridge: Intel Corporation 6300ESB 64-bit PCI-X Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 6300ESB USB Universal Host Controller (rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 6300ESB USB Universal Host Controller (rev 02)
0000:00:1d.4 System peripheral: Intel Corporation 6300ESB Watchdog Timer (rev 02)
0000:00:1d.5 PIC: Intel Corporation 6300ESB I/O Advanced Programmable Interrupt Controller (rev 02)
0000:00:1d.7 USB Controller: Intel Corporation 6300ESB USB2 Enhanced Host Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 0a)
0000:00:1f.0 ISA bridge: Intel Corporation 6300ESB LPC Interface Controller (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 6300ESB PATA Storage Controller (rev 02)
0000:00:1f.2 IDE interface: Intel Corporation 6300ESB SATA Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corporation 6300ESB SMBus Controller (rev 02)
0000:01:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge A (rev 09)
0000:01:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge B (rev 09)
0000:08:01.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
0000:08:02.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet Controller
0000:08:03.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet Controller
0000:09:01.0 Ethernet controller: Intel Corporation 82541PI Gigabit Ethernet Controller (rev 05)
phylo ~ # lspci -v
0000:00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 0c)
        Subsystem: Intel Corporation E7520 Memory Controller Hub
        Flags: bus master, fast devsel, latency 0
        Capabilities: [40] #09 [4105]

0000:00:00.1 Class ff00: Intel Corporation E7525/E7520 Error Reporting Registers (rev 0c)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 3590
        Flags: fast devsel

0000:00:01.0 System peripheral: Intel Corporation E7520 DMA Controller (rev 0c)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 3594
        Flags: fast devsel, IRQ 10
        Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [b0] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-

0000:00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port A (rev 0c) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
        Capabilities: [64] #10 [0041]

0000:00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B (rev 0c) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
        Capabilities: [64] #10 [0041]

0000:00:05.0 PCI bridge: Intel Corporation E7520 PCI Express Port B1 (rev 0c) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
        Capabilities: [64] #10 [0041]

0000:00:06.0 PCI bridge: Intel Corporation E7520 PCI Express Port C (rev 0c) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
        Capabilities: [64] #10 [0041]

0000:00:07.0 PCI bridge: Intel Corporation E7520 PCI Express Port C1 (rev 0c) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
        Capabilities: [64] #10 [0041]

0000:00:1c.0 PCI bridge: Intel Corporation 6300ESB 64-bit PCI-X Bridge (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 96
        Bus: primary=00, secondary=08, subordinate=08, sec-latency=48
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: d0100000-d01fffff
        Prefetchable memory behind bridge: 00000000d8000000-00000000dff00000
        Capabilities: [50] PCI-X bridge device.

0000:00:1d.0 USB Controller: Intel Corporation 6300ESB USB Universal Host Controller (rev 02) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 24d0
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at 1400 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 6300ESB USB Universal Host Controller (rev 02) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 24d0
        Flags: bus master, medium devsel, latency 0, IRQ 22
        I/O ports at 1420 [size=32]

0000:00:1d.4 System peripheral: Intel Corporation 6300ESB Watchdog Timer (rev 02)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 25ab
        Flags: medium devsel
        Memory at d0001000 (32-bit, non-prefetchable) [size=16]

0000:00:1d.5 PIC: Intel Corporation 6300ESB I/O Advanced Programmable Interrupt Controller (rev 02) (prog-if 20 [IO(X)-APIC])
        Flags: bus master, fast devsel, latency 0
        Capabilities: [50] PCI-X non-bridge device.

0000:00:1d.7 USB Controller: Intel Corporation 6300ESB USB2 Enhanced Host Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 25a1
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at d0001400 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 0a) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=09, subordinate=09, sec-latency=200
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d0200000-d02fffff
        Prefetchable memory behind bridge: d0300000-d03fffff

0000:00:1f.0 ISA bridge: Intel Corporation 6300ESB LPC Interface Controller (rev 02)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corporation 6300ESB PATA Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 24d0
        Flags: bus master, medium devsel, latency 0, IRQ 21
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1460 [size=16]
        Memory at d0001800 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.2 IDE interface: Intel Corporation 6300ESB SATA Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 21
        I/O ports at 14a8 [size=8]
        I/O ports at 149c [size=4]
        I/O ports at 14a0 [size=8]
        I/O ports at 1498 [size=4]
        I/O ports at 1470 [size=16]

0000:00:1f.3 SMBus: Intel Corporation 6300ESB SMBus Controller (rev 02)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 24d0
        Flags: medium devsel, IRQ 10
        I/O ports at 1440 [size=32]

0000:01:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge A (rev 09) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [6c] Power Management version 2
        Capabilities: [d8] 
0000:01:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge B (rev 09) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=01, secondary=03, subordinate=03, sec-latency=32
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [6c] Power Management version 2
        Capabilities: [d8] 
0000:08:01.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
        Flags: stepping, 66Mhz, medium devsel, IRQ 17
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at 2000 [size=256]
        Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at d01a0000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2

0000:08:02.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet Controller
        Subsystem: Intel Corporation PRO/1000 MT Network Connection
        Flags: bus master, 66Mhz, medium devsel, latency 52, IRQ 18
        Memory at d0140000 (32-bit, non-prefetchable) [size=128K]
        Memory at d0120000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 2400 [size=64]
        Expansion ROM at d01c0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

0000:08:03.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet Controller
        Subsystem: Intel Corporation PRO/1000 MT Network Connection
        Flags: bus master, 66Mhz, medium devsel, latency 52, IRQ 19
        Memory at d0180000 (32-bit, non-prefetchable) [size=128K]
        Memory at d0160000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 2440 [size=64]
        Expansion ROM at d01e0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

0000:09:01.0 Ethernet controller: Intel Corporation 82541PI Gigabit Ethernet Controller (rev 05)
        Subsystem: Intel Corporation: Unknown device 1376
        Flags: bus master, 66Mhz, medium devsel, latency 52, IRQ 20
        Memory at d0220000 (32-bit, non-prefetchable) [size=128K]
        Memory at d0200000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 3000 [size=64]
        Expansion ROM at d0300000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.

phylo ~ # 
