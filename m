Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbTDDLf1 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 06:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTDDLfP (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 06:35:15 -0500
Received: from mail.explainerdc.com ([212.72.36.220]:43940 "EHLO
	mail.explainerdc.com") by vger.kernel.org with ESMTP
	id S263645AbTDDLdQ convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 06:33:16 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: RAID 5 performance problems
Date: Fri, 4 Apr 2003 13:44:43 +0200
Message-ID: <73300040777B0F44B8CE29C87A0782E101FA988F@exchange.explainerdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RAID 5 performance problems
Thread-Index: AcL6MHEK1nbEBPr5QxGZ33qq5Ke5dwAaGfqA
From: "Jonathan Vardy" <jonathan@explainerdc.com>
To: "Peter L. Ashford" <ashford@sdsc.edu>,
       "Jonathan Vardy" <jonathanv@explainerdc.com>
Cc: "Stephan van Hienen" <raid@a2000.nu>, <linux-raid@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's the one.  Your 120GB drives are being seen as UDMA-33. 
>  Whatever is
> causing this is slowing you down.  Fix this, and the 
> performance should
> improve.
> 
> > but after the boot I set hdparm manually for each drive 
> with the following
> > settings:
> >
> > hdparm -a8 -A1 -c1 -d1 -m16 -u1 /dev/hdc.
> 
> According to your single-drive benchmarks, it didn't do the 
> job.  You'll
> have to find the CAUSE of the UDMA-33 identification, and fix it.  An
> example (not necessarily your problem) is that if a 
> 40-conductor cable is
> used, you CAN'T set the drive to UDMA-66/100/133.  There may 
> also be some
> settings in the drive or controller, or some jumpers, that 
> are keeping the
> drive from switching to the fast modes.
> 
> Once you get the drives being identified at a fast UDMA, you 
> then need to
> again verify the array performance.  It should have climbed 
> significantly.
> 
> Good luck.
> 				Peter Ashford
> 

I've rebooted with the original Red Hat kernel (2.4.20) and it
recognizes the drives correctly now (UDMA100) but the performance is
still poor

Here's the latest info:

Bootlog:

ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
PDC20270: IDE controller at PCI slot 02:01.0
PDC20270: chipset revision 2
PDC20270: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x9040-0x9047, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9048-0x904f, BIOS settings: hdg:pio, hdh:pio
    ide4: BM-DMA at 0x90c0-0x90c7, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x90c8-0x90cf, BIOS settings: hdk:pio, hdl:pio
hda: Maxtor 2B020H1, ATA DISK drive
blk: queue c0453420, I/O limit 4095Mb (mask 0xffffffff)
hdc: WDC WD1200BB-00CAA1, ATA DISK drive
blk: queue c04538a0, I/O limit 4095Mb (mask 0xffffffff)
hde: WDC WD1200BB-60CJA1, ATA DISK drive
blk: queue c0453d20, I/O limit 4095Mb (mask 0xffffffff)
hdg: WDC WD1200BB-60CJA1, ATA DISK drive
blk: queue c04541a0, I/O limit 4095Mb (mask 0xffffffff)
hdi: WDC WD1200BB-60CJA1, ATA DISK drive
blk: queue c0454620, I/O limit 4095Mb (mask 0xffffffff)
hdk: WDC WD1200BB-60CJA1, ATA DISK drive
blk: queue c0454aa0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9000-0x9007,0x9012 on irq 19
ide3 at 0x9020-0x9027,0x9032 on irq 19
ide4 at 0x9080-0x9087,0x9092 on irq 19
ide5 at 0x90a0-0x90a7,0x90b2 on irq 19
hda: host protected area => 1
hda: 39062500 sectors (20000 MB) w/2048KiB Cache, CHS=2431/255/63,
UDMA(33)
hdc: host protected area => 1
hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(33)
hde: host protected area => 1
hde: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(100)
hdg: host protected area => 1
hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(100)
hdi: host protected area => 1
hdi: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(100)
hdk: host protected area => 1
hdk: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(100)

The bonny results are as followed:

Version  1.03       ------Sequential Output------ --Sequential Input-
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
/sec %CP
store.datzegik.c 1G  2717  99 10837  30  4912  10  2747  95 17228  14
114.5   1
                    ------Sequential Create------ --------Random
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read---
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
/sec %CP
                 16   367  98 +++++ +++ 13163  99   368  98 +++++ +++
1386  93
store.datzegik.com,1G,2717,99,10837,30,4912,10,2747,95,17228,14,114.5,1,
16,367,98,+++++,+++,13163,99,368,98,+++++,+++,1386,93

The results per drive with hdparm:

/dev/hda:
 	Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28
MB/sec
 	Timing buffered disk reads:  64 MB in  4.32 seconds = 14.81
MB/sec

/dev/hdc:
	Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28
MB/sec
	Timing buffered disk reads:  64 MB in  4.55 seconds = 14.07
MB/sec

/dev/hde:
	Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28
MB/sec
	Timing buffered disk reads:  64 MB in  2.50 seconds = 25.60
MB/sec

/dev/hdg:
	Timing buffer-cache reads:   128 MB in  1.12 seconds =114.29
MB/sec
	Timing buffered disk reads:  64 MB in  2.30 seconds = 27.83
MB/sec

/dev/hdi:
	Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28
MB/sec
	Timing buffered disk reads:  64 MB in  2.27 seconds = 28.19
MB/sec

/dev/hdk:
	Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28
MB/sec
	Timing buffered disk reads:  64 MB in  2.54 seconds = 25.20
MB/sec

The raid device:

/dev/md0:
	Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28
MB/sec
	Timing buffered disk reads:  64 MB in  2.19 seconds = 29.22
MB/sec

