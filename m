Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVKKVct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVKKVct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 16:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVKKVct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:32:49 -0500
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:49241 "EHLO
	mailrelay2.tu-graz.ac.at") by vger.kernel.org with ESMTP
	id S1751205AbVKKVcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:32:48 -0500
Message-ID: <43750DFD.4030808@derhammer.net>
Date: Fri, 11 Nov 2005 22:32:45 +0100
From: Michael Hammer <michael@derhammer.net>
Reply-To: michael@derhammer.net
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Probably problem with Promise SATA Controller
Content-Type: multipart/mixed;
 boundary="------------010402080906020105020702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010402080906020105020702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello all together!

I am new to this mailing list, so please be patient :-)

I own the following system:

- AMD Athlon MP 2800 + (2x -> SMP kernel)
- ASUS A7M266-D (AMD 760 MP chipset)
- 512 MB RAM Kingston KVR266X72RC25
- SCSI storage controller: Adaptec AIC-7892A U160/m
- Mass storage controller: Promise Technology, Inc. 
PDC20518/PDC40518                                  (SATAII 150 TX4)
      -> with 3 Seagate Cheetah 7200.8 250 GB attached
- ATI Technologies Inc Radeon R300 NG [FireGL X1] 256 MB
- USB Controller: NEC Corporation USB 2.0
- Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C                                  /8139C+

The SATA HDDs from Seagate are working in an array, therefore see the 
following /etc/raidtab:

raiddev /dev/md0                      raid-level      5             
nr-raid-disks   3             nr-spare-disks  0             
persistent-superblock 1
       parity-algorithm        left-symmetric
       chunk-size      32            device          /dev/sdb1
       raid-disk       0             device          /dev/sdc1
       raid-disk       1
       device          /dev/sdd1
       raid-disk       2

/dev/md0 is used in a Logical Volume. pvdisplay

 PV /dev/md0   VG data   lvm2 [465.77 GB / 0    free]
 Total: 1 [465.77 GB] / in use: 1 [465.77 GB] / in no VG: 0 [0   ]

I have nearly tried everything except exchanging all the hardware :-) , 
that means changing the cables the pci-slot for the controller and all 
different kind of kernel versions: 2.6.11.12, 2.6.12 and 2.6.14.2 (the 
running kernel at this moment) and reading the SMART infos of the hdds 
(the harddisks should be ok).

When there is a high load on the RAID the following printk appears:
...
Nov 11 21:30:39 artemis ata3: status=0x51 { DriveReady SeekComplete Error }
Nov 11 21:30:39 artemis ata3: called with no error (51)!
Nov 11 21:30:39 artemis ata4: status=0x51 { DriveReady SeekComplete Error }
Nov 11 21:30:39 artemis ata4: called with no error (51)!
...

Depending on load intensity and durability there are more or less error 
messages. Especially the "called with no error (51)!" is very confusing 
for me. I have scrolled threw libata-scsi.c and it seems to me, that my 
kind of error can not be interpreted, else I shouldn't see this message, 
should I?

Perhaps you can give me any advice..... I can really need it :-)

Thanks

Michael

p.s.: The dmesg output is attached


--------------010402080906020105020702
Content-Type: text/plain;
 name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.out"

Linux version 2.6.14.1 (root@artemis) (gcc version 3.3.6 (Gentoo 3.3.6, ssp-3.3.6-1.0, pie-8.7.8)) #2 SMP Wed Nov 9 17:14:11 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009cc00 (usable)
 BIOS-e820: 000000000009cc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
