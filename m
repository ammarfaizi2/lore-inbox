Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVEGQFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVEGQFJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 12:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVEGQFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 12:05:09 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:41054 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262638AbVEGQD6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 12:03:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=L4+O6SSzxb1406+Nsgl5z6E569/D/iFH8MA/nQjU1wEWMr1XHE696dyJmLYDcj3Ep3Ah/sImBRoGCzhhBk8hTTH8iAekeSad9LDy908TIE0c7NiocED9Rywk2PsaXYUeahmFRyGg67uQGYbCaKDGx95ZRq9mkQNbSZbDIw3mLtM=
Message-ID: <87ab37ab0505070903c286c54@mail.gmail.com>
Date: Sun, 8 May 2005 00:03:56 +0800
From: kylin <fierykylin@gmail.com>
Reply-To: kylin <fierykylin@gmail.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: BroadCom 5721 NICs conflict with each other and USB under linux 2.6.12-rc3-git1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suddenly found that my 2 BroadCom 5721 NICs can not work
intercurrently, if one works, the other will not.
i have enable the "pci=routeirq" option in grub for the Dmesg hinted.
but still  conflict.when i look in to the proc/interrupts:i got:
           CPU0       
  0:    9084632          XT-PIC  timer
  1:         10          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:         21          XT-PIC  ehci_hcd:usb1
  5:          0          XT-PIC  parport0
  7:     945888          XT-PIC  megaraid, uhci_hcd:usb4,
radeon@pci:0000:10:0d.0
  8:          0          XT-PIC  rtc
  9:          1          XT-PIC  acpi
 10:          0          XT-PIC  uhci_hcd:usb3
 11:    2436114          XT-PIC  uhci_hcd:usb2, eth0, eth1
 12:        101          XT-PIC  i8042
 14:         11          XT-PIC  ide0
NMI:          0 
ERR:          0
also ,the USB disk can not work well 
i am using the intel E7520 chipset on Dell PE 2800 with PCI express supported,
and BroadCom 5721 NICs is a PCIe ethernet card.
I doubt that is because the IRQ 's fault . can some kind hearted help me out ?

i am running a kernel 2.6.12-rc3-git1 #2 Sun May 8 00:00:05 CST 2005
i686 i686 i386 GNU/Linux of Fedora Core 4 Test 2,

if useful ,below is the lspci:
00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 09)
	Subsystem: Dell: Unknown device 016e
	Flags: bus master, fast devsel, latency 0
	Capabilities: [40] Vendor Specific Information

00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express
Port A (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
	Memory behind bridge: dfc00000-dfefffff
	Prefetchable memory behind bridge: 00000000da000000-00000000da000000
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
	Capabilities: [64] Express Root Port (Slot-) IRQ 0
	Capabilities: [100] Advanced Error Reporting

00:03.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express
Port A1 (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=06, sec-latency=0
	Memory behind bridge: dfb00000-dfbfffff
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
	Capabilities: [64] Express Root Port (Slot-) IRQ 0
	Capabilities: [100] Advanced Error Reporting

00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B
(rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=07, subordinate=09, sec-latency=0
	I/O behind bridge: 0000d000-0000efff
	Memory behind bridge: df900000-dfafffff
	Prefetchable memory behind bridge: 00000000d9000000-00000000d9f00000
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
	Capabilities: [64] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Advanced Error Reporting

00:05.0 PCI bridge: Intel Corporation E7520 PCI Express Port B1 (rev
09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=0a, subordinate=0c, sec-latency=0
	I/O behind bridge: 0000b000-0000cfff
	Memory behind bridge: df400000-df8fffff
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
	Capabilities: [64] Express Root Port (Slot-) IRQ 0
	Capabilities: [100] Advanced Error Reporting

00:06.0 PCI bridge: Intel Corporation E7520 PCI Express Port C (rev
09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=0d, subordinate=0f, sec-latency=0
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: df200000-df3fffff
	Prefetchable memory behind bridge: 00000000d8000000-00000000d8f00000
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
	Capabilities: [64] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Advanced Error Reporting

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell: Unknown device 016e
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 7ce0 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell: Unknown device 016e
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at 7cc0 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell: Unknown device 016e
	Flags: bus master, medium devsel, latency 0, IRQ 7
	I/O ports at 7ca0 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2
EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Dell: Unknown device 016e
	Flags: bus master, medium devsel, latency 0, IRQ 3
	Memory at dff00000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
(prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=10, subordinate=10, sec-latency=32
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: df000000-df1fffff
	Prefetchable memory behind bridge: d0000000-d7ffffff

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC
Interface Bridge (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE
Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Dell: Unknown device 016e
	Flags: bus master, medium devsel, latency 0
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at fc00 [size=16]
	Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

01:00.0 PCI bridge: Intel Corporation 80332 [Dobson] I/O processor
(rev 06) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
	Memory behind bridge: dfd00000-dfefffff
	Prefetchable memory behind bridge: 00000000da000000-00000000da000000
	Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] PCI-X bridge device.
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [300] Power Budgeting

01:00.2 PCI bridge: Intel Corporation 80332 [Dobson] I/O processor
(rev 06) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
	Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] PCI-X bridge device.
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [300] Power Budgeting

02:0e.0 RAID bus controller: Dell PowerEdge Expandable RAID controller
4 (rev 06)
	Subsystem: Dell PowerEdge Expandable RAID Controller 4e/Di
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 7
	Memory at da0f0000 (32-bit, prefetchable) [size=64K]
	Memory at dfdc0000 (32-bit, non-prefetchable) [size=256K]
	Expansion ROM at dfe00000 [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
	Capabilities: [e0] PCI-X non-bridge device.

04:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI
Bridge A (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=64
	Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] PCI-X bridge device.
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [300] Power Budgeting

04:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI
Bridge B (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=04, secondary=06, subordinate=06, sec-latency=64
	Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] PCI-X bridge device.
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [300] Power Budgeting

07:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721
Gigabit Ethernet PCI Express (rev 11)
	Subsystem: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at df9f0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
	Capabilities: [d0] Express Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [13c] Virtual Channel

0a:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI
Bridge A (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=0a, secondary=0b, subordinate=0b, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: df700000-df8fffff
	Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] PCI-X bridge device.
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [300] Power Budgeting

0a:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI
Bridge B (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=0a, secondary=0c, subordinate=0c, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: df500000-df6fffff
	Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] PCI-X bridge device.
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [300] Power Budgeting

0b:07.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit
Ethernet Controller (rev 05)
	Subsystem: Dell: Unknown device 016d
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at df7e0000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at ccc0 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.

0c:08.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit
Ethernet Controller (rev 05)
	Subsystem: Dell: Unknown device 016d
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at df5e0000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at bcc0 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.

0d:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721
Gigabit Ethernet PCI Express (rev 11)
	Subsystem: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at df2f0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
	Capabilities: [d0] Express Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [13c] Virtual Channel

10:0d.0 VGA compatible controller: ATI Technologies Inc Radeon RV100
QY [Radeon 7000/VE] (prog-if 00 [VGA])
	Subsystem: Dell: Unknown device 016e
	Flags: bus master, VGA palette snoop, stepping, medium devsel,
latency 32, IRQ 7
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 8c00 [size=256]
	Memory at df0f0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2



-- 
we who r about to die,salute u!
