Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBGKMs>; Wed, 7 Feb 2001 05:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBGKMj>; Wed, 7 Feb 2001 05:12:39 -0500
Received: from smtp1.jp.psi.net ([154.33.63.111]:34063 "EHLO smtp1.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129028AbRBGKMZ>;
	Wed, 7 Feb 2001 05:12:25 -0500
Message-ID: <3A811F85.4CB0A61F@vgkk.com>
Date: Wed, 07 Feb 2001 19:12:21 +0900
From: "A.Sajjad Zaidi" <sajjad@vgkk.com>
Organization: Vanguard K.K.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Promise, DMA and RAID5 problems running 2.4.1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just built a system that uses a K7V motherboard with the KT133
chipset. It has an onboard Promise PDC20265 ATA-100 controller.  Im
running RH6.2.

I built a 2.4.1 kernel with support for the controller and it booted up
fine with the "ide=reverse" parameter. It was when I tried adding new
drives (all IBM-DTLA307045 s) that I realised that the cylinder/head
translation is different and I cant use the whole drive unless its
partitioned while attached to the other IDE ports.

The only option was to attach it to the normal ports and move the drive
back after partitioning. I dont see any jumpers or BIOS options to
change this so it must be a kernel setting, but I dont see anythere
there.


Second, I set up raid mirroring for 4 drives(2 raid, 2spare).  Since one
drive isnt available yet, one of the 2 raid partitions are set as
'failed-disk'. All drives are connected to the ATA-100 controller. This
worked fine and I could even boot off of /dev/md0 until I setup raid5.

The main problem started after I setup raid5 on the remaining space
(3raid, 1spare), total space of about 82GB. One of the 3 raid disks were
set to failed, so it included the spare in the array and continued
reconstruction.

After doing hdparm -tT /dev/md4 a couple of times or transfering data to
it, I get the following message:

hda: dma_intr: bad DMA status
hda: dma_intr: status=0x50 { DriveReady SeekComplete }
hda: dma_intr: bad DMA status
hda: dma_intr: status=0x50 { DriveReady SeekComplete }
hda: dma_intr: bad DMA status
hda: dma_intr: status=0x50 { DriveReady SeekComplete }
hda: dma_intr: bad DMA status
hda: dma_intr: status=0x50 { DriveReady SeekComplete }
hda: DMA disabled
hdb: DMA disabled

and the system freezes completely. I have no option, but to do a cold
reboot.

Without DMA support, everything is fine, but hdparm gives me a mere 8.xx
MB/s  transfer rate.
Anyone else have very similar problems?


A.Sajjad Zaidi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
