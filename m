Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSLAJZO>; Sun, 1 Dec 2002 04:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSLAJZO>; Sun, 1 Dec 2002 04:25:14 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:19723 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261568AbSLAJZN>; Sun, 1 Dec 2002 04:25:13 -0500
Date: Sun, 1 Dec 2002 10:32:34 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-ac1
Message-ID: <20021201093234.GC22272@louise.pinerecords.com>
References: <20021130183456.GJ18259@louise.pinerecords.com> <200212010201.gB1210d11940@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212010201.gB1210d11940@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  	drive->using_dma = 1;
> > >  	ide_toggle_bounce(drive, 1);
> > > +	printk(KERN_INFO "%s: DMA enabled\n", drive->name);
> > >  	return HWIF(drive)->ide_dma_host_on(drive);
> > >  }
> > 
> > with the above applied:
> 
> Better I think that via drivers turn DMA off -quietly-

This isn't just via but possibly all drivers
that call ide-iops.c::ide_config_drive_speed() --

arm/icside.c pci/aec62xx.c pci/alim15x3.c pci/amd74xx.c pci/cmd64x.c
pci/cs5530.c pci/hpt34x.c pci/hpt366.c pci/it8172.c pci/nvidia.c
pci/pdc202xx_new.c pci/pdc202xx_old.c pci/piix.c pci/sc1200.c
pci/serverworks.c pci/siimage.c pci/sis5513.c pci/sl82c105.c
pci/slc90e66.c pci/via82cxxx.c

The following bit kills the noise:

diff -urN linux-2.4.20-ac1/drivers/ide/ide-iops.c linux-2.4.20-ac1.x/drivers/ide/ide-iops.c
--- linux-2.4.20-ac1/drivers/ide/ide-iops.c	2002-12-01 10:23:29 +0100
+++ linux-2.4.20-ac1.x/drivers/ide/ide-iops.c	2002-12-01 10:16:00 +0100
@@ -891,7 +891,7 @@
 	if (speed >= XFER_SW_DMA_0)
 		hwif->ide_dma_host_on(drive);
 	else
-		hwif->ide_dma_off(drive);
+		hwif->ide_dma_off_quietly(drive);
 #endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
 
 	switch(speed) {

--
Tomas Szepe <szepe@pinerecords.com>
