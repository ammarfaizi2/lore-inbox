Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264920AbUFHJiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbUFHJiY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUFHJiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:38:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42460 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264920AbUFHJhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:37:14 -0400
Date: Tue, 8 Jun 2004 11:37:12 +0200 (CEST)
From: Jan Brezina <morf@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: DMA dosn't work on VIA vt8237 with >2.6.5
Message-ID: <Pine.LNX.4.58.0406080151220.32035@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
problem: DMA can not be enabled : hdparm : HDIO_SET_DMA ...
I have tried kernels 2.6.6, 2.6.7-rc2 and 2.6.5, with various
configurations, dosn't matter ...
Kernel 2.6.1 works (but there some problem with vsftp and it isn't
reported in 2.6.6 version) with probably right configuration (down).
It seems that chipset driver can not take control over ide:

VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.0
VP_IDE: port 0x01f0 already claimed by ide0
VP_IDE: port 0x0170 already claimed by ide1
VP_IDE: neither IDE port enabled (BIOS)

(I atache full listings from dmesg, lspci -vvv from 2.6.5 kernel;
with presented 2.6.1 configuration)

Jan

-------------------- 2.6.1 working configuration
#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

--------------- dmesg from 2.6.5
Linux version 2.6.5-gentoo (root@morfik) (gcc version 3.3.2 20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #1 Tue Jun 8 00:40:54 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
found SMP MP-table at 000f4c90
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 GBT                                       ) @ 0x000f6560
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x0fff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x0fff3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x0fff72c0
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Gentoo ro root=302 /dev/hdc=ide-scsi idex=dma
ide_setup: idex=dma -- BAD OPTION
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1674.932 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 255076k/262080k available (2359k kernel code, 6268k reserved, 753k data, 352k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3293.18 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2000+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1674.0235 MHz.
..... host bus clock speed is 267.0877 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfa010, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [ALKA] (IRQs 20)
ACPI: PCI Interrupt Link [ALKB] (IRQs 21)
ACPI: PCI Interrupt Link [ALKC] (IRQs 22)
ACPI: PCI Interrupt Link [ALKD] (IRQs 23)
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:09[A] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
00:00:09[B] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
00:00:09[C] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
00:00:09[D] -> 2-16 -> IRQ 16
_CRS returns NULL! Using IRQ 21 fordevice (PCI Interrupt Link [ALKB]).
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
_CRS returns NULL! Using IRQ 20 fordevice (PCI Interrupt Link [ALKA]).
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:00:11[A] -> 2-20 -> IRQ 20
_CRS returns NULL! Using IRQ 22 fordevice (PCI Interrupt Link [ALKC]).
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
_CRS returns NULL! Using IRQ 23 fordevice (PCI Interrupt Link [ALKD]).
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
00:00:11[D] -> 2-23 -> IRQ 23
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    C1
 11 001 01  1    1    0   1   0    1    1    A9
 12 001 01  1    1    0   1   0    1    1    B1
 13 001 01  1    1    0   1   0    1    1    B9
 14 001 01  1    1    0   1   0    1    1    D1
 15 001 01  1    1    0   1   0    1    1    C9
 16 001 01  1    1    0   1   0    1    1    D9
 17 001 01  1    1    0   1   0    1    1    E1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.6 [Flags: R/O].
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.2, from 11 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Intel(R) PRO/10GbE Network Driver - version 1.0.47-k1jg
Copyright (c) 2001-2003 Intel Corporation.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: WDC WD800JB-00ETA0, ATA DISK drive
hdc: TEAC CD-W552E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: Host Protected Area detected.
	current capacity is 156299375 sectors (80025 MB)
	native  capacity is 156301488 sectors (80026 MB)
hda: 156299375 sectors (80025 MB) w/8192KiB Cache, CHS=16383/255/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p4 < p5 >
hdc: ATAPI 52X CD-ROM CD-R/RW CD-MRW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 21, pci mem d080c000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. USB
uhci_hcd 0000:00:10.0: irq 21, io base 0000d400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. USB (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 0000d800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. USB (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 0000dc00
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 352k freed
Adding 1951856k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
VP_IDE: IDE controller at PCI slot 0000:00:0f.0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.0
VP_IDE: port 0x01f0 already claimed by ide0
VP_IDE: port 0x0170 already claimed by ide1
VP_IDE: neither IDE port enabled (BIOS)
NTFS volume version 3.0.
PCI: Setting latency timer of device 0000:00:11.5 to 64
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xd09e3000, 00:0d:61:1c:58:66, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8101'
eth0: link up, 10Mbps, half-duplex, lpa 0x0000

-------------- lspci -vvv from 2.6.5
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable)
	Capabilities: [80] AGP version 3.5
		Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: da000000-dbffffff
	Prefetchable memory behind bridge: d8000000-d9ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.0 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 10
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at dc000000 (32-bit, non-prefetchable)
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
	Subsystem: Giga-byte Technology: Unknown device 5001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
	Subsystem: Giga-byte Technology GA-7VAX Onboard Audio (Realtek ALC650)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 22
	Region 0: I/O ports at e400
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Giga-byte Technology GA-7VM400M Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at e800
	Region 1: Memory at dc001000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at da000000 (32-bit, non-prefetchable)
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


---------------------------------------------------------------
 Jan Brezina - morf; MFF UK - matematika;
 morf@atrey.karlin.mff.cuni.cz
---------------------------------------------------------------
