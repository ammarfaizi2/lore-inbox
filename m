Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbUJWQJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbUJWQJz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 12:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUJWQJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 12:09:54 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27638 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261226AbUJWQID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 12:08:03 -0400
Date: Sun, 24 Oct 2004 00:29:52 +0900 (JST)
Message-Id: <20041024.002952.78703128.masa@cs.osakafu-u.ac.jp>
To: linux-kernel@vger.kernel.org
Subject: Second SATA disk is not recognized in kernel 2.6.x
From: Masakazu Iwamura <masa@cs.osakafu-u.ac.jp>
X-Mailer: Mew version 3.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I have a trouble which relates to serial ATA (libata). In summary, my
PC boots in kernel 2.4.27 with two SATA disks normally. But, in kernel
2.6.x (I tested 2.6.8.1, 2.6.9), it boots with only one disk. The
second disk is not available. Are there any good idea to resolve this
problem?

Actually, my PC has three SATA disks. One of them includes linux
system (the boot disk). The others construct a RAID by use of a
hardware RAID system "ARAID99 2000". So, BIOS recognizes there are two
disks. The RAID system includes my home directory only. The chipset of
the motherboard is ICH5R.

In kernel 2.4.27, the first disk is recognized as /dev/hde and the
second one is as /dev/hdg. In kernel 2.6.x, the first disk is
recognized as /dev/sda. But, /dev/sdb does not appear (/dev/hdg is
also).

Thanks,
masa

============================================================
Here are logs:

