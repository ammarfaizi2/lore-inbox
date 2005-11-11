Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVKKMjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVKKMjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 07:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVKKMjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 07:39:49 -0500
Received: from re01.intra2net.com ([82.165.28.202]:38048 "EHLO
	re01.intra2net.com") by vger.kernel.org with ESMTP id S1750701AbVKKMjs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 07:39:48 -0500
From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Organization: Intra2net AG
Subject: sata performance problem with 2.4.32-rc3
Date: Fri, 11 Nov 2005 13:39:38 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 24266
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200511111339.38178.thomas.jarosch@intra2net.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm facing a SATA performance problem with kernel 2.4.32-rc3.
The machine is a HP Proliant DL320 G3, 2.9 Ghz Celeron, 1GB RAM.
Chipset is an Intel E7221 (ICH6 rev 3).

The machine felt very slow, so I tried kernel 2.6.13 on it.
With kernel 2.6, it works like a charm. According to the changelog
of 2.4.32-rc3, libata is updated to 2.6.x latest.

Here's a bonnie++ benchmark:

Results with kernel 2.6.13:
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
proliant         2G 30641  71 28554   8 16580   3 29447  61 50313   5 185.9   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16 28156 100 +++++ +++ 25285  99 24020  93 +++++ +++ 22937  99
proliant,2G,30641,71,28554,8,16580,3,29447,61,50313,5,185.9,0,16,28156,100,+++++,+++,25285,99,24020,93,+++++,+++,22937,99


Results with kernel 2.4.32-rc3:
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
proliant         2G 10523  28 11532   3  7162   1 24271  60 53495   5 164.3   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16 30498 100 +++++ +++ 27244  98 29630  99 +++++ +++ 11587  46
proliant,2G,10523,28,11532,3,7162,1,24271,60,53495,5,164.3,0,16,30498,100,+++++,+++,27244,98,29630,99,+++++,+++,11587,46


Are there any boot/compile options I could try to improve performance in 2.4?

I've experienced the same performance problem a while ago 
with an Intel D915GUX board / kernel 2.4.31.
This board is also ICH6 based.

Below are the boot messages from both kernels on the same hardware,
hope it helps debugging the issue.

Please CC: answers.

Thanks in advance,
Thomas Jarosch


Boot messages from kernel 2.4.32-rc3:

ACPI: PCI Interrupt Link [LNKA] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *7 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 5 *7 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs *5 7 10 11)
PCI: Probing PCI hardware
00:00:1d[A] -> 8-16 -> IRQ 16 level low
00:00:1d[B] -> 8-17 -> IRQ 17 level low
00:00:1d[C] -> 8-18 -> IRQ 18 level low
00:00:1d[D] -> 8-19 -> IRQ 19 level low
00:01:02[A] -> 8-22 -> IRQ 22 level low
00:01:02[B] -> 8-23 -> IRQ 23 level low
00:05:00[A] -> 10-23 -> IRQ 47 level low
00:05:00[B] -> 11-23 -> IRQ 71 level low
00:06:01[A] -> 10-0 -> IRQ 24 level low
00:06:01[B] -> 10-1 -> IRQ 25 level low
00:06:03[A] -> 10-3 -> IRQ 27 level low
00:06:03[B] -> 10-2 -> IRQ 26 level low
00:09:01[A] -> 11-0 -> IRQ 48 level low
00:09:01[B] -> 11-1 -> IRQ 49 level low
00:09:01[C] -> 11-2 -> IRQ 50 level low
00:09:01[D] -> 11-3 -> IRQ 51 level low
number of MP IRQ sources: 15.
number of IO-APIC #8 registers: 24.
number of IO-APIC #10 registers: 24.
number of IO-APIC #11 registers: 24.
testing the IO APIC.......................

IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0020
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
 09 001 01  0    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    A9
 11 001 01  1    1    0   1   0    1    1    B1
 12 001 01  1    1    0   1   0    1    1    B9
 13 001 01  1    1    0   1   0    1    1    C1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 001 01  1    1    0   1   0    1    1    C9
 17 001 01  1    1    0   1   0    1    1    D1

IO APIC #10......
.... register #00: 0A000000
.......    : physical APIC id: 0A
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 0A000000
.......     : arbitration: 0A
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  1    1    0   1   0    1    1    E9
 01 001 01  1    1    0   1   0    1    1    32
 02 001 01  1    1    0   1   0    1    1    42
 03 001 01  1    1    0   1   0    1    1    3A
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 001 01  1    1    0   1   0    1    1    D9

