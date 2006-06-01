Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWFAXsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWFAXsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWFAXsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:48:03 -0400
Received: from gw.goop.org ([64.81.55.164]:18074 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750993AbWFAXsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:48:02 -0400
Message-ID: <447F7CAE.4050204@goop.org>
Date: Thu, 01 Jun 2006 16:47:58 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, auke-jan.h.kok@intel.com,
       cramerj@intel.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: e1000 fails to load sometimes: The EEPROM Checksum Is Not Valid
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.17-rc5-mm2 (and other kernels), the e1000 fails to load 
sometimes, with the message:

Intel(R) PRO/1000 Network Driver - version 7.0.38-k4-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:02:00.0 to 64
e1000: 0000:02:00.0: e1000_probe: The EEPROM Checksum Is Not Valid
e1000: probe of 0000:02:00.0 failed with error -5


Sometimes it will do this after several modprobe/rmmod cycles, and then 
it will load OK.  Once loaded, it seems to work perfectly.

This is this built-in e1000 in a Thinkpad X60:
02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet 
Controller

The full lspci output:

00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub (rev 03)
        Subsystem: Lenovo Unknown device 2017
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation Mobile Integrated Graphics Controller (rev 03) (prog-if 00 [VGA])
        Subsystem: Lenovo Unknown device 201a
        Flags: bus master, fast devsel, latency 0, IRQ 20
        Memory at ee100000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 1800 [size=8]
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Memory at ee200000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
        Capabilities: [d0] Power Management version 2

00:02.1 Display controller: Intel Corporation Mobile Integrated Graphics Controller (rev 03)
        Subsystem: Lenovo Unknown device 201a
        Flags: fast devsel
        Memory at ee180000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 2

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
        Subsystem: Lenovo Unknown device 2010
        Flags: bus master, fast devsel, latency 0, IRQ 22
        Memory at ee240000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: ee000000-ee0fffff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00003000-00004fff
        Memory behind bridge: ec000000-edffffff
        Prefetchable memory behind bridge: 00000000e4000000-00000000e4000000
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=0b, sec-latency=0
        I/O behind bridge: 00005000-00006fff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: 00000000e4100000-00000000e4100000
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4 (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=0c, subordinate=13, sec-latency=0
        I/O behind bridge: 00007000-00008fff
        Memory behind bridge: ea000000-ebffffff
        Prefetchable memory behind bridge: 00000000e4200000-00000000e4200000
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Lenovo Unknown device 200a
        Flags: bus master, medium devsel, latency 0, IRQ 20
        I/O ports at 1820 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Lenovo Unknown device 200a
        Flags: bus master, medium devsel, latency 0, IRQ 22
        I/O ports at 1840 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Lenovo Unknown device 200a
        Flags: bus master, medium devsel, latency 0, IRQ 23
        I/O ports at 1860 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Lenovo Unknown device 200a
        Flags: bus master, medium devsel, latency 0, IRQ 21
        I/O ports at 1880 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Lenovo Unknown device 200b
        Flags: bus master, medium devsel, latency 0, IRQ 21
        Memory at ee444000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2) (prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=15, subordinate=18, sec-latency=32
        I/O behind bridge: 00009000-0000cfff
        Memory behind bridge: e4300000-e7ffffff
        Prefetchable memory behind bridge: 00000000e0000000-00000000e3f00000
        Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 02)
        Subsystem: Lenovo Unknown device 2009
        Flags: bus master, medium devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Lenovo Unknown device 200c
        Flags: bus master, medium devsel, latency 0, IRQ 20
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1810 [size=16]

00:1f.2 SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controllers cc=AHCI (rev 02) (prog-if 01 [AHCI 1.0])
        Subsystem: Lenovo Unknown device 200d
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 20
        I/O ports at 18d0 [size=8]
        I/O ports at 18c4 [size=4]
        I/O ports at 18c8 [size=8]
        I/O ports at 18c0 [size=4]
        I/O ports at 18b0 [size=16]
        Memory at ee444400 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
        Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
        Subsystem: Lenovo Unknown device 200f
        Flags: medium devsel, IRQ 11
        I/O ports at 18e0 [size=32]

02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet Controller
        Subsystem: Lenovo Unknown device 207e
        Flags: bus master, fast devsel, latency 0, IRQ 20
        Memory at ee000000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 2000 [size=32]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [e0] Express Endpoint IRQ 0

03:00.0 Ethernet controller: Atheros Communications, Inc. AR5212 802.11abg NIC (rev 01)
        Subsystem: IBM Unknown device 058a
        Flags: bus master, fast devsel, latency 0, IRQ 22
        Memory at edf00000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
        Capabilities: [60] Express Legacy Endpoint IRQ 0
        Capabilities: [90] MSI-X: Enable- Mask- TabSize=1

15:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b4)
        Subsystem: Lenovo Unknown device 201c
        Flags: bus master, medium devsel, latency 168, IRQ 20
        Memory at e4300000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=15, secondary=16, subordinate=17, sec-latency=176
        Memory window 0: e0000000-e1fff000 (prefetchable)
        Memory window 1: e6000000-e7fff000
        I/O window 0: 00009000-000090ff
        I/O window 1: 00009400-000094ff
        16-bit legacy interface ports at 0001

15:00.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 09) (prog-if 10 [OHCI])
        Subsystem: Lenovo Unknown device 201e
        Flags: bus master, medium devsel, latency 64, IRQ 22
        Memory at e4301000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2

15:00.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 18)
        Subsystem: Lenovo Unknown device 201d
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at e4301800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2


What's going on here?  How can this be fixed?

Thanks,
    J
