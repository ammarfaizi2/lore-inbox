Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270630AbSISJ1g>; Thu, 19 Sep 2002 05:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270881AbSISJ1f>; Thu, 19 Sep 2002 05:27:35 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:31721 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S270630AbSISJ1e>; Thu, 19 Sep 2002 05:27:34 -0400
Message-Id: <5.1.0.14.2.20020919102432.0438bec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 19 Sep 2002 10:33:09 +0100
To: Jens Axboe <axboe@suse.de>, Andre Hedrick <andre@linux-ide.org>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: ide double init? + Re: BUG: Current 2.5-BK tree dies on boot!
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020919084754.GC936@suse.de>
References: <E17rlgP-0006wL-00@storm.christs.cam.ac.uk>
 <E17rlgP-0006wL-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:47 19/09/02, Jens Axboe wrote:
>On Wed, Sep 18 2002, Anton Altaparmakov wrote:
> > This is without preempt. I tried both with and without SMP, with and 
> without
> > large TLB pages, with and without pte highmem, all die in the same place.
>
>You have highmem, and bouncing does not get correctly enabled on the ide
>drives. This, in combination with broken bouncing (woops), will probably
>make it die fairly quickly.
>
>I attach two patches, one fixes the bouncing, the other fixes IDE bounce
>enable.

BK as of this morning already contains the bounce patch, so I only applied 
the IDE bounce enable and it worked fine. - Thanks!

Note there is something odd wrt IDE initialization. The driver seems to be 
trying to initialize twice and there quite a few messages output which 
don't reflect reality (probably a consequence of the double init). For 
example it says DMA disabled but checking with hdparm and in /proc/ide/via 
DMA is enabled just fine. And it says neither IDE port enabled (BIOS) which 
isn't true either.

Here is the current IDE output on boot:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVER07-0, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-12102B, ATAPI CD/DVD-ROM drive
hdd: Maxtor 90288D2, ATA DISK drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
VP_IDE: IDE controller at PCI slot 00:07.1
PCI: Unable to reserve I/O region #5:10@d000 for device 00:07.1
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
VP_IDE: port 0x01f0 already claimed by ide0
VP_IDE: port 0x0170 already claimed by ide1
VP_IDE: neither IDE port enabled (BIOS)
hda: host protected area => 1
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63, UDMA(100)
  hda: hda1 hda2 < hda5 hda6 hda7 >
hdd: host protected area => 1
hdd: 5627664 sectors (2881 MB) w/256KiB Cache, CHS=5583/16/63, UDMA(33)
  hdd: hdd1 hdd2 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 >
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: LITE-ON   Model: LTR-12102B        Rev: NS1D
   Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12

But it all seems to works just fine, despite the slightly confused init...

Best regards,

         Anton


-- 
   "I haven't lost my mind... it's backed up on tape." - Peter da Silva
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

