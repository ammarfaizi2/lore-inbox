Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbSLHMZe>; Sun, 8 Dec 2002 07:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbSLHMZe>; Sun, 8 Dec 2002 07:25:34 -0500
Received: from spacecake.plus.com ([195.166.148.239]:31106 "EHLO
	unicorn.encapsulated.net") by vger.kernel.org with ESMTP
	id <S265413AbSLHMZa>; Sun, 8 Dec 2002 07:25:30 -0500
Date: Sun, 8 Dec 2002 12:31:34 +0000
From: Spacecake <lkml@spacecake.plus.com>
To: linux-kernel@vger.kernel.org
Subject: HPT372 RAID controller
Message-Id: <20021208123134.4be342c7.lkml@spacecake.plus.com>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been putting off posting to this mailing list, because i really
didn't want to bother all you busy kernel development type peoples :),
but after searching for about a week, i am no closer to the answer -
maybe the author of the driver can help me, or something.

Using the above raid controller, which is onboard the Abit KX7-333R
motherboard.
Using a single HDD to test it with, the HDD in question works fine using
the VIA IDE controller on the same board.
If this matters, i don't actually want RAID, i am just using it as
another IDE controller.

I'm using the 2.4.20 kernel, and i thought this controller had been
supported since 2.4.18. I'll include the relevant part of my current
.config below.

Here is what happens when i try to boot it up with the drive attatched:

(roughly)
HPT372: ide controller, PCI bus 00 dev 98
HPT372: chipset rev 5
HPT372: not 100% naitive mode, will probe irqs later.

Everything seems normal... then:

hde: dma_intr: status=0xff { busy }
hde: dma disabled
supurious 8259A interrupt

I don't know if the last line is related, but i don't think it was there
before...

ide2: reset timed out
hde: status timeout: status=0xff { busy }
hde: drive not ready for command
ide2: reset timed out, status 0xff {busy }
end_request: I/O error, dev 21:02 (hde) sector 8264
kjournald starting blah blah
end_request: I/O error, dev 21:02 (hde) sector 8264
EXT3 FS mounted readonly blah blah
end_request: I/O error, dev 21:02 (hde) sector 8264

Then it complains about not being able to find an init, etc.

Here is .config:

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_OFFBOARD=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

I've tried setting various different options - such as enabling RAID,
but that shouldn't matter if i just want to use the controller to add
more disks.
But the above is what i believe should be working...

Any ideas?
And apologies if i am posting to the wrong list for this kind of stuff.

Regards,
 - Daniel




