Return-Path: <linux-kernel-owner+w=401wt.eu-S1751288AbXANWoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbXANWoP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 17:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbXANWoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 17:44:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:45458 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751288AbXANWoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 17:44:13 -0500
X-Authenticated: #5039886
Date: Sun, 14 Jan 2007 23:44:09 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: jeff@garzik.org
Cc: linux-kernel@vger.kernel.org, htejun@gmail.com
Subject: SATA exceptions with 2.6.20-rc5
Message-ID: <20070114224409.GA17199@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	jeff@garzik.org, linux-kernel@vger.kernel.org, htejun@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with 2.6.20-rc{2,4,5} (no other tested yet) I see SATA exceptions quite
often, with 2.6.19 there are no such exceptions. dmesg and lspci -v
output follows. In the meantime, I'll start bisecting.

Thanks
Björn


Linux version 2.6.20-rc2 (doener@atjola) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #4 SMP Sun Dec 31 12:54:22 CET 2006
Command line: root=/dev/md0 ro quiet 
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fee0000 (usable)
 BIOS-e820: 000000007fee0000 - 000000007fee3000 (ACPI NVS)
 BIOS-e820: 000000007fee3000 - 000000007fef0000 (ACPI data)
 BIOS-e820: 000000007fef0000 - 000000007ff00000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524000) 1 entries of 256 used
end_pfn_map = 1048576
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7a70
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fee3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fee30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000007fee9540
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x000000007fee9780
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fee9480
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524000) 1 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524000
On node 0 totalpages: 523903
  DMA zone: 56 pages used for memmap
  DMA zone: 1122 pages reserved
  DMA zone: 2821 pages, LIFO batch:0
  DMA32 zone: 7108 pages used for memmap
  DMA32 zone: 512796 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
Nvidia board detected. Ignoring ACPI timer override.
If you got timer trouble try acpi_use_timer_override
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 80000000 (gap: 7ff00000:60100000)
PERCPU: Allocating 32000 bytes of per cpu data
Built 1 zonelists.  Total pages: 515617
Kernel command line: root=/dev/md0 ro quiet 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ 5a74000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 2059000k/2096000k available (2795k kernel code, 36392k reserved, 1089k data, 224k init)
Calibrating delay using timer specific routine.. 4422.42 BogoMIPS (lpj=22112114)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
Freeing SMP alternatives: 28k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12558084
Detected 12.558 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4420.44 BogoMIPS (lpj=22102213)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 89 cycles, maxerr 393 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2210.219 MHz processor.
migration_cost=327
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:05:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs *3 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
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
SCSI subsystem initialized
libata version 2.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:09.0
  IO window: c000-cfff
  MEM window: fc000000-fdffffff
  PREFETCH window: fea00000-feafffff
PCI: Bridge: 0000:00:0b.0
  IO window: b000-bfff
  MEM window: fe900000-fe9fffff
  PREFETCH window: fe800000-fe8fffff
PCI: Bridge: 0000:00:0c.0
  IO window: a000-afff
  MEM window: fe700000-fe7fffff
  PREFETCH window: fe600000-fe6fffff
PCI: Bridge: 0000:00:0d.0
  IO window: 9000-9fff
  MEM window: fe500000-fe5fffff
  PREFETCH window: fe400000-fe4fffff
PCI: Bridge: 0000:00:0e.0
  IO window: 8000-8fff
  MEM window: f4000000-fbffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
