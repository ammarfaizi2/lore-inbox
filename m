Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbTDDPy0 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 10:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTDDPyL (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 10:54:11 -0500
Received: from mail.explainerdc.com ([212.72.36.220]:25512 "EHLO
	mail.explainerdc.com") by vger.kernel.org with ESMTP
	id S263787AbTDDPtu convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 10:49:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: RAID 5 performance problems
Date: Fri, 4 Apr 2003 18:01:17 +0200
Message-ID: <73300040777B0F44B8CE29C87A0782E101FA98FB@exchange.explainerdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RAID 5 performance problems
Thread-Index: AcL6MHEK1nbEBPr5QxGZ33qq5Ke5dwAaGfqAAAnQgUA=
From: "Jonathan Vardy" <jonathan@explainerdc.com>
To: "Jonathan Vardy" <jonathan@explainerdc.com>,
       "Peter L. Ashford" <ashford@sdsc.edu>,
       "Jonathan Vardy" <jonathanv@explainerdc.com>
Cc: "Stephan van Hienen" <raid@a2000.nu>, <linux-raid@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've rebooted with the original Red Hat kernel (2.4.20) and it
> recognizes the drives correctly now (UDMA100) but the performance is
> still poor

Added to this I've replaced the rounded cables with the promise cables
to make sure this is not an issue. I've put in two 500Mhz processors so
it is comparable with my friends orignal setup of 2x500Mhz, 6x80GB (2x
Udma33, 4x Udma66) which had around 80MB/sec for reads.

The dual 500Mhz setup with 2.4.20 does:

/dev/md0:
	Timing buffer-cache reads:   128 MB in  0.96 seconds =133.33
MB/sec
	Timing buffered disk reads:  64 MB in  3.05 seconds = 20.98
MB/sec

Latest Bonnie++ results:

Version  1.03       ------Sequential Output------ --Sequential Input-
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
/sec %CP
store.datzegik.c 1G  3800  99 11114  22  4910   7  3632  92 17681  10
105.9   0
                    ------Sequential Create------ --------Random
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read---
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
/sec %CP
                 16   484  98 +++++ +++ 15714  86   518  98 +++++ +++
1985  92
store.datzegik.com,1G,3800,99,11114,22,4910,7,3632,92,17681,10,105.9,0,1
6,484,98,+++++,+++,15714,86,518,98,+++++,+++,1985,92

Bootmessages:

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
