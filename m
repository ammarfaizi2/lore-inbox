Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423791AbWJaS7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423791AbWJaS7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423795AbWJaS7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:59:35 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:23056 "EHLO
	smtp-vbr6.xs4all.nl") by vger.kernel.org with ESMTP
	id S1423791AbWJaS7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:59:31 -0500
Date: Tue, 31 Oct 2006 19:59:21 +0100
From: jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: scary message 'failed to recover some devices ... retrying' HPT370
Message-ID: <20061031185921.GA3636@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a whim, after reading about recent developments, I tried to boot
2.6.19-rc4-mm1 with only the new SATA drivers active, and all PATA
drivers inactive.

This is an Asus A8N-SLI Premium motherboard, with 8 sata drives on the
NForce chipset and on a SiL3114 controller, 3 pata devices (2 hd, 1 dvd
writer) on the motherboards PATA connectors and, for good measure, 2
additional hds on a HPT374 4-port PATA raid card, in JBOD mode.

The message reads 'ata11: failed to recover some devices, retrying in 5
secs' in this part:

pata_hpt37x: BIOS has not set timing clocks.
hpt37x: HPT374: Bus clock 33MHz.
ACPI: PCI Interrupt 0000:05:06.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
ata11: PATA max UDMA/133 cmd 0x6000 ctl 0x6402 bmdma 0x7000 irq 16
ata12: PATA max UDMA/133 cmd 0x6800 ctl 0x6C02 bmdma 0x7008 irq 16
scsi10 : pata_hpt37x
ata11.00: ATA-6, max UDMA/100, 488397168 sectors: LBA48
ata11.00: ata11: dev 0 multi count 16
ata11.01: failed to IDENTIFY (I/O error, err_mask=0x1)
ata11: failed to recover some devices, retrying in 5 secs
ata11.01: failed to IDENTIFY (I/O error, err_mask=0x1)
ata11: failed to recover some devices, retrying in 5 secs
ata11.01: failed to IDENTIFY (I/O error, err_mask=0x1)
ata11: failed to recover some devices, retrying in 5 secs
Find mode for 12 reports A81F442
Find mode for DMA 69 reports 12848242
ata11.00: configured for UDMA/100
scsi11 : pata_hpt37x
ATA: abnormal status 0x8 on port 0x6807
scsi 10:0:0:0: Direct-Access     ATA      WDC WD2500JB-00F 15.0 PQ: 0 ANSI: 5
SCSI device sdk: 488397168 512-byte hdwr sectors (250059 MB)
sdk: Write Protect is off
sdk: Mode Sense: 00 3a 00 00
SCSI device sdk: drive cache: write back
SCSI device sdk: 488397168 512-byte hdwr sectors (250059 MB)
sdk: Write Protect is off
sdk: Mode Sense: 00 3a 00 00
SCSI device sdk: drive cache: write back
 sdk: sdk1
