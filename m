Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbULJWQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbULJWQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbULJWOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:14:35 -0500
Received: from 4.Red-80-32-108.pooles.rima-tde.net ([80.32.108.4]:7040 "EHLO
	gimli") by vger.kernel.org with ESMTP id S261843AbULJWMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:12:46 -0500
Message-ID: <41BA201C.9090103@sombragris.com>
Date: Fri, 10 Dec 2004 23:15:56 +0100
From: Miguel Angel Flores <maf@sombragris.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] aic7xxx driver warning
Content-Type: multipart/mixed;
 boundary="------------070407090409060202070507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070407090409060202070507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

These are two possible patches for the 2.6.10rc3. The patches correct a 
compiler warning when CONFIG_HIGHMEM64G is not defined.

Both patches works well. "Opt1" is the Alan Cox way and "Opt2" is the 
MaF way :-)

Cheers,
MaF

--------------070407090409060202070507
Content-Type: text/x-patch;
 name="aic7xxx.opt1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aic7xxx.opt1.patch"

diff -r -u linux-2.6.10rc3/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c linux-2.6.10rc3-maf/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
--- linux-2.6.10rc3/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2004-12-05 20:02:40.000000000 +0100
+++ linux-2.6.10rc3-maf/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2004-12-10 21:21:57.000000000 +0100
@@ -226,7 +226,7 @@
 	}
 	pci_set_master(pdev);
 
-	mask_39bit = 0x7FFFFFFFFFULL;
+	mask_39bit = (dma_addr_t)0x7FFFFFFFFFULL;
 	if (sizeof(dma_addr_t) > 4
 	 && ahc_linux_get_memsize() > 0x80000000
 	 && pci_set_dma_mask(pdev, mask_39bit) == 0) {

--------------070407090409060202070507
Content-Type: text/x-patch;
 name="aic7xxx.opt2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aic7xxx.opt2.patch"

diff -r -u linux-2.6.10rc3/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c linux-2.6.10rc3-maf/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
--- linux-2.6.10rc3/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2004-12-05 20:02:40.000000000 +0100
+++ linux-2.6.10rc3-maf/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2004-12-10 21:31:51.000000000 +0100
@@ -226,10 +226,10 @@
 	}
 	pci_set_master(pdev);
 
-	mask_39bit = 0x7FFFFFFFFFULL;
 	if (sizeof(dma_addr_t) > 4
 	 && ahc_linux_get_memsize() > 0x80000000
 	 && pci_set_dma_mask(pdev, mask_39bit) == 0) {
+		mask_39bit = (dma_addr_t)0x7FFFFFFFFFULL;
 		ahc->flags |= AHC_39BIT_ADDRESSING;
 		ahc->platform_data->hw_dma_mask = mask_39bit;
 	} else {

--------------070407090409060202070507--