io scheduler noop registered
io scheduler deadline registered (default)
0000:00:02.1 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
PCI: Found disabled HT MSI Mapping on 0000:00:0b.0
PCI: MSI quirk detected. MSI disabled on chipset 0000:00:0b.0.
PCI: Found disabled HT MSI Mapping on 0000:00:0c.0
PCI: MSI quirk detected. MSI disabled on chipset 0000:00:0c.0.
PCI: Found disabled HT MSI Mapping on 0000:00:0d.0
PCI: MSI quirk detected. MSI disabled on chipset 0000:00:0d.0.
PCI: Found disabled HT MSI Mapping on 0000:00:0e.0
PCI: MSI quirk detected. MSI disabled on chipset 0000:00:0e.0.
PCI: Setting latency timer of device 0000:00:0b.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
ACPI: Thermal Zone [THRM] (40 C)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
tg3.c:v3.71 (December 15, 2006)
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:04:00.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:04:00.0 to 64
eth0: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000Base-T Ethernet 00:e0:81:55:09:b0
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: TOSHIBA DVD-ROM SD-M1502, ATAPI CD/DVD-ROM drive
hdb: AOPEN CD-RW CRW4852 1.00 20030123, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 48X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdb: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
sata_nv 0000:00:07.0: version 3.2
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 23
sata_nv 0000:00:07.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0xFFFFC20000004480 ctl 0xFFFFC200000044A0 bmdma 0xD400 irq 23
ata2: SATA max UDMA/133 cmd 0xFFFFC20000004580 ctl 0xFFFFC200000045A0 bmdma 0xD408 irq 23
scsi0 : sata_nv
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 160086528 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 160086528 sectors: LBA 
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0 ANSI: 5
ata1: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0 ANSI: 5
ata2: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3
sd 1:0:0:0: Attached scsi disk sdb
usbmon: debugfs is not available
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 22, io mem 0xfeb00000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 21, io mem 0xfebff000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
usb 1-5: new high speed USB device using ehci_hcd and address 2
usb 1-5: configuration #1 chosen from 1 choice
usb 2-6: new full speed USB device using ohci_hcd and address 2
usb 2-6: configuration #1 chosen from 1 choice
hub 2-6:1.0: USB hub found
hub 2-6:1.0: 4 ports detected
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x04F9 pid 0x0022
usb 2-6.3: new low speed USB device using ohci_hcd and address 3
usb 2-6.3: configuration #1 chosen from 1 choice
usb 2-6.4: new low speed USB device using ohci_hcd and address 4
usb 2-6.4: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver hiddev
input: Lite-On Tech IBM USB Keyboard with UltraNav as /class/input/input2
input: USB HID v1.10 Keyboard [Lite-On Tech IBM USB Keyboard with UltraNav] on usb-0000:00:02.0-6.3
input: Lite-On Tech IBM USB Keyboard with UltraNav as /class/input/input3
input: USB HID v1.10 Device [Lite-On Tech IBM USB Keyboard with UltraNav] on usb-0000:00:02.0-6.3
input: Synaptics Inc. Composite TouchPad / TrackPoint as /class/input/input4
input: USB HID v1.00 Mouse [Synaptics Inc. Composite TouchPad / TrackPoint] on usb-0000:00:02.0-6.4
input: Synaptics Inc. Composite TouchPad / TrackPoint as /class/input/input5
input: USB HID v1.00 Mouse [Synaptics Inc. Composite TouchPad / TrackPoint] on usb-0000:00:02.0-6.4
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 KBD port at 0x60,0x64 irq 1
gameport: EMU10K1 is pci0000:01:08.1/gameport0, io 0xc400, speed 1205kHz
mice: PS/2 mouse device common for all mice
md: raid1 personality registered for level 1
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.14rc1 (Wed Dec 20 08:11:48 2006 UTC).
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 19
sidewinder.c: unknown joystick device detected on pci0000:01:08.1/gameport0, contact <vojtech@ucw.cz>
sidewinder.c: ID packet, 225 bits. [153952b1b912b1b913b1ab5295a95ab52912b52913b1291a95291ab12]
sidewinder.c: Data packet, 5 bits. [ff]
ALSA device list:
  #0: Audigy 1 [SB0090] (rev.3, serial:0x531102) at 0xc800, irq 19
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ processors (version 2.00.00)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0xe
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb1 has different UUID to sdb3
md:  adding sda3 ...
md: sda1 has different UUID to sdb3
md: created md1
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
raid1: raid set md1 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 224k freed
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:0a.0 to 64
forcedeth: using HIGHDMA
eth1: forcedeth.c: subsystem: 010f1:2865 bound to 0000:00:0a.0
Adding 979956k swap on /dev/sda2.  Priority:-1 extents:1 across:979956k
Adding 979956k swap on /dev/sdb2.  Priority:-2 extents:1 across:979956k
EXT3 FS on md0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth1: no link during initialization.
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:05:00.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:05:00.0 to 64
NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-9631  Thu Nov  9 17:35:27 PST 2006
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA





