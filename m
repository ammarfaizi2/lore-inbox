Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbSITOqE>; Fri, 20 Sep 2002 10:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262747AbSITOqD>; Fri, 20 Sep 2002 10:46:03 -0400
Received: from mailgate.imerge.co.uk ([195.217.208.100]:47357 "EHLO
	imgserv04.imerge-bh.co.uk") by vger.kernel.org with ESMTP
	id <S262731AbSITOqB>; Fri, 20 Sep 2002 10:46:01 -0400
Message-ID: <C0D45ABB3F45D5118BBC00508BC292DB9D420A@imgserv04>
From: James Finnie <jf1@IMERGE.co.uk>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
       James Finnie <jf1@IMERGE.co.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: IDE Hard disk geometry problem in 2.4.19 / 2.4.20pre7
Date: Fri, 20 Sep 2002 15:53:40 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
> Sent: 20 September 2002 15:19
> To: James Finnie
> Cc: 'linux-kernel@vger.kernel.org'
> Subject: Re: IDE Hard disk geometry problem in 2.4.19 / 2.4.20pre7
> 
> 
> James Finnie wrote:
> > Hi,
> > 
> > I have a large number of IDE hard disks here where I work.  
> Since moving to
> > 2.4.19 from 2.4.17, several of these disks have stopped 
> working, resulting
> > in a kernel panic after the drive has declared itself to 
> have 0 cylinders!
> > All the disks that have broken are the following:
> > 
> > Seagate 80GB U6 ST380020ACE with Firmware version 4.65
> > 
> > We have lots of these same drives, with FW v 3.34, that all 
> work fine.  I do
> > not have a single drive with the 4.65 firmware working.  
> > 
> > My problem is that these drives used to work fine, with 
> 2.4.17.  They are
> > not obsolete hardware, I think they are all less than 6 months old.
> > 
> > I have seen this on CS5530 with the standard kernel PCI 
> IDE, and on SIS630
> > with the SIS Kernel IDE driver.  
> > 
> > Setting ide=nodma makes no difference.
> > 
> > Here is an excerpt from the kernel console booting:
> > 
> > 
> > ....
> > hda: ST380020ACE, ATA DISK drive
> > ....
> > hda: task_no_data_intr: status=0x51 { DriveReady 
> SeekComplete Error }
> > hda: task_no_data_intr: error=0x04  { DriveStatusError }
> > hda: setmax_ext LBA 1, native 0
> > hda: 0 sectors (0 MB) w/2048KiB Cache, CHS 0/255/63, (U)DMA
> > ....
> > hda2: bad access: block=2, count=2
> > end_request: I/O error, dev 03:02 (hda), sector 2
> > EXT3-fs: unable to read superblock
> > hda2: bad access: block=2, count=2
> > end_request: I/O error, dev 03:02 (hda), sector 2
> > EXT3-fs: unable to read superblock
> > Kernel panic: VFS: Unable to mount root fs on 03:02
> > 
> > 
> > Is this a result of all the new IDE stuff that went in in 2.4.19???
> 
> 
> "All the new IDE stuff" hasn't really hit 2.4.x yet...
> 
> Do you have CONFIG_IDEDISK_STROKE set?  If yes, do things 
> start working 
> if you disable it?
> 
> Can you post the other IDE options you have set in your kernel config?
> 
> 	Jeff
> 
> 
> 

Hi Jeff,

we do not have CONFIG_IDEDISK_STROKE set; I just tried setting it and get
the same result.

Here are the IDE bits that we are setting: 

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
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
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
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
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIS5513=y
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


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
Imerge Limited                          Tel :- +44 (0)1954 783600 
Unit 6 Bar Hill Business Park           Fax :- +44 (0)1954 783601 
Saxon Way                               Web :- http://www.imerge.co.uk 
Bar Hill 
Cambridge 
CB3 8SL 
United Kingdom 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


