Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287421AbSBIUjl>; Sat, 9 Feb 2002 15:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287425AbSBIUjf>; Sat, 9 Feb 2002 15:39:35 -0500
Received: from inetgw.eproduction.ch ([212.249.19.98]:266 "EHLO
	inetgw.eproduction.ch") by vger.kernel.org with ESMTP
	id <S287421AbSBIUj2>; Sat, 9 Feb 2002 15:39:28 -0500
Message-ID: <01C9A99CE9CFD511B3BB00D0B73EBB25424DC4@exchange.intern.eproduction.ch>
From: =?ISO-8859-1?Q? "R=FCegg,?= Peter H." <pruegg@eproduction.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with mke2fs on huge RAID-partition
Date: Sat, 9 Feb 2002 21:44:49 +0100 
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Is there a limitation in the maximum size of a partition 
>> (well, 400 GB is not that small...), may it be a (known) 
>> problem of mke2fs or the particular Kernel-Version, or 
>> does anyone have any suggestions where else to seek?
> 
> Well, I know for a fact that people have created such large 
> ext2 filesystems.
> 
>> All RAID is done in software, using (at the moment) a 
>> Standard RedHat 7.2 Kernel 2.4.7.
> 
> The first thing to do would be to update to the latest RH kernel.

Hi there,

thanks for all the answers (Wow! I've got eMail from Alan Cox! ;-).
They basically all said the same: upgrade to a newer kernel. Well, for 
some strange reason I have not yet been able to compile a running 
kernel on that system (tried 2.4.18-pre9 and 2.4.17, Processor-Type 
Athlon, i686, i386; it's an Athlon XP-1600) - it always freezes a 
few seconds after init started. Standard RedHat-Kernels do run though, 
so I've upgraded to their 2.4.9-21 (Strangely, the messages captured 
via serial console are more or less the same...) The behaviour didn't 
change - the box solidly freezes as soon as mke2fs starts to write 
the superblocks. However, different to before the harddisks are 
audibly writing something for approximately 1 second now - and the
resyncing of the raid1-arrays has become immensly (times 4) faster, too.

I've included my raidtab [1], mke2fs command [2], and the .config [3] as
well as the captured messages from the not-working-2.4.18-pre9 [3], as I
fear this might be related and maybe a hardware malfunction in the end...

I'm still glad for any suggestions - coworkers are way keen on their
mp3-server ;-)

Thanks & Greets


Peter H. Ruegg
Systems-/Networkadministrator eProduction AG

[1] 
raiddev		    /dev/md3
raid-level		    1
nr-raid-disks		    2
chunk-size		    64k
persistent-superblock	    1
nr-spare-disks		    0
    device	    /dev/hda3
    raid-disk     0
    device	    /dev/hdb3
    raid-disk     1
raiddev		    /dev/md5
raid-level		    1
nr-raid-disks		    2
chunk-size		    64k
persistent-superblock	    1
nr-spare-disks		    0
    device	    /dev/hda1
    raid-disk     0
    device	    /dev/hdb1
    raid-disk     1
raiddev		    /dev/md6
raid-level		    1
nr-raid-disks		    2
chunk-size		    64k
persistent-superblock	    1
nr-spare-disks		    0
    device	    /dev/hda9
    raid-disk     0
    device	    /dev/hdb9
    raid-disk     1
raiddev		    /dev/md0
raid-level		    1
nr-raid-disks		    2
chunk-size		    64k
persistent-superblock	    1
nr-spare-disks		    0
    device	    /dev/hda8
    raid-disk     0
    device	    /dev/hdb8
    raid-disk     1
raiddev		    /dev/md4
raid-level		    1
nr-raid-disks		    2
chunk-size		    64k
persistent-superblock	    1
nr-spare-disks		    0
    device	    /dev/hda6
    raid-disk     0
    device	    /dev/hdb6
    raid-disk     1
raiddev		    /dev/md1
raid-level		    1
nr-raid-disks		    2
chunk-size		    64k
persistent-superblock	    1
nr-spare-disks		    0
    device	    /dev/hda5
    raid-disk     0
    device	    /dev/hdb5
    raid-disk     1
raiddev		    /dev/md2
raid-level		    1
nr-raid-disks		    2
chunk-size		    64k
persistent-superblock	    1
nr-spare-disks		    0
    device	    /dev/hda7
    raid-disk     0
    device	    /dev/hdb7
    raid-disk     1
raiddev		    /dev/md7
raid-level	            5
nr-raid-disks               6
nr-spare-disks              0
persistent-superblock       1
parity-algorithm            left-symmetric
chunk-size                  128k
    device	/dev/hde1
    raid-disk	0
    device	/dev/hdg1
    raid-disk	1
    device	/dev/hdi1
    raid-disk	2
    device	/dev/hdk1
    raid-disk	3
    device	/dev/hdm1
    raid-disk	4
    device	/dev/hdo1
    raid-disk	5




[2]
mke2fs -b 4096 -i 1048576 -m 1 -L /home/mp3 -R stride=32 -j -v /dev/md7




[3]
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_MD_MULTIPATH=y
CONFIG_BLK_DEV_LVM=m
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_ATALK=m
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_POLICE=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_BUSMOUSE=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_R128=y
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_CQCAM=m
CONFIG_QUOTA=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m
CONFIG_UFS_FS=m
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_ZISOFS_FS=y
CONFIG_ZLIB_FS_INFLATE=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y



[4]
Linux version 2.4.18-pre9 (root@dhcp-179) (gcc version 2.96 20000731 (Red
Hat Linux 7.1 2.96-98)) #8 Sat Feb 9 19:57:57 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131052
zone(0): 4096 pages.
zone(1): 126956 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=notwlinux ro root=903
BOOT_FILE=/boot/vmlinuz-2.4.18-pre9 hdd=ide-scsi console=ttyS0
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 1410.245 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 2811.49 BogoMIPS
Memory: 513320k/524208k available (1429k kernel code, 10496k reserved, 398k
data, 208k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0df0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/3074] at 00:11.0
PCI: Found IRQ 11 for device 00:11.1
PCI: Sharing IRQ 11 with 00:0d.0
PCI: Sharing IRQ 11 with 01:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20268: IDE controller on PCI bus 00 dev 68
PCI: Found IRQ 11 for device 00:0d.0
PCI: Sharing IRQ 11 with 00:11.1
PCI: Sharing IRQ 11 with 01:00.0
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
PDC20268: IDE controller on PCI bus 00 dev 70
PCI: Found IRQ 10 for device 00:0e.0
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide4: BM-DMA at 0x8800-0x8807, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x8808-0x880f, BIOS settings: hdk:pio, hdl:pio
PDC20268: IDE controller on PCI bus 00 dev 78
PCI: Found IRQ 5 for device 00:0f.0
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide6: BM-DMA at 0x7000-0x7007, BIOS settings: hdm:pio, hdn:pio
    ide7: BM-DMA at 0x7008-0x700f, BIOS settings: hdo:pio, hdp:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: Found IRQ 11 for device 00:11.1
PCI: Sharing IRQ 11 with 00:0d.0
PCI: Sharing IRQ 11 with 01:00.0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0x6400-0x6407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x6408-0x640f, BIOS settings: hdc:pio, hdd:DMA
hda: MAXTOR 6L040J2, ATA DISK drive
hdb: MAXTOR 6L040J2, ATA DISK drive
hdd: PHILIPS CDRW1610A, ATAPI CD/DVD-ROM drive
hde: MAXTOR 6L080J4, ATA DISK drive
hdg: MAXTOR 6L080J4, ATA DISK drive
hdi: MAXTOR 6L080J4, ATA DISK drive
hdk: MAXTOR 6L080J4, ATA DISK drive
hdm: MAXTOR 6L080J4, ATA DISK drive
hdo: MAXTOR 6L080J4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb800-0xb807,0xb402 on irq 11
ide3 at 0xb000-0xb007,0xa802 on irq 11
ide4 at 0xa000-0xa007,0x9802 on irq 10
ide5 at 0x9400-0x9407,0x9002 on irq 10
ide6 at 0x8400-0x8407,0x8002 on irq 5
ide7 at 0x7800-0x7807,0x7402 on irq 5
hda: 78177792 sectors (40027 MB) w/1818KiB Cache, CHS=4866/255/63, UDMA(100)
hdb: 78177792 sectors (40027 MB) w/1818KiB Cache, CHS=4866/255/63, UDMA(100)
hde: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63,
UDMA(100)
hdg: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63,
UDMA(100)
hdi: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63,
UDMA(100)
hdk: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63,
UDMA(100)
hdm: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63,
UDMA(100)
hdo: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63,
UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 >
 hde: hde1
 hdg: hdg1
 hdi: hdi1
 hdk: hdk1
 hdm:hdm: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdm: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdm: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdm: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdm: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdm: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdm: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdm: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide6: reset: success
 hdm1
 hdo:hdo: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdo: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdo: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdo: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdo: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdo: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdo: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdo: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide7: reset: success
 hdo1
PCI: Assigned IRQ 6 for device 00:10.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:10.0: 3Com PCI 3c905C Tornado at 0x6800. Vers LK1.1.16
[drm] Initialized r128 2.1.6 20010405 on minor 0
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2156.000 MB/sec
   32regs    :  1249.200 MB/sec
   pIII_sse  :  2298.800 MB/sec
   pII_mmx   :  3308.000 MB/sec
   p5_mmx    :  4232.400 MB/sec
raid5: using function: pIII_sse (2298.800 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 0000003e]
 [events: 0000003e]
 [events: 0000003e]
 [events: 0000003e]
 [events: 0000003e]
 [events: 0000003f]
 [events: 0000003f]
 [events: 0000003e]
 [events: 0000003e]
 [events: 0000003e]
 [events: 0000003e]
 [events: 0000003e]
 [events: 0000003f]
 [events: 0000003f]
 [events: 0000001f]
 [events: 0000001f]
 [events: 0000001f]
 [events: 0000001f]
 [events: 0000001f]
 [events: 0000001f]
md: autorun ...
md: considering hdo1 ...
md:  adding hdo1 ...
md:  adding hdm1 ...
md:  adding hdk1 ...
md:  adding hdi1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md7
md: bind<hde1,1>
md: bind<hdg1,2>
md: bind<hdi1,3>
md: bind<hdk1,4>
md: bind<hdm1,5>
md: bind<hdo1,6>
md: running: <hdo1><hdm1><hdk1><hdi1><hdg1><hde1>
md: hdo1's event counter: 0000001f
md: hdm1's event counter: 0000001f
md: hdk1's event counter: 0000001f
md: hdi1's event counter: 0000001f
md: hdg1's event counter: 0000001f
md: hde1's event counter: 0000001f
md: md7: raid array is not clean -- starting background reconstruction
md7: max total readahead window set to 2560k
md7: 5 data-disks, max readahead per data-disk: 512k
raid5: device hdo1 operational as raid disk 5
raid5: device hdm1 operational as raid disk 4
raid5: device hdk1 operational as raid disk 3
raid5: device hdi1 operational as raid disk 2
raid5: device hdg1 operational as raid disk 1
raid5: device hde1 operational as raid disk 0
raid5: allocated 6435kB for md7
raid5: raid level 5 set md7 active with 6 out of 6 devices, algorithm 2
raid5: raid set md7 not clean; reconstructing parity
RAID5 conf printout:
 --- rd:6 wd:6 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdi1
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
 disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
 disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
RAID5 conf printout:
 --- rd:6 wd:6 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdi1
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
 disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
 disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
md: updating md7 RAID superblock on device
md: hdo1 [events: 00000020]<6>(write) hdo1's sb offset: 78177344
md: syncing RAID array md7
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000
KB/sec) for reconstruction.
md: using 124k window, over a total of 78177280 blocks.
md: hdm1 [events: 00000020]<6>(write) hdm1's sb offset: 78177344
md: hdk1 [events: 00000020]<6>(write) hdk1's sb offset: 78177344
md: hdi1 [events: 00000020]<6>(write) hdi1's sb offset: 78177344
spurious 8259A interrupt: IRQ7.
md: hdg1 [events: 00000020]<6>(write) hdg1's sb offset: 78177344
md: hde1 [events: 00000020]<6>(write) hde1's sb offset: 78177344
md: considering hdb9 ...
md:  adding hdb9 ...
md:  adding hda9 ...
md: created md6
md: bind<hda9,1>
md: bind<hdb9,2>
md: running: <hdb9><hda9>
md: hdb9's event counter: 0000003f
md: hda9's event counter: 0000003f
md: md6: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md6: max total readahead window set to 124k
md6: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdb9 operational as mirror 1
raid1: device hda9 operational as mirror 0
raid1: raid set md6 not clean; reconstructing mirrors
raid1: raid set md6 active with 2 out of 2 mirrors
md: updating md6 RAID superblock on device
md: hdb9 [events: 00000040]<6>(write) hdb9's sb offset: 24715904
md: syncing RAID array md6
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000
KB/sec) for reconstruction.
md: using 124k window, over a total of 24715904 blocks.
md: hda9 [events: 00000040]<6>(write) hda9's sb offset: 24715904
md: considering hdb8 ...
md:  adding hdb8 ...
md:  adding hda8 ...
md: created md0
md: bind<hda8,1>
md: bind<hdb8,2>
md: running: <hdb8><hda8>
md: hdb8's event counter: 0000003f
md: hda8's event counter: 0000003f
md: md0: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdb8 operational as mirror 1
raid1: device hda8 operational as mirror 0
raid1: raid set md0 not clean; reconstructing mirrors
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: hdb8 [events: 00000040]<6>(write) hdb8's sb offset: 4096448
md: delaying resync of md0 until md6 has finished resync (they share one or
more physical units)
md: hda8 [events: 00000040]<6>(write) hda8's sb offset: 4096448
md: considering hdb7 ...
md:  adding hdb7 ...
md:  adding hda7 ...
md: created md2
md: bind<hda7,1>
md: bind<hdb7,2>
md: running: <hdb7><hda7>
md: hdb7's event counter: 0000003e
md: hda7's event counter: 0000003e
md: md2: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md2: max total readahead window set to 124k
md2: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdb7 operational as mirror 1
raid1: device hda7 operational as mirror 0
raid1: raid set md2 not clean; reconstructing mirrors
raid1: raid set md2 active with 2 out of 2 mirrors
md: updating md2 RAID superblock on device
md: hdb7 [events: 0000003f]<6>(write) hdb7's sb offset: 2048192
md: delaying resync of md2 until md6 has finished resync (they share one or
more physical units)
md: hda7 [events: 0000003f]<6>(write) hda7's sb offset: 2048192
md: considering hdb6 ...
md:  adding hdb6 ...
md:  adding hda6 ...
md: created md4
md: bind<hda6,1>
md: bind<hdb6,2>
md: running: <hdb6><hda6>
md: hdb6's event counter: 0000003e
md: hda6's event counter: 0000003e
md: md4: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md4: max total readahead window set to 124k
md4: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdb6 operational as mirror 1
raid1: device hda6 operational as mirror 0
raid1: raid set md4 not clean; reconstructing mirrors
raid1: raid set md4 active with 2 out of 2 mirrors
md: updating md4 RAID superblock on device
md: hdb6 [events: 0000003f]<6>(write) hdb6's sb offset: 1028032
md: delaying resync of md4 until md6 has finished resync (they share one or
more physical units)
md: hda6 [events: 0000003f]<6>(write) hda6's sb offset: 1028032
md: considering hdb5 ...
md:  adding hdb5 ...
md:  adding hda5 ...
md: created md1
md: bind<hda5,1>
md: bind<hdb5,2>
md: running: <hdb5><hda5>
md: hdb5's event counter: 0000003e
md: hda5's event counter: 0000003e
md: md1: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdb5 operational as mirror 1
raid1: device hda5 operational as mirror 0
raid1: raid set md1 not clean; reconstructing mirrors
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: hdb5 [events: 0000003f]<6>(write) hdb5's sb offset: 3076352
md: delaying resync of md1 until md6 has finished resync (they share one or
more physical units)
md: hda5 [events: 0000003f]<6>(write) hda5's sb offset: 3076352
md: considering hdb3 ...
md:  adding hdb3 ...
md:  adding hda3 ...
md: created md3
md: bind<hda3,1>
md: bind<hdb3,2>
md: running: <hdb3><hda3>
md: hdb3's event counter: 0000003e
md: hda3's event counter: 0000003e
md: md3: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md3: max total readahead window set to 124k
md3: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdb3 operational as mirror 1
raid1: device hda3 operational as mirror 0
raid1: raid set md3 not clean; reconstructing mirrors
raid1: raid set md3 active with 2 out of 2 mirrors
md: updating md3 RAID superblock on device
md: hdb3 [events: 0000003f]<6>(write) hdb3's sb offset: 2048192
md: delaying resync of md3 until md6 has finished resync (they share one or
more physical units)
md: hda3 [events: 0000003f]<6>(write) hda3's sb offset: 2048192
md: considering hdb1 ...
md:  adding hdb1 ...
md:  adding hda1 ...
md: created md5
md: bind<hda1,1>
md: bind<hdb1,2>
md: running: <hdb1><hda1>
md: hdb1's event counter: 0000003e
md: hda1's event counter: 0000003e
md: md5: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md5: max total readahead window set to 124k
md5: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdb1 operational as mirror 1
raid1: device hda1 operational as mirror 0
raid1: raid set md5 not clean; reconstructing mirrors
raid1: raid set md5 active with 2 out of 2 mirrors
md: updating md5 RAID superblock on device
md: hdb1 [events: 0000003f]<6>(write) hdb1's sb offset: 24000
md: delaying resync of md5 until md6 has finished resync (they share one or
more physical units)
md: hda1 [events: 0000003f]<6>(write) hda1's sb offset: 24000
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed

--8<------------------------------------------------------------------------
-
main(){char*s="O_>>^PQAHBbPQAHBbPOOH^^PAAHBJPAAHBbPA_H>BB";int
i,j,k=1,l,m,n;
for(j=0;j<7;j++)for(l=0;m=l-6+j,i=m/6,n=j*6+i,k=1<<m%6,l<41-j;l++)
putchar(l<6-j?' ':l==40-j?'\n':k&&s[n]&k?'*':' ');}
