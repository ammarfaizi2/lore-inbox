Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUGMAez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUGMAez (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUGMAez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:34:55 -0400
Received: from bastion.paxonet.com ([209.172.126.232]:12967 "EHLO
	mail.paxonet.com") by vger.kernel.org with ESMTP id S264499AbUGMAdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:33:51 -0400
Date: Mon, 12 Jul 2004 17:33:49 -0700 (PDT)
From: Simon Matthews <simon@paxonet.com>
X-X-Sender: simon@newspare.coreel.com
To: linux-kernel@vger.kernel.org
Subject: 0-order allocation failed
Message-ID: <Pine.LNX.4.58.0407121725340.17890@newspare.coreel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system keeps locking up with this error message. 

I am trying to copy from a SCSI disk to an IDE disk when this happens. 
What I see is that all the memory is shown as used, and "cached". The 
machine has 4GB of memory, which should be sufficient for a mere cp -a.

The IDE disk is a WD 200GB disk on a Promise Ultra133 TX2 controller. I 
have enabled PROMISE PDC202{68|69|70|71|75|76|77} support in my kernel 
(2.4.24 with the 3.5GB VM patch and 3.5GB of memory enabled in the kernel 
config)

The cached memory appears to be about twice the amount of data that has 
been copied. dmesg showed nothing until the machine locked up. 

Any suggestions? 

>From the terminal in which I was running "top":
  5:15pm  up 19 min,  0 users,  load average: 2.91, 1.52, 0.72
Segmentation faultleeping, 5 running, 0 zombie, 0 stopped
[simon@kilea ~]$ % user, 92.0% system,  0.0% nice,  7.5% idle
CPU1 states:  0.0% user, 74.4% system,  0.0% nice, 25.0% idle
Mem:  3751712K av, 3653832K used,   97880K free,       0K shrd,     260K 
buff
Swap: 4145120K av,       0K used, 4145120K free                 3289248K 
cached
                                                                                
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1139 root      19   0  6464 6464   480 R    63.3  0.1   0:50 cp
    5 root      20   0     0    0     0 RW   36.7  0.0   0:34 kswapd
   11 root      20   0     0    0     0 RW   36.7  0.0   0:02 kjournald
    6 root      20   0     0    0     0 RW   24.1  0.0   0:17 bdflush
    7 root       9   0     0    0     0 SW    2.3  0.0   0:04 kupdated

The results of "free" just before the lockup:
[simon@kilea ~]$ free
             total       used       free     shared    buffers     cached
Mem:       3751712    3628700     123012          0        344    3265952
-/+ buffers/cache:     362404    3389308
Swap:      4145120          0    4145120


dmesg, showing boot up:
]# dmesg
1-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HLB_.P64H._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.SLOT._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 14 15)
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (1-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:1f[A] -> 1-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (1-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:1f[B] -> 1-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (1-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:1f[C] -> 1-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (1-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:1f[D] -> 1-19 -> IRQ 19
Pin 1-16 already programmed
Pin 1-17 already programmed
IOAPIC[0]: Set PCI routing entry (1-22 -> 0xc9 -> IRQ 22 Mode:1 Active:1)
00:03:04[A] -> 1-22 -> IRQ 22
Pin 1-22 already programmed
Pin 1-22 already programmed
Pin 1-22 already programmed
Pin 1-22 already programmed
Pin 1-22 already programmed
Pin 1-22 already programmed
Pin 1-22 already programmed
IOAPIC[0]: Set PCI routing entry (1-23 -> 0xd1 -> IRQ 23 Mode:1 Active:1)
00:03:08[A] -> 1-23 -> IRQ 23
Pin 1-19 already programmed
Pin 1-17 already programmed
Pin 1-18 already programmed
Pin 1-19 already programmed
IOAPIC[0]: Set PCI routing entry (1-20 -> 0xd9 -> IRQ 20 Mode:1 Active:1)
00:04:0a[D] -> 1-20 -> IRQ 20
Pin 1-18 already programmed
Pin 1-19 already programmed
Pin 1-20 already programmed
IOAPIC[0]: Set PCI routing entry (1-21 -> 0xe1 -> IRQ 21 Mode:1 Active:1)
00:04:06[D] -> 1-21 -> IRQ 21
Pin 1-19 already programmed
Pin 1-20 already programmed
Pin 1-21 already programmed
Pin 1-22 already programmed
Pin 1-21 already programmed
number of MP IRQ sources: 15.
number of IO-APIC #1 registers: 24.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
 
IO APIC #1......
.... register #00: 01008000
.......    : physical APIC id: 01
.......    : Delivery Type: 1
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    1    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 003 03  1    1    0   1   0    1    1    B9
 13 003 03  1    1    0   1   0    1    1    C1
 14 003 03  1    1    0   1   0    1    1    D9
 15 003 03  1    1    0   1   0    1    1    E1
 16 003 03  1    1    0   1   0    1    1    C9
 17 003 03  1    1    0   1   0    1    1    D1
 
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 02000000
.......     : arbitration: 02
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
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
IRQ9 -> 0:9-> 0:9
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
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 3553M
agpgart: Detected Intel i860 chipset
agpgart: AGP aperture is 64M @ 0xec000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x10e0-0x10e7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x10e8-0x10ef, BIOS settings: hdc:pio, hdd:pio
PDC20269: IDE controller at PCI slot 04:06.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x3040-0x3047, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x3048-0x304f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD2000JB-00FUA0, ATA DISK drive
blk: queue e04136b8, I/O limit 4095Mb (mask 0xffffffff)
ide2 at 0x3060-0x3067,0x3056 on irq 18
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 390721968 sectors (200050 MB) w/8192KiB Cache, CHS=24321/255/63, 
UDMA(100)
Partition check:
 hde: hde1 hde2
SCSI subsystem driver Revision: 1.00
NCR53c406a: no available ports found
sym.3.8.0: setting PCI_COMMAND_PARITY...
sym.3.8.1: setting PCI_COMMAND_PARITY...
sym0: <1010-66> rev 0x1 on pci bus 3 device 8 function 1 irq 19
sym0: using 64 bit DMA addressing
sym0: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
sym1: <1010-66> rev 0x1 on pci bus 3 device 8 function 0 irq 23
sym1: using 64 bit DMA addressing
sym1: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
scsi1 : sym-2.1.17a
blk: queue f7acc218, I/O limit 1048575Mb (mask 0xffffffffff)
  Vendor: SEAGATE   Model: ST39236LW         Rev: 0005
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f77cbe18, I/O limit 1048575Mb (mask 0xffffffffff)
  Vendor: IBM       Model: DDYS-T36950M      Rev: SA2A
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f77cba18, I/O limit 1048575Mb (mask 0xffffffffff)
  Vendor: IBM       Model: DDYS-T36950M      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f77cb618, I/O limit 1048575Mb (mask 0xffffffffff)
sym0:0:0: tagged command queuing enabled, command queue depth 16.
sym0:1:0: tagged command queuing enabled, command queue depth 16.
sym0:2:0: tagged command queuing enabled, command queue depth 16.
  Vendor: IBM       Model: IC35L073UCDY10-0  Rev: S21E
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7762218, I/O limit 1048575Mb (mask 0xffffffffff)
  Vendor: SEAGATE   Model: ST1181677LC       Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f773f818, I/O limit 1048575Mb (mask 0xffffffffff)
sym1:4:0: tagged command queuing enabled, command queue depth 16.
sym1:9:0: tagged command queuing enabled, command queue depth 16.
scsi2 : SCSI host adapter emulation for IDE ATAPI devices
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi1, channel 0, id 4, lun 0
Attached scsi disk sde at scsi1, channel 0, id 9, lun 0
sym0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 31)
SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
 sda: sda1 sda2 < sda5 sda6 sda7 >
sym0:1:0:M_REJECT to send for : 1-6-4-c-0-3e-1-0.
sym0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 31)
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
 sdb: sdb1 sdb2 sdb3
sym0:2:0:M_REJECT to send for : 1-6-4-c-0-3e-1-0.
sym0:2: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 31)
SCSI device sdc: 71687340 512-byte hdwr sectors (36704 MB)
 sdc: sdc1 sdc2 sdc3
sym1:4:0:M_REJECT to send for : 1-6-4-c-0-3e-1-0.
sym1:4: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 31)
SCSI device sdd: 143374805 512-byte hdwr sectors (73408 MB)
 sdd: sdd1 sdd2 sdd3 sdd4 sdd6 sdd7 sdd8
