Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUIAQHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUIAQHX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267319AbUIAP5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:57:32 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:62386 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267323AbUIAPvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:44 -0400
Date: Wed, 1 Sep 2004 16:51:21 +0100
Message-Id: <200409011551.i81FpLcH000635@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] plug leaks in aic7xxx_osm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.6/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- bk-linus/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-08-28 21:57:23.000000000 +0100
+++ linux-2.6/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-09-01 13:31:12.000000000 +0100
@@ -1408,6 +1408,7 @@ ahc_dmamem_alloc(struct ahc_softc *ahc, 
 	if (ahc->dev_softc != NULL)
 		if (ahc_pci_set_dma_mask(ahc->dev_softc, 0xFFFFFFFF)) {
 			printk(KERN_WARNING "aic7xxx: No suitable DMA available.\n");
+			kfree(map);
 			return (ENODEV);
 		}
 	*vaddr = pci_alloc_consistent(ahc->dev_softc,
@@ -1416,6 +1417,7 @@ ahc_dmamem_alloc(struct ahc_softc *ahc, 
 		if (ahc_pci_set_dma_mask(ahc->dev_softc,
 				     ahc->platform_data->hw_dma_mask)) {
 			printk(KERN_WARNING "aic7xxx: No suitable DMA available.\n");
+			kfree(map);
 			return (ENODEV);
 		}
 #else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0) */