IO APIC #11......
.... register #00: 0B000000
.......    : physical APIC id: 0B
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 0B000000
.......     : arbitration: 0B
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  1    1    0   1   0    1    1    4A
 01 001 01  1    1    0   1   0    1    1    52
 02 001 01  1    1    0   1   0    1    1    5A
 03 001 01  1    1    0   1   0    1    1    62
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
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
IRQ22 -> 0:22
IRQ23 -> 0:23
IRQ24 -> 1:0
IRQ25 -> 1:1
IRQ26 -> 1:2
IRQ27 -> 1:3
IRQ47 -> 1:23
IRQ48 -> 2:0
IRQ49 -> 2:1
IRQ50 -> 2:2
IRQ51 -> 2:3
IRQ71 -> 2:23
.................................... done.
PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 7
PCI: Using ACPI for IRQ routing
PCI: Device 00:00 not found by BIOS
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
BIOS EDD facility v0.11 2004-Jun-21, 2 devices found
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 00:1f.1
PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 7
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0500-0x0507, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0508-0x050f, BIOS settings: hdc:pio, hdd:pio
hda: DV-28E-N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
SCSI subsystem driver Revision: 1.00
Red Hat/Adaptec aacraid driver (1.1-3 Nov 11 2005 10:19:00)
megaraid: v2.10.10.1 (Release Date: Thu Jan 27 16:19:44 EDT 2005)
GDT-HA: Storage RAID Controller Driver. Version: 3.04 
GDT-HA: Found 0 PCI Storage RAID Controllers
3ware Storage Controller device driver for Linux v1.02.00.037.
3w-xxxx: No cards found.
libata version 1.11 loaded.
ahci version 1.01
PCI: Setting latency timer of device 00:1f.2 to 64
ahci(00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
ahci(00:1f.2) flags: 64bit stag led pmp 
ata1: SATA max UDMA/133 cmd 0xF8805100 ctl 0x0 bmdma 0x0 irq 17
ata2: SATA max UDMA/133 cmd 0xF8805180 ctl 0x0 bmdma 0x0 irq 17
ata3: SATA max UDMA/133 cmd 0xF8805200 ctl 0x0 bmdma 0x0 irq 17
ata4: SATA max UDMA/133 cmd 0xF8805280 ctl 0x0 bmdma 0x0 irq 17
ata1: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4633 85:7849 86:3c01 87:4623 88:203f
ata1: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
ata1: dev 0 configured for UDMA/100
ata2: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4633 85:7849 86:3c01 87:4623 88:203f
ata2: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
ata2: dev 0 configured for UDMA/100
ata3: no device found (phy stat 00000000)
ata4: no device found (phy stat 00000000)
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
  Vendor: ATA       Model: Maxtor 6L080M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6L080M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
 sdb: sdb1 sdb2 sdb3


Boot messages from kernel 2.6.13:

Linux version 2.6.13-1 (root@rdx) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-49)) #1 Sun Sep 11 23:29:44 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff3000 (usable)
 BIOS-e820: 000000003fff3000 - 000000003fffb000 (ACPI data)
 BIOS-e820: 000000003fffb000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f4f40
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 262131
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32755 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v002 HP                                    ) @ 0x000f4ec0
ACPI: XSDT (v001 HP     D18      0x00000002  0x0000162e) @ 0x3fff3274
ACPI: FADT (v003 HP     D18      0x00000002  0x0000162e) @ 0x3fff32f4
ACPI: SPCR (v001 HP     SPCRRBSU 0x00000001  0x0000162e) @ 0x3fff3100
ACPI: MCFG (v001 HP     ProLiant 0x00000001  0x00000000) @ 0x3fff3180
ACPI: MADT (v001 HP     00000083 0x00000002  0x00000000) @ 0x3fff31c0
ACPI: DSDT (v001 HP         DSDT 0x00000001 INTL 0x20030228) @ 0x00000000
ACPI: PM-Timer IO Port: 0x908
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] disabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x0a] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 10, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0b] address[0xfec80100] gsi_base[48])
IOAPIC[2]: apic_id 11, version 32, address 0xfec80100, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: ro root=/dev/sdb2
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec80000)
mapped IOAPIC to ffffa000 (fec80100)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2926.769 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034676k/1048524k available (1888k kernel code, 12868k reserved, 636k data, 176k init, 131020k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5857.12 BogoMIPS (lpj=2928561)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000651d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000651d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: bfebf3ff 20000000 00000000 00000080 0000651d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
CPU: Intel(R) Celeron(R) CPU 2.93GHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking if image is initramfs... it is
Freeing initrd memory: 835k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0096, last bus=11
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.IP2P._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICHE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PTA0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PTA0.PCXA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PTA0.PCXB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *7 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 5 *7 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs *5 7 10 11)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Device 0000:00:00.0 not found by BIOS
PCI: Bridge: 0000:05:00.0
  IO window: disabled.
  MEM window: fde00000-fdefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:05:00.2
  IO window: 4000-4fff
  MEM window: fdf00000-fdffffff
  PREFETCH window: 40000000-400fffff
PCI: Bridge: 0000:00:01.0
  IO window: 4000-4fff
  MEM window: fde00000-fdffffff
  PREFETCH window: 40000000-400fffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-3fff
  MEM window: fbf00000-fddfffff
  PREFETCH window: 40100000-401fffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:05:00.0 to 64
PCI: Setting latency timer of device 0000:05:00.2 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key C9DD946B360E1BAE
  - key was been created 8809637 seconds in future
- User ID: Red Hat, Inc. (Kernel Module GPG key)
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: CPU0 (power states: C1[C1])
ACPI: Thermal Zone [THM0] (8 C)
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler deadline registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A]: no GSI - using IRQ 7
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0500-0x0507, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0508-0x050f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: DV-28E-N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbmon: debugfs is not available
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices:
[4294672.113000]
ACPI: (supports S0 S4 S5)
Freeing unused kernel memory: 176k freed
SCSI subsystem initialized
libata version 1.12 loaded.
ata_piix version 1.04
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1080 ctl 0x108A bmdma 0x10A0 irq 201
ata2: SATA max UDMA/133 cmd 0x1090 ctl 0x109A bmdma 0x10A8 irq 201
input: AT Translated Set 2 keyboard on isa0060/serio0
ata1: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4633 85:7849 86:3c01 87:4623 88:203f
ata1: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4633 85:7849 86:3c01 87:4623 88:203f
ata2: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6L080M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 <<6>input: PS/2 Generic Mouse on isa0060/serio1
 sda5 sda6 sda7 sda8 sda9 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: ATA       Model: Maxtor 6L080M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
