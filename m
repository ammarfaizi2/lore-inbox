Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266174AbUF3Ayj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUF3Ayj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 20:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUF3Ayj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 20:54:39 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:4817 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S266174AbUF3AyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 20:54:20 -0400
Date: Tue, 29 Jun 2004 20:54:20 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: libata: 2.6.7-bk6,12 hang with ata_piix in combined mode; -bk5 ok
Message-ID: <20040630005420.GA4163@ti64.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

I have a Dell Poweredge 750 with a pair of Maxtor 250GB SATA drives
running Fedora Core 1 + upgrades to support 2.6.

The Dell BIOS configures the controller in combined mode.
Kernel 2.6.7-bk5 boots, while 2.6.7-bk6,bk12 generate the following
timeout (copied by hand):

ata_piix: combined mode detected
ACPI: PCI interrupt 0000:1f.2[A]: no GSI
ata: 0x1f0 IDE port busy
ata1: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFEA8 irq 15
ata1: dev 0 ATA, max UDMA/133 488281250 sectors: lba48
ata1: dev 1 ATA, max UDMA/133 488281250 sectors: lba48
ata1: dev0 configured for UDMA/133
ata1: dev1 configured for UDMA/133
scsi0: ata_piix
  Vendor: ATA      Model: Maxtor 7Y250M0    Rev: YAR5
  Type: Direct Access                       ANSI SCSI revision: 05
SCSI device sda: 488281250 512-byte hdwr sectors (250000MB)
SCSI device sda: drive cache: write back
 sda:<3>ata1: command 0x25 timeout, stat 0xd0 host_stat 0x64
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 00 00 00 00 00 08 00
Current sda: sense key Medium Error
Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 0
ATA: abnormal status 0xD0 on port 0x177
ATA: abnormal status 0xD0 on port 0x177
ATA: abnormal status 0xD0 on port 0x177


boot log and lspci -vvv for 2.6.7-bk5 follow.

	Bill Rugolsky


