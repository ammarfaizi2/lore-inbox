Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288922AbSATS5S>; Sun, 20 Jan 2002 13:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288923AbSATS5J>; Sun, 20 Jan 2002 13:57:09 -0500
Received: from firewall.oeone.com ([216.191.248.101]:15232 "EHLO
	masouds1.oeone.com") by vger.kernel.org with ESMTP
	id <S288922AbSATS4t>; Sun, 20 Jan 2002 13:56:49 -0500
Date: Sun, 20 Jan 2002 14:01:07 -0500
From: Masoud Sharbiani <masouds@oeone.com>
To: linux-kernel@vger.kernel.org
Subject: PDC20265 IDE raid controller hangs when cmd640 defined.
Message-ID: <20020120140107.A12537@masouds1.oeone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
I recently got a MS-6321 dual processor motherboard which has Promise 
FastTrak (IDE) RAID controller. When I attached two Maxtor 6L040J2 drives(40 gig)
to the two channels, it couldn't boot Linux-2.4.17 and hanged just after detecting 
IDE controllers and just before partition detection.
I finally got what was wrong, I had to disable CMD640 bugfix option. Is this a 
known issue? Since I couldn't find anything on google.

A second question: Is this true that ataraid only supports only one raid?
if not, what is the major number for second raid?

[/var/log/messages]
.....
 ttyS00 at 0x03f8 (irq = 4) is a 16550A
 ttyS01 at 0x02f8 (irq = 3) is a 16550A
 Real Time Clock Driver v1.10e
 block: 128 slots per queue, batch=32
 RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
 Uniform Multi-Platform E-IDE driver Revision: 6.31
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 VP_IDE: IDE controller on PCI bus 00 dev 39
 VP_IDE: chipset revision 6
 VP_IDE: not 100%% native mode: will probe irqs later
 VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
     ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:DMA, hdd:DMA
 PDC20265: IDE controller on PCI bus 00 dev 60
 PDC20265: chipset revision 2
 ide: Found promise 20265 in RAID mode.
 PDC20265: not 100%% native mode: will probe irqs later
 PDC20265: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
     ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio

--------------HERE IS WHERE KERNEL HANGS.
and the rest of kernel log file when I disable cmd640 bugfix. Business as usual.
 hda: FUJITSU MPG3409AT E, ATA DISK drive
 hdc: DVDROM 10X, ATAPI CD/DVD-ROM drive
 hdd: LITE-ON LTR-12101B, ATAPI CD/DVD-ROM drive
 hde: MAXTOR 6L040J2, ATA DISK drive
 hdg: MAXTOR 6L040J2, ATA DISK drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 ide1 at 0x170-0x177,0x376 on irq 15
 ide2 at 0xcc00-0xcc07,0xd002 on irq 11
 ide3 at 0xd400-0xd407,0xd802 on irq 11
 hda: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=4983/255/63, UDMA(100)
 A Register SYNC_IN ERRDY_EN IORDY_EN PREFETCH_EN PIO(A) = 0 
         AP 11110000
 B Register MB0 DMA(B) = 1 PB1 PB0 PIO(B) = 3 
         BP 00100011
 C Register IORDYp MC0 DMA(C) = 1 
         CP 01000001
 D Register 
         DP 00000000
 hde: UDMA 5 drive0 0x004123f0 0x004123f0
 hde: 78177792 sectors (40027 MB) w/1818KiB Cache, CHS=77557/16/63, UDMA(100)
 A Register SYNC_IN ERRDY_EN IORDY_EN PREFETCH_EN PIO(A) = 0 
         AP 11110000
 B Register MB0 DMA(B) = 1 PB1 PB0 PIO(B) = 3 
         BP 00100011
 C Register IORDYp MC0 DMA(C) = 1 
         CP 01000001
 D Register 
         DP 00000000
 hdg: UDMA 5 drive2 0x004123f0 0x004123f0
 hdg: 78177792 sectors (40027 MB) w/1818KiB Cache, CHS=77557/16/63, UDMA(100)
 hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
 Uniform CD-ROM driver Revision: 3.12
 Partition check:
  hda: hda1 hda2 < hda5 hda6 hda7 hda8 > hda3 hda4
  hde: [PTBL] [4866/255/63] hde1 hde2
  hdg: unknown partition table
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a post-1991 82077
  ataraid/d0: ataraid/d0p1 ataraid/d0p2
 Drive 0 is 38172 Mb (33 / 0) 
 Drive 1 is 38172 Mb (34 / 0) 
 Raid0 array consists of 2 drives. 
 Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta
 Highpoint HPT370 Softwareraid driver for linux version 0.01
 No raid array found
 pci_hotplug: PCI Hot Plug PCI Core version: 0.3
 NET4: Linux TCP/IP 1.0 for NET4.0
 IP Protocols: ICMP, UDP, TCP, IGMP
 IP: routing cache hash table of 8192 buckets, 64Kbytes
 TCP: Hash tables configured (established 262144 bind 65536)
 NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
....


-- 
Masoud Sharabiani
Software Developer, OEone Corporation
#103 - 290 St-Joseph Blvd.
Hull, Quebec J8Y 3Y3
819-770-3444 ext. 521

Unix:        Your gun, Your bullet, Your foot, Your choice.
M$-CE/ME/NT: Same as Unix, BUT: No choice, and We Aim Higher.
