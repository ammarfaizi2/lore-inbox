Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265703AbUFDJu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265703AbUFDJu3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUFDJu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:50:29 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:46748 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S265715AbUFDJpo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:45:44 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: [ACPI] Asus SK8N (x86_64) motherboard ata1 DMA timeout (Promise SATA)
Date: Fri, 4 Jun 2004 10:45:36 +0100
User-Agent: KMail/1.6
Cc: len.brown@intel.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ATEwAoMhelHg9Zk"
Message-Id: <200406041045.36908.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ATEwAoMhelHg9Zk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Using linux-2.6.7-rc2 (32bit), two SATA drives on Promise TX2plus. The bios=
=20
has been upgraded to latest version 1007.

Without any kernel parameters, the i/o locks after a short time copying fil=
es.=20
Copied by hand from dmesg after i/o freeze:

ata1 DMA timeout
scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x2a 00 04 ae a2 f2 00 00 08 00
Current sda: sense =3D 70 3
ASC=3D c ASCQ=3D 2
Raw sense data: 0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 0x00=
=20
0x0c 0x02
end_request: I/O error, dev sda, sector 78553842

I guess this is interrupt related?

=46rom dmesg without kernel params (broken case)

ata1: SATA max UDMA/133 cmd 0xF8ABF200 ctl 0xF8ABF238 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xF8ABF280 ctl 0xF8ABF2B8 bmdma 0x0 irq 19

=46rom dmesg with acpi=3Doff (working fine)

ata1: SATA max UDMA/133 cmd 0xF8AB6200 ctl 0xF8AB6238 bmdma 0x0 irq 11
ata2: SATA max UDMA/133 cmd 0xF8AB6280 ctl 0xF8AB62B8 bmdma 0x0 irq 11

=46ull dmesg's are attached for working and broken cases. Let me know if I =
can=20
provide any more information.

Andrew Walrond

--Boundary-00=_ATEwAoMhelHg9Zk
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg.no_kernel_params"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.no_kernel_params"

Linux version 2.6.7-rc2 (root@orac.shed) (gcc version 3.4.0) #3 Thu Jun 3 17:02:06 GMT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bffc0000 (usable)
 BIOS-e820: 00000000bffc0000 - 00000000bffd0000 (ACPI data)
 BIOS-e820: 00000000bffd0000 - 00000000c0000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000e7000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 00000000bffc0000 (usable)
 user: 00000000bffc0000 - 00000000bffd0000 (ACPI data)
 user: 00000000bffd0000 - 00000000c0000000 (ACPI NVS)
 user: 00000000fec00000 - 00000000fec01000 (reserved)
 user: 00000000fee00000 - 00000000fee01000 (reserved)
 user: 00000000ff7c0000 - 0000000100000000 (reserved)
 user: 0000000100000000 - 0000000140000000 (usable)
Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 1048576
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 819200 pages, LIFO batch:16
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                    ) @ 0x000fa500
ACPI: XSDT (v001 A M I  OEMXSDT  0x03000429 MSFT 0x00000097) @ 0xbffc0100
ACPI: FADT (v003 A M I  OEMFACP  0x03000429 MSFT 0x00000097) @ 0xbffc0290
ACPI: MADT (v001 A M I  OEMAPIC  0x03000429 MSFT 0x00000097) @ 0xbffc0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x03000429 MSFT 0x00000097) @ 0xbffd0040
ACPI: DSDT (v001  SK8N_ SK8N_701 0x00000701 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/sda1 vga=0x307 mem=5242880K
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1400.114 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 3107364k/4194304k available (2678k kernel code, 36980k reserved, 858k data, 164k init, 2227968k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2768.89 BogoMIPS
Dentry cache hash table entries: 524288 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
CPU:     After vendor identify, caps: 078bfbff e1d3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU:     After all inits, caps: 078bfbff e1d3fbff 00000000 00000010
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Opteron(tm) Processor 240 stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-16, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22, 1-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1399.0786 MHz.
..... host bus clock speed is 199.0969 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 19) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 17) *11
ACPI: PCI Interrupt Link [LNKE] (IRQs 16) *11
ACPI: PCI Interrupt Link [LUS0] (IRQs 20) *5
ACPI: PCI Interrupt Link [LUS1] (IRQs 20) *5
ACPI: PCI Interrupt Link [LUS2] (IRQs 20) *10
ACPI: PCI Interrupt Link [LKLN] (IRQs 21) *10
ACPI: PCI Interrupt Link [LAUI] (IRQs 21) *11
ACPI: PCI Interrupt Link [LKMO] (IRQs 21) *0, disabled.
ACPI: PCI Interrupt Link [LKSM] (IRQs 22) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 22) *0, disabled.
    ACPI-0201: *** Error: Return object type is incorrect [\_SB_.LATA._CRS] (Node f7f6f388), AE_TYPE