sd 10:0:0:0: Attached scsi disk sdk
sd 10:0:0:0: Attached scsi generic sg11 type 0
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: HPT374: Bus clock 33MHz.
ACPI: PCI Interrupt 0000:05:06.1[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
ata13: PATA max UDMA/133 cmd 0x7400 ctl 0x7802 bmdma 0x8400 irq 16
ata14: PATA max UDMA/133 cmd 0x7C00 ctl 0x8002 bmdma 0x8408 irq 16
scsi12 : pata_hpt37x
ata13.00: ATA-7, max UDMA/100, 586072368 sectors: LBA48
ata13.00: ata13: dev 0 multi count 16
Find mode for 12 reports A81F442
Find mode for DMA 69 reports 12848242
ata13.00: configured for UDMA/100
scsi13 : pata_hpt37x
ATA: abnormal status 0x8 on port 0x7C07
scsi 12:0:0:0: Direct-Access     ATA      ST3300831A       3.01 PQ: 0 ANSI: 5
SCSI device sdl: 586072368 512-byte hdwr sectors (300069 MB)
sdl: Write Protect is off
sdl: Mode Sense: 00 3a 00 00
SCSI device sdl: drive cache: write back
SCSI device sdl: 586072368 512-byte hdwr sectors (300069 MB)
sdl: Write Protect is off
sdl: Mode Sense: 00 3a 00 00
SCSI device sdl: drive cache: write back
 sdl: sdl1

It seems that one of the empty ports on the HPT374 card is giving these
scary messages. Why only one of the empty ports? lspci -v and dmesg
(both for 2.6.19-rc4-mm1 with regular PATA drivers and without) included
below.

Are these messages anything to worry about?

Kind regards,
Jurriaan
[please note: I'm subscribed to lkml, not to linux-ide]

lspci -v:

00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
	Subsystem: ASUSTeK Computer Inc. Unknown device 815a
	Flags: bus master, 66MHz, fast devsel, latency 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
	Capabilities: [e0] HyperTransport: MSI Mapping

00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0

00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: 66MHz, fast devsel, IRQ 7
	I/O ports at e400 [size=32]
	I/O ports at 4c00 [size=64]
	I/O ports at 4c40 [size=64]
	Capabilities: [44] Power Management version 2

00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
	Memory at da004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 20
	Memory at feb00000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] Debug port
	Capabilities: [80] Power Management version 2

00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Controller (rev a2)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 7
	I/O ports at dc00 [size=256]
	I/O ports at e000 [size=256]
	Memory at da003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0
	[virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	[virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	[virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	[virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2

00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: ASUSTeK Computer Inc. Unknown device 815a
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
	I/O ports at 09f0 [size=8]
	I/O ports at 0bf0 [size=4]
	I/O ports at 0970 [size=8]
	I/O ports at 0b70 [size=4]
	I/O ports at d800 [size=16]
	Memory at da002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
	I/O ports at 09e0 [size=8]
	I/O ports at 0be0 [size=4]
	I/O ports at 0960 [size=8]
	I/O ports at 0b60 [size=4]
	I/O ports at c400 [size=16]
	Memory at da001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) (prog-if 01 [Subtractive decode])
	Flags: bus master, 66MHz, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=128
	I/O behind bridge: 00006000-0000afff
	Memory behind bridge: d8000000-d9ffffff
	Prefetchable memory behind bridge: da100000-da1fffff

00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
	Memory at da000000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at b000 [size=8]
	Capabilities: [44] Power Management version 2

00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d0000000-d7ffffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000cfffffff
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel

01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600] (rev a2) (prog-if 00 [VGA])
	Flags: bus master, fast devsel, latency 0, IRQ 18
	Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
	Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Memory at d4000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at d5000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [78] Express Endpoint IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting

05:06.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc. Unknown device 0001
	Flags: bus master, 66MHz, medium devsel, latency 120, IRQ 16
	I/O ports at 6000 [size=8]
	I/O ports at 6400 [size=4]
	I/O ports at 6800 [size=8]
	I/O ports at 6c00 [size=4]
	I/O ports at 7000 [size=256]
	Expansion ROM at da1c0000 [disabled by cmd] [size=128K]
	Capabilities: [60] Power Management version 2

05:06.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc. Unknown device 0001
	Flags: bus master, 66MHz, medium devsel, latency 120, IRQ 16
	I/O ports at 7400 [size=8]
	I/O ports at 7800 [size=4]
	I/O ports at 7c00 [size=8]
	I/O ports at 8000 [size=4]
	I/O ports at 8400 [size=256]
	Capabilities: [60] Power Management version 2

05:07.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Lite-On Communications Inc LNE100TX
	Flags: bus master, medium devsel, latency 32, IRQ 17
	I/O ports at 8800 [size=256]
	Memory at d900f000 (32-bit, non-prefetchable) [size=256]
	[virtual] Expansion ROM at da180000 [disabled] [size=256K]

05:08.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
	Subsystem: Creative Labs Unknown device 2001
	Flags: bus master, medium devsel, latency 32, IRQ 18
	I/O ports at 8c00 [size=64]
	Capabilities: [dc] Power Management version 2

05:08.1 Input device controller: Creative Labs SB Audigy Game Port (rev 04)
	Subsystem: Creative Labs SB Audigy MIDI/Game Port
	Flags: bus master, medium devsel, latency 32
	I/O ports at 9000 [size=8]
	Capabilities: [dc] Power Management version 2

05:08.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04) (prog-if 10 [OHCI])
	Subsystem: Creative Labs SB Audigy FireWire Port
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at d900e000 (32-bit, non-prefetchable) [size=2K]
	Memory at d9000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

05:0a.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8167
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 19
	I/O ports at 9400 [size=8]
	I/O ports at 9800 [size=4]
	I/O ports at 9c00 [size=8]
	I/O ports at a000 [size=4]
	I/O ports at a400 [size=16]
	Memory at d900c000 (32-bit, non-prefetchable) [size=1K]
	[virtual] Expansion ROM at da100000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2

05:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 16
	Memory at d900d000 (32-bit, non-prefetchable) [size=2K]
	Memory at d9004000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

05:0c.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
	Subsystem: ASUSTeK Computer Inc. Marvell 88E8001 Gigabit Ethernet Controller (Asus)
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 17
	Memory at d9008000 (32-bit, non-prefetchable) [size=16K]
	I/O ports at a800 [size=256]
	[virtual] Expansion ROM at da1e0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data

dmesg for 2.6.19-rc4-mm1 with PATA drivers:

Linux version 2.6.19-rc4-mm1 (jurriaan@middle) (gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)) #8 SMP Tue Oct 31 19:10:57 CET 2006
Command line: root=/dev/md2 video=nvidiafb:1600x1200-32@85 atkbd.softrepeat=1
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c800 (usable)
 BIOS-e820: 000000000009c800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
Entering add_active_range(0, 0, 156) 0 entries of 256 used
Entering add_active_range(0, 256, 786416) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1310720) 2 entries of 256 used
end_pfn_map = 1310720
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7d30
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x00000000bfff9900
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x00000000bfff9b80
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff9cc0
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff9840
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
Entering add_active_range(0, 0, 156) 0 entries of 256 used
Entering add_active_range(0, 256, 786416) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1310720) 2 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1310720
early_node_map[3] active PFN ranges
    0:        0 ->      156
    0:      256 ->   786416
    0:  1048576 ->  1310720
On node 0 totalpages: 1048460
  DMA zone: 56 pages used for memmap
  DMA zone: 1852 pages reserved
  DMA zone: 2088 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 768040 pages, LIFO batch:31
  Normal zone: 3584 pages used for memmap
  Normal zone: 258560 pages, LIFO batch:31
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009c000 - 000000000009d000
Nosave address range: 000000000009d000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Nosave address range: 00000000bfff0000 - 00000000bfff3000
Nosave address range: 00000000bfff3000 - 00000000c0000000
Nosave address range: 00000000c0000000 - 00000000e0000000
Nosave address range: 00000000e0000000 - 00000000f0000000
Nosave address range: 00000000f0000000 - 00000000fec00000
Nosave address range: 00000000fec00000 - 0000000100000000
Allocating PCI resources starting at c2000000 (gap: c0000000:20000000)
PERCPU: Allocating 31936 bytes of per cpu data
Built 1 zonelists.  Total pages: 1028688
Kernel command line: root=/dev/md2 video=nvidiafb:1600x1200-32@85 atkbd.softrepeat=1
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Memory: 4042632k/5242880k available (3945k kernel code, 150996k reserved, 2407k data, 288k init)
Calibrating delay using timer specific routine.. 5042.57 BogoMIPS (lpj=2521288)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
Freeing SMP alternatives: 44k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 13128039
Detected 13.128 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5040.43 BogoMIPS (lpj=2520217)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -76 cycles, maxerr 588 cycles)
Brought up 2 CPUs
testing NMI watchdog ... CPU#0: NMI appears to be stuck (111->116)!
CPU#1: NMI appears to be stuck (60->65)!
Uhhuh. NMI received for unknown reason 3d.
Do you have a strange power saving mode enabled?
Dazed and confused, but trying to continue
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2520.581 MHz processor.
Uhhuh. NMI received for unknown reason 00.
Do you have a strange power saving mode enabled?
Dazed and confused, but trying to continue
migration_cost=141
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000
PCI: No mmconfig possible on device 00:18
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:05:08.2[B] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[d900e000-d900e7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[16]  MMIO=[d900d000-d900d7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
PCI: Bridge: 0000:00:09.0
  IO window: 6000-afff
  MEM window: d8000000-d9ffffff
  PREFETCH window: da100000-da1fffff
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: d0000000-d7ffffff
  PREFETCH window: c0000000-cfffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Coda Kernel/Venus communications, v6.0.0, coda@cs.cmu.edu
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/O].
io scheduler noop registered
io scheduler cfq registered (default)
PCI: Linking AER extended capability on 0000:00:0b.0
PCI: Linking AER extended capability on 0000:00:0c.0
PCI: Linking AER extended capability on 0000:00:0d.0
PCI: Linking AER extended capability on 0000:00:0e.0
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
Allocate Port Service[0000:00:0b.0:pcie03]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
Allocate Port Service[0000:00:0c.0:pcie03]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
Allocate Port Service[0000:00:0d.0:pcie03]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
Allocate Port Service[0000:00:0e.0:pcie03]
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
nvidiafb: Device ID: 10de0141 
nvidiafb: CRTC0 analog found
nvidiafb: CRTC1 analog found
nvidiafb: EDID found from BUS2
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 160x66
nvidiafb: PCI nVidia NV14 framebuffer (64MB @ 0xC0000000)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
skge 1.9 addr 0xd9008000 irq 17 chip Yukon-Lite rev 9
skge eth0: addr 00:15:f2:20:e6:69
Marvell 88E1101: Registered new driver
Davicom DM9161E: Registered new driver
Davicom DM9131: Registered new driver
Cicada Cis8204: Registered new driver
Cicada Cis8201: Registered new driver
LXT970: Registered new driver
LXT971: Registered new driver
QS6612: Registered new driver
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:0a.0 to 64
forcedeth: using HIGHDMA
eth1: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
Linux Tulip driver version 1.1.14 (May 11, 2002)
ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
eth2: Lite-On 82c168 PNIC rev 32 at Port 0x8800, 00:A0:CC:21:89:0C, IRQ 17.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD2000JB-32EVA0, ATA DISK drive
ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
hdb: _NEC DVD_RW ND-3540A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d80000738f5d]
hdc: WDC WD2000JB-00FUA0, ATA DISK drive
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[00023c014100f4bf]
ide1 at 0x170-0x177,0x376 on irq 15
HPT374: IDE controller at PCI slot 0000:05:06.0
ACPI: PCI Interrupt 0000:05:06.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
HPT374: chipset revision 7
HPT374: DPLL base: 48 MHz, f_CNT: 147, assuming 33 MHz PCI
HPT374: using 66 MHz DPLL clock
HPT374: 100% native mode on irq 16
    ide2: BM-DMA at 0x7000-0x7007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x7008-0x700f, BIOS settings: hdg:pio, hdh:pio
