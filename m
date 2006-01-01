Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWAARjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWAARjP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 12:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWAARjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 12:39:14 -0500
Received: from webmail-outgoing2.us4.outblaze.com ([205.158.62.67]:64163 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S1750947AbWAARjO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 12:39:14 -0500
X-OB-Received: from unknown (205.158.62.16)
  by wfilter.us4.outblaze.com; 1 Jan 2006 17:39:09 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
From: "1qay beer" <1qay@beer.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Jan 2006 13:39:09 -0400
Subject: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver for
 PDC202XX
X-Originating-Ip: 10.0.0.150
X-Originating-Server: ws5-10.us4.outblaze.com
Message-Id: <20060101173909.D30257B386@ws5-10.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Dear Alan Cox,
Dear Jeff Garzik,

Everyone a happy new year!

We are in stable Kernel 2.6.14.5, year 2006.
Since 1997 people asking on several list for a functional PDC202XX Driver.
Since some years I spend hours and hours finding a solution for a stable driver. 
(PDC20269/Promise Ultra133 TX2)
There seem to be none.

There are two Solution:
-The IDE Driver (pdc202xx_new) has still problems with "DMA Timeout".
-The Libata Driver (pata_pdc2027x) seems to be still somewhat experimental.

Unfortunatly I'am not a kernel developper else there would be probably already
a solution ;-)

So what is the Solution for the PDC20269 Ultra ATA Controller?
I would mark this bold on the wishlist for 2006 ;-)

Thanx


=========================================================
Anyone wants a small summary of the halfworking solutions

Way 1 - IDE pdc202xx_new  --> /dev/hdxx )
------------------------------------------
  Just compile your kernel with a module (or built in):
  $make menuconfig
       -> Device Drivers                                                                                 
         -> ATA/ATAPI/MFM/RLL support                                                                     
           -> ATA/ATAPI/MFM/RLL support (IDE [=y])                                                       
             -> Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support (BLK_DEV_IDE [=y])                    
               -> PCI IDE chipset support (BLK_DEV_IDEPCI [=y])                                           
                 -> Generic PCI bus-master DMA support (BLK_DEV_IDEDMA_PCI
		   ->PROMISE PDC202{68|69|70|71|75|76|77} support
   $make-kpkg kernel_image
Problems:)
hde: dma_timer_expiry: dma status == 0x60
 hde: DMA timeout retry
 PDC202XX: Primary channel reset.
 hde: timeout waiting for DMA
 hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
 ide: failed opcode was: unknown
 hde: drive not ready for command
 hde: status error: status=0x50 { DriveReady SeekComplete }
 ide: failed opcode was: unknown
 hde: no DRQ after issuing MULTWRITE_EXT
 hde: status error: status=0x50 { DriveReady SeekComplete }
 ide: failed opcode was: unknown
 hde: no DRQ after issuing MULTWRITE_EXT
 hde: status error: status=0x50 { DriveReady SeekComplete }
 ide: failed opcode was: unknown
 hdf: DMA disabled
 PDC202XX: Primary channel reset.
 hde: no DRQ after issuing MULTWRITE_EXT
 ide2: reset: success
 hde: dma_timer_expiry: dma status == 0x20
 hde: DMA timeout retry
 PDC202XX: Primary channel reset.
 hde: timeout waiting for DMA

or similar


Way 2 - libata  (emulates SCSI device) --> /dev/sdxx  )
-------------------------------------------------------
     Get the latest libata patch/kernel
          http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.15-rc4-libata1.patch.bz2
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.15-rc5.tar.bz2
       ....(untar)...
       $make menuconfig
        -> Device Drivers                                                                                  
         -> SCSI device support                                                                           
           -> SCSI device support (SCSI [=m])                                                             
             -> SCSI low-level drivers                                                                    
               -> Serial ATA (SATA) support (SCSI_SATA [=m])  
                  ->SCSI_PATA_PDC2027X
  
        Enable PATA as suggested here:
        -http://lkml.org/lkml/2004/8/1/100
        -http://seclists.org/lists/linux-kernel/2005/May/0503.html
           In include/linux/libata.h
              #define ATA_ENABLE_ATAPI /* undefine to disable ATAPI support */
              #define ATA_ENABLE_PATA /* define to enable PATA support in some
                                       * low-level drivers */ 
         
        Compile and pray!

        With some harddisk it works without problem (seagate 7200.8)
        With others Maxtor Maxline III it's not working at all:
        Kernel Panics even at boottime:
         ATA1: Abnormal status 0x8 on port 0xD...........
         or Lost Interrupts...
         or the drivers seems to be loaded (lsmod) but there are no
            harddiscs under /prov/scsi/... /dev/sdxx



-- 
_______________________________________________
The coolest e-mail address on the web and it’s FREE!  Sign-up today for Beer Mail @ beer.com.

