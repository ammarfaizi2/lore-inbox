Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbTE3XYz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbTE3XYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:24:55 -0400
Received: from [65.198.37.67] ([65.198.37.67]:63956 "EHLO gghcwest.com")
	by vger.kernel.org with ESMTP id S264056AbTE3XYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:24:53 -0400
Subject: Re: Different geometry settings for identical drives
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <306584240A9@vcnet.vc.cvut.cz>
References: <306584240A9@vcnet.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1054337888.24145.6.camel@heat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 30 May 2003 16:38:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-30 at 16:20, Petr Vandrovec wrote:
> On 30 May 03 at 15:46, Jeffrey Baker wrote:
> 
> > hda: host protected area => 1
> > hda: setmax LBA 234441648, native  234375000
> > hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
> > hdc: attached ide-disk driver.
> > hdc: host protected area => 1
> > hdc: setmax LBA 234441648, native  234375000
> > hdc: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
> > hdd: attached ide-cdrom driver.
> > hdd: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
> > 
> > The result is that hda works fine but hdc doesn't.  When I try to mke2fs
> > on the latter I see:
> > 
> > hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hdc: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=234441583, sector=232343808
> > 
> > You can see that LBAsect (234441583) is higher than the "native" sectors
> > quoted by the kernel (234375000, difference 66583 sectors).  Why are
> > these two disks being addressed differently?  
> 
> As far as I can tell, it has nothing to do with disk geometry.
> 
> Someone just cut couple of sectors at the end from disk, you compiled
> your kernel without CONFIG_IDEDISK_STROKE, but still kernel for some
> reason reports block size as if idedisk_set_max_address() was invoked.
> 
> I do not see how this could happen with 2.4.21-rc3... Can you recheck
> that you are using 2.4.21-rc3 without any additional patches?

I'm running 2.4.21-rc3 with the latest patch from ftp.x86-64.org:

prime:/usr/src# uname -r
2.4.21-rc3

The x86-64.org patch doesn't touch much outside of arch/x86_64.  You are
right that CONFIG_IDE_STROKE is off:

prime:/usr/src/linux# grep IDE .config | sort | tac  
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDE=y
# IDE, ATA and ATAPI Block devices
# CONFIG_VIDEO_SELECT is not set
# CONFIG_VIDEO_DEV is not set
# CONFIG_PARIDE is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_IVB is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# ATA/IDE/MFM/RLL support

-jwb