Linux version 2.6.7-bk5 (rugolsky@ti70) (gcc version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #1 Tue Jun 29 20:27:03 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
 BIOS-e820: 000000003ffc0000 - 000000003ffcfc00 (ACPI data)
 BIOS-e820: 000000003ffcfc00 - 000000003ffff000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed8ffff (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262080
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32704 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                      ) @ 0x000fdc40
ACPI: RSDT (v001 DELL   PE750    0x00000001 MSFT 0x0100000a) @ 0x000fdc54
ACPI: FADT (v001 DELL   PE750    0x00000001 MSFT 0x0100000a) @ 0x000fdc84
ACPI: MADT (v001 DELL   PE750    0x00000001 MSFT 0x0100000a) @ 0x000fdcf8
ACPI: SPCR (v001 DELL   PE750    0x00000001 MSFT 0x0100000a) @ 0x000fdd6c
ACPI: DSDT (v001 DELL    PE7xx   0x00000001 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Built 1 zonelists
Kernel command line: ro root=LABEL=/ acpi=on selinux=0 vdso=0
Initializing CPU#0
CPU 0 irqstacks, hard=c039d000 soft=c039c000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2801.122 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034972k/1048320k available (1851k kernel code, 12424k reserved, 653k data, 152k init, 130816k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5554.17 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 301k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc9de, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI3._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 9 10 11 12)
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 7
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI interrupt 0000:00:1f.2[A]: no GSI
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 3
ACPI: PCI interrupt 0000:01:01.0[A] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI interrupt 0000:03:02.0[A] -> GSI 11 (level, low) -> IRQ 11
vesafb: probe of vesafb0 failed with error -6
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1088555762.296:0): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i875 Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 4M @ 0xfe800000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: SAMSUNG CD-ROM SN-124, ATAPI CD/DVD-ROM drive
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
libata version 1.02 loaded.
ata_piix version 1.02
ata_piix: combined mode detected
ACPI: PCI interrupt 0000:00:1f.2[A]: no GSI
ata: 0x1f0 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFEA8 irq 15
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 488281250 sectors: lba48
ata1: dev 1 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
ata1: dev 1 ATA, max UDMA/133, 488281250 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata1: dev 1 configured for UDMA/133
scsi0 : ata_piix
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488281250 512-byte hdwr sectors (250000 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 488281250 512-byte hdwr sectors (250000 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
md: raid1 personality registered as nr 3
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb7 ...
md:  adding sdb7 ...
md: sdb6 has different UUID to sdb7
md: sdb5 has different UUID to sdb7
md: sdb3 has different UUID to sdb7
md: sdb2 has different UUID to sdb7
md: sdb1 has different UUID to sdb7
md:  adding sda7 ...
md: sda6 has different UUID to sdb7
md: sda5 has different UUID to sdb7
md: sda3 has different UUID to sdb7
md: sda2 has different UUID to sdb7
md: sda1 has different UUID to sdb7
md: created md7
md: bind<sda7>
md: bind<sdb7>
md: running: <sdb7><sda7>
raid1: raid set md7 active with 2 out of 2 mirrors
md: considering sdb6 ...
md:  adding sdb6 ...
md: sdb5 has different UUID to sdb6
md: sdb3 has different UUID to sdb6
md: sdb2 has different UUID to sdb6
md: sdb1 has different UUID to sdb6
md:  adding sda6 ...
md: sda5 has different UUID to sdb6
md: sda3 has different UUID to sdb6
md: sda2 has different UUID to sdb6
md: sda1 has different UUID to sdb6
md: created md6
md: bind<sda6>
md: bind<sdb6>
md: running: <sdb6><sda6>
raid1: raid set md6 active with 2 out of 2 mirrors
md: considering sdb5 ...
md:  adding sdb5 ...
md: sdb3 has different UUID to sdb5
md: sdb2 has different UUID to sdb5
md: sdb1 has different UUID to sdb5
md:  adding sda5 ...
md: sda3 has different UUID to sdb5
md: sda2 has different UUID to sdb5
md: sda1 has different UUID to sdb5
md: created md5
md: bind<sda5>
md: bind<sdb5>
md: running: <sdb5><sda5>
raid1: raid set md5 active with 2 out of 2 mirrors
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md: sdb1 has different UUID to sdb3
md:  adding sda3 ...
md: sda2 has different UUID to sdb3
md: sda1 has different UUID to sdb3
md: created md3
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
raid1: raid set md3 active with 2 out of 2 mirrors
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb1 has different UUID to sdb2
md:  adding sda2 ...
md: sda1 has different UUID to sdb2
md: created md2
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
raid1: raid set md2 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md1
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md1 active with 2 out of 2 mirrors
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 152k freed
ACPI: Power Button (FF) [PWRF]
EXT3 FS on md2, internal journal
Adding 522040k swap on /dev/md3.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
microcode: No suitable data for cpu 0
ip_tables: (C) 2000-2002 Netfilter core team
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:01:01.0[A] -> GSI 3 (level, low) -> IRQ 3
PCI: Setting latency timer of device 0000:01:01.0 to 64
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_validate_option: Transmit Descriptors set to 1024
divert: allocating divert_blk for eth0
ACPI: PCI interrupt 0000:03:02.0[A] -> GSI 11 (level, low) -> IRQ 11
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
divert: allocating divert_blk for eth1
ip_tables: (C) 2000-2002 Netfilter core team
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
process `snmptrapd' is using obsolete setsockopt SO_BSDCOMPAT
lp: driver loaded but no devices found
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel



00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fe800000 (32-bit, prefetchable) [size=4M]
        Capabilities: <available only to root>

00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fe100000-fe2fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1c.0 PCI bridge: Intel Corp. Enterprise Southbridge Hublink PCI-X Bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: <available only to root>

00:1d.0 USB Controller: Intel Corp. Enterprise Southbridge USB 1.1 UHCI (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 0165
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at cce0 [size=32]

00:1d.1 USB Controller: Intel Corp. Enterprise Southbridge USB 1.1 UHCI (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 0165
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at ccc0 [size=32]

00:1d.4 System peripheral: Intel Corp. Enterprise Southbridge Watchdog Timer (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 0165
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at fe300400 (32-bit, non-prefetchable) [size=16]

00:1d.5 PIC: Intel Corp. Enterprise Southbridge IOxAPIC (rev 02) (prog-if 20 [IO(X)-APIC])
        Subsystem: Dell Computer Corporation: Unknown device 0165
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: <available only to root>

00:1d.7 USB Controller: Intel Corp. Enterprise Southbridge USB 2.0 EHCI (rev 02) (prog-if 20 [EHCI])
        Subsystem: Dell Computer Corporation: Unknown device 0165
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 7
        Region 0: Memory at fe300000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev 0a) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fc000000-fdffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. Enterprise Southbridge ISA Bridge (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.2 IDE interface: Intel Corp. Enterprise Southbridge SATA cc=IDE (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell Computer Corporation: Unknown device 0165
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fea0 [size=16]

00:1f.3 SMBus: Intel Corp. Enterprise Southbridge SMBUS (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 0165
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at 08c0 [size=32]

01:01.0 Ethernet controller: Intel Corp. 82547GI Gigabit Ethernet Controller
        Subsystem: Dell Computer Corporation: Unknown device 0165
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (63750ns min), cache line size 10
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at fe1e0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at ece0 [size=32]
        Capabilities: <available only to root>

03:02.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller
        Subsystem: Dell Computer Corporation: Unknown device 0165
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), cache line size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fdee0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at dcc0 [size=64]
        Capabilities: <available only to root>

03:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 0165
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 10
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at fdedf000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

