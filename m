Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTDVTWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTDVTWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:22:43 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60288 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263420AbTDVTW0 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:22:26 -0400
Message-Id: <200304221934.h3MJYQLq004845@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk3 - #if cleanup drivers/* (2/6)
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Apr 2003 15:34:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the drivers/* subtree

--- linux-2.5.68-bk3/drivers/ide/ide-probe.c.dist	2003-04-22 13:57:00.000000000 -0400
+++ linux-2.5.68-bk3/drivers/ide/ide-probe.c	2003-04-22 15:19:09.894168198 -0400
@@ -803,7 +803,7 @@
 		return;
 
 	if ((hwif->chipset != ide_4drives || !hwif->mate || !hwif->mate->present) &&
-#if CONFIG_BLK_DEV_PDC4030
+#ifdef CONFIG_BLK_DEV_PDC4030
 	    (hwif->chipset != ide_pdc4030 || hwif->channel == 0) &&
 #endif /* CONFIG_BLK_DEV_PDC4030 */
 	    (hwif_check_regions(hwif))) {
--- linux-2.5.68-bk3/drivers/isdn/eicon/eicon_mod.c.dist	2003-04-07 13:30:42.000000000 -0400
+++ linux-2.5.68-bk3/drivers/isdn/eicon/eicon_mod.c	2003-04-22 15:17:11.218045971 -0400
@@ -245,7 +245,7 @@
 							card->hwif.isa.shmem = (eicon_isa_shmem *)a;
 							return 0;
 						case EICON_BUS_MCA:
-#if CONFIG_MCA
+#ifdef CONFIG_MCA
 							if (eicon_mca_find_card(
 								0, a,
 								card->hwif.isa.irq,
@@ -853,7 +853,7 @@
 		card->type = Type;
 		switch (Type) {
 #ifdef CONFIG_ISDN_DRV_EICON_ISA
-#if CONFIG_MCA /* only needed for MCA */
+#ifdef CONFIG_MCA /* only needed for MCA */
                         case EICON_CTYPE_S:
                         case EICON_CTYPE_SX:
                         case EICON_CTYPE_SCOM:
@@ -1342,7 +1342,7 @@
 static void __exit
 eicon_exit(void)
 {
-#if CONFIG_PCI	
+#ifdef CONFIG_PCI	
 #ifdef CONFIG_ISDN_DRV_EICON_PCI
 	card_t *pCard;
 	word wCardIndex;
@@ -1374,7 +1374,7 @@
 		eicon_freecard(last);
         }
 
-#if CONFIG_PCI	
+#ifdef CONFIG_PCI	
 #ifdef CONFIG_ISDN_DRV_EICON_PCI
 	pCard = DivasCards;
 	for (wCardIndex = 0; wCardIndex < MAX_CARDS; wCardIndex++)
--- linux-2.5.68-bk3/drivers/isdn/eicon/eicon_pci.c.dist	2003-04-07 13:32:49.000000000 -0400
+++ linux-2.5.68-bk3/drivers/isdn/eicon/eicon_pci.c	2003-04-22 15:17:18.516032091 -0400
@@ -26,7 +26,7 @@
 
 char *eicon_pci_revision = "$Revision: 1.1.4.1.2.3 $";
 
-#if CONFIG_PCI	         /* intire stuff is only for PCI */
+#ifdef CONFIG_PCI	         /* intire stuff is only for PCI */
 #ifdef CONFIG_ISDN_DRV_EICON_PCI
 
 int eicon_pci_find_card(char *ID)
--- linux-2.5.68-bk3/drivers/isdn/hisax/avm_pci.c.dist	2003-04-07 13:31:02.000000000 -0400
+++ linux-2.5.68-bk3/drivers/isdn/hisax/avm_pci.c	2003-04-22 15:17:30.008508909 -0400
@@ -730,7 +730,7 @@
 			}
 		}
 #endif
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 		if ((dev_avm = pci_find_device(PCI_VENDOR_ID_AVM,
 			PCI_DEVICE_ID_AVM_A1,  dev_avm))) {
 			if (avm_pci_probe(card->cs, dev_avm))
--- linux-2.5.68-bk3/drivers/isdn/hisax/diva.c.dist	2003-04-22 13:57:37.000000000 -0400
+++ linux-2.5.68-bk3/drivers/isdn/hisax/diva.c	2003-04-22 15:17:44.439522776 -0400
@@ -772,7 +772,7 @@
 		}
 	}
 #endif
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 	if ((dev_diva = pci_find_device(PCI_VENDOR_ID_EICON,
 					PCI_DEVICE_ID_EICON_DIVA20,
 					dev_diva))) {
--- linux-2.5.68-bk3/drivers/isdn/hisax/elsa.c.dist	2003-04-22 13:57:37.000000000 -0400
+++ linux-2.5.68-bk3/drivers/isdn/hisax/elsa.c	2003-04-22 15:17:24.054287837 -0400
@@ -1098,7 +1098,7 @@
 			return 0;
 		return 1;
 	} else if (card->typ == ISDN_CTYPE_ELSA_PCI) {
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 		if ((dev_qs1000 = pci_find_device(PCI_VENDOR_ID_ELSA,
 			PCI_DEVICE_ID_ELSA_MICROLINK, dev_qs1000))) {
 			if (elsa_qs_pci_probe(card->cs, dev_qs1000,
--- linux-2.5.68-bk3/drivers/isdn/hisax/niccy.c.dist	2003-04-22 13:57:37.000000000 -0400
+++ linux-2.5.68-bk3/drivers/isdn/hisax/niccy.c	2003-04-22 15:17:39.163356808 -0400
@@ -319,7 +319,7 @@
 			return 0;
 		return 1;
 	} else {
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 		if ((niccy_dev = pci_find_device(PCI_VENDOR_ID_SATSAGEM,
 			PCI_DEVICE_ID_SATSAGEM_NICCY, niccy_dev))) {
 			if (niccy_pci_probe(card->cs, niccy_dev) < 0)
--- linux-2.5.68-bk3/drivers/isdn/hisax/sedlbauer.c.dist	2003-04-22 13:57:37.000000000 -0400
+++ linux-2.5.68-bk3/drivers/isdn/hisax/sedlbauer.c	2003-04-22 15:17:49.786661293 -0400
@@ -789,7 +789,7 @@
 	}
 #endif
 /* Probe for Sedlbauer speed pci */
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 	dev_sedl = pci_find_device(PCI_VENDOR_ID_TIGERJET,
 				   PCI_DEVICE_ID_TIGERJET_100, dev_sedl);
 	if (dev_sedl) {
--- linux-2.5.68-bk3/drivers/mtd/maps/sa1100-flash.c.dist	2003-04-22 13:57:04.000000000 -0400
+++ linux-2.5.68-bk3/drivers/mtd/maps/sa1100-flash.c	2003-04-22 15:18:29.440924744 -0400
@@ -337,7 +337,7 @@
 
 #ifdef CONFIG_SA1100_FREEBIRD
 static struct mtd_partition freebird_partitions[] = {
-#if CONFIG_SA1100_FREEBIRD_NEW
+#ifdef CONFIG_SA1100_FREEBIRD_NEW
 	{
 		.name		= "firmware",
 		.size		= 0x00040000,
--- linux-2.5.68-bk3/drivers/net/typhoon.c.dist	2003-04-22 13:57:41.000000000 -0400
+++ linux-2.5.68-bk3/drivers/net/typhoon.c	2003-04-22 15:17:59.553143920 -0400
@@ -2135,7 +2135,7 @@
 	return 0;
 }
 
-#if CONFIG_PM
+#ifdef CONFIG_PM
 static int
 typhoon_resume(struct pci_dev *pdev)
 {
@@ -2483,7 +2483,7 @@
 	.id_table	= typhoon_pci_tbl,
 	.probe		= typhoon_init_one,
 	.remove		= __devexit_p(typhoon_remove_one),
-#if CONFIG_PM
+#ifdef CONFIG_PM
 	.suspend	= typhoon_suspend,
 	.resume		= typhoon_resume,
 	.enable_wake	= typhoon_enable_wake,
--- linux-2.5.68-bk3/drivers/scsi/aic7xxx/aic79xx_osm.h.dist	2003-04-22 13:57:06.000000000 -0400
+++ linux-2.5.68-bk3/drivers/scsi/aic7xxx/aic79xx_osm.h	2003-04-22 15:18:13.240134057 -0400
@@ -246,7 +246,7 @@
 typedef struct timer_list ahd_timer_t;
 
 /********************************** Includes **********************************/
-#if CONFIG_AIC79XX_REG_PRETTY_PRINT
+#ifdef CONFIG_AIC79XX_REG_PRETTY_PRINT
 #define AIC_DEBUG_REGISTERS 1
 #else
 #define AIC_DEBUG_REGISTERS 0
--- linux-2.5.68-bk3/drivers/scsi/aic7xxx/aic7xxx_osm.h.dist	2003-04-22 13:57:43.000000000 -0400
+++ linux-2.5.68-bk3/drivers/scsi/aic7xxx/aic7xxx_osm.h	2003-04-22 15:18:06.158157571 -0400
@@ -258,7 +258,7 @@
 typedef struct timer_list ahc_timer_t;
 
 /********************************** Includes **********************************/
-#if CONFIG_AIC7XXX_REG_PRETTY_PRINT
+#ifdef CONFIG_AIC7XXX_REG_PRETTY_PRINT
 #define AIC_DEBUG_REGISTERS 1
 #else
 #define AIC_DEBUG_REGISTERS 0
--- linux-2.5.68-bk3/drivers/scsi/scsi_error.c.dist	2003-04-22 13:57:44.000000000 -0400
+++ linux-2.5.68-bk3/drivers/scsi/scsi_error.c	2003-04-22 15:18:19.187302136 -0400
@@ -188,7 +188,7 @@
 	return sdev->online;
 }
 
-#if CONFIG_SCSI_LOGGING
+#ifdef CONFIG_SCSI_LOGGING
 /**
  * scsi_eh_prt_fail_stats - Log info on failures.
  * @shost:	scsi host being recovered.
--- linux-2.5.68-bk3/drivers/scsi/sd.c.dist	2003-04-22 13:57:06.000000000 -0400
+++ linux-2.5.68-bk3/drivers/scsi/sd.c	2003-04-22 15:18:23.991648325 -0400
@@ -696,7 +696,7 @@
 	int good_sectors = (result == 0 ? this_count : 0);
 	sector_t block_sectors = 1;
 	sector_t error_sector;
-#if CONFIG_SCSI_LOGGING
+#ifdef CONFIG_SCSI_LOGGING
 	SCSI_LOG_HLCOMPLETE(1, printk("sd_rw_intr: %s: res=0x%x\n", 
 				SCpnt->request->rq_disk->disk_name, result));
 	if (0 != result) {


