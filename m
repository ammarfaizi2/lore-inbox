Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbSK3Biq>; Fri, 29 Nov 2002 20:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267201AbSK3Biq>; Fri, 29 Nov 2002 20:38:46 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:33157 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267200AbSK3Bip>; Fri, 29 Nov 2002 20:38:45 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 29 Nov 2002 17:45:40 -0800
Message-Id: <200211300145.RAA00362@baldur.yggdrasil.com>
To: torvalds@transmeta.com
Subject: Re: Patch/resubmit(2.5.50): Eliminate pci_dev.driver_data
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote:
>Can we please get this integrated
>already?  I want to try some more changes to pci.h and I'd rather keep
>the patches separate.

	Grr.  I already have one overlapping patch that I forgot
to remove from that diff.  Here is a corrected patch.  It will
be offset by one line when you apply it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.50/include/linux/pci.h	2002-11-27 14:35:59.000000000 -0800
+++ linux/include/linux/pci.h	2002-11-23 06:41:41.000000000 -0800
@@ -344,8 +344,7 @@
 	u8		rom_base_reg;	/* which config register controls the ROM */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
-	void		*driver_data;	/* data private to the driver */
 	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
@@ -753,12 +752,12 @@
  */
 static inline void *pci_get_drvdata (struct pci_dev *pdev)
 {
-	return pdev->driver_data;
+	return pdev->dev.driver_data;
 }
 
 static inline void pci_set_drvdata (struct pci_dev *pdev, void *data)
 {
-	pdev->driver_data = data;
+	pdev->dev.driver_data = data;
 }
 
 /*