ACPI: PCI Interrupt 0000:05:06.1[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
HPT374: no clock data saved by BIOS
HPT374: DPLL base: 48 MHz, f_CNT: 122, assuming 33 MHz PCI
HPT374: using 66 MHz DPLL clock
    ide4: BM-DMA at 0x8400-0x8407, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0x8408-0x840f, BIOS settings: hdk:pio, hdl:pio
Probing IDE interface ide2...
hde: WDC WD2500JB-00FUA0, ATA DISK drive
ide2 at 0x6000-0x6007,0x6402 on irq 16
Probing IDE interface ide3...
Probing IDE interface ide4...
hdi: ST3300831A, ATA DISK drive
ide4 at 0x7400-0x7407,0x7802 on irq 16
Probing IDE interface ide5...
Probing IDE interface ide3...
Probing IDE interface ide5...
hda: max request size: 512KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
hdc: max request size: 512KiB
hdc: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 hdc8 hdc9 >
hde: max request size: 512KiB
hde: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
hde: cache flushes supported
 hde: hde1
hdi: max request size: 512KiB
hdi: 586072368 sectors (300069 MB) w/8192KiB Cache, CHS=36481/255/63, UDMA(100)
hdi: cache flushes supported
 hdi: hdi1
hdb: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
RocketRAID 3xxx SATA Controller driver v1.0 (060426)
libata version 2.00 loaded.
sata_sil 0000:05:0a.0: version 2.0
ACPI: PCI Interrupt 0000:05:0a.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 19
sata_sil 0000:05:0a.0: Applying R_ERR on DMA activate FIS errata fix
ata1: SATA max UDMA/100 cmd 0xFFFFC200100BA080 ctl 0xFFFFC200100BA08A bmdma 0xFFFFC200100BA000 irq 19
ata2: SATA max UDMA/100 cmd 0xFFFFC200100BA0C0 ctl 0xFFFFC200100BA0CA bmdma 0xFFFFC200100BA008 irq 19
ata3: SATA max UDMA/100 cmd 0xFFFFC200100BA280 ctl 0xFFFFC200100BA28A bmdma 0xFFFFC200100BA200 irq 19
ata4: SATA max UDMA/100 cmd 0xFFFFC200100BA2C0 ctl 0xFFFFC200100BA2CA bmdma 0xFFFFC200100BA208 irq 19
scsi0 : sata_sil
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/100
scsi2 : sata_sil
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/100
scsi3 : sata_sil
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata4.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata4.00: ata4: dev 0 multi count 16
ata4.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
sd 2:0:0:0: Attached scsi generic sg2 type 0
scsi 3:0:0:0: Direct-Access     ATA      ST3250823AS      3.02 PQ: 0 ANSI: 5
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
sd 3:0:0:0: Attached scsi generic sg3 type 0
sata_nv 0000:00:07.0: version 3.1
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) -> IRQ 22
sata_nv 0000:00:07.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata5: SATA max UDMA/133 cmd 0xFFFFC200100BC480 ctl 0xFFFFC200100BC4A0 bmdma 0xD800 irq 22
ata6: SATA max UDMA/133 cmd 0xFFFFC200100BC580 ctl 0xFFFFC200100BC5A0 bmdma 0xD808 irq 22
Losing some ticks... checking if CPU frequency changed.
scsi4 : sata_nv
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 31/32)
ata5.00: ata5: dev 0 multi count 1
ata5.00: configured for UDMA/133
scsi5 : sata_nv
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
ata6.00: ata6: dev 0 multi count 1
ata6.00: configured for UDMA/133
scsi 4:0:0:0: Direct-Access     ATA      ST3300622AS      3.AA PQ: 0 ANSI: 5
ata5: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sde: 586072368 512-byte hdwr sectors (300069 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
SCSI device sde: 586072368 512-byte hdwr sectors (300069 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
 sde: sde1 sde2
sd 4:0:0:0: Attached scsi disk sde
sd 4:0:0:0: Attached scsi generic sg4 type 0
scsi 5:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
ata6: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
 sdf: sdf1
sd 5:0:0:0: Attached scsi disk sdf
sd 5:0:0:0: Attached scsi generic sg5 type 0
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level, low) -> IRQ 21
sata_nv 0000:00:08.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata7: SATA max UDMA/133 cmd 0xFFFFC200100BE480 ctl 0xFFFFC200100BE4A0 bmdma 0xC400 irq 21
ata8: SATA max UDMA/133 cmd 0xFFFFC200100BE580 ctl 0xFFFFC200100BE5A0 bmdma 0xC408 irq 21
scsi6 : sata_nv
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 31/32)
ata7.00: ata7: dev 0 multi count 1
ata7.00: configured for UDMA/133
scsi7 : sata_nv
ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
ata8.00: ata8: dev 0 multi count 1
ata8.00: configured for UDMA/133
scsi 6:0:0:0: Direct-Access     ATA      ST3300622AS      3.AA PQ: 0 ANSI: 5
ata7: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sdg: 586072368 512-byte hdwr sectors (300069 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
SCSI device sdg: 586072368 512-byte hdwr sectors (300069 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
 sdg: sdg1 sdg2
sd 6:0:0:0: Attached scsi disk sdg
sd 6:0:0:0: Attached scsi generic sg6 type 0
scsi 7:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
ata8: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
 sdh: sdh1
sd 7:0:0:0: Attached scsi disk sdh
sd 7:0:0:0: Attached scsi generic sg7 type 0
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: HPT374: Bus clock 33MHz.
PCI: Unable to reserve I/O region #1:8@7400 for device 0000:05:06.1
pata_hpt37x: probe of 0000:05:06.1 failed with error -16
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 20, io mem 0xfeb00000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.19-rc4-mm1 ehci_hcd
usb usb1: SerialNumber: 0000:00:02.1
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 23, io mem 0xda004000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.19-rc4-mm1 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
i2c /dev entries driver
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
raid6: int64x1   2328 MB/s
raid6: int64x2   3148 MB/s
raid6: int64x4   3035 MB/s
raid6: int64x8   2050 MB/s
raid6: sse2x1    2320 MB/s
raid6: sse2x2    3285 MB/s
raid6: sse2x4    3929 MB/s
raid6: using algorithm sse2x4 (3929 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  8036.000 MB/sec
raid5: using function: generic_sse (8036.000 MB/sec)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
NET: Registered protocol family 8
NET: Registered protocol family 20
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ processors (version 2.00.00)
powernow-k8:    0 : fid 0x10 (2400 MHz), vid 0x8
powernow-k8:    1 : fid 0xe (2200 MHz), vid 0xa
powernow-k8:    2 : fid 0xc (2000 MHz), vid 0xc
powernow-k8:    3 : fid 0xa (1800 MHz), vid 0xe
powernow-k8:    4 : fid 0x2 (1000 MHz), vid 0x12
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
logips2pp: Detected unknown logitech mouse model 1
input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdh1 ...
md:  adding sdh1 ...
md:  adding sdg1 ...
md:  adding sdf1 ...
md:  adding sde1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: hdc9 has different UUID to sdh1
md: hdc8 has different UUID to sdh1
md: hdc7 has different UUID to sdh1
md: hdc6 has different UUID to sdh1
md: hdc5 has different UUID to sdh1
md: hda9 has different UUID to sdh1
md: hda8 has different UUID to sdh1
md: hda7 has different UUID to sdh1
md: hda6 has different UUID to sdh1
md: hda5 has different UUID to sdh1
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: bind<sde1>
md: bind<sdf1>
md: bind<sdg1>
md: bind<sdh1>
md: running: <sdh1><sdg1><sdf1><sde1><sdd1><sdc1><sdb1><sda1>
raid5: device sdh1 operational as raid disk 1
raid5: device sdg1 operational as raid disk 0
raid5: device sdf1 operational as raid disk 5
raid5: device sde1 operational as raid disk 6
raid5: device sdd1 operational as raid disk 7
raid5: device sdc1 operational as raid disk 3
raid5: device sdb1 operational as raid disk 2
raid5: device sda1 operational as raid disk 4
raid5: allocated 8462kB for md0
raid5: raid level 6 set md0 active with 8 out of 8 devices, algorithm 2
RAID5 conf printout:
 --- rd:8 wd:8
 disk 0, o:1, dev:sdg1
 disk 1, o:1, dev:sdh1
 disk 2, o:1, dev:sdb1
 disk 3, o:1, dev:sdc1
 disk 4, o:1, dev:sda1
 disk 5, o:1, dev:sdf1
 disk 6, o:1, dev:sde1
 disk 7, o:1, dev:sdd1
md0: bitmap initialized from disk: read 15/15 pages, set 1 bits, status: 0
created bitmap (233 pages) for device md0
md: considering hdc9 ...
md:  adding hdc9 ...
md: hdc8 has different UUID to hdc9
md: hdc7 has different UUID to hdc9
md: hdc6 has different UUID to hdc9
md: hdc5 has different UUID to hdc9
md:  adding hda9 ...
md: hda8 has different UUID to hdc9
md: hda7 has different UUID to hdc9
md: hda6 has different UUID to hdc9
md: hda5 has different UUID to hdc9
md: created md4
md: bind<hda9>
md: bind<hdc9>
md: running: <hdc9><hda9>
raid1: raid set md4 active with 2 out of 2 mirrors
md4: bitmap initialized from disk: read 10/10 pages, set 48 bits, status: 0
created bitmap (156 pages) for device md4
md: considering hdc8 ...
md:  adding hdc8 ...
md: hdc7 has different UUID to hdc8
md: hdc6 has different UUID to hdc8
md: hdc5 has different UUID to hdc8
md:  adding hda8 ...
md: hda7 has different UUID to hdc8
md: hda6 has different UUID to hdc8
md: hda5 has different UUID to hdc8
md: created md3
md: bind<hda8>
md: bind<hdc8>
md: running: <hdc8><hda8>
raid1: raid set md3 active with 2 out of 2 mirrors
md3: bitmap initialized from disk: read 8/8 pages, set 5 bits, status: 0
created bitmap (123 pages) for device md3
md: considering hdc7 ...
md:  adding hdc7 ...
md: hdc6 has different UUID to hdc7
md: hdc5 has different UUID to hdc7
md:  adding hda7 ...
md: hda6 has different UUID to hdc7
md: hda5 has different UUID to hdc7
md: created md2
md: bind<hda7>
md: bind<hdc7>
md: running: <hdc7><hda7>
raid1: raid set md2 active with 2 out of 2 mirrors
md2: bitmap initialized from disk: read 8/8 pages, set 83 bits, status: 0
created bitmap (123 pages) for device md2
md: considering hdc6 ...
md:  adding hdc6 ...
md: hdc5 has different UUID to hdc6
md:  adding hda6 ...
md: hda5 has different UUID to hdc6
md: created md1
md: bind<hda6>
md: bind<hdc6>
md: running: <hdc6><hda6>
raid1: raid set md1 active with 2 out of 2 mirrors
md1: bitmap initialized from disk: read 12/12 pages, set 70 bits, status: 0
created bitmap (184 pages) for device md1
md: considering hdc5 ...
md:  adding hdc5 ...
md:  adding hda5 ...
md: created md5
md: bind<hda5>
md: bind<hdc5>
md: running: <hdc5><hda5>
raid1: raid set md5 active with 2 out of 2 mirrors
md5: bitmap initialized from disk: read 9/9 pages, set 0 bits, status: 0
created bitmap (129 pages) for device md5
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 288k freed
Adding 4200888k swap on /dev/md5.  Priority:-1 extents:1 across:4200888k
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md2, internal journal
i2c_adapter i2c-3: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-4: nForce2 SMBus adapter at 0x4c40
it87: Found IT8712F chip at 0x290, revision 7
it87: in3 is VCC (+5V)
it87: in7 is VCCH (+5V Stand-By)
it87-isa 9191-0290: Detected broken BIOS defaults, disabling PWM interface
ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
Installing spdif_bug patch: Audigy 2 ZS [2001]
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: md4: found reiserfs format "3.6" with standard journal
ReiserFS: md4: using ordered data mode
ReiserFS: md4: journal params: device md4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md4: checking transaction log (md4)
ReiserFS: md4: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hde1: found reiserfs format "3.6" with standard journal
ReiserFS: hde1: using ordered data mode
ReiserFS: hde1: journal params: device hde1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hde1: checking transaction log (hde1)
ReiserFS: hde1: Using r5 hash to sort names
ReiserFS: sde2: found reiserfs format "3.6" with standard journal
ReiserFS: sde2: using ordered data mode
ReiserFS: sde2: journal params: device sde2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sde2: checking transaction log (sde2)
ReiserFS: sde2: Using r5 hash to sort names
ReiserFS: sdg2: found reiserfs format "3.6" with standard journal
ReiserFS: sdg2: using ordered data mode
ReiserFS: sdg2: journal params: device sdg2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdg2: checking transaction log (sdg2)
ReiserFS: sdg2: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdi1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_tables: (C) 2000-2006 Netfilter Core Team
switch: Setting full-duplex based on MII#1 link partner capability of 8de1.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 312 bytes per conntrack
adsl: no IPv6 routers present
switch: no IPv6 routers present

dmesg for 2.6.19-rc4-mm1 without PATA drivers:
Linux version 2.6.19-rc4-mm1 (jurriaan@middle) (gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)) #9 SMP Tue Oct 31 19:27:17 CET 2006
Command line: root=/dev/md2 video=nvidiafb:1600x1200-32@85
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c800 (usable)
 BIOS-e820: 000000000009c800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
Entering add_active_range(0, 0, 156) 0 entries of 256 used
Entering add_active_range(0, 256, 786416) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1310720) 2 entries of 256 used
end_pfn_map = 1310720
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7d30
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x00000000bfff9900
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x00000000bfff9b80
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff9cc0
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff9840
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
Entering add_active_range(0, 0, 156) 0 entries of 256 used
Entering add_active_range(0, 256, 786416) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1310720) 2 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1310720
early_node_map[3] active PFN ranges
    0:        0 ->      156
    0:      256 ->   786416
    0:  1048576 ->  1310720
