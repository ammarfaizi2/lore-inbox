Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317751AbSHKFj5>; Sun, 11 Aug 2002 01:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317752AbSHKFj5>; Sun, 11 Aug 2002 01:39:57 -0400
Received: from static-b2-215.highspeed.eol.ca ([64.56.236.215]:11648 "EHLO
	zeus.home.lan") by vger.kernel.org with ESMTP id <S317751AbSHKFjz>;
	Sun, 11 Aug 2002 01:39:55 -0400
Date: Sun, 11 Aug 2002 01:43:41 -0400 (EDT)
From: Stewart <bdlists@snerk.org>
X-X-Sender: blackdeath@zeus.home.lan
Reply-To: Stewart <bdlists@snerk.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 IDE Partition Check issue (again)
Message-ID: <Pine.LNX.4.44.0208110143120.14122-100000@zeus.home.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002 steveb@unix.lancs.ac.uk wrote:

> Sorry if this is an old issue, but I'm still seeing this problem between
> ALI15x3 and Maxtor drives when DMA is enabled...

> If I run 2.4.19 DMA is not autodetected. I get lousy performance. I can
> enable DMA (with hdparm) on all but my Maxtor drive, but if I manually
> enable DMA on the Maxtor drive disk access freezes (to both drives on
> the channel).
> 
> If I run 2.4.19-ac4 DMA is turned on automatically and the system hangs
> at the partition check.

I'm not quite certain whether my problem is related or not, but I happened 
to see that you're running the same onboard chipset driver as I am, and 
I'm having strange large IDE disk problems lately.

I'm not sure if this is hardware or not, as this drive is an RMA 
replacement unit (bad sectors), and the text of this new message puzzles 
me.

Anyways, to the particulars.

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using 
pci=bi
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD800BB-75CAA0, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
hdc: MATSHITA CR-585, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: setmax LBA 156301488, native  156250000
hda: 156250000 sectors (80000 MB) w/2048KiB Cache, CHS=9726/255/63, (U)DMA
spurious 8259A interrupt: IRQ7.
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 >
ide-floppy driver 0.99.newide


Shortly before I got home tonight (the clock is wrong; it's supposed to 
read 1:19; it's been corrected, so ignore it. {smile} ) my system's IDE 
bus was frozen, so all daemons were dead in their tracks. IP routing was 
still functional, but none of my servers (hence my mail and web browsing) 
were cut off at the knees.

Here's what I found in /var/log/messages, right before the lockup (and 
reset; C-A-D wouldn't respond);

Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250000, sector=1527880
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250000, sector=1527880
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250000, sector=1527880
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr:ror }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250685, sector=1528520
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250685, sector=1528520
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250685, sector=1528520
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250685, sector=1528520
Aug 10 21:09:46 zeus kernel: ide0: reset: success
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250685, sector=1528520
Aug 10 21:09:46 zeus kernel: end_request: I/O error, dev 03:0b (hda), 
sector 1528520
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250685, sector=1528528
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250685, sector=1528528
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250685, sector=1528528
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250685, sector=1528528
Aug 10 21:09:46 zeus kernel: ide0: reset: success
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250685, sector=1528528
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250685, sector=1528528
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=156250685, sector=1528528
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug 10 21:09:46 zeus kernel: hda: multwrite_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=15^G ^N^Amg^Dk<8E>^R^Q<88>^A^@^@^@H^@

After that it just got corrupted for a couple of lines.

Written on the drive itself is a sector count of 156250000, which is 
reported by the line(s) in dmesg;

hda: setmax LBA 156301488, native  156250000
hda: 156250000 sectors (80000 MB) w/2048KiB Cache, CHS=9726/255/63, (U)DMA

So, what I'm curious to know is - why was it trying to write to sectors 
156250000 and 156250685? By my count, that's the last sector and a sector 
beyond the end of the drive.

Anyways, this being a brand-new drive I'm somewhat frustrated by all of 
this, and I'd love to know whether this is possibly hardware, or software 
related.

Thank-you all in advance for any insight.

-- 
  Stewart Honsberger @ http://blackdeath.snerk.org/
  Linux zeus 2.4.19 #3 Fri Aug 2 23:28:56 EDT 2002 i586 AuthenticAMD
  1:34am  up 23 min,  2 users,  load average: 1.04, 1.11, 1.01
  Doesn't it bother you, that we have to search for intelligent life
  --- OUT THERE??


