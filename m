Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132837AbRC2Ucs>; Thu, 29 Mar 2001 15:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132838AbRC2Uce>; Thu, 29 Mar 2001 15:32:34 -0500
Received: from phoenix.nanospace.com ([209.213.199.121]:5381 "HELO
	phoenix.nanospace.com") by vger.kernel.org with SMTP
	id <S132837AbRC2UcI>; Thu, 29 Mar 2001 15:32:08 -0500
Date: Thu, 29 Mar 2001 12:31:31 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.4.2 IDE data point
Message-ID: <20010329123127.A219@thune.yy.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like to play with old junky hardware.  Except for disk drives.  I like
the storage.  As a result, I have a P5/233 with 250G across 5 IDE's.  It's
kludgy, yes, but it's fun.

Anyway, the 5th IDE drive (and cdrom) is on an old sound blaster card.
Depending on configuration, linux times out reading the partition table on
this drive.  I had the same problem with later 2.2.* kernels with recent
IDE patches.

The following table describes two items I have tracked it down to:

            CONFIG_IDEPCI_SHARE_IRQ
               YES        NO
            +--------+--------+
BIOS    YES | fails  | fails  |
PNP-OS  NO  | fails  | works  |
            +--------+--------+

Below are the output of dmesg and my .config.  I can do just about any
other testing asked.

Oh, and even with this, it's not surprising to get:
hdd: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdd: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdd: DMA disabled
ide1: reset: success
hdb: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdb: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: timeout waiting for DMA

Though I *suspect* this may be caused by bad cables.

mrc

30 BogoMIPS
Memory: 78320k/81920k available (938k kernel code, 3212k reserved, 364k data, 216k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU: After generic, caps: 008001bf 00000000 00000000 00000000
CPU: Common caps: 008001bf 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU: After generic, caps: 008001bf 00000000 00000000 00000000
CPU: Common caps: 008001bf 00000000 00000000 00000000
CPU0: Intel Pentium MMX stepping 03
per-CPU timeslice cutoff: 159.61 usecs.
SMP motherboard not detected. Using dummy APIC emulation.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfb000, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7000] at 00:07.0
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Calling quirk for 01:02
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB32 PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 51872kB/17290kB, 192 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
ide3: Creative SB32 PnP IDE interface
hda: Maxtor 91303D6, ATA DISK drive
hdb: Maxtor 53073U6, ATA DISK drive
hdc: Maxtor 93652U8, ATA DISK drive
hdd: Maxtor 92048U8, ATA DISK drive
hdg: probing with STATUS(0x50) instead of ALTSTATUS(0xd0)
hdg: Maxtor 53073H6, ATA DISK drive
hdh: probing with STATUS(0x00) instead of ALTSTATUS(0x80)
hdh: HITACHI CDR-7930, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide3 at 0x168-0x16f,0x36e on irq 10
hda: 25450992 sectors (13031 MB) w/512KiB Cache, CHS=12624/32/63, (U)DMA
hdb: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=59554/16/63, (U)DMA
hdc: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=70780/16/63, (U)DMA
hdd: 39876480 sectors (20417 MB) w/2048KiB Cache, CHS=39560/16/63, (U)DMA
hdg: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=59554/16/63
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdb: hdb1 hdb2 hdb3
 hdc: [PTBL] [4441/255/63] hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 >
 hdd: hdd1 hdd2 hdd3
 hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 hdg6 hdg7 >
Real Time Clock Driver v1.10d
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ACPI: System description tables not found
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 66520k swap-space (priority 1)
Adding Swap: 72252k swap-space (priority 1)
Adding Swap: 65984k swap-space (priority 1)
md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md.c: sizeof(mdp_super_t) = 4096
(read) hda3's sb offset: 5317120 [events: 00000123]
(read) hdc3's sb offset: 5245120 [events: 00000123]
autorun ...
considering hdc3 ...
  adding hdc3 ...
  adding hda3 ...
created md0
bind<hda3,1>
bind<hdc3,2>
running: <hdc3><hda3>
now!
hdc3's event counter: 00000123
hda3's event counter: 00000123
raid0 personality registered
md0: max total readahead window set to 2048k
md0: 2 data-disks, max readahead per data-disk: 1024k
raid0: looking at hda3
raid0:   comparing hda3(5317120) with hda3(5317120)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdc3
raid0:   comparing hdc3(5245120) with hda3(5317120)
raid0:   NOT EQUAL
raid0:   comparing hdc3(5245120) with hdc3(5245120)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
zone 0
 checking hda3 ... contained as device 0
  (5317120) is smallest!.
 checking hdc3 ... contained as device 1
  (5245120) is smallest!.
 zone->nb_dev: 2, size: 10490240
current zone offset: 5245120
zone 1
 checking hda3 ... contained as device 0
  (5317120) is smallest!.
 checking hdc3 ... nope.
 zone->nb_dev: 1, size: 72000
current zone offset: 5317120
done.
raid0 : md_size is 10562240 blocks.
raid0 : conf->smallest->size is 72000 blocks.
raid0 : nb_zone is 147.
raid0 : Allocating 1176 bytes for hash.
md: updating md0 RAID superblock on device
hdc3 [events: 00000124](write) hdc3's sb offset: 5245120
hda3 [events: 00000124](write) hda3's sb offset: 5317120
.
... autorun DONE.
(read) hdc5's sb offset: 5245120 [events: 000000d4]
(read) hdg3's sb offset: 5243008 [events: 000000d4]
autorun ...
considering hdg3 ...
  adding hdg3 ...
  adding hdc5 ...
created md1
bind<hdc5,1>
bind<hdg3,2>
running: <hdg3><hdc5>
now!
hdg3's event counter: 000000d4
hdc5's event counter: 000000d4
md1: max total readahead window set to 2048k
md1: 2 data-disks, max readahead per data-disk: 1024k
raid0: looking at hdc5
raid0:   comparing hdc5(5245120) with hdc5(5245120)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdg3
raid0:   comparing hdg3(5243008) with hdc5(5245120)
raid0:   NOT EQUAL
raid0:   comparing hdg3(5243008) with hdg3(5243008)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
zone 0
 checking hdc5 ... contained as device 0
  (5245120) is smallest!.
 checking hdg3 ... contained as device 1
  (5243008) is smallest!.
 zone->nb_dev: 2, size: 10486016
current zone offset: 5243008
zone 1
 checking hdc5 ... contained as device 0
  (5245120) is smallest!.
 checking hdg3 ... nope.
 zone->nb_dev: 1, size: 2112
current zone offset: 5245120
done.
raid0 : md_size is 10488128 blocks.
raid0 : conf->smallest->size is 2112 blocks.
raid0 : nb_zone is 4966.
raid0 : Allocating 39728 bytes for hash.
md: updating md1 RAID superblock on device
hdg3 [events: 000000d5](write) hdg3's sb offset: 5243008
hdc5 [events: 000000d5](write) hdc5's sb offset: 5245120
.
... autorun DONE.
(read) hdb2's sb offset: 9437312 [events: 000000d4]
(read) hdd2's sb offset: 9437312 [events: 000000d4]
(read) hdg5's sb offset: 9437248 [events: 000000d4]
autorun ...
considering hdg5 ...
  adding hdg5 ...
  adding hdd2 ...
  adding hdb2 ...
created md2
bind<hdb2,1>
bind<hdd2,2>
bind<hdg5,3>
running: <hdg5><hdd2><hdb2>
now!
hdg5's event counter: 000000d4
hdd2's event counter: 000000d4
hdb2's event counter: 000000d4
md2: max total readahead window set to 3072k
md2: 3 data-disks, max readahead per data-disk: 1024k
raid0: looking at hdb2
raid0:   comparing hdb2(9437312) with hdb2(9437312)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdd2
raid0:   comparing hdd2(9437312) with hdb2(9437312)
raid0:   EQUAL
raid0: looking at hdg5
raid0:   comparing hdg5(9437248) with hdb2(9437312)
raid0:   NOT EQUAL
raid0:   comparing hdg5(9437248) with hdd2(9437312)
raid0:   NOT EQUAL
raid0:   comparing hdg5(9437248) with hdg5(9437248)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
zone 0
 checking hdb2 ... contained as device 0
  (9437312) is smallest!.
 checking hdd2 ... contained as device 1
 checking hdg5 ... contained as device 2
  (9437248) is smallest!.
 zone->nb_dev: 3, size: 28311744
current zone offset: 9437248
zone 1
 checking hdb2 ... contained as device 0
  (9437312) is smallest!.
 checking hdd2 ... contained as device 1
 checking hdg5 ... nope.
 zone->nb_dev: 2, size: 128
current zone offset: 9437312
done.
raid0 : md_size is 28311872 blocks.
raid0 : conf->smallest->size is 128 blocks.
raid0 : nb_zone is 221187.
raid0 : Allocating 1769496 bytes for hash.
md: updating md2 RAID superblock on device
hdg5 [events: 000000d5](write) hdg5's sb offset: 9437248
hdd2 [events: 000000d5](write) hdd2's sb offset: 9437312
hdb2 [events: 000000d5](write) hdb2's sb offset: 9437312
.
... autorun DONE.
(read) hdb3's sb offset: 20446208 [events: 00000103]
(read) hdc8's sb offset: 9237248 [events: 00000103]
(read) hdd3's sb offset: 10369216 [events: 00000103]
autorun ...
considering hdd3 ...
  adding hdd3 ...
  adding hdc8 ...
  adding hdb3 ...
created md3
bind<hdb3,1>
bind<hdc8,2>
bind<hdd3,3>
running: <hdd3><hdc8><hdb3>
now!
hdd3's event counter: 00000103
hdc8's event counter: 00000103
hdb3's event counter: 00000103
md3: max total readahead window set to 3072k
md3: 3 data-disks, max readahead per data-disk: 1024k
raid0: looking at hdb3
raid0:   comparing hdb3(20446208) with hdb3(20446208)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdc8
raid0:   comparing hdc8(9237248) with hdb3(20446208)
raid0:   NOT EQUAL
raid0:   comparing hdc8(9237248) with hdc8(9237248)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: looking at hdd3
raid0:   comparing hdd3(10369216) with hdb3(20446208)
raid0:   NOT EQUAL
raid0:   comparing hdd3(10369216) with hdc8(9237248)
raid0:   NOT EQUAL
raid0:   comparing hdd3(10369216) with hdd3(10369216)
raid0:   END
raid0:   ==> UNIQUE
raid0: 3 zones
raid0: FINAL 3 zones
zone 0
 checking hdb3 ... contained as device 0
  (20446208) is smallest!.
 checking hdc8 ... contained as device 1
  (9237248) is smallest!.
 checking hdd3 ... contained as device 2
 zone->nb_dev: 3, size: 27711744
current zone offset: 9237248
zone 1
 checking hdb3 ... contained as device 0
  (20446208) is smallest!.
 checking hdc8 ... nope.
 checking hdd3 ... contained as device 1
  (10369216) is smallest!.
 zone->nb_dev: 2, size: 2263936
current zone offset: 10369216
zone 2
 checking hdb3 ... contained as device 0
  (20446208) is smallest!.
 checking hdc8 ... nope.
 checking hdd3 ... nope.
 zone->nb_dev: 1, size: 10076992
current zone offset: 20446208
done.
raid0 : md_size is 40052672 blocks.
raid0 : conf->smallest->size is 2263936 blocks.
raid0 : nb_zone is 18.
raid0 : Allocating 144 bytes for hash.
md: updating md3 RAID superblock on device
hdd3 [events: 00000104](write) hdd3's sb offset: 10369216
hdc8 [events: 00000104](write) hdc8's sb offset: 9237248
hdb3 [events: 00000104](write) hdb3's sb offset: 20446208
.
... autorun DONE.
(read) hda4's sb offset: 7209152 [events: 000000d4]
(read) hdc6's sb offset: 7341568 [events: 000000d4]
(read) hdg6's sb offset: 6291840 [events: 000000d4]
autorun ...
considering hdg6 ...
  adding hdg6 ...
  adding hdc6 ...
  adding hda4 ...
created md4
bind<hda4,1>
bind<hdc6,2>
bind<hdg6,3>
running: <hdg6><hdc6><hda4>
now!
hdg6's event counter: 000000d4
hdc6's event counter: 000000d4
hda4's event counter: 000000d4
md4: max total readahead window set to 3072k
md4: 3 data-disks, max readahead per data-disk: 1024k
raid0: looking at hda4
raid0:   comparing hda4(7209152) with hda4(7209152)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdc6
raid0:   comparing hdc6(7341568) with hda4(7209152)
raid0:   NOT EQUAL
raid0:   comparing hdc6(7341568) with hdc6(7341568)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: looking at hdg6
raid0:   comparing hdg6(6291840) with hda4(7209152)
raid0:   NOT EQUAL
raid0:   comparing hdg6(6291840) with hdc6(7341568)
raid0:   NOT EQUAL
raid0:   comparing hdg6(6291840) with hdg6(6291840)
raid0:   END
raid0:   ==> UNIQUE
raid0: 3 zones
raid0: FINAL 3 zones
zone 0
 checking hda4 ... contained as device 0
  (7209152) is smallest!.
 checking hdc6 ... contained as device 1
 checking hdg6 ... contained as device 2
  (6291840) is smallest!.
 zone->nb_dev: 3, size: 18875520
current zone offset: 6291840
zone 1
 checking hda4 ... contained as device 0
  (7209152) is smallest!.
 checking hdc6 ... contained as device 1
 checking hdg6 ... nope.
 zone->nb_dev: 2, size: 1834624
current zone offset: 7209152
zone 2
 checking hda4 ... nope.
 checking hdc6 ... contained as device 0
  (7341568) is smallest!.
 checking hdg6 ... nope.
 zone->nb_dev: 1, size: 132416
current zone offset: 7341568
done.
raid0 : md_size is 20842560 blocks.
raid0 : conf->smallest->size is 132416 blocks.
raid0 : nb_zone is 158.
raid0 : Allocating 1264 bytes for hash.
md: updating md4 RAID superblock on device
hdg6 [events: 000000d5](write) hdg6's sb offset: 6291840
hdc6 [events: 000000d5](write) hdc6's sb offset: 7341568
hda4 [events: 000000d5](write) hda4's sb offset: 7209152
.
... autorun DONE.
(read) hdc7's sb offset: 8393856 [events: 000000d4]
(read) hdg7's sb offset: 4716288 [events: 000000d4]
autorun ...
considering hdg7 ...
  adding hdg7 ...
  adding hdc7 ...
created md5
bind<hdc7,1>
bind<hdg7,2>
running: <hdg7><hdc7>
now!
hdg7's event counter: 000000d4
hdc7's event counter: 000000d4
md5: max total readahead window set to 2048k
md5: 2 data-disks, max readahead per data-disk: 1024k
raid0: looking at hdc7
raid0:   comparing hdc7(8393856) with hdc7(8393856)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdg7
raid0:   comparing hdg7(4716288) with hdc7(8393856)
raid0:   NOT EQUAL
raid0:   comparing hdg7(4716288) with hdg7(4716288)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
zone 0
 checking hdc7 ... contained as device 0
  (8393856) is smallest!.
 checking hdg7 ... contained as device 1
  (4716288) is smallest!.
 zone->nb_dev: 2, size: 9432576
current zone offset: 4716288
zone 1
 checking hdc7 ... contained as device 0
  (8393856) is smallest!.
 checking hdg7 ... nope.
 zone->nb_dev: 1, size: 3677568
current zone offset: 8393856
done.
raid0 : md_size is 13110144 blocks.
raid0 : conf->smallest->size is 3677568 blocks.
raid0 : nb_zone is 4.
raid0 : Allocating 32 bytes for hash.
md: updating md5 RAID superblock on device
hdg7 [events: 000000d5](write) hdg7's sb offset: 4716288
hdc7 [events: 000000d5](write) hdc7's sb offset: 8393856
.
... autorun DONE.
Linux Tulip driver version 0.9.13a (January 20, 2001)
PCI: Found IRQ 11 for device 00:13.0
eth0: Lite-On 82c168 PNIC rev 32 at 0x6400, 00:A0:CC:26:67:40, IRQ 11.
eth0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
eth0: Setting full-duplex based on MII#1 link partner capability of 05e1.
Serial driver version 5.02 (2000-08-09) with HUB-6 MANY_PORTS SHARE_IRQ DETECT_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A


#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
CONFIG_M586MMX=y
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_TOSHIBA=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_EISA=y
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_I82365=y
CONFIG_TCIC=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=m
# CONFIG_MTD_DEBUG is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOC1000=m
CONFIG_MTD_DOC2000=m
CONFIG_MTD_DOC2001=m
CONFIG_MTD_DOCPROBE=m
CONFIG_MTD_DOCPROBE_ADDRESS=0000
# CONFIG_MTD_DOCPROBE_HIGH is not set
# CONFIG_MTD_DOCPROBE_55AA is not set

#
# RAM/ROM Device Drivers
#
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PMC551=m
CONFIG_MTD_PMC551_BUGFIX=y
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Linearly Mapped Flash Device Drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
# CONFIG_MTD_JEDEC is not set
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_START=8000000
CONFIG_MTD_PHYSMAP_LEN=4000000
CONFIG_MTD_PHYSMAP_BUSWIDTH=2

#
# Drivers for chip mappings
#
# CONFIG_MTD_MIXMEM is not set
CONFIG_MTD_NORA=m
# CONFIG_MTD_OCTAGON is not set
CONFIG_MTD_PNC2000=m
CONFIG_MTD_RPXLITE=m
# CONFIG_MTD_VMAX is not set

#
# User modules and translation layers for MTD devices
#
CONFIG_MTD_CHAR=m
CONFIG_MTD_BLOCK=m
CONFIG_FTL=m
CONFIG_NFTL=m
# CONFIG_NFTL_RW is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_XD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_BLK_DEV_DAC960=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_BLK_DEV_LVM=m

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_FWMARK is not set
CONFIG_IP_ROUTE_NAT=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IPV6=m
# CONFIG_IPV6_EUI64 is not set

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_KHTTPD=m
# CONFIG_ATM is not set

#
#  
#
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
CONFIG_DECNET=m
# CONFIG_DECNET_SIOCGIFCONF is not set
# CONFIG_DECNET_ROUTER is not set
CONFIG_BRIDGE=m
CONFIG_X25=m
CONFIG_LAPB=m
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
CONFIG_ECONET=m
# CONFIG_ECONET_AUNUDP is not set
# CONFIG_ECONET_NATIVE is not set
CONFIG_WAN_ROUTER=m
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_ISAPNP=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_AEC62XX_TUNING=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD7409=y
# CONFIG_AMD7409_OVERRIDE is not set
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
CONFIG_HPT34X_AUTODMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_BLK_DEV_NS87415=y
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_OSB4=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDE_CHIPSETS=y

#
# Note: most of these also require special kernel boot parameters
#
# CONFIG_BLK_DEV_4DRIVES is not set
CONFIG_BLK_DEV_ALI14XX=y
CONFIG_BLK_DEV_DTC2278=y
CONFIG_BLK_DEV_HT6560B=y
CONFIG_BLK_DEV_PDC4030=y
CONFIG_BLK_DEV_QD6580=y
CONFIG_BLK_DEV_UMC8672=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_IVB=y
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_DEBUG_QUEUES=y
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_7000FASST=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AHA152X=m
CONFIG_SCSI_AHA1542=m
CONFIG_SCSI_AHA1740=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_PROC_STATS=y
CONFIG_AIC7XXX_RESET_DELAY=5
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_IN2000=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_MEGARAID=m
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_CPQFCTS=m
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_DTC3280=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
CONFIG_SCSI_EATA_LINKED_COMMANDS=y
CONFIG_SCSI_EATA_MAX_TAGS=16
CONFIG_SCSI_EATA_DMA=m
CONFIG_SCSI_EATA_PIO=m
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_GENERIC_NCR5380=m
CONFIG_SCSI_GENERIC_NCR53C400=y
CONFIG_SCSI_G_NCR5380_PORT=y
# CONFIG_SCSI_G_NCR5380_MEM is not set
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_NCR53C406A=m
CONFIG_SCSI_NCR53C7xx=m
CONFIG_SCSI_NCR53C7xx_sync=y
CONFIG_SCSI_NCR53C7xx_FAST=y
CONFIG_SCSI_NCR53C7xx_DISCONNECT=y
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
CONFIG_SCSI_NCR53C8XX_PQS_PDS=y
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
CONFIG_SCSI_PAS16=m
CONFIG_SCSI_PCI2000=m
CONFIG_SCSI_PCI2220I=m
CONFIG_SCSI_PSI240I=m
CONFIG_SCSI_QLOGIC_FAS=m
CONFIG_SCSI_QLOGIC_ISP=m
CONFIG_SCSI_QLOGIC_FC=m
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_SEAGATE=m
CONFIG_SCSI_SIM710=m
CONFIG_SCSI_SYM53C416=m
CONFIG_SCSI_DC390T=m
# CONFIG_SCSI_DC390T_NOGENSUPP is not set
CONFIG_SCSI_T128=m
CONFIG_SCSI_U14_34F=m
CONFIG_SCSI_U14_34F_LINKED_COMMANDS=y
CONFIG_SCSI_U14_34F_MAX_TAGS=8
CONFIG_SCSI_ULTRASTOR=m
CONFIG_SCSI_DEBUG=m

#
# PCMCIA SCSI adapter support
#
CONFIG_SCSI_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_QLOGIC=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_APA1480=m

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m
CONFIG_IEEE1394_PCILYNX=m
# CONFIG_IEEE1394_PCILYNX_LOCALRAM is not set
# CONFIG_IEEE1394_PCILYNX_PORTS is not set
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_ISA=m
CONFIG_ARCNET_COM20020_PCI=m

#
# Appletalk devices
#
CONFIG_APPLETALK=y
CONFIG_LTPC=m
CONFIG_COPS=m
# CONFIG_COPS_DAYNA is not set
# CONFIG_COPS_TANGENT is not set
CONFIG_IPDDP=m
# CONFIG_IPDDP_ENCAP is not set
# CONFIG_IPDDP_DECAP is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
CONFIG_NET_SB1000=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
CONFIG_LANCE=m
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
CONFIG_ULTRA=m
CONFIG_ULTRA32=m
CONFIG_SMC9194=m
CONFIG_NET_VENDOR_RACAL=y
CONFIG_NI5010=m
CONFIG_NI52=m
CONFIG_NI65=m
CONFIG_AT1700=m
CONFIG_DEPCA=m
CONFIG_HP100=m
CONFIG_NET_ISA=y
CONFIG_E2100=m
CONFIG_EWRK3=m
CONFIG_EEXPRESS=m
CONFIG_EEXPRESS_PRO=m
CONFIG_HPLAN_PLUS=m
CONFIG_HPLAN=m
CONFIG_ETH16I=m
CONFIG_NE2000=m
CONFIG_SK_G16=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_TULIP=m
CONFIG_DE4X5=m
CONFIG_DGRS=m
CONFIG_DM9102=m
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PM is not set
CONFIG_LNE390=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_NE3210=m
CONFIG_ES3210=m
CONFIG_8139TOO=m
CONFIG_RTL8129=m
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
CONFIG_WINBOND_840=m
CONFIG_HAPPYMEAL=m
CONFIG_NET_POCKET=y
CONFIG_ATP=m
CONFIG_DE600=m
CONFIG_DE620=m

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_SK98LIN=m
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
CONFIG_HIPPI=y
CONFIG_ROADRUNNER=m
# CONFIG_ROADRUNNER_LARGE_RINGS is not set
CONFIG_PLIP=m
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
CONFIG_STRIP=m
CONFIG_WAVELAN=m
CONFIG_ARLAN=m
CONFIG_AIRONET4500=m
CONFIG_AIRONET4500_NONCS=m
CONFIG_AIRONET4500_PNP=y
CONFIG_AIRONET4500_PCI=y
CONFIG_AIRONET4500_ISA=y
CONFIG_AIRONET4500_I365=y
CONFIG_AIRONET4500_PROC=m

#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMTR=m
CONFIG_IBMOL=m
CONFIG_IBMLS=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
CONFIG_TMSISA=m
CONFIG_ABYSS=m
CONFIG_SMCTR=m
CONFIG_NET_FC=y
CONFIG_IPHASE5526=m
CONFIG_RCPCI=m
CONFIG_SHAPER=m

#
# Wan interfaces
#
CONFIG_WAN=y
CONFIG_HOSTESS_SV11=m
CONFIG_COSA=m
# CONFIG_COMX is not set
CONFIG_LANMEDIA=m
CONFIG_SEALEVEL_4021=m
CONFIG_SYNCLINK_SYNCPPP=m
CONFIG_DLCI=m
CONFIG_DLCI_COUNT=24
CONFIG_DLCI_MAX=8
CONFIG_SDLA=m
CONFIG_WAN_ROUTER_DRIVERS=y
CONFIG_VENDOR_SANGOMA=m
CONFIG_WANPIPE_CARDS=1
# CONFIG_WANPIPE_CHDLC is not set
# CONFIG_WANPIPE_PPP is not set
CONFIG_CYCLADES_SYNC=m
CONFIG_CYCLOMX_X25=y
CONFIG_LAPBETHER=m
CONFIG_X25_ASY=m
CONFIG_SBNI=m

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_ARCNET_COM20020_CS=m
CONFIG_PCMCIA_IBMTR=m
CONFIG_PCMCIA_XIRTULIP=m
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=m
CONFIG_PCMCIA_NETWAVE=m
CONFIG_PCMCIA_WAVELAN=m
CONFIG_AIRONET4500_CS=m

#
# Amateur Radio support
#
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
# CONFIG_6PACK is not set
CONFIG_BPQETHER=m
CONFIG_DMASCC=m
CONFIG_SCC=m
# CONFIG_SCC_DELAY is not set
# CONFIG_SCC_TRXECHO is not set
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_BAYCOM_EPP=m
CONFIG_SOUNDMODEM=m
CONFIG_SOUNDMODEM_SBC=y
CONFIG_SOUNDMODEM_WSS=y
CONFIG_SOUNDMODEM_AFSK1200=y
CONFIG_SOUNDMODEM_AFSK2400_7=y
CONFIG_SOUNDMODEM_AFSK2400_8=y
CONFIG_SOUNDMODEM_AFSK2666=y
CONFIG_SOUNDMODEM_HAPN4800=y
CONFIG_SOUNDMODEM_PSK4800=y
CONFIG_SOUNDMODEM_FSK9600=y
CONFIG_YAM=m

#
# IrDA (infrared) support
#
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
# CONFIG_IRDA_ULTRA is not set
CONFIG_IRDA_OPTIONS=y

#
#   IrDA options
#
# CONFIG_IRDA_CACHE_LAST_LSAP is not set
# CONFIG_IRDA_FAST_RR is not set
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m

#
# FIR device drivers
#
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m

#
# ISDN subsystem
#
CONFIG_ISDN=m
# CONFIG_ISDN_PPP is not set
# CONFIG_ISDN_AUDIO is not set
# CONFIG_ISDN_X25 is not set

#
# ISDN feature submodules
#
CONFIG_ISDN_DRV_LOOP=m
CONFIG_ISDN_DIVERSION=m

#
# low-level hardware drivers
#

#
# Passive ISDN cards
#
# CONFIG_ISDN_DRV_HISAX is not set

#
# Active ISDN cards
#
CONFIG_ISDN_DRV_ICN=m
CONFIG_ISDN_DRV_PCBIT=m
CONFIG_ISDN_DRV_SC=m
CONFIG_ISDN_DRV_ACT2000=m
CONFIG_ISDN_DRV_EICON=y
CONFIG_ISDN_DRV_EICON_DIVAS=m
CONFIG_ISDN_DRV_EICON_OLD=m
CONFIG_ISDN_DRV_EICON_PCI=y
# CONFIG_ISDN_DRV_EICON_ISA is not set
CONFIG_ISDN_CAPI=m
# CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON is not set
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m
CONFIG_ISDN_CAPI_CAPIDRV=m
CONFIG_ISDN_DRV_AVMB1_B1ISA=m
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
# CONFIG_ISDN_DRV_AVMB1_B1PCIV4 is not set
CONFIG_ISDN_DRV_AVMB1_T1ISA=m
CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=m
CONFIG_ISDN_DRV_AVMB1_AVM_CS=m
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
CONFIG_CD_NO_IDESCSI=y
CONFIG_AZTCD=m
CONFIG_GSCD=m
CONFIG_SBPCD=m
CONFIG_MCD=m
CONFIG_MCD_IRQ=11
CONFIG_MCD_BASE=300
CONFIG_MCDX=m
CONFIG_OPTCD=m
CONFIG_CM206=m
CONFIG_SJCD=m
CONFIG_ISP16_CDI=m
CONFIG_CDU31A=m
CONFIG_CDU535=m

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_SERIAL_EXTENDED=y
# CONFIG_SERIAL_MANY_PORTS is not set
# CONFIG_SERIAL_SHARE_IRQ is not set
CONFIG_SERIAL_DETECT_IRQ=y
# CONFIG_SERIAL_MULTIPORT is not set
CONFIG_HUB6=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_COMPUTONE=m
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=m
CONFIG_ESPSERIAL=m
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_ISI=m
CONFIG_SYNCLINK=m
CONFIG_N_HDLC=m
CONFIG_RISCOM8=m
CONFIG_SPECIALIX=m
# CONFIG_SPECIALIX_RTSCTS is not set
CONFIG_SX=m
CONFIG_RIO=m
CONFIG_RIO_OLDPCI=y
# CONFIG_STALDRV is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m

#
# Mice
#
CONFIG_BUSMOUSE=m
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m

#
# Joysticks
#
CONFIG_JOYSTICK=y

#
# Game port support
#
CONFIG_INPUT_NS558=m
CONFIG_INPUT_LIGHTNING=m
CONFIG_INPUT_PCIGAME=m

#
# Gameport joysticks
#
CONFIG_INPUT_ANALOG=m
CONFIG_INPUT_A3D=m
CONFIG_INPUT_ADI=m
CONFIG_INPUT_COBRA=m
CONFIG_INPUT_GF2K=m
CONFIG_INPUT_GRIP=m
CONFIG_INPUT_INTERACT=m
CONFIG_INPUT_TMDC=m
CONFIG_INPUT_SIDEWINDER=m

#
# Serial port support
#
CONFIG_INPUT_SERPORT=m

#
# Serial port joysticks
#
CONFIG_INPUT_WARRIOR=m
CONFIG_INPUT_MAGELLAN=m
CONFIG_INPUT_SPACEORB=m
CONFIG_INPUT_SPACEBALL=m
CONFIG_INPUT_IFORCE_232=m
CONFIG_INPUT_IFORCE_USB=m

#
# Parallel port joysticks
#
CONFIG_INPUT_DB9=m
CONFIG_INPUT_GAMECON=m
CONFIG_INPUT_TURBOGRAFX=m
CONFIG_QIC02_TAPE=m
CONFIG_QIC02_DYNCONF=y

#
#   Setting runtime QIC-02 configuration is done with qic02conf
#

#
#   from the tpqic02-support package.  It is available at
#

#
#   metalab.unc.edu or ftp://titus.cfw.com/pub/Linux/util/
#

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDT=m
CONFIG_WDTPCI=m
# CONFIG_WDT_501 is not set
CONFIG_PCWATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_60XX_WDT=m
CONFIG_MIXCOMWD=m
CONFIG_I810_TCO=m
CONFIG_INTEL_RNG=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DTLK=m
CONFIG_R3964=m
CONFIG_APPLICOM=m

#
# Ftape, the floppy tape device driver
#
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240

#
#   The compressor will be built as a module only!
#
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
# CONFIG_FT_PROC_FS is not set
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set

#
# Hardware configuration
#
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_GAMMA=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_MGA=m
CONFIG_PCMCIA_SERIAL=m

#
# PCMCIA character device support
#
CONFIG_PCMCIA_SERIAL_CS=m
CONFIG_PCMCIA_SERIAL_CB=m

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
CONFIG_I2C_PARPORT=m

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_PMS=m
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_STRADIS=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_BUZ=m
CONFIG_VIDEO_ZR36120=m

#
# Radio Adapters
#
CONFIG_RADIO_CADET=m
CONFIG_RADIO_RTRACK=m
CONFIG_RADIO_RTRACK2=m
CONFIG_RADIO_AZTECH=m
CONFIG_RADIO_GEMTEK=m
CONFIG_RADIO_MAESTRO=m
CONFIG_RADIO_MIROPCM20=m
CONFIG_RADIO_SF16FMI=m
CONFIG_RADIO_TERRATEC=m
CONFIG_RADIO_TRUST=m
CONFIG_RADIO_TYPHOON=m
CONFIG_RADIO_TYPHOON_PROC_FS=y
CONFIG_RADIO_ZOLTRIX=m

#
# File systems
#
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_BFS_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_EFS_FS=m
CONFIG_JFFS_FS=m
CONFIG_JFFS_FS_VERBOSE=0
CONFIG_CRAMFS=m
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
CONFIG_QNX4FS_FS=m
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
# CONFIG_SYSV_FS_WRITE is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_NCP_FS=m
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_MDA_CONSOLE=m

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=m
CONFIG_FB_CLGEN=m
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_PM2_PCI is not set
CONFIG_FB_CYBER2000=m
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=m
CONFIG_FB_HGA=m
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_MATROX_G450=m
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FB_ATY=m
CONFIG_FB_ATY128=m
CONFIG_FB_3DFX=m
CONFIG_FB_SIS=m
CONFIG_FB_VIRTUAL=m
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB2=m
CONFIG_FBCON_CFB4=m
CONFIG_FBCON_CFB8=m
CONFIG_FBCON_CFB16=m
CONFIG_FBCON_CFB24=m
CONFIG_FBCON_CFB32=m
CONFIG_FBCON_AFB=m
CONFIG_FBCON_ILBM=m
# CONFIG_FBCON_IPLAN2P2 is not set
CONFIG_FBCON_IPLAN2P4=m
CONFIG_FBCON_IPLAN2P8=m
CONFIG_FBCON_MAC=m
CONFIG_FBCON_VGA_PLANES=m
CONFIG_FBCON_VGA=m
CONFIG_FBCON_HGA=m
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set

#
# Sound
#
CONFIG_SOUND=m
CONFIG_SOUND_CMPCI=m
CONFIG_SOUND_CMPCI_SPDIFLOOP=y
# CONFIG_SOUND_CMPCI_4CH is not set
CONFIG_SOUND_EMU10K1=m
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_SONICVIBES=m
CONFIG_SOUND_TRIDENT=m
CONFIG_SOUND_MSNDCLAS=m
# CONFIG_MSNDCLAS_HAVE_BOOT is not set
CONFIG_MSNDCLAS_INIT_FILE="/etc/sound/msndinit.bin"
CONFIG_MSNDCLAS_PERM_FILE="/etc/sound/msndperm.bin"
CONFIG_SOUND_MSNDPIN=m
# CONFIG_MSNDPIN_HAVE_BOOT is not set
CONFIG_MSNDPIN_INIT_FILE="/etc/sound/pndspini.bin"
CONFIG_MSNDPIN_PERM_FILE="/etc/sound/pndsperm.bin"
CONFIG_SOUND_VIA82CXXX=m
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
CONFIG_SOUND_AD1816=m
CONFIG_SOUND_SGALAXY=m
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_ACI_MIXER=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_SSCAPE=m
CONFIG_SOUND_GUS=m
CONFIG_SOUND_GUS16=y
CONFIG_SOUND_GUSMAX=y
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_NM256=m
CONFIG_SOUND_MAD16=m
# CONFIG_MAD16_OLDCARD is not set
CONFIG_SOUND_PAS=m
# CONFIG_PAS_JOYSTICK is not set
CONFIG_SOUND_PSS=m
# CONFIG_PSS_MIXER is not set
# CONFIG_PSS_HAVE_BOOT is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_WAVEFRONT=m
CONFIG_SOUND_MAUI=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
# CONFIG_SOUND_YMFPCI_LEGACY is not set
CONFIG_SOUND_UART6850=m
CONFIG_SOUND_AEDSP16=m
# CONFIG_SC6600 is not set
# CONFIG_AEDSP16_SBPRO is not set
# CONFIG_AEDSP16_MSS is not set
# CONFIG_AEDSP16_MPU401 is not set
CONFIG_SOUND_TVMIXER=m

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Controllers
#
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_WACOM=m

#
# USB Imaging devices
#
CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m

#
# USB Multimedia devices
#
CONFIG_USB_IBMCAM=m
CONFIG_USB_OV511=m
CONFIG_USB_DSBR=m
CONFIG_USB_DABUSB=m

#
# USB Network adaptors
#
CONFIG_USB_PLUSB=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_NET1080=m

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_DEBUG is not set
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_OMNINET=m

#
# USB misc drivers
#
CONFIG_USB_RIO500=m

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y


-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