sym1:9:0:M_REJECT to send for : 1-6-4-c-0-3e-1-0.
sym1:9: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 31)
SCSI device sde: 354600001 512-byte hdwr sectors (181555 MB)
 sde: sde3 sde8
es1371: version v0.32 time 13:52:44 Jan  5 2004
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   925.200 MB/sec
   32regs    :   559.200 MB/sec
   pIII_sse  :  1045.200 MB/sec
   pII_mmx   :   934.000 MB/sec
   p5_mmx    :   909.600 MB/sec
raid5: using function: pIII_sse (1045.200 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.7(28/03/2003)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
Adding Swap: 2049016k swap-space (priority 1)
Unable to find swap-space signature
Adding Swap: 2096104k swap-space (priority 1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,5), internal journal
 [events: 00000038]
 [events: 00000038]
md: autorun ...
md: considering sdc3 ...
md:  adding sdc3 ...
md:  adding sdb3 ...
md: created md0
md: bind<sdb3,1>
md: bind<sdc3,2>
md: running: <sdc3><sdb3>
md: sdc3's event counter: 00000038
md: sdb3's event counter: 00000038
md: md0: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device sdc3 operational as mirror 1
raid1: device sdb3 operational as mirror 0
raid1: raid set md0 not clean; reconstructing mirrors
raid1: raid set md0 active with 2 out of 2 mirrors
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 
KB/sec) for reconstruction.
md: using 124k window, over a total of 33588160 blocks.
md: updating md0 RAID superblock on device
md: sdc3 [events: 00000039]<6>(write) sdc3's sb offset: 33588160
md: sdb3 [events: 00000039]<6>(write) sdb3's sb offset: 33588160
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs: Unrecognized mount option default
EXT2-fs warning (device md(9,0)): ext2_read_super: mounting ext3 
filesystem as ext2
 
ufs_read_super: fs needs fsck
ufs_read_super: fs needs fsck
ufs_read_super: fs needs fsck
ufs_read_super: fs needs fsck
ufs_read_super: fs needs fsck
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:E0:81:00:16:F6, IRQ 21.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x3258698e).
EXT3-fs: Unrecognized mount option default



Simon