found SMP MP-table at 000f7ea0
On node 0 totalpages: 131052
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126956 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f85f0
ACPI: RSDT (v001 ASUS   A7M266-D 0x30303031 MSFT 0x31313031) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7M266-D 0x30303031 MSFT 0x31313031) @ 0x1ffec100
ACPI: BOOT (v001 ASUS   A7M266-D 0x30303031 MSFT 0x31313031) @ 0x1ffec040
ACPI: MADT (v001 ASUS   A7M266-D 0x30303031 MSFT 0x31313031) @ 0x1ffec080
ACPI: DSDT (v001   ASUS A7M266-D 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: root=/dev/sda3 udev video=mtrr,ywrap vga=0x31A
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2133.608 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515196k/524208k available (2426k kernel code, 8528k reserved, 650k data, 204k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4274.95 BogoMIPS (lpj=8549902)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: CLK_CTL MSR was 60031223. Reprogramming to 20031223
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000 00000000 00000000
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Athlon(TM) MP 2800+ stepping 00
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4267.23 BogoMIPS (lpj=8534479)
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: CLK_CTL MSR was 60031223. Reprogramming to 20031223
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000 00000000 00000000
CPU1: AMD Athlon(TM) MP 2800+ stepping 00
Total of 2 processors activated (8542.19 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
softlockup thread 0 started up.
Brought up 2 CPUs
softlockup thread 1 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf1f30, last bus=2
PCI: Using configuration type 1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:05.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: ce800000-cfdfffff
  PREFETCH window: d0000000-ef7fffff
PCI: Bridge: 0000:00:10.0
  IO window: 9000-9fff
  MEM window: ca800000-ccffffff
  PREFETCH window: cfe00000-cfefffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Simple Boot Flag at 0x3a set to 0x1
SGI XFS with ACLs, security attributes, realtime, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
BIOS failed to enable PCI standards compliance, fixing this error.
vesafb: framebuffer at 0xe0000000, mapped to 0xe0880000, using 5120k, total 131072k
vesafb: mode is 1280x1024x16, linelength=2560, pages=50
vesafb: protected mode interface info at c000:56fd
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
lp: driver loaded but no devices found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: Printer, HEWLETT-PACKARD DESKJET 970C
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler deadline registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 0000:00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: 0000:00:07.1 (rev 04) UDMA100 controller
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: IBM-DTLA-307030, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 60036480 sectors (30738 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 21 (level, low) -> IRQ 16
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: ST336752LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous.
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
 target0:0:0: Ending Domain Validation
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:4: Beginning Domain Validation
 target0:0:4: Domain Validation skipping write tests
 target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:4: Ending Domain Validation
libata version 1.12 loaded.
sata_promise version 1.02
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 20 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0xE0816200 ctl 0xE0816238 bmdma 0x0 irq 17
ata2: SATA max UDMA/133 cmd 0xE0816280 ctl 0xE08162B8 bmdma 0x0 irq 17
ata3: SATA max UDMA/133 cmd 0xE0816300 ctl 0xE0816338 bmdma 0x0 irq 17
ata4: SATA max UDMA/133 cmd 0xE0816380 ctl 0xE08163B8 bmdma 0x0 irq 17
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi1 : sata_promise
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata2: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi2 : sata_promise
ata3: no device found (phy stat 00000000)
scsi3 : sata_promise
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata4: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata4: dev 0 configured for UDMA/133
scsi4 : sata_promise
  Vendor: ATA       Model: ST3250823AS       Rev: 3.04
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3250823AS       Rev: 3.04
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 71687369 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 71687369 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1
Attached scsi disk sdd at scsi4, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
mice: PS/2 mouse device common for all mice
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  6053.000 MB/sec
raid5: using function: pIII_sse (6053.000 MB/sec)
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
CAPI Subsystem Rev 1.1.2.8
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md: created md0
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1><sdb1>
raid5: device sdd1 operational as raid disk 2
raid5: device sdc1 operational as raid disk 1
raid5: device sdb1 operational as raid disk 0
raid5: allocated 3162kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, o:1, dev:sdb1
 disk 1, o:1, dev:sdc1
 disk 2, o:1, dev:sdd1
md: ... autorun DONE.
ReiserFS: sda3: found reiserfs format "3.6" with standard journal
input: AT Translated Set 2 keyboard on isa0060/serio0
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding 3076436k swap on /dev/sda2.  Priority:-1 extents:1 across:3076436k
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 19 (level, low) -> IRQ 18
eth0: RealTek RTL8139 at 0xe083c000, 00:50:fc:39:f6:f7, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8139C'
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
ReiserFS: sda5: found reiserfs format "3.6" with standard journal
ReiserFS: sda5: using ordered data mode
ReiserFS: sda5: journal params: device sda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda5: checking transaction log (sda5)
ReiserFS: sda5: Using r5 hash to sort names
ReiserFS: sda6: found reiserfs format "3.6" with standard journal
ReiserFS: sda6: using ordered data mode
ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda6: checking transaction log (sda6)
ReiserFS: sda6: Using r5 hash to sort names
ReiserFS: sda7: found reiserfs format "3.6" with standard journal
ReiserFS: sda7: using ordered data mode
ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda7: checking transaction log (sda7)
ReiserFS: sda7: Using r5 hash to sort names
ReiserFS: sda8: found reiserfs format "3.6" with standard journal
ReiserFS: sda8: using ordered data mode
ReiserFS: sda8: journal params: device sda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda8: checking transaction log (sda8)
ReiserFS: sda8: Using r5 hash to sort names
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
ReiserFS: dm-2: found reiserfs format "3.6" with standard journal
ReiserFS: dm-2: using ordered data mode
ReiserFS: dm-2: journal params: device dm-2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-2: checking transaction log (dm-2)
ReiserFS: dm-2: Using r5 hash to sort names
ReiserFS: dm-4: found reiserfs format "3.6" with standard journal
ReiserFS: dm-4: using ordered data mode
ReiserFS: dm-4: journal params: device dm-4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-4: checking transaction log (dm-4)
ReiserFS: dm-4: Using r5 hash to sort names
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
ReiserFS: dm-3: found reiserfs format "3.6" with standard journal
ReiserFS: dm-3: using ordered data mode
ReiserFS: dm-3: journal params: device dm-3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-3: checking transaction log (dm-3)
ReiserFS: dm-3: Using r5 hash to sort names
ReiserFS: dm-5: found reiserfs format "3.6" with standard journal
ReiserFS: dm-5: using ordered data mode
ReiserFS: dm-5: journal params: device dm-5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-5: checking transaction log (dm-5)
ReiserFS: dm-5: Using r5 hash to sort names
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 18 (level, low) -> IRQ 19
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 17 (level, low) -> IRQ 20
ohci_hcd 0000:02:06.0: OHCI Host Controller
ohci_hcd 0000:02:06.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:02:06.0: irq 20, io mem 0xcc000000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:02:06.1[B] -> GSI 18 (level, low) -> IRQ 19
ohci_hcd 0000:02:06.1: OHCI Host Controller
ohci_hcd 0000:02:06.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:02:06.1: irq 19, io mem 0xcb800000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using ohci_hcd and address 2
usb 2-1: new low speed USB device using ohci_hcd and address 2
ACPI: PCI Interrupt 0000:02:06.2[C] -> GSI 19 (level, low) -> IRQ 18
ehci_hcd 0000:02:06.2: EHCI Host Controller
ehci_hcd 0000:02:06.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:02:06.2: irq 18, io mem 0xcb000000
ehci_hcd 0000:02:06.2: park 0
ehci_hcd 0000:02:06.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 5 ports detected
usb 1-2: USB disconnect, address 2
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
USB Universal Host Controller Interface driver v2.3
usb 3-3: new high speed USB device using ehci_hcd and address 3
usb 3-4: new high speed USB device using ehci_hcd and address 4
hub 3-4:1.0: USB hub found
hub 3-4:1.0: 4 ports detected
usb 2-1: new low speed USB device using ohci_hcd and address 3
usb 3-4.1: new high speed USB device using ehci_hcd and address 5
hub 3-4.1:1.0: USB hub found
hub 3-4.1:1.0: 4 ports detected
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:02:06.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03e6e80(lo)
IPv6 over IPv4 tunneling driver
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
eth0: no IPv6 routers present
Linux agpgart interface v0.101 (c) Dave Jones
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
[fglrx] Maximum main memory to use for locked dma buffers: 431 MBytes.
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 16 (level, low) -> IRQ 21
[fglrx] module loaded - fglrx 8.18.8 [Oct 25 2005] on minor 0
Fire GL built-in AGP-support
Based on agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected AMD AMD 760MP chipset
agpgart: AGP aperture is 128M @ 0xf0000000
Power management callback for AGP chipset installed
[fglrx] AGP detected, AgpState   = 0x0f000207 (hardware caps of chipset)
AGP: Found 2 AGPv2 devices
AGP: Doing enable for AGPv2
[fglrx] AGP enabled,  AgpCommand = 0x0f000304 (selected caps)
[fglrx] free  AGP = 118222848
[fglrx] max   AGP = 118222848
[fglrx] free  LFB = 100659200
[fglrx] max   LFB = 100659200
[fglrx] free  Inv = 0
[fglrx] max   Inv = 0
[fglrx] total Inv = 0
[fglrx] total TIM = 0
[fglrx] total FB  = 0
[fglrx] total AGP = 32768
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
ReiserFS: sda1: using ordered data mode
ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda1: checking transaction log (sda1)
ReiserFS: sda1: Using r5 hash to sort names
ata4: status=0x51 { DriveReady SeekComplete Error }
ata4: called with no error (51)!
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: called with no error (51)!
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: called with no error (51)!

--------------010402080906020105020702--
