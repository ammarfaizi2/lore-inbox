Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314329AbSEFKCU>; Mon, 6 May 2002 06:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314338AbSEFKCT>; Mon, 6 May 2002 06:02:19 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:12147 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314329AbSEFKCS>; Mon, 6 May 2002 06:02:18 -0400
Message-Id: <5.1.0.14.2.20020506105723.04138980@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 06 May 2002 11:02:42 +0100
To: Jens Axboe <axboe@suse.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: tcq problem details Re: vanilla 2.5.13 severe file system
  corruption experienced follozing e2fsck ...
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020506085033.GD820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

I didn't get a panic in the limited testing I did just now on 2.5.14 for 
ntfs however I do get soemthing odd. Even when the box is fully idle 
proc/ide/blah/tcq shows this:

TCQ currently on:       yes
Max queue depth:        32
Max achieved depth:     14
Max depth since last:   1
Current depth:          0
Active tags:            [ 1, 3, 4, 6, 9, 11, 12, 14, 17, 19, 20, 22, 25, 
27, 28, 29, 30, 31, ]
Queue:                  released [ 1390 ] - started [ 3986 ]
pending request and queue count mismatch (counted: 18)
DMA status:             not running

Some times the number of active tags is higher, seems to vary...

/me ignorant: this looks wrong. Why are there active tags when no activity? 
If a am right and this is a problem then perhaps tags are "leaking" some how?

-- ide related msgs from boot --
ATA/ATAPI driver v7.0.0
ATA: system bus speed 33MHz
ATA: interface: VIA Technologies, Inc. Bus Master IDE, on PCI slot 00:07.1
ATA: chipset rev.: 6
ATA: non-legacy mode: IRQ probe delayed
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVER07-0, ATA DISK drive
hdc: LITE-ON LTR-12102B, ATAPI CD/DVD-ROM drive
hdd: Maxtor 90288D2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: tagged command queueing enabled, command queue depth 32
hda: 80418240 sectors w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
hdd: 5627664 sectors w/256KiB Cache, CHS=5583/16/63, UDMA(33)
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
  hda: [PTBL] [5005/255/63] hda1 hda2 < hda5 hda6 hda7 >
  hdd: [PTBL] [697/128/63] hdd1 hdd2 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 >

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

