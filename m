Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbVK3AAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbVK3AAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVK3AAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:00:19 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:32195 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751415AbVK3AAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:00:16 -0500
Date: Wed, 30 Nov 2005 01:00:15 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: linux-kernel@vger.kernel.org
Cc: Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051130000525.1009.32824.sendpatchset@thinktank.campus.ltu.se>
In-Reply-To: <20051130000425.1009.94647.sendpatchset@thinktank.campus.ltu.se>
References: <20051130000425.1009.94647.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 4/6] drivers/scsi: Replace pci_module_init() with pci_register_driver()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Replace obsolete pci_module_init() with pci_register_driver().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 3w-9xxx.c                 |    2 +-
 3w-xxxx.c                 |    2 +-
 a100u2w.c                 |    2 +-
 ahci.c                    |    2 +-
 aic7xxx/aic79xx_osm_pci.c |    2 +-
 aic7xxx/aic7xxx_osm_pci.c |    2 +-
 ata_piix.c                |    4 ++--
 dc395x.c                  |    2 +-
 dmx3191d.c                |    2 +-
 ipr.c                     |    2 +-
 ips.c                     |    2 +-
 megaraid.c                |    2 +-
 megaraid/megaraid_sas.c   |    2 +-
 nsp32.c                   |    2 +-
 pdc_adma.c                |    2 +-
 qla1280.c                 |    2 +-
 qla2xxx/ql2100.c          |    2 +-
 qla2xxx/ql2200.c          |    2 +-
 qla2xxx/ql2300.c          |    2 +-
 qla2xxx/ql2322.c          |    2 +-
 qla2xxx/ql6312.c          |    2 +-
 qla2xxx/qla_os.c          |    2 +-
 sata_mv.c                 |    2 +-
 sata_nv.c                 |    2 +-
 sata_promise.c            |    2 +-
 sata_qstor.c              |    2 +-
 sata_sil.c                |    2 +-
 sata_sil24.c              |    2 +-
 sata_sis.c                |    2 +-
 sata_svw.c                |    2 +-
 sata_sx4.c                |    2 +-
 sata_uli.c                |    2 +-
 sata_via.c                |    2 +-
 sata_vsc.c                |    2 +-
 tmscsim.c                 |    2 +-
 35 files changed, 36 insertions(+), 36 deletions(-)

diff -Narup a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
--- a/drivers/scsi/3w-9xxx.c	2005-11-29 11:08:57.000000000 +0100
+++ b/drivers/scsi/3w-9xxx.c	2005-11-29 17:31:45.000000000 +0100
@@ -2206,7 +2206,7 @@ static int __init twa_init(void)
 {
 	printk(KERN_WARNING "3ware 9000 Storage Controller device driver for Linux v%s.\n", TW_DRIVER_VERSION);
 
-	return pci_module_init(&twa_driver);
+	return pci_register_driver(&twa_driver);
 } /* End twa_init() */
 
 /* This function is called on driver exit */
diff -Narup a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
--- a/drivers/scsi/3w-xxxx.c	2005-11-29 11:08:57.000000000 +0100
+++ b/drivers/scsi/3w-xxxx.c	2005-11-29 19:06:03.000000000 +0100
@@ -2482,7 +2482,7 @@ static int __init tw_init(void)
 {
 	printk(KERN_WARNING "3ware Storage Controller device driver for Linux v%s.\n", TW_DRIVER_VERSION);
 
-	return pci_module_init(&tw_driver);
+	return pci_register_driver(&tw_driver);
 } /* End tw_init() */
 
 /* This function is called on driver exit */
diff -Narup a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
--- a/drivers/scsi/a100u2w.c	2005-11-29 11:08:57.000000000 +0100
+++ b/drivers/scsi/a100u2w.c	2005-11-29 19:06:03.000000000 +0100
@@ -1186,7 +1186,7 @@ static struct pci_driver inia100_pci_dri
 
 static int __init inia100_init(void)
 {
-	return pci_module_init(&inia100_pci_driver);
+	return pci_register_driver(&inia100_pci_driver);
 }
 
 static void __exit inia100_exit(void)
