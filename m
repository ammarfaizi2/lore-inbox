Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289521AbSAOMcB>; Tue, 15 Jan 2002 07:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289523AbSAOMbs>; Tue, 15 Jan 2002 07:31:48 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:64260 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S289521AbSAOMbX>; Tue, 15 Jan 2002 07:31:23 -0500
From: Norbert Preining <preining@logic.at>
Date: Tue, 15 Jan 2002 13:29:55 +0100
To: linux-kernel@vger.kernel.org
Cc: andre@linuxdiskcert.org
Subject: [BUG] 2.4.18.3, ide-patch, read_dev_sector hangs in read_cache_page
Message-ID: <20020115132955.A31735@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list, hi Andre!

I already described the problem, now in more detail:

2.4.18-pre3
ide.2.4.18-pre2.12102001.patch

is booting but when checking the partition table of hdf on a hpt370
it hangs in read_cache_page in read_dev_sector from fs/partitions/check.c.
This is what I could find out.

Without the ide-patch it works without any problems.

Hardware:
Athlon TB1400
Epox 8kta+pro (via)
secondary ide controller hpt370 with the most recent bios from the hpt page.
hdf: IBM-DCAA-33610, ATA DISK drive

All other infos could be found in the dmesg output at the end of this email

Best wishes

Norbert


On Mon, 14 Jan 2002, preining wrote:
> Here is the end of a kernel boot WITH the ide patch:
> Partition check:
>  hda: hda1 hda2
>  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11 hdb12 hdb13 >
>  hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 hde9 hde10 hde11 hde12 >
>  hdf:
> And here it hangs, nothing more.
> 
> I have the following config vars set concerning IDE:
> [/usr/src/linux] grep _IDE .config
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> # CONFIG_IDEDISK_STROKE is not set
> # CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
> # CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
> # CONFIG_BLK_DEV_IDEDISK_IBM is not set
> # CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
> # CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
> # CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
> # CONFIG_BLK_DEV_IDEDISK_WD is not set
> # CONFIG_BLK_DEV_IDECS is not set
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> CONFIG_BLK_DEV_IDEFLOPPY=m
> CONFIG_BLK_DEV_IDESCSI=y
> # CONFIG_IDE_TASK_IOCTL is not set
> CONFIG_IDE_TASKFILE_IO=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_IDEDMA_ONLYDISK=y
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_PCI_WIP is not set
> # CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
> # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_IDEDMA_AUTO=y
> CONFIG_IDEDMA_IVB=y
> CONFIG_BLK_DEV_IDE_MODES=y
> # CONFIG_CD_NO_IDESCSI is not set
> 
> 
> Here a dmesg of a boot from another kernel without ide-patches, but
> with the hpt patches FROM the ide patch, so ot must be something
> in another place of the ide patch:
> 
> Linux version 2.4.18pre2-packet (root@mandala) (gcc version 2.95.2 19991024 (release)) #5 Wed Jan 9 09:32:03 CET 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
>  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
>  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> On node 0 totalpages: 65520
> zone(0): 4096 pages.
> zone(1): 61424 pages.
> zone(2): 0 pages.
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!
> Kernel command line: BOOT_IMAGE=linux ro root=341 BOOT_FILE=/boot/image hdd=ide-scsi video=vesa:ypan
> ide_setup: hdd=ide-scsi
> Initializing CPU#0
> Detected 1400.087 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 2791.83 BogoMIPS
> Memory: 255640k/262080k available (1153k kernel code, 6056k reserved, 325k data, 224k init, 0k highmem)
> Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
> Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
> Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
> CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
> CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
> CPU: AMD Athlon(tm) processor stepping 04
> Enabling fast FPU save and restore... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1400.0716 MHz.
> ..... host bus clock speed is 266.6803 MHz.
> cpu: 0, clocks: 2666803, slice: 1333401
> CPU0<T0:2666800,T1:1333392,D:7,S:1333401,C:2666803>
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: Intel
> PCI: PCI BIOS revision 2.10 entry at 0xfb3f0, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> Unknown bridge resource 0: assuming transparent
> PCI: Using IRQ router VIA [1106/0686] at 00:07.0
> Applying VIA southbridge workaround.
> PCI: Disabling Via external APIC routing
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> apm: BIOS version 1.2 Flags 0x07 (Driver version 1.15)
> Starting kswapd
> VFS: Diskquotas version dquot_6.4.0 initialized
> Detected PS/2 Mouse Port.
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> PCI: Found IRQ 5 for device 00:0c.0
> PCI: Sharing IRQ 5 with 00:0a.0
> Real Time Clock Driver v1.10e
> block: 128 slots per queue, batch=32
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
> HPT370A: IDE controller on PCI bus 00 dev 70
> PCI: Found IRQ 11 for device 00:0e.0
> PCI: Sharing IRQ 11 with 00:09.0
> HPT370A: chipset revision 4
> HPT370A: not 100% native mode: will probe irqs later
> HPT370: using 33MHz PCI clock
>     ide2: BM-DMA at 0xe400-0xe407, BIOS settings: hde:DMA, hdf:DMA
>     ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: hdg:DMA, hdh:pio
> hda: IBM-DTTA-350840, ATA DISK drive
> hdb: Maxtor 52049H4, ATA DISK drive
> hdc: TOSHIBA DVD-ROM SD-M1402, ATAPI CD/DVD-ROM drive
> hdd: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
> hde: IC35L040AVER07-0, ATA DISK drive
> hdf: IBM-DCAA-33610, ATA DISK drive
> hdg: IC35L040AVER07-0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0xd400-0xd407,0xd802 on irq 11
> ide3 at 0xdc00-0xdc07,0xe002 on irq 11
> hda: 16514064 sectors (8455 MB) w/467KiB Cache, CHS=1027/255/63, UDMA(33)
> hdb: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=39703/16/63, UDMA(100)
> hde: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(44)
> hdf: 7056000 sectors (3613 MB) w/96KiB Cache, CHS=7000/16/63, DMA
> hdg: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(44)
> hdc: ATAPI 40X DVD-ROM drive, 128kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> Partition check:
>  hda: hda1 hda2
>  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11 hdb12 hdb13 >
>  hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 hde9 hde10 hde11 hde12 >
>  hdf: hdf1 hdf2
> ...
> 

-----------------------------------------------------------------------
Norbert Preining <preining@logic.at> 
University of Technology Vienna, Austria            gpg DSA: 0x09C5B094
-----------------------------------------------------------------------
WIGAN (n.)

If, when talking to someone you know has only one leg, you're trying
to treat then perfectly casually and normally, but find to your horror
that your conversion is liberally studded with references to (a) Long
John Silver, (b) Hopalong Cassidy, (c) The Hockey Cokey, (d) 'putting
your foot in it', (e) 'the last leg of the UEFA competition', you are
said to have committed a wigan. The word is derived from the fact that
sub-editors at ITN used to manage to mention the name of either the
town Wigan, or Lord Wigg, in every fourth script that Reginald
Bosanquet was given to read.

			--- Douglas Adams, The Meaning of Liff 
