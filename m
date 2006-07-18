Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWGRXGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWGRXGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 19:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWGRXGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 19:06:55 -0400
Received: from server6.greatnet.de ([83.133.96.26]:23961 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932402AbWGRXGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 19:06:53 -0400
Message-ID: <44BD6A3F.9040702@nachtwindheim.de>
Date: Wed, 19 Jul 2006 01:09:51 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: James.Bottomley@SteelEye.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: [PATCH] pci_module_init conversion in scsi subsys 2nd try
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, a mailer issue.

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Converts pci_module_init() to pci_register_driver() in the scsi subsys
on 23 drivers which only return the value of pci_module_init().
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

diff -ruN linux-2.6.18-rc2/drivers/scsi/3w-9xxx.c linux/drivers/scsi/3w-9xxx.c
--- linux-2.6.18-rc2/drivers/scsi/3w-9xxx.c	2006-07-18 13:37:14.000000000 +0200
+++ linux/drivers/scsi/3w-9xxx.c	2006-07-18 20:58:25.000000000 +0200
@@ -2211,7 +2211,7 @@
 {
 	printk(KERN_WARNING "3ware 9000 Storage Controller device driver for Linux v%s.\n", TW_DRIVER_VERSION);
 
-	return pci_module_init(&twa_driver);
+	return pci_register_driver(&twa_driver);
 } /* End twa_init() */
 
 /* This function is called on driver exit */
diff -ruN linux-2.6.18-rc2/drivers/scsi/3w-xxxx.c linux/drivers/scsi/3w-xxxx.c
--- linux-2.6.18-rc2/drivers/scsi/3w-xxxx.c	2006-07-18 13:37:14.000000000 +0200
+++ linux/drivers/scsi/3w-xxxx.c	2006-07-18 20:59:21.000000000 +0200
@@ -2486,7 +2486,7 @@
 {
 	printk(KERN_WARNING "3ware Storage Controller device driver for Linux v%s.\n", TW_DRIVER_VERSION);
 
-	return pci_module_init(&tw_driver);
+	return pci_register_driver(&tw_driver);
 } /* End tw_init() */
 
 /* This function is called on driver exit */
diff -ruN linux-2.6.18-rc2/drivers/scsi/a100u2w.c linux/drivers/scsi/a100u2w.c
--- linux-2.6.18-rc2/drivers/scsi/a100u2w.c	2006-07-18 13:37:15.000000000 +0200
+++ linux/drivers/scsi/a100u2w.c	2006-07-18 21:00:18.000000000 +0200
@@ -1187,7 +1187,7 @@
 
 static int __init inia100_init(void)
 {
-	return pci_module_init(&inia100_pci_driver);
+	return pci_register_driver(&inia100_pci_driver);
 }
 
 static void __exit inia100_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/scsi/aic7xxx/aic79xx_osm_pci.c linux/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
--- linux-2.6.18-rc2/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2006-07-18 13:37:15.000000000 +0200
+++ linux/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2006-07-18 21:21:03.000000000 +0200
@@ -198,7 +198,7 @@
 int
 ahd_linux_pci_init(void)
 {
-	return (pci_module_init(&aic79xx_pci_driver));
+	return pci_register_driver(&aic79xx_pci_driver);
 }
 
 void
diff -ruN linux-2.6.18-rc2/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c linux/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
--- linux-2.6.18-rc2/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2006-07-18 13:37:15.000000000 +0200
+++ linux/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2006-07-18 21:22:17.000000000 +0200
@@ -246,8 +246,7 @@
 int
 ahc_linux_pci_init(void)
 {
-	/* Translate error or zero return into zero or one */
-	return pci_module_init(&aic7xxx_pci_driver) ? 0 : 1;
+	return pci_register_driver(&aic7xxx_pci_driver);
 }
 
 void
diff -ruN linux-2.6.18-rc2/drivers/scsi/dc395x.c linux/drivers/scsi/dc395x.c
--- linux-2.6.18-rc2/drivers/scsi/dc395x.c	2006-07-18 13:37:15.000000000 +0200
+++ linux/drivers/scsi/dc395x.c	2006-07-18 21:14:19.000000000 +0200
@@ -4949,7 +4949,7 @@
  **/
 static int __init dc395x_module_init(void)
 {
-	return pci_module_init(&dc395x_driver);
+	return pci_register_driver(&dc395x_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/scsi/dmx3191d.c linux/drivers/scsi/dmx3191d.c
--- linux-2.6.18-rc2/drivers/scsi/dmx3191d.c	2006-07-18 13:37:15.000000000 +0200
+++ linux/drivers/scsi/dmx3191d.c	2006-07-18 21:14:44.000000000 +0200
@@ -155,7 +155,7 @@
 
 static int __init dmx3191d_init(void)
 {
-	return pci_module_init(&dmx3191d_pci_driver);
+	return pci_register_driver(&dmx3191d_pci_driver);
 }
 
 static void __exit dmx3191d_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/scsi/ipr.c linux/drivers/scsi/ipr.c
--- linux-2.6.18-rc2/drivers/scsi/ipr.c	2006-07-18 13:37:17.000000000 +0200
+++ linux/drivers/scsi/ipr.c	2006-07-18 21:13:42.000000000 +0200
@@ -6721,7 +6721,7 @@
 	ipr_info("IBM Power RAID SCSI Device Driver version: %s %s\n",
 		 IPR_DRIVER_VERSION, IPR_DRIVER_DATE);
 
-	return pci_module_init(&ipr_driver);
+	return pci_register_driver(&ipr_driver);
 }
 
 /**
diff -ruN linux-2.6.18-rc2/drivers/scsi/nsp32.c linux/drivers/scsi/nsp32.c
--- linux-2.6.18-rc2/drivers/scsi/nsp32.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/nsp32.c	2006-07-18 21:02:24.000000000 +0200
@@ -3581,7 +3581,7 @@
  */
 static int __init init_nsp32(void) {
 	nsp32_msg(KERN_INFO, "loading...");
-	return pci_module_init(&nsp32_driver);
+	return pci_register_driver(&nsp32_driver);
 }
 
 static void __exit exit_nsp32(void) {
diff -ruN linux-2.6.18-rc2/drivers/scsi/pdc_adma.c linux/drivers/scsi/pdc_adma.c
--- linux-2.6.18-rc2/drivers/scsi/pdc_adma.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/pdc_adma.c	2006-07-18 21:02:55.000000000 +0200
@@ -721,7 +721,7 @@
 
 static int __init adma_ata_init(void)
 {
-	return pci_module_init(&adma_ata_pci_driver);
+	return pci_register_driver(&adma_ata_pci_driver);
 }
 
 static void __exit adma_ata_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/scsi/qla1280.c linux/drivers/scsi/qla1280.c
--- linux-2.6.18-rc2/drivers/scsi/qla1280.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/qla1280.c	2006-07-18 21:04:10.000000000 +0200
@@ -4484,7 +4484,7 @@
 		qla1280_setup(qla1280);
 #endif
 
-	return pci_module_init(&qla1280_pci_driver);
+	return pci_register_driver(&qla1280_pci_driver);
 }
 
 static void __exit
diff -ruN linux-2.6.18-rc2/drivers/scsi/sata_mv.c linux/drivers/scsi/sata_mv.c
--- linux-2.6.18-rc2/drivers/scsi/sata_mv.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/sata_mv.c	2006-07-18 21:04:33.000000000 +0200
@@ -2447,7 +2447,7 @@
 
 static int __init mv_init(void)
 {
-	return pci_module_init(&mv_pci_driver);
+	return pci_register_driver(&mv_pci_driver);
 }
 
 static void __exit mv_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/scsi/sata_nv.c linux/drivers/scsi/sata_nv.c
--- linux-2.6.18-rc2/drivers/scsi/sata_nv.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/sata_nv.c	2006-07-18 21:04:50.000000000 +0200
@@ -583,7 +583,7 @@
 
 static int __init nv_init(void)
 {
-	return pci_module_init(&nv_pci_driver);
+	return pci_register_driver(&nv_pci_driver);
 }
 
 static void __exit nv_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/scsi/sata_promise.c linux/drivers/scsi/sata_promise.c
--- linux-2.6.18-rc2/drivers/scsi/sata_promise.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/sata_promise.c	2006-07-18 21:05:25.000000000 +0200
@@ -817,7 +817,7 @@
 
 static int __init pdc_ata_init(void)
 {
-	return pci_module_init(&pdc_ata_pci_driver);
+	return pci_register_driver(&pdc_ata_pci_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/scsi/sata_qstor.c linux/drivers/scsi/sata_qstor.c
--- linux-2.6.18-rc2/drivers/scsi/sata_qstor.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/sata_qstor.c	2006-07-18 21:05:42.000000000 +0200
@@ -712,7 +712,7 @@
 
 static int __init qs_ata_init(void)
 {
-	return pci_module_init(&qs_ata_pci_driver);
+	return pci_register_driver(&qs_ata_pci_driver);
 }
 
 static void __exit qs_ata_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/scsi/sata_sil24.c linux/drivers/scsi/sata_sil24.c
--- linux-2.6.18-rc2/drivers/scsi/sata_sil24.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/sata_sil24.c	2006-07-18 21:06:12.000000000 +0200
@@ -1206,7 +1206,7 @@
 
 static int __init sil24_init(void)
 {
-	return pci_module_init(&sil24_pci_driver);
+	return pci_register_driver(&sil24_pci_driver);
 }
 
 static void __exit sil24_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/scsi/sata_sil.c linux/drivers/scsi/sata_sil.c
--- linux-2.6.18-rc2/drivers/scsi/sata_sil.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/sata_sil.c	2006-07-18 21:07:09.000000000 +0200
@@ -714,7 +714,7 @@
 
 static int __init sil_init(void)
 {
-	return pci_module_init(&sil_pci_driver);
+	return pci_register_driver(&sil_pci_driver);
 }
 
 static void __exit sil_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/scsi/sata_sis.c linux/drivers/scsi/sata_sis.c
--- linux-2.6.18-rc2/drivers/scsi/sata_sis.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/sata_sis.c	2006-07-18 21:07:26.000000000 +0200
@@ -334,7 +334,7 @@
 
 static int __init sis_init(void)
 {
-	return pci_module_init(&sis_pci_driver);
+	return pci_register_driver(&sis_pci_driver);
 }
 
 static void __exit sis_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/scsi/sata_svw.c linux/drivers/scsi/sata_svw.c
--- linux-2.6.18-rc2/drivers/scsi/sata_svw.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/sata_svw.c	2006-07-18 21:08:01.000000000 +0200
@@ -488,7 +488,7 @@
 
 static int __init k2_sata_init(void)
 {
-	return pci_module_init(&k2_sata_pci_driver);
+	return pci_register_driver(&k2_sata_pci_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/scsi/sata_sx4.c linux/drivers/scsi/sata_sx4.c
--- linux-2.6.18-rc2/drivers/scsi/sata_sx4.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/sata_sx4.c	2006-07-18 21:08:20.000000000 +0200
@@ -1482,7 +1482,7 @@
 
 static int __init pdc_sata_init(void)
 {
-	return pci_module_init(&pdc_sata_pci_driver);
+	return pci_register_driver(&pdc_sata_pci_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/scsi/sata_uli.c linux/drivers/scsi/sata_uli.c
--- linux-2.6.18-rc2/drivers/scsi/sata_uli.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/sata_uli.c	2006-07-18 21:08:48.000000000 +0200
@@ -287,7 +287,7 @@
 
 static int __init uli_init(void)
 {
-	return pci_module_init(&uli_pci_driver);
+	return pci_register_driver(&uli_pci_driver);
 }
 
 static void __exit uli_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/scsi/sata_via.c linux/drivers/scsi/sata_via.c
--- linux-2.6.18-rc2/drivers/scsi/sata_via.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/sata_via.c	2006-07-18 21:09:15.000000000 +0200
@@ -381,7 +381,7 @@
 
 static int __init svia_init(void)
 {
-	return pci_module_init(&svia_pci_driver);
+	return pci_register_driver(&svia_pci_driver);
 }
 
 static void __exit svia_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/scsi/sata_vsc.c linux/drivers/scsi/sata_vsc.c
--- linux-2.6.18-rc2/drivers/scsi/sata_vsc.c	2006-07-18 13:37:18.000000000 +0200
+++ linux/drivers/scsi/sata_vsc.c	2006-07-18 21:09:55.000000000 +0200
@@ -462,7 +462,7 @@
 
 static int __init vsc_sata_init(void)
 {
-	return pci_module_init(&vsc_sata_pci_driver);
+	return pci_register_driver(&vsc_sata_pci_driver);
 }
 
 