00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
	Subsystem: Tyan Computer Unknown device 2865
	Flags: bus master, 66MHz, fast devsel, latency 0
	Capabilities: <access denied>

00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
	Subsystem: Tyan Computer Unknown device 2865
	Flags: bus master, 66MHz, fast devsel, latency 0

00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
	Subsystem: Tyan Computer Unknown device 2865
	Flags: 66MHz, fast devsel, IRQ 7
	I/O ports at fc00 [size=32]
	I/O ports at 1c00 [size=64]
	I/O ports at 1c40 [size=64]
	Capabilities: <access denied>

00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) (prog-if 10 [OHCI])
	Subsystem: Tyan Computer Unknown device 2865
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
	Memory at febff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>

00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: Tyan Computer Unknown device 2865
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
	Memory at feb00000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <access denied>

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a [Master SecP PriP])
	Subsystem: Tyan Computer Unknown device 2865
	Flags: bus master, 66MHz, fast devsel, latency 0
	[virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	[virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	[virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	[virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	I/O ports at e800 [size=16]
	Capabilities: <access denied>

00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: Tyan Computer Unknown device 2865
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
	I/O ports at 09f0 [size=8]
	I/O ports at 0bf0 [size=4]
	I/O ports at 0970 [size=8]
	I/O ports at 0b70 [size=4]
	I/O ports at d400 [size=16]
	Memory at febfc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>

00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) (prog-if 01 [Subtractive decode])
	Flags: bus master, 66MHz, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: fea00000-feafffff

00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
	Subsystem: Tyan Computer Unknown device 2865
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 20
	Memory at febfb000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at d000 [size=8]
	Capabilities: <access denied>

00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fe900000-fe9fffff
	Prefetchable memory behind bridge: 00000000fe800000-00000000fe8fffff
	Capabilities: <access denied>

00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: fe700000-fe7fffff
	Prefetchable memory behind bridge: 00000000fe600000-00000000fe6fffff
	Capabilities: <access denied>

00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: fe500000-fe5fffff
	Prefetchable memory behind bridge: 00000000fe400000-00000000fe4fffff
	Capabilities: <access denied>

00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: f4000000-fbffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Capabilities: <access denied>

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: <access denied>

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel

01:05.0 Display controller: ATI Technologies Inc Rage XL (rev 27)
	Flags: stepping, medium devsel, IRQ 10
	Memory at fc000000 (32-bit, non-prefetchable) [disabled] [size=16M]
	I/O ports at cc00 [disabled] [size=256]
	Memory at fdfff000 (32-bit, non-prefetchable) [disabled] [size=4K]
	[virtual] Expansion ROM at fea00000 [disabled] [size=128K]
	Capabilities: <access denied>

01:08.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
	Subsystem: Creative Labs SB0090 Audigy Player/OEM
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at c800 [size=32]
	Capabilities: <access denied>

01:08.1 Input device controller: Creative Labs SB Audigy Game Port (rev 03)
	Subsystem: Creative Labs SB Audigy MIDI/Game Port
	Flags: bus master, medium devsel, latency 32
	I/O ports at c400 [size=8]
	Capabilities: <access denied>

01:08.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (prog-if 10 [OHCI])
	Subsystem: Creative Labs SB Audigy FireWire Port
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at fdffe000 (32-bit, non-prefetchable) [size=2K]
	Memory at fdff8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>

04:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 11)
	Subsystem: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express
	Flags: bus master, fast devsel, latency 0, IRQ 19
	Memory at fe5f0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <access denied>

05:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600] (rev a2) (prog-if 00 [VGA])
	Flags: bus master, fast devsel, latency 0, IRQ 18
	Memory at f4000000 (32-bit, non-prefetchable) [size=64M]
	Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Memory at fa000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at f8000000 [disabled] [size=128K]
	Capabilities: <access denied>