ACPI: PCI Interrupt Link [LATA] (IRQs 22) *0
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LKSM] enabled at IRQ 22
00:00:01[A] -> 1-22 -> IRQ 22 level high
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 20
00:00:02[A] -> 1-20 -> IRQ 20 level high
ACPI: PCI Interrupt Link [LAUI] enabled at IRQ 21
00:00:06[A] -> 1-21 -> IRQ 21 level high
ACPI: PCI Interrupt Link [LKMO] enabled at IRQ 21
ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 20
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 20
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 16
00:00:0b[A] -> 1-16 -> IRQ 16 level high
ACPI: PCI Interrupt Link [LKLN] enabled at IRQ 21
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 17
00:01:03[A] -> 1-17 -> IRQ 17 level high
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 18
00:01:03[B] -> 1-18 -> IRQ 18 level high
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 19
00:01:03[C] -> 1-19 -> IRQ 19 level high
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 17
number of MP IRQ sources: 15.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................
IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  1    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   0   0    1    1    C1
 11 001 01  1    1    0   0   0    1    1    C9
 12 001 01  1    1    0   0   0    1    1    D1
 13 001 01  1    1    0   0   0    1    1    D9
 14 001 01  1    1    0   0   0    1    1    B1
 15 001 01  1    1    0   0   0    1    1    B9
 16 001 01  1    1    0   0   0    1    1    A9
 17 000 00  1    0    0   0   0    0    0    00
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
.................................... done.
PCI: Using ACPI for IRQ routing
vesafb: framebuffer at 0xe0000000, mapped to 0xf8809000, size 2560k
vesafb: mode is 1280x1024x8, linelength=1280, pages=1
vesafb: protected mode interface info at c000:e350
vesafb: scrolling: redraw
mtrr: type mismatch for e0000000,200000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,100000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,80000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,40000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,20000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,10000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,8000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,4000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,2000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,1000 old: uncachable new: write-combining
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x800  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x400  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x200  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x100  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x80  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x40  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x20  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x10  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x8  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x4  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x2  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x1  base: 0xe0000000
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
highmem bounce pool size: 64 pages
udf: registering filesystem
SGI XFS with large block numbers, no debug enabled
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1)
Console: switching to colour frame buffer device 160x64
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: Maximum main memory to use for agp memory: 3932M
agpgart: AGP aperture is 128M @ 0xf0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
PCI: Enabling device 0000:00:05.0 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:05.0 to 64
eth0: forcedeth.c: subsystem: 01043:80c5 bound to 0000:00:05.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3: IDE controller at PCI slot 0000:00:08.0
NFORCE3: chipset revision 165
NFORCE3: not 100% native mode: will probe irqs later
NFORCE3: 0000:00:08.0 (rev a5) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: _NEC DVD_RW ND-2500A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.02 loaded.
sata_promise version 1.00
ata1: SATA max UDMA/133 cmd 0xF8ABF200 ctl 0xF8ABF238 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xF8ABF280 ctl 0xF8ABF2B8 bmdma 0x0 irq 19
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors:
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:407f
ata2: dev 0 ATA, max UDMA/133, 240121728 sectors:
ata2: dev 0 configured for UDMA/133
scsi1 : sata_promise
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
ReiserFS: sda1: using ordered data mode
ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda1: checking transaction log (sda1)
ReiserFS: sda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 164k freed
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: Using r5 hash to sort names
Adding 1959888k swap on /dev/sda5.  Priority:-1 extents:1