------------------------------------------------------------
The output of dmesg on kernel 2.6.9
------------------------------------------------------------
Linux version 2.6.9 (masa@orange) (gcc バージョン 3.3.4 (Debian 1:3.3.4-13)) #1 Thu Oct 21 04:27:30 JST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 262064
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32688 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000fad80
ACPI: RSDT (v001 A M I  OEMRSDT  0x02000425 MSFT 0x00000097) @ 0x3ffb0000
ACPI: FADT (v002 A M I  OEMFACP  0x02000425 MSFT 0x00000097) @ 0x3ffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x02000425 MSFT 0x00000097) @ 0x3ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x02000425 MSFT 0x00000097) @ 0x3ffc0040
ACPI: DSDT (v001  A0030 A0030006 0x00000006 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2998.841 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035360k/1048256k available (2036k kernel code, 12312k reserved, 838k data, 164k init, 130752k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5931.00 BogoMIPS (lpj=2965504)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI interrupt 0000:02:0b.0[A] -> GSI 23 (level, low) -> IRQ 23
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
highmem bounce pool size: 64 pages
SGI XFS with ACLs, no debug enabled
Initializing Cryptographic API
vesafb: probe of vesafb0 failed with error -6
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: ATAPI COMBO52XMAX, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
libata version 1.02 loaded.
ata_piix version 1.02
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF90 irq 18
ata2: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF98 irq 18
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 160086528 sectors:
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
Real Time Clock Driver v1.12
hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49455 usecs
intel8x0: clocking to 48000
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
ACPI: PCI interrupt 0000:02:0b.0[A] -> GSI 23 (level, low) -> IRQ 23
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd480. Vers LK1.1.19
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000eec0
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000ef00
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0000ef20
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 16, io base 0000ef40
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f8846800
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8189 buckets, 65512 max) - 300 bytes per conntrack
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU0 updated from revision 0x17 to 0x21, date = 03242004 
IA-32 Microcode Update Driver v1.14 unregistered
------------------------------------------------------------

**

------------------------------------------------------------
The output of dmesg on kernel 2.4.27
------------------------------------------------------------
Linux version 2.4.27 (root@orange) (gcc バージョン 3.3.4 (Debian 1:3.3.4-6sarge1)) #1 SMP Mon Oct 4 18:38:12 JST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262064
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32688 pages.
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x000fad80
ACPI: RSDT (v001 A M I  OEMRSDT  0x02000425 MSFT 0x00000097) @ 0x3ffb0000
ACPI: FADT (v002 A M I  OEMFACP  0x02000425 MSFT 0x00000097) @ 0x3ffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x02000425 MSFT 0x00000097) @ 0x3ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x02000425 MSFT 0x00000097) @ 0x3ffc0040
ACPI: DSDT (v001  A0030 A0030006 0x00000006 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  Product ID:  APIC at: 0xFEE00000
I/O APIC #13 Version 32 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 2
Kernel command line: root=/dev/hde1 ro 
Initializing CPU#0
Detected 2998.629 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5989.99 BogoMIPS
Memory: 1032172k/1048256k available (2083k kernel code, 15696k reserved, 596k data, 124k init, 130752k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
per-CPU timeslice cutoff: 1462.98 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5989.99 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
Total of 2 processors activated (11979.98 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
ENABLING IO-APIC IRQs
Setting 13 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 13 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 13-0, 13-5, 13-10, 13-11, 13-21 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 23.
number of IO-APIC #13 registers: 24.
testing the IO APIC.......................

IO APIC #13......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 003 03  1    1    0   1   0    1    1    91
 11 003 03  1    1    0   1   0    1    1    99
 12 003 03  1    1    0   1   0    1    1    A1
 13 003 03  1    1    0   1   0    1    1    A9
 14 003 03  1    1    0   1   0    1    1    B1
 15 000 00  1    0    0   0   0    0    0    00
 16 003 03  1    1    0   1   0    1    1    B9
 17 003 03  1    1    0   1   0    1    1    C1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2998.5660 MHz.
..... host bus clock speed is 199.9041 MHz.
cpu: 0, clocks: 1999041, slice: 666347
CPU0<T0:1999040,T1:1332688,D:5,S:666347,C:1999041>
cpu: 1, clocks: 1999041, slice: 666347
CPU1<T0:1999040,T1:666336,D:10,S:666347,C:1999041>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B2,I3,P0) -> 20
PCI->APIC IRQ transform: (B2,I5,P0) -> 22
PCI->APIC IRQ transform: (B2,I11,P0) -> 23
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS with no debug enabled
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
floppy0: no floppy controllers found
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: unsupported bridge
agpgart: no supported devices found.
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized radeon 1.7.0 20020828 on minor 1
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
ICH5-SATA: IDE controller at PCI slot 00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: 100% native mode on irq 18
    ide2: BM-DMA at 0xef90-0xef97, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xef98-0xef9f, BIOS settings: hdg:DMA, hdh:pio
hdc: ATAPI COMBO52XMAX, ATAPI CD/DVD-ROM drive
hde: Maxtor 6Y080M0, ATA DISK drive
blk: queue c041cc78, I/O limit 4095Mb (mask 0xffffffff)
hdg: ASI ARAID99 2000 Mirror Rev 1.03, ATA DISK drive
hdh: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
hdh: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
blk: queue c041d0e4, I/O limit 4095Mb (mask 0xffffffff)
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xefe0-0xefe7,0xefae on irq 18
ide3 at 0xefa0-0xefa7,0xefaa on irq 18
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=158816/16/63, UDMA(33)
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 490234752 sectors (251000 MB), CHS=30515/255/63, UDMA(100)
Partition check:
 hde: hde1 hde2
 hdg: hdg1
SCSI subsystem driver Revision: 1.00
GDT: Storage RAID Controller Driver. Version: 2.05 
GDT: Found 0 PCI Storage RAID Controllers
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
Adding Swap: 2113768k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,1), internal journal
Real Time Clock Driver v1.10f
hdc: attached ide-cdrom driver.
hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
XFS mounting filesystem ide3(34,1)
Ending clean XFS mount for filesystem: ide3(34,1)
Intel 810 + AC97 Audio, version 1.01, 18:42:11 Oct  4 2004
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH5 found at IO 0xee80 and 0xe800, MEM 0xfebff400 and 0xfebff000, IRQ 17
i810: Intel ICH5 mmio at 0xf8930400 and 0xf8932000
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97  codec, id: ALG144 (Unknown)
i810_audio: only 48Khz playback available.
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 18:42:21 Oct  4 2004
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xeec0, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xef00, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xef20, IRQ 18
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.3 to 64
usb-uhci.c: USB UHCI at I/O 0xef40, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
sk98lin: Network Device Driver v6.22
(C)Copyright 1999-2004 Marvell(R).
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
02:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd480. Vers LK1.1.18-ac
 00:50:04:70:a1:ae, IRQ 23
  product code 5451 rev 00.12 date 03-02-99
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
02:0b.0: scatter/gather enabled. h/w checksums enabled
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8189 buckets, 65512 max) - 288 bytes per conntrack
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU0 updated from revision 0x17 to 0x21, date = 03242004 
microcode: CPU1 updated from revision 0x17 to 0x21, date = 03242004 
IA-32 Microcode Update Driver v1.14 unregistered
------------------------------------------------------------