diff -Narup a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-11-29 11:08:57.000000000 +0100
+++ b/drivers/scsi/ahci.c	2005-11-29 19:06:03.000000000 +0100
@@ -1140,7 +1140,7 @@ static void ahci_remove_one (struct pci_
 
 static int __init ahci_init(void)
 {
-	return pci_module_init(&ahci_pci_driver);
+	return pci_register_driver(&ahci_pci_driver);
 }
 
 static void __exit ahci_exit(void)
diff -Narup a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
--- a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2005-11-29 11:05:13.000000000 +0100
+++ b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2005-11-29 18:16:42.000000000 +0100
@@ -198,7 +198,7 @@ ahd_linux_pci_dev_probe(struct pci_dev *
 int
 ahd_linux_pci_init(void)
 {
-	return (pci_module_init(&aic79xx_pci_driver));
+	return (pci_register_driver(&aic79xx_pci_driver));
 }
 
 void
diff -Narup a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
--- a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2005-11-29 11:05:13.000000000 +0100
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2005-11-29 18:09:03.000000000 +0100
@@ -246,7 +246,7 @@ int
 ahc_linux_pci_init(void)
 {
 	/* Translate error or zero return into zero or one */
-	return pci_module_init(&aic7xxx_pci_driver) ? 0 : 1;
+	return pci_register_driver(&aic7xxx_pci_driver) ? 0 : 1;
 }
 
 void
diff -Narup a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2005-11-29 11:08:57.000000000 +0100
+++ b/drivers/scsi/ata_piix.c	2005-11-29 19:10:33.000000000 +0100
@@ -684,8 +684,8 @@ static int __init piix_init(void)
 {
 	int rc;
 
-	DPRINTK("pci_module_init\n");
-	rc = pci_module_init(&piix_pci_driver);
+	DPRINTK("pci_register_driver\n");
+	rc = pci_register_driver(&piix_pci_driver);
 	if (rc)
 		return rc;
 
diff -Narup a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
--- a/drivers/scsi/dc395x.c	2005-11-29 11:08:57.000000000 +0100
+++ b/drivers/scsi/dc395x.c	2005-11-29 19:06:03.000000000 +0100
@@ -4921,7 +4921,7 @@ static struct pci_driver dc395x_driver =
  **/
 static int __init dc395x_module_init(void)
 {
-	return pci_module_init(&dc395x_driver);
+	return pci_register_driver(&dc395x_driver);
 }
 
 
diff -Narup a/drivers/scsi/dmx3191d.c b/drivers/scsi/dmx3191d.c
--- a/drivers/scsi/dmx3191d.c	2005-11-29 11:05:13.000000000 +0100
+++ b/drivers/scsi/dmx3191d.c	2005-11-29 17:34:00.000000000 +0100
@@ -155,7 +155,7 @@ static struct pci_driver dmx3191d_pci_dr
 
 static int __init dmx3191d_init(void)
 {
-	return pci_module_init(&dmx3191d_pci_driver);
+	return pci_register_driver(&dmx3191d_pci_driver);
 }
 
 static void __exit dmx3191d_exit(void)
diff -Narup a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
--- a/drivers/scsi/ipr.c	2005-11-29 11:08:57.000000000 +0100
+++ b/drivers/scsi/ipr.c	2005-11-29 19:06:03.000000000 +0100
@@ -6644,7 +6644,7 @@ static int __init ipr_init(void)
 	ipr_info("IBM Power RAID SCSI Device Driver version: %s %s\n",
 		 IPR_DRIVER_VERSION, IPR_DRIVER_DATE);
 
-	return pci_module_init(&ipr_driver);
+	return pci_register_driver(&ipr_driver);
 }
 
 /**
diff -Narup a/drivers/scsi/ips.c b/drivers/scsi/ips.c
--- a/drivers/scsi/ips.c	2005-11-29 11:08:57.000000000 +0100
+++ b/drivers/scsi/ips.c	2005-11-29 19:06:03.000000000 +0100
@@ -7073,7 +7073,7 @@ ips_remove_device(struct pci_dev *pci_de
 static int __init
 ips_module_init(void)
 {
-	if (pci_module_init(&ips_pci_driver) < 0)
+	if (pci_register_driver(&ips_pci_driver) < 0)
 		return -ENODEV;
 	ips_driver_template.module = THIS_MODULE;
 	ips_order_controllers();
diff -Narup a/drivers/scsi/megaraid/megaraid_sas.c b/drivers/scsi/megaraid/megaraid_sas.c
--- a/drivers/scsi/megaraid/megaraid_sas.c	2005-11-29 11:08:57.000000000 +0100
+++ b/drivers/scsi/megaraid/megaraid_sas.c	2005-11-29 19:06:03.000000000 +0100
@@ -2768,7 +2768,7 @@ static int __init megasas_init(void)
 	/*
 	 * Register ourselves as PCI hotplug module
 	 */
-	rval = pci_module_init(&megasas_pci_driver);
+	rval = pci_register_driver(&megasas_pci_driver);
 
 	if (rval) {
 		printk(KERN_DEBUG "megasas: PCI hotplug regisration failed \n");
diff -Narup a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
--- a/drivers/scsi/megaraid.c	2005-11-29 11:08:57.000000000 +0100
+++ b/drivers/scsi/megaraid.c	2005-11-29 17:28:03.000000000 +0100
@@ -5082,7 +5082,7 @@ static int __init megaraid_init(void)
 				"megaraid: failed to create megaraid root\n");
 	}
 #endif
-	error = pci_module_init(&megaraid_pci_driver);
+	error = pci_register_driver(&megaraid_pci_driver);
 	if (error) {
 #ifdef CONFIG_PROC_FS
 		remove_proc_entry("megaraid", &proc_root);
diff -Narup a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
--- a/drivers/scsi/nsp32.c	2005-11-29 11:08:57.000000000 +0100
+++ b/drivers/scsi/nsp32.c	2005-11-29 19:06:02.000000000 +0100
@@ -3574,7 +3574,7 @@ static struct pci_driver nsp32_driver = 
  */
 static int __init init_nsp32(void) {
 	nsp32_msg(KERN_INFO, "loading...");
-	return pci_module_init(&nsp32_driver);
+	return pci_register_driver(&nsp32_driver);
 }
 
 static void __exit exit_nsp32(void) {
diff -Narup a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
--- a/drivers/scsi/pdc_adma.c	2005-11-29 11:08:58.000000000 +0100
+++ b/drivers/scsi/pdc_adma.c	2005-11-29 19:06:02.000000000 +0100
@@ -722,7 +722,7 @@ err_out:
 
 static int __init adma_ata_init(void)
 {
-	return pci_module_init(&adma_ata_pci_driver);
+	return pci_register_driver(&adma_ata_pci_driver);
 }
 
 static void __exit adma_ata_exit(void)
diff -Narup a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
--- a/drivers/scsi/qla1280.c	2005-11-29 11:08:58.000000000 +0100
+++ b/drivers/scsi/qla1280.c	2005-11-29 19:06:02.000000000 +0100
@@ -4772,7 +4772,7 @@ qla1280_init(void)
 		qla1280_setup(qla1280);
 #endif
 
-	return pci_module_init(&qla1280_pci_driver);
+	return pci_register_driver(&qla1280_pci_driver);
 }
 
 static void __exit
diff -Narup a/drivers/scsi/qla2xxx/ql2100.c b/drivers/scsi/qla2xxx/ql2100.c
--- a/drivers/scsi/qla2xxx/ql2100.c	2005-11-29 11:08:58.000000000 +0100
+++ b/drivers/scsi/qla2xxx/ql2100.c	2005-11-29 19:06:02.000000000 +0100
@@ -73,7 +73,7 @@ static struct pci_driver qla2100_pci_dri
 static int __init
 qla2100_init(void)
 {
-	return pci_module_init(&qla2100_pci_driver);
+	return pci_register_driver(&qla2100_pci_driver);
 }
 
 static void __exit
diff -Narup a/drivers/scsi/qla2xxx/ql2200.c b/drivers/scsi/qla2xxx/ql2200.c
--- a/drivers/scsi/qla2xxx/ql2200.c	2005-11-29 11:08:58.000000000 +0100
+++ b/drivers/scsi/qla2xxx/ql2200.c	2005-11-29 19:06:02.000000000 +0100
@@ -73,7 +73,7 @@ static struct pci_driver qla2200_pci_dri
 static int __init
 qla2200_init(void)
 {
-	return pci_module_init(&qla2200_pci_driver);
+	return pci_register_driver(&qla2200_pci_driver);
 }
 
 static void __exit
diff -Narup a/drivers/scsi/qla2xxx/ql2300.c b/drivers/scsi/qla2xxx/ql2300.c
--- a/drivers/scsi/qla2xxx/ql2300.c	2005-11-29 11:08:58.000000000 +0100
+++ b/drivers/scsi/qla2xxx/ql2300.c	2005-11-29 19:06:02.000000000 +0100
@@ -84,7 +84,7 @@ static struct pci_driver qla2300_pci_dri
 static int __init
 qla2300_init(void)
 {
-	return pci_module_init(&qla2300_pci_driver);
+	return pci_register_driver(&qla2300_pci_driver);
 }
 
 static void __exit
diff -Narup a/drivers/scsi/qla2xxx/ql2322.c b/drivers/scsi/qla2xxx/ql2322.c
--- a/drivers/scsi/qla2xxx/ql2322.c	2005-11-29 11:08:58.000000000 +0100
+++ b/drivers/scsi/qla2xxx/ql2322.c	2005-11-29 19:06:02.000000000 +0100
@@ -89,7 +89,7 @@ static struct pci_driver qla2322_pci_dri
 static int __init
 qla2322_init(void)
 {
-	return pci_module_init(&qla2322_pci_driver);
+	return pci_register_driver(&qla2322_pci_driver);
 }
 
 static void __exit
diff -Narup a/drivers/scsi/qla2xxx/ql6312.c b/drivers/scsi/qla2xxx/ql6312.c
--- a/drivers/scsi/qla2xxx/ql6312.c	2005-11-29 11:08:58.000000000 +0100
+++ b/drivers/scsi/qla2xxx/ql6312.c	2005-11-29 19:06:02.000000000 +0100
@@ -83,7 +83,7 @@ static struct pci_driver qla6312_pci_dri
 static int __init
 qla6312_init(void)
 {
-	return pci_module_init(&qla6312_pci_driver);
+	return pci_register_driver(&qla6312_pci_driver);
 }
 
 static void __exit
diff -Narup a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
--- a/drivers/scsi/qla2xxx/qla_os.c	2005-11-29 11:08:58.000000000 +0100
+++ b/drivers/scsi/qla2xxx/qla_os.c	2005-11-29 19:06:02.000000000 +0100
@@ -2565,7 +2565,7 @@ qla2x00_module_init(void)
 		return -ENODEV;
 
 	printk(KERN_INFO "QLogic Fibre Channel HBA Driver\n");
-	ret = pci_module_init(&qla2xxx_pci_driver);
+	ret = pci_register_driver(&qla2xxx_pci_driver);
 	if (ret) {
 		kmem_cache_destroy(srb_cachep);
 		fc_release_transport(qla2xxx_transport_template);
diff -Narup a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
--- a/drivers/scsi/sata_mv.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/sata_mv.c	2005-11-29 17:33:15.000000000 +0100
@@ -2229,7 +2229,7 @@ err_out:
 
 static int __init mv_init(void)
 {
-	return pci_module_init(&mv_pci_driver);
+	return pci_register_driver(&mv_pci_driver);
 }
 
 static void __exit mv_exit(void)
diff -Narup a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/sata_nv.c	2005-11-29 19:06:02.000000000 +0100
@@ -591,7 +591,7 @@ static void nv_check_hotplug_ck804(struc
 
 static int __init nv_init(void)
 {
-	return pci_module_init(&nv_pci_driver);
+	return pci_register_driver(&nv_pci_driver);
 }
 
 static void __exit nv_exit(void)
diff -Narup a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/sata_promise.c	2005-11-29 19:06:02.000000000 +0100
@@ -743,7 +743,7 @@ err_out:
 
 static int __init pdc_ata_init(void)
 {
-	return pci_module_init(&pdc_ata_pci_driver);
+	return pci_register_driver(&pdc_ata_pci_driver);
 }
 
 
diff -Narup a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/sata_qstor.c	2005-11-29 19:06:03.000000000 +0100
@@ -712,7 +712,7 @@ err_out:
 
 static int __init qs_ata_init(void)
 {
-	return pci_module_init(&qs_ata_pci_driver);
+	return pci_register_driver(&qs_ata_pci_driver);
 }
 
 static void __exit qs_ata_exit(void)
diff -Narup a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
--- a/drivers/scsi/sata_sil24.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/sata_sil24.c	2005-11-29 17:24:27.000000000 +0100
@@ -1017,7 +1017,7 @@ static int sil24_init_one(struct pci_dev
 
 static int __init sil24_init(void)
 {
-	return pci_module_init(&sil24_pci_driver);
+	return pci_register_driver(&sil24_pci_driver);
 }
 
 static void __exit sil24_exit(void)
diff -Narup a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/sata_sil.c	2005-11-29 19:06:03.000000000 +0100
@@ -512,7 +512,7 @@ err_out:
 
 static int __init sil_init(void)
 {
-	return pci_module_init(&sil_pci_driver);
+	return pci_register_driver(&sil_pci_driver);
 }
 
 static void __exit sil_exit(void)
diff -Narup a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/sata_sis.c	2005-11-29 17:25:34.000000000 +0100
@@ -335,7 +335,7 @@ err_out:
 
 static int __init sis_init(void)
 {
-	return pci_module_init(&sis_pci_driver);
+	return pci_register_driver(&sis_pci_driver);
 }
 
 static void __exit sis_exit(void)
diff -Narup a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/sata_svw.c	2005-11-29 19:06:03.000000000 +0100
@@ -485,7 +485,7 @@ static struct pci_driver k2_sata_pci_dri
 
 static int __init k2_sata_init(void)
 {
-	return pci_module_init(&k2_sata_pci_driver);
+	return pci_register_driver(&k2_sata_pci_driver);
 }
 
 
diff -Narup a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/sata_sx4.c	2005-11-29 19:06:02.000000000 +0100
@@ -1495,7 +1495,7 @@ err_out:
 
 static int __init pdc_sata_init(void)
 {
-	return pci_module_init(&pdc_sata_pci_driver);
+	return pci_register_driver(&pdc_sata_pci_driver);
 }
 
 
diff -Narup a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/sata_uli.c	2005-11-29 19:06:03.000000000 +0100
@@ -272,7 +272,7 @@ err_out:
 
 static int __init uli_init(void)
 {
-	return pci_module_init(&uli_pci_driver);
+	return pci_register_driver(&uli_pci_driver);
 }
 
 static void __exit uli_exit(void)
diff -Narup a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/sata_via.c	2005-11-29 19:06:03.000000000 +0100
@@ -382,7 +382,7 @@ err_out:
 
 static int __init svia_init(void)
 {
-	return pci_module_init(&svia_pci_driver);
+	return pci_register_driver(&svia_pci_driver);
 }
 
 static void __exit svia_exit(void)
diff -Narup a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/sata_vsc.c	2005-11-29 17:28:53.000000000 +0100
@@ -417,7 +417,7 @@ static struct pci_driver vsc_sata_pci_dr
 
 static int __init vsc_sata_init(void)
 {
-	return pci_module_init(&vsc_sata_pci_driver);
+	return pci_register_driver(&vsc_sata_pci_driver);
 }
 
 
diff -Narup a/drivers/scsi/tmscsim.c b/drivers/scsi/tmscsim.c
--- a/drivers/scsi/tmscsim.c	2005-11-29 11:08:59.000000000 +0100
+++ b/drivers/scsi/tmscsim.c	2005-11-29 17:35:27.000000000 +0100
@@ -2671,7 +2671,7 @@ static int __init dc390_module_init(void
 		printk (KERN_INFO "DC390: Using safe settings.\n");
 	}
 
-	return pci_module_init(&dc390_driver);
+	return pci_register_driver(&dc390_driver);
 }
 
 static void __exit dc390_module_exit(void)