On node 0 totalpages: 1048460
  DMA zone: 56 pages used for memmap
  DMA zone: 1841 pages reserved
  DMA zone: 2099 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 768040 pages, LIFO batch:31
  Normal zone: 3584 pages used for memmap
  Normal zone: 258560 pages, LIFO batch:31
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009c000 - 000000000009d000
Nosave address range: 000000000009d000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Nosave address range: 00000000bfff0000 - 00000000bfff3000
Nosave address range: 00000000bfff3000 - 00000000c0000000
Nosave address range: 00000000c0000000 - 00000000e0000000
Nosave address range: 00000000e0000000 - 00000000f0000000
Nosave address range: 00000000f0000000 - 00000000fec00000
Nosave address range: 00000000fec00000 - 0000000100000000
Allocating PCI resources starting at c2000000 (gap: c0000000:20000000)
PERCPU: Allocating 31936 bytes of per cpu data
Built 1 zonelists.  Total pages: 1028699
Kernel command line: root=/dev/md2 video=nvidiafb:1600x1200-32@85
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Memory: 4042676k/5242880k available (3924k kernel code, 150952k reserved, 2389k data, 284k init)
Calibrating delay using timer specific routine.. 5042.57 BogoMIPS (lpj=2521288)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
Freeing SMP alternatives: 44k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 13127938
Detected 13.127 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5040.43 BogoMIPS (lpj=2520217)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -76 cycles, maxerr 588 cycles)
Brought up 2 CPUs
testing NMI watchdog ... CPU#0: NMI appears to be stuck (111->116)!
CPU#1: NMI appears to be stuck (60->65)!
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2520.562 MHz processor.
Uhhuh. NMI received for unknown reason 2d.
Do you have a strange power saving mode enabled?
Dazed and confused, but trying to continue
Uhhuh. NMI received for unknown reason 00.
Do you have a strange power saving mode enabled?
Dazed and confused, but trying to continue
migration_cost=161
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000
PCI: No mmconfig possible on device 00:18
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:05:08.2[B] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[d900e000-d900e7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[16]  MMIO=[d900d000-d900d7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
PCI: Bridge: 0000:00:09.0
  IO window: 6000-afff
  MEM window: d8000000-d9ffffff
  PREFETCH window: da100000-da1fffff
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: d0000000-d7ffffff
  PREFETCH window: c0000000-cfffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Coda Kernel/Venus communications, v6.0.0, coda@cs.cmu.edu
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/O].
io scheduler noop registered
io scheduler cfq registered (default)
PCI: Linking AER extended capability on 0000:00:0b.0
PCI: Linking AER extended capability on 0000:00:0c.0
PCI: Linking AER extended capability on 0000:00:0d.0
PCI: Linking AER extended capability on 0000:00:0e.0
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
Allocate Port Service[0000:00:0b.0:pcie03]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
Allocate Port Service[0000:00:0c.0:pcie03]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
Allocate Port Service[0000:00:0d.0:pcie03]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
Allocate Port Service[0000:00:0e.0:pcie03]
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
nvidiafb: Device ID: 10de0141 
nvidiafb: CRTC0 analog found
nvidiafb: CRTC1 analog found
nvidiafb: EDID found from BUS2
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 160x66
nvidiafb: PCI nVidia NV14 framebuffer (64MB @ 0xC0000000)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
skge 1.9 addr 0xd9008000 irq 17 chip Yukon-Lite rev 9
skge eth0: addr 00:15:f2:20:e6:69
Marvell 88E1101: Registered new driver
Davicom DM9161E: Registered new driver
Davicom DM9131: Registered new driver
Cicada Cis8204: Registered new driver
Cicada Cis8201: Registered new driver
LXT970: Registered new driver
LXT971: Registered new driver
QS6612: Registered new driver
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:0a.0 to 64
forcedeth: using HIGHDMA
eth1: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
Linux Tulip driver version 1.1.14 (May 11, 2002)
ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
eth2: Lite-On 82c168 PNIC rev 32 at Port 0x8800, 00:A0:CC:21:89:0C, IRQ 17.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
RocketRAID 3xxx SATA Controller driver v1.0 (060426)
libata version 2.00 loaded.
sata_sil 0000:05:0a.0: version 2.0
ACPI: PCI Interrupt 0000:05:0a.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 19
sata_sil 0000:05:0a.0: Applying R_ERR on DMA activate FIS errata fix
ata1: SATA max UDMA/100 cmd 0xFFFFC20000056080 ctl 0xFFFFC2000005608A bmdma 0xFFFFC20000056000 irq 19
ata2: SATA max UDMA/100 cmd 0xFFFFC200000560C0 ctl 0xFFFFC200000560CA bmdma 0xFFFFC20000056008 irq 19
ata3: SATA max UDMA/100 cmd 0xFFFFC20000056280 ctl 0xFFFFC2000005628A bmdma 0xFFFFC20000056200 irq 19
ata4: SATA max UDMA/100 cmd 0xFFFFC200000562C0 ctl 0xFFFFC200000562CA bmdma 0xFFFFC20000056208 irq 19
scsi0 : sata_sil
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : sata_sil
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[00023c014100f4bf]
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d80000738f5d]
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/100
scsi2 : sata_sil
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/100
scsi3 : sata_sil
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata4.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata4.00: ata4: dev 0 multi count 16
ata4.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
sd 2:0:0:0: Attached scsi generic sg2 type 0
scsi 3:0:0:0: Direct-Access     ATA      ST3250823AS      3.02 PQ: 0 ANSI: 5
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
sd 3:0:0:0: Attached scsi generic sg3 type 0
sata_nv 0000:00:07.0: version 3.1
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) -> IRQ 22
sata_nv 0000:00:07.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata5: SATA max UDMA/133 cmd 0xFFFFC200100BC480 ctl 0xFFFFC200100BC4A0 bmdma 0xD800 irq 22
ata6: SATA max UDMA/133 cmd 0xFFFFC200100BC580 ctl 0xFFFFC200100BC5A0 bmdma 0xD808 irq 22
scsi4 : sata_nv
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 31/32)
ata5.00: ata5: dev 0 multi count 1
ata5.00: configured for UDMA/133
scsi5 : sata_nv
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
ata6.00: ata6: dev 0 multi count 1
ata6.00: configured for UDMA/133
scsi 4:0:0:0: Direct-Access     ATA      ST3300622AS      3.AA PQ: 0 ANSI: 5
ata5: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sde: 586072368 512-byte hdwr sectors (300069 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
SCSI device sde: 586072368 512-byte hdwr sectors (300069 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
 sde: sde1 sde2
sd 4:0:0:0: Attached scsi disk sde
sd 4:0:0:0: Attached scsi generic sg4 type 0
scsi 5:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
ata6: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
 sdf: sdf1
sd 5:0:0:0: Attached scsi disk sdf
sd 5:0:0:0: Attached scsi generic sg5 type 0
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level, low) -> IRQ 21
sata_nv 0000:00:08.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata7: SATA max UDMA/133 cmd 0xFFFFC200100BE480 ctl 0xFFFFC200100BE4A0 bmdma 0xC400 irq 21
ata8: SATA max UDMA/133 cmd 0xFFFFC200100BE580 ctl 0xFFFFC200100BE5A0 bmdma 0xC408 irq 21
scsi6 : sata_nv
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 31/32)
ata7.00: ata7: dev 0 multi count 1
ata7.00: configured for UDMA/133
scsi7 : sata_nv
ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
ata8.00: ata8: dev 0 multi count 1
ata8.00: configured for UDMA/133
scsi 6:0:0:0: Direct-Access     ATA      ST3300622AS      3.AA PQ: 0 ANSI: 5
ata7: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sdg: 586072368 512-byte hdwr sectors (300069 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
SCSI device sdg: 586072368 512-byte hdwr sectors (300069 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
 sdg: sdg1 sdg2
sd 6:0:0:0: Attached scsi disk sdg
sd 6:0:0:0: Attached scsi generic sg6 type 0
scsi 7:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
ata8: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
 sdh: sdh1
sd 7:0:0:0: Attached scsi disk sdh
sd 7:0:0:0: Attached scsi generic sg7 type 0
pata_amd 0000:00:06.0: version 0.2.4
PCI: Setting latency timer of device 0000:00:06.0 to 64
ata9: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata10: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi8 : pata_amd
ata9.00: ATA-6, max UDMA/100, 390721968 sectors: LBA48 
ata9.00: ata9: dev 0 multi count 1
ata9.01: ATAPI, max UDMA/33
ata9.00: configured for UDMA/100
ata9.01: configured for UDMA/33
scsi9 : pata_amd
ata10.00: ATA-6, max UDMA/100, 390721968 sectors: LBA48 
ata10.00: ata10: dev 0 multi count 1
ata10.00: configured for UDMA/100
scsi 8:0:0:0: Direct-Access     ATA      WDC WD2000JB-32E 15.0 PQ: 0 ANSI: 5
SCSI device sdi: 390721968 512-byte hdwr sectors (200050 MB)
Losing some ticks... checking if CPU frequency changed.
sdi: Write Protect is off
sdi: Mode Sense: 00 3a 00 00
SCSI device sdi: drive cache: write back
SCSI device sdi: 390721968 512-byte hdwr sectors (200050 MB)
sdi: Write Protect is off
sdi: Mode Sense: 00 3a 00 00
SCSI device sdi: drive cache: write back
 sdi: sdi1 sdi2 < sdi5 sdi6 sdi7 sdi8 sdi9 >
sd 8:0:0:0: Attached scsi disk sdi
sd 8:0:0:0: Attached scsi generic sg8 type 0
scsi 8:0:1:0: CD-ROM            _NEC     DVD_RW ND-3540A  1.01 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 8:0:1:0: Attached scsi CD-ROM sr0
sr 8:0:1:0: Attached scsi generic sg9 type 5
scsi 9:0:0:0: Direct-Access     ATA      WDC WD2000JB-00F 15.0 PQ: 0 ANSI: 5
SCSI device sdj: 390721968 512-byte hdwr sectors (200050 MB)
sdj: Write Protect is off
sdj: Mode Sense: 00 3a 00 00
SCSI device sdj: drive cache: write back
SCSI device sdj: 390721968 512-byte hdwr sectors (200050 MB)
sdj: Write Protect is off
sdj: Mode Sense: 00 3a 00 00
SCSI device sdj: drive cache: write back
 sdj: sdj1 sdj2 < sdj5 sdj6 sdj7 sdj8 sdj9 >
sd 9:0:0:0: Attached scsi disk sdj
sd 9:0:0:0: Attached scsi generic sg10 type 0
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: HPT374: Bus clock 33MHz.
ACPI: PCI Interrupt 0000:05:06.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
ata11: PATA max UDMA/133 cmd 0x6000 ctl 0x6402 bmdma 0x7000 irq 16
ata12: PATA max UDMA/133 cmd 0x6800 ctl 0x6C02 bmdma 0x7008 irq 16
scsi10 : pata_hpt37x
ata11.00: ATA-6, max UDMA/100, 488397168 sectors: LBA48 
ata11.00: ata11: dev 0 multi count 16
ata11.01: failed to IDENTIFY (I/O error, err_mask=0x1)
ata11: failed to recover some devices, retrying in 5 secs
ata11.01: failed to IDENTIFY (I/O error, err_mask=0x1)
ata11: failed to recover some devices, retrying in 5 secs
ata11.01: failed to IDENTIFY (I/O error, err_mask=0x1)
ata11: failed to recover some devices, retrying in 5 secs
Find mode for 12 reports A81F442
Find mode for DMA 69 reports 12848242
ata11.00: configured for UDMA/100
scsi11 : pata_hpt37x
ATA: abnormal status 0x8 on port 0x6807
scsi 10:0:0:0: Direct-Access     ATA      WDC WD2500JB-00F 15.0 PQ: 0 ANSI: 5
SCSI device sdk: 488397168 512-byte hdwr sectors (250059 MB)
sdk: Write Protect is off
sdk: Mode Sense: 00 3a 00 00
SCSI device sdk: drive cache: write back
SCSI device sdk: 488397168 512-byte hdwr sectors (250059 MB)
sdk: Write Protect is off
sdk: Mode Sense: 00 3a 00 00
SCSI device sdk: drive cache: write back
 sdk: sdk1
sd 10:0:0:0: Attached scsi disk sdk
sd 10:0:0:0: Attached scsi generic sg11 type 0
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: HPT374: Bus clock 33MHz.
ACPI: PCI Interrupt 0000:05:06.1[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
ata13: PATA max UDMA/133 cmd 0x7400 ctl 0x7802 bmdma 0x8400 irq 16
ata14: PATA max UDMA/133 cmd 0x7C00 ctl 0x8002 bmdma 0x8408 irq 16
scsi12 : pata_hpt37x
ata13.00: ATA-7, max UDMA/100, 586072368 sectors: LBA48 
ata13.00: ata13: dev 0 multi count 16
Find mode for 12 reports A81F442
Find mode for DMA 69 reports 12848242
ata13.00: configured for UDMA/100
scsi13 : pata_hpt37x
ATA: abnormal status 0x8 on port 0x7C07
scsi 12:0:0:0: Direct-Access     ATA      ST3300831A       3.01 PQ: 0 ANSI: 5
SCSI device sdl: 586072368 512-byte hdwr sectors (300069 MB)
sdl: Write Protect is off
sdl: Mode Sense: 00 3a 00 00
SCSI device sdl: drive cache: write back
SCSI device sdl: 586072368 512-byte hdwr sectors (300069 MB)
sdl: Write Protect is off
sdl: Mode Sense: 00 3a 00 00
SCSI device sdl: drive cache: write back
 sdl: sdl1
sd 12:0:0:0: Attached scsi disk sdl
sd 12:0:0:0: Attached scsi generic sg12 type 0
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 20, io mem 0xfeb00000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.19-rc4-mm1 ehci_hcd
usb usb1: SerialNumber: 0000:00:02.1
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 23, io mem 0xda004000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.19-rc4-mm1 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
i2c /dev entries driver
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
raid6: int64x1   2339 MB/s
raid6: int64x2   3156 MB/s
raid6: int64x4   2992 MB/s
raid6: int64x8   2070 MB/s
raid6: sse2x1    2386 MB/s
raid6: sse2x2    3367 MB/s
raid6: sse2x4    3929 MB/s
raid6: using algorithm sse2x4 (3929 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  8040.000 MB/sec
raid5: using function: generic_sse (8040.000 MB/sec)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
NET: Registered protocol family 8
NET: Registered protocol family 20
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ processors (version 2.00.00)
powernow-k8:    0 : fid 0x10 (2400 MHz), vid 0x8
powernow-k8:    1 : fid 0xe (2200 MHz), vid 0xa
powernow-k8:    2 : fid 0xc (2000 MHz), vid 0xc
powernow-k8:    3 : fid 0xa (1800 MHz), vid 0xe
powernow-k8:    4 : fid 0x2 (1000 MHz), vid 0x12
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
logips2pp: Detected unknown logitech mouse model 1
input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdj9 ...
md:  adding sdj9 ...
md: sdj8 has different UUID to sdj9
md: sdj7 has different UUID to sdj9
md: sdj6 has different UUID to sdj9
md: sdj5 has different UUID to sdj9
md:  adding sdi9 ...
md: sdi8 has different UUID to sdj9
md: sdi7 has different UUID to sdj9
md: sdi6 has different UUID to sdj9
md: sdi5 has different UUID to sdj9
md: sdh1 has different UUID to sdj9
md: sdg1 has different UUID to sdj9
md: sdf1 has different UUID to sdj9
md: sde1 has different UUID to sdj9
md: sdd1 has different UUID to sdj9
md: sdc1 has different UUID to sdj9
md: sdb1 has different UUID to sdj9
md: sda1 has different UUID to sdj9
md: created md4
md: bind<sdi9>
md: bind<sdj9>
md: running: <sdj9><sdi9>
raid1: raid set md4 active with 2 out of 2 mirrors
md4: bitmap initialized from disk: read 10/10 pages, set 48 bits, status: 0
created bitmap (156 pages) for device md4
md: considering sdj8 ...
md:  adding sdj8 ...
md: sdj7 has different UUID to sdj8
md: sdj6 has different UUID to sdj8
md: sdj5 has different UUID to sdj8
md:  adding sdi8 ...
md: sdi7 has different UUID to sdj8
md: sdi6 has different UUID to sdj8
md: sdi5 has different UUID to sdj8
md: sdh1 has different UUID to sdj8
md: sdg1 has different UUID to sdj8
md: sdf1 has different UUID to sdj8
md: sde1 has different UUID to sdj8
md: sdd1 has different UUID to sdj8
md: sdc1 has different UUID to sdj8
md: sdb1 has different UUID to sdj8
md: sda1 has different UUID to sdj8
md: created md3
md: bind<sdi8>
md: bind<sdj8>
md: running: <sdj8><sdi8>
raid1: raid set md3 active with 2 out of 2 mirrors
md3: bitmap initialized from disk: read 8/8 pages, set 6 bits, status: 0
created bitmap (123 pages) for device md3
md: considering sdj7 ...
md:  adding sdj7 ...
md: sdj6 has different UUID to sdj7
md: sdj5 has different UUID to sdj7
md:  adding sdi7 ...
md: sdi6 has different UUID to sdj7
md: sdi5 has different UUID to sdj7
md: sdh1 has different UUID to sdj7
md: sdg1 has different UUID to sdj7
md: sdf1 has different UUID to sdj7
md: sde1 has different UUID to sdj7
md: sdd1 has different UUID to sdj7
md: sdc1 has different UUID to sdj7
md: sdb1 has different UUID to sdj7
md: sda1 has different UUID to sdj7
md: created md2
md: bind<sdi7>
md: bind<sdj7>
md: running: <sdj7><sdi7>
raid1: raid set md2 active with 2 out of 2 mirrors
md2: bitmap initialized from disk: read 8/8 pages, set 91 bits, status: 0
created bitmap (123 pages) for device md2
md: considering sdj6 ...
md:  adding sdj6 ...
md: sdj5 has different UUID to sdj6
md:  adding sdi6 ...
md: sdi5 has different UUID to sdj6
md: sdh1 has different UUID to sdj6
md: sdg1 has different UUID to sdj6
md: sdf1 has different UUID to sdj6
md: sde1 has different UUID to sdj6
md: sdd1 has different UUID to sdj6
md: sdc1 has different UUID to sdj6
md: sdb1 has different UUID to sdj6
md: sda1 has different UUID to sdj6
md: created md1
md: bind<sdi6>
md: bind<sdj6>
md: running: <sdj6><sdi6>
raid1: raid set md1 active with 2 out of 2 mirrors
md1: bitmap initialized from disk: read 12/12 pages, set 40 bits, status: 0
created bitmap (184 pages) for device md1
md: considering sdj5 ...
md:  adding sdj5 ...
md:  adding sdi5 ...
md: sdh1 has different UUID to sdj5
md: sdg1 has different UUID to sdj5
md: sdf1 has different UUID to sdj5
md: sde1 has different UUID to sdj5
md: sdd1 has different UUID to sdj5
md: sdc1 has different UUID to sdj5
md: sdb1 has different UUID to sdj5
md: sda1 has different UUID to sdj5
md: created md5
md: bind<sdi5>
md: bind<sdj5>
md: running: <sdj5><sdi5>
raid1: raid set md5 active with 2 out of 2 mirrors
md5: bitmap initialized from disk: read 9/9 pages, set 0 bits, status: 0
created bitmap (129 pages) for device md5
md: considering sdh1 ...
md:  adding sdh1 ...
md:  adding sdg1 ...
md:  adding sdf1 ...
md:  adding sde1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: bind<sde1>
md: bind<sdf1>
md: bind<sdg1>
md: bind<sdh1>
md: running: <sdh1><sdg1><sdf1><sde1><sdd1><sdc1><sdb1><sda1>
raid5: device sdh1 operational as raid disk 1
raid5: device sdg1 operational as raid disk 0
raid5: device sdf1 operational as raid disk 5
raid5: device sde1 operational as raid disk 6
raid5: device sdd1 operational as raid disk 7
raid5: device sdc1 operational as raid disk 3
raid5: device sdb1 operational as raid disk 2
raid5: device sda1 operational as raid disk 4
raid5: allocated 8462kB for md0
raid5: raid level 6 set md0 active with 8 out of 8 devices, algorithm 2
RAID5 conf printout:
 --- rd:8 wd:8
 disk 0, o:1, dev:sdg1
 disk 1, o:1, dev:sdh1
 disk 2, o:1, dev:sdb1
 disk 3, o:1, dev:sdc1
 disk 4, o:1, dev:sda1
 disk 5, o:1, dev:sdf1
 disk 6, o:1, dev:sde1
 disk 7, o:1, dev:sdd1
md0: bitmap initialized from disk: read 15/15 pages, set 1 bits, status: 0
created bitmap (233 pages) for device md0
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 284k freed
Adding 4200888k swap on /dev/md5.  Priority:-1 extents:1 across:4200888k
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md2, internal journal
i2c_adapter i2c-3: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-4: nForce2 SMBus adapter at 0x4c40
it87: Found IT8712F chip at 0x290, revision 7
it87: in3 is VCC (+5V)
it87: in7 is VCCH (+5V Stand-By)
it87-isa 9191-0290: Detected broken BIOS defaults, disabling PWM interface
ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
Installing spdif_bug patch: Audigy 2 ZS [2001]
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: md4: found reiserfs format "3.6" with standard journal
ReiserFS: md4: using ordered data mode
ReiserFS: md4: journal params: device md4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md4: checking transaction log (md4)
ReiserFS: md4: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: sde2: found reiserfs format "3.6" with standard journal
ReiserFS: sde2: using ordered data mode
ReiserFS: sde2: journal params: device sde2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sde2: checking transaction log (sde2)
ReiserFS: sde2: Using r5 hash to sort names
ReiserFS: sdg2: found reiserfs format "3.6" with standard journal
ReiserFS: sdg2: using ordered data mode
ReiserFS: sdg2: journal params: device sdg2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdg2: checking transaction log (sdg2)
ReiserFS: sdg2: Using r5 hash to sort names
ip_tables: (C) 2000-2006 Netfilter Core Team
switch: Setting full-duplex based on MII#1 link partner capability of 8de1.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 312 bytes per conntrack
switch: no IPv6 routers present
adsl: no IPv6 routers present
-- 
"Besides," she added with a shrug, "strategy and tactics are anathema
to the Apocalypse."
        Steven Erikson - Deadhouse Gates
Debian (Unstable) GNU/Linux 2.6.18-mm3 2x5042 bogomips load 2.04