--Boundary-00=_ATEwAoMhelHg9Zk
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg.acpi_off"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.acpi_off"

Linux version 2.6.7-rc2 (root@orac.shed) (gcc version 3.4.0) #3 Thu Jun 3 17:02:06 GMT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bffc0000 (usable)
 BIOS-e820: 00000000bffc0000 - 00000000bffd0000 (ACPI data)
 BIOS-e820: 00000000bffd0000 - 00000000c0000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000e7000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 00000000bffc0000 (usable)
 user: 00000000bffc0000 - 00000000bffd0000 (ACPI data)
 user: 00000000bffd0000 - 00000000c0000000 (ACPI NVS)
 user: 00000000fec00000 - 00000000fec01000 (reserved)
 user: 00000000fee00000 - 00000000fee01000 (reserved)
 user: 00000000ff7c0000 - 0000000100000000 (reserved)
 user: 0000000100000000 - 0000000140000000 (usable)
Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 1048576
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 819200 pages, LIFO batch:16
DMI 2.3 present.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: TEMPLATE Product ID: SK8N         APIC at: 0xFEE00000
Processor #0 15:5 APIC version 16
I/O APIC #1 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: root=/dev/sda1 acpi=off vga=0x307 mem=5242880K
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1399.846 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 3107364k/4194304k available (2678k kernel code, 36980k reserved, 858k data, 164k init, 2227968k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2768.89 BogoMIPS
Dentry cache hash table entries: 524288 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
CPU:     After vendor identify, caps: 078bfbff e1d3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU:     After all inits, caps: 078bfbff e1d3fbff 00000000 00000010
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Opteron(tm) Processor 240 stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 1 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 1 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-16, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22, 1-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 16.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................
IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1399.0786 MHz.
..... host bus clock speed is 199.0969 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [10de/00d0] at 0000:00:01.0
vesafb: framebuffer at 0xe0000000, mapped to 0xf8800000, size 2560k
vesafb: mode is 1280x1024x8, linelength=1280, pages=1
vesafb: protected mode interface info at c000:e350
vesafb: scrolling: redraw
mtrr: type mismatch for e0000000,200000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,100000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,80000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,40000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,20000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,10000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,8000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,4000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,2000 old: uncachable new: write-combining
mtrr: type mismatch for e0000000,1000 old: uncachable new: write-combining
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x800  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x400  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x200  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x100  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x80  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x40  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x20  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x10  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x8  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x4  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x2  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x1  base: 0xe0000000
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
highmem bounce pool size: 64 pages
udf: registering filesystem
SGI XFS with large block numbers, no debug enabled
Console: switching to colour frame buffer device 160x64
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: Maximum main memory to use for agp memory: 3932M
agpgart: AGP aperture is 128M @ 0xf0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
PCI: Enabling device 0000:00:05.0 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:05.0 to 64
eth0: forcedeth.c: subsystem: 01043:80c5 bound to 0000:00:05.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3: IDE controller at PCI slot 0000:00:08.0
NFORCE3: chipset revision 165
NFORCE3: not 100% native mode: will probe irqs later
NFORCE3: 0000:00:08.0 (rev a5) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: _NEC DVD_RW ND-2500A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.02 loaded.
sata_promise version 1.00
ata1: SATA max UDMA/133 cmd 0xF8AB6200 ctl 0xF8AB6238 bmdma 0x0 irq 11
ata2: SATA max UDMA/133 cmd 0xF8AB6280 ctl 0xF8AB62B8 bmdma 0x0 irq 11
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors:
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:407f
ata2: dev 0 ATA, max UDMA/133, 240121728 sectors:
ata2: dev 0 configured for UDMA/133
scsi1 : sata_promise
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
ReiserFS: sda1: using ordered data mode
ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda1: checking transaction log (sda1)
ReiserFS: sda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 164k freed
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: Using r5 hash to sort names
Adding 1959888k swap on /dev/sda5.  Priority:-1 extents:1
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names

--Boundary-00=_ATEwAoMhelHg9Zk--
