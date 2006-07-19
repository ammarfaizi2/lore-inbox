Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWGSP6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWGSP6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWGSP6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:58:21 -0400
Received: from server6.greatnet.de ([83.133.96.26]:10909 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030197AbWGSP6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:58:19 -0400
Message-ID: <44BE567A.4000609@nachtwindheim.de>
Date: Wed, 19 Jul 2006 17:57:46 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: jgarzik@pobox.com
Cc: kernel-janitors@lists.osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [NET] pci_module_init() removal on some net-drivers
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Removes pci_module_init() from 56 net-subsys-drivers and replaces it with
pci_register_driver(), if the initialistion function just returns the
return value of those functions. 
There are still some pci_module_init() left in the net drivers which require
a closer look.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

diff -ruN linux-2.6.18-rc2/drivers/net/8139cp.c linux/drivers/net/8139cp.c
--- linux-2.6.18-rc2/drivers/net/8139cp.c	2006-07-18 13:37:07.000000000 +0200
+++ linux/drivers/net/8139cp.c	2006-07-19 17:41:08.000000000 +0200
@@ -2098,7 +2098,7 @@
 #ifdef MODULE
 	printk("%s", version);
 #endif
-	return pci_module_init (&cp_driver);
+	return pci_register_driver(&cp_driver);
 }
 
 static void __exit cp_exit (void)
diff -ruN linux-2.6.18-rc2/drivers/net/8139too.c linux/drivers/net/8139too.c
--- linux-2.6.18-rc2/drivers/net/8139too.c	2006-07-18 13:37:07.000000000 +0200
+++ linux/drivers/net/8139too.c	2006-07-19 17:40:35.000000000 +0200
@@ -2629,7 +2629,7 @@
 	printk (KERN_INFO RTL8139_DRIVER_NAME "\n");
 #endif
 
-	return pci_module_init (&rtl8139_pci_driver);
+	return pci_register_driver(&rtl8139_pci_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/net/acenic.c linux/drivers/net/acenic.c
--- linux-2.6.18-rc2/drivers/net/acenic.c	2006-07-18 13:37:07.000000000 +0200
+++ linux/drivers/net/acenic.c	2006-07-19 16:45:07.000000000 +0200
@@ -725,7 +725,7 @@
 
 static int __init acenic_init(void)
 {
-	return pci_module_init(&acenic_pci_driver);
+	return pci_register_driver(&acenic_pci_driver);
 }
 
 static void __exit acenic_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/net/amd8111e.c linux/drivers/net/amd8111e.c
--- linux-2.6.18-rc2/drivers/net/amd8111e.c	2006-07-18 13:37:07.000000000 +0200
+++ linux/drivers/net/amd8111e.c	2006-07-19 17:40:08.000000000 +0200
@@ -2158,7 +2158,7 @@
 
 static int __init amd8111e_init(void)
 {
-	return pci_module_init(&amd8111e_driver);
+	return pci_register_driver(&amd8111e_driver);
 }
 
 static void __exit amd8111e_cleanup(void)
diff -ruN linux-2.6.18-rc2/drivers/net/arcnet/com20020-pci.c linux/drivers/net/arcnet/com20020-pci.c
--- linux-2.6.18-rc2/drivers/net/arcnet/com20020-pci.c	2006-07-18 13:37:07.000000000 +0200
+++ linux/drivers/net/arcnet/com20020-pci.c	2006-07-19 17:39:43.000000000 +0200
@@ -177,7 +177,7 @@
 static int __init com20020pci_init(void)
 {
 	BUGLVL(D_NORMAL) printk(VERSION);
-	return pci_module_init(&com20020pci_driver);
+	return pci_register_driver(&com20020pci_driver);
 }
 
 static void __exit com20020pci_cleanup(void)
diff -ruN linux-2.6.18-rc2/drivers/net/b44.c linux/drivers/net/b44.c
--- linux-2.6.18-rc2/drivers/net/b44.c	2006-07-18 13:37:07.000000000 +0200
+++ linux/drivers/net/b44.c	2006-07-19 17:38:59.000000000 +0200
@@ -2354,7 +2354,7 @@
 	dma_desc_align_mask = ~(dma_desc_align_size - 1);
 	dma_desc_sync_size = max_t(unsigned int, dma_desc_align_size, sizeof(struct dma_desc));
 
-	return pci_module_init(&b44_driver);
+	return pci_register_driver(&b44_driver);
 }
 
 static void __exit b44_cleanup(void)
diff -ruN linux-2.6.18-rc2/drivers/net/bnx2.c linux/drivers/net/bnx2.c
--- linux-2.6.18-rc2/drivers/net/bnx2.c	2006-07-18 13:37:07.000000000 +0200
+++ linux/drivers/net/bnx2.c	2006-07-19 17:38:00.000000000 +0200
@@ -6015,7 +6015,7 @@
 
 static int __init bnx2_init(void)
 {
-	return pci_module_init(&bnx2_pci_driver);
+	return pci_register_driver(&bnx2_pci_driver);
 }
 
 static void __exit bnx2_cleanup(void)
diff -ruN linux-2.6.18-rc2/drivers/net/cassini.c linux/drivers/net/cassini.c
--- linux-2.6.18-rc2/drivers/net/cassini.c	2006-07-18 13:37:07.000000000 +0200
+++ linux/drivers/net/cassini.c	2006-07-19 17:37:18.000000000 +0200
@@ -5245,7 +5245,7 @@
 	else
 		link_transition_timeout = 0;
 
-	return pci_module_init(&cas_driver);
+	return pci_register_driver(&cas_driver);
 }
 
 static void __exit cas_cleanup(void)
diff -ruN linux-2.6.18-rc2/drivers/net/chelsio/cxgb2.c linux/drivers/net/chelsio/cxgb2.c
--- linux-2.6.18-rc2/drivers/net/chelsio/cxgb2.c	2006-07-18 13:37:07.000000000 +0200
+++ linux/drivers/net/chelsio/cxgb2.c	2006-07-19 17:36:38.000000000 +0200
@@ -1243,7 +1243,7 @@
 
 static int __init t1_init_module(void)
 {
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit t1_cleanup_module(void)
diff -ruN linux-2.6.18-rc2/drivers/net/dl2k.c linux/drivers/net/dl2k.c
--- linux-2.6.18-rc2/drivers/net/dl2k.c	2006-07-18 13:37:07.000000000 +0200
+++ linux/drivers/net/dl2k.c	2006-07-19 17:35:37.000000000 +0200
@@ -1815,7 +1815,7 @@
 static int __init
 rio_init (void)
 {
-	return pci_module_init (&rio_driver);
+	return pci_register_driver(&rio_driver);
 }
 
 static void __exit
diff -ruN linux-2.6.18-rc2/drivers/net/eepro100.c linux/drivers/net/eepro100.c
--- linux-2.6.18-rc2/drivers/net/eepro100.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/eepro100.c	2006-07-19 17:34:01.000000000 +0200
@@ -2385,7 +2385,7 @@
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&eepro100_driver);
+	return pci_register_driver(&eepro100_driver);
 }
 
 static void __exit eepro100_cleanup_module(void)
diff -ruN linux-2.6.18-rc2/drivers/net/epic100.c linux/drivers/net/epic100.c
--- linux-2.6.18-rc2/drivers/net/epic100.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/epic100.c	2006-07-19 17:33:39.000000000 +0200
@@ -1604,7 +1604,7 @@
 		version, version2, version3);
 #endif
 
-	return pci_module_init (&epic_driver);
+	return pci_register_driver(&epic_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/net/fealnx.c linux/drivers/net/fealnx.c
--- linux-2.6.18-rc2/drivers/net/fealnx.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/fealnx.c	2006-07-19 17:33:04.000000000 +0200
@@ -1984,7 +1984,7 @@
 	printk(version);
 #endif
 
-	return pci_module_init(&fealnx_driver);
+	return pci_register_driver(&fealnx_driver);
 }
 
 static void __exit fealnx_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/net/forcedeth.c linux/drivers/net/forcedeth.c
--- linux-2.6.18-rc2/drivers/net/forcedeth.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/forcedeth.c	2006-07-19 17:32:20.000000000 +0200
@@ -4540,7 +4540,7 @@
 static int __init init_nic(void)
 {
 	printk(KERN_INFO "forcedeth.c: Reverse Engineered nForce ethernet driver. Version %s.\n", FORCEDETH_VERSION);
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit exit_nic(void)
diff -ruN linux-2.6.18-rc2/drivers/net/ixgb/ixgb_main.c linux/drivers/net/ixgb/ixgb_main.c
--- linux-2.6.18-rc2/drivers/net/ixgb/ixgb_main.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/ixgb/ixgb_main.c	2006-07-19 17:31:21.000000000 +0200
@@ -162,7 +162,7 @@
 
 	printk(KERN_INFO "%s\n", ixgb_copyright);
 
-	return pci_module_init(&ixgb_driver);
+	return pci_register_driver(&ixgb_driver);
 }
 
 module_init(ixgb_init_module);
diff -ruN linux-2.6.18-rc2/drivers/net/natsemi.c linux/drivers/net/natsemi.c
--- linux-2.6.18-rc2/drivers/net/natsemi.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/natsemi.c	2006-07-19 17:30:27.000000000 +0200
@@ -3246,7 +3246,7 @@
 	printk(version);
 #endif
 
-	return pci_module_init (&natsemi_driver);
+	return pci_register_driver(&natsemi_driver);
 }
 
 static void __exit natsemi_exit_mod (void)
diff -ruN linux-2.6.18-rc2/drivers/net/ne2k-pci.c linux/drivers/net/ne2k-pci.c
--- linux-2.6.18-rc2/drivers/net/ne2k-pci.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/ne2k-pci.c	2006-07-19 17:30:03.000000000 +0200
@@ -702,7 +702,7 @@
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&ne2k_driver);
+	return pci_register_driver(&ne2k_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/net/ns83820.c linux/drivers/net/ns83820.c
--- linux-2.6.18-rc2/drivers/net/ns83820.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/ns83820.c	2006-07-19 17:29:34.000000000 +0200
@@ -2178,7 +2178,7 @@
 static int __init ns83820_init(void)
 {
 	printk(KERN_INFO "ns83820.c: National Semiconductor DP83820 10/100/1000 driver.\n");
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit ns83820_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/net/pci-skeleton.c linux/drivers/net/pci-skeleton.c
--- linux-2.6.18-rc2/drivers/net/pci-skeleton.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/pci-skeleton.c	2006-07-19 17:29:07.000000000 +0200
@@ -1963,7 +1963,7 @@
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&netdrv_pci_driver);
+	return pci_register_driver(&netdrv_pci_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/net/r8169.c linux/drivers/net/r8169.c
--- linux-2.6.18-rc2/drivers/net/r8169.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/r8169.c	2006-07-19 17:28:37.000000000 +0200
@@ -2809,7 +2809,7 @@
 static int __init
 rtl8169_init_module(void)
 {
-	return pci_module_init(&rtl8169_pci_driver);
+	return pci_register_driver(&rtl8169_pci_driver);
 }
 
 static void __exit
diff -ruN linux-2.6.18-rc2/drivers/net/rrunner.c linux/drivers/net/rrunner.c
--- linux-2.6.18-rc2/drivers/net/rrunner.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/rrunner.c	2006-07-19 17:28:05.000000000 +0200
@@ -1736,7 +1736,7 @@
 
 static int __init rr_init_module(void)
 {
-	return pci_module_init(&rr_driver);
+	return pci_register_driver(&rr_driver);
 }
 
 static void __exit rr_cleanup_module(void)
diff -ruN linux-2.6.18-rc2/drivers/net/s2io.c linux/drivers/net/s2io.c
--- linux-2.6.18-rc2/drivers/net/s2io.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/s2io.c	2006-07-19 17:27:26.000000000 +0200
@@ -7275,7 +7275,7 @@
 
 int __init s2io_starter(void)
 {
-	return pci_module_init(&s2io_driver);
+	return pci_register_driver(&s2io_driver);
 }
 
 /**
diff -ruN linux-2.6.18-rc2/drivers/net/saa9730.c linux/drivers/net/saa9730.c
--- linux-2.6.18-rc2/drivers/net/saa9730.c	2006-06-18 03:49:35.000000000 +0200
+++ linux/drivers/net/saa9730.c	2006-07-19 17:26:46.000000000 +0200
@@ -1131,7 +1131,7 @@
 
 static int __init saa9730_init(void)
 {
-	return pci_module_init(&saa9730_driver);
+	return pci_register_driver(&saa9730_driver);
 }
 
 static void __exit saa9730_cleanup(void)
diff -ruN linux-2.6.18-rc2/drivers/net/sis190.c linux/drivers/net/sis190.c
--- linux-2.6.18-rc2/drivers/net/sis190.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/sis190.c	2006-07-19 17:26:14.000000000 +0200
@@ -1871,7 +1871,7 @@
 
 static int __init sis190_init_module(void)
 {
-	return pci_module_init(&sis190_pci_driver);
+	return pci_register_driver(&sis190_pci_driver);
 }
 
 static void __exit sis190_cleanup_module(void)
diff -ruN linux-2.6.18-rc2/drivers/net/sis900.c linux/drivers/net/sis900.c
--- linux-2.6.18-rc2/drivers/net/sis900.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/sis900.c	2006-07-19 17:25:53.000000000 +0200
@@ -2495,7 +2495,7 @@
 	printk(version);
 #endif
 
-	return pci_module_init(&sis900_pci_driver);
+	return pci_register_driver(&sis900_pci_driver);
 }
 
 static void __exit sis900_cleanup_module(void)
diff -ruN linux-2.6.18-rc2/drivers/net/sk98lin/skge.c linux/drivers/net/sk98lin/skge.c
--- linux-2.6.18-rc2/drivers/net/sk98lin/skge.c	2006-07-18 13:37:08.000000000 +0200
+++ linux/drivers/net/sk98lin/skge.c	2006-07-19 17:25:20.000000000 +0200
@@ -5133,7 +5133,7 @@
 
 static int __init skge_init(void)
 {
-	return pci_module_init(&skge_driver);
+	return pci_register_driver(&skge_driver);
 }
 
 static void __exit skge_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/net/skfp/skfddi.c linux/drivers/net/skfp/skfddi.c
--- linux-2.6.18-rc2/drivers/net/skfp/skfddi.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/skfp/skfddi.c	2006-07-19 17:24:07.000000000 +0200
@@ -2280,7 +2280,7 @@
 
 static int __init skfd_init(void)
 {
-	return pci_module_init(&skfddi_pci_driver);
+	return pci_register_driver(&skfddi_pci_driver);
 }
 
 static void __exit skfd_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/net/skge.c linux/drivers/net/skge.c
--- linux-2.6.18-rc2/drivers/net/skge.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/skge.c	2006-07-19 17:23:08.000000000 +0200
@@ -3511,7 +3511,7 @@
 
 static int __init skge_init_module(void)
 {
-	return pci_module_init(&skge_driver);
+	return pci_register_driver(&skge_driver);
 }
 
 static void __exit skge_cleanup_module(void)
diff -ruN linux-2.6.18-rc2/drivers/net/starfire.c linux/drivers/net/starfire.c
--- linux-2.6.18-rc2/drivers/net/starfire.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/starfire.c	2006-07-19 17:21:43.000000000 +0200
@@ -2053,7 +2053,7 @@
 		return -ENODEV;
 	}
 
-	return pci_module_init (&starfire_driver);
+	return pci_register_driver(&starfire_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/net/sundance.c linux/drivers/net/sundance.c
--- linux-2.6.18-rc2/drivers/net/sundance.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/sundance.c	2006-07-19 17:21:10.000000000 +0200
@@ -1736,7 +1736,7 @@
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&sundance_driver);
+	return pci_register_driver(&sundance_driver);
 }
 
 static void __exit sundance_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/net/sungem.c linux/drivers/net/sungem.c
--- linux-2.6.18-rc2/drivers/net/sungem.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/sungem.c	2006-07-19 16:51:17.000000000 +0200
@@ -3194,7 +3194,7 @@
 
 static int __init gem_init(void)
 {
-	return pci_module_init(&gem_driver);
+	return pci_register_driver(&gem_driver);
 }
 
 static void __exit gem_cleanup(void)
diff -ruN linux-2.6.18-rc2/drivers/net/sunhme.c linux/drivers/net/sunhme.c
--- linux-2.6.18-rc2/drivers/net/sunhme.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/sunhme.c	2006-07-19 16:54:59.000000000 +0200
@@ -3275,7 +3275,7 @@
 
 static int __init happy_meal_pci_init(void)
 {
-	return pci_module_init(&hme_pci_driver);
+	return pci_register_driver(&hme_pci_driver);
 }
 
 static void happy_meal_pci_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/net/tc35815.c linux/drivers/net/tc35815.c
--- linux-2.6.18-rc2/drivers/net/tc35815.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/tc35815.c	2006-07-19 17:20:39.000000000 +0200
@@ -1725,7 +1725,7 @@
 
 static int __init tc35815_init_module(void)
 {
-	return pci_module_init(&tc35815_driver);
+	return pci_register_driver(&tc35815_driver);
 }
 
 static void __exit tc35815_cleanup_module(void)
diff -ruN linux-2.6.18-rc2/drivers/net/tg3.c linux/drivers/net/tg3.c
--- linux-2.6.18-rc2/drivers/net/tg3.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/tg3.c	2006-07-19 16:46:16.000000000 +0200
@@ -11756,7 +11756,7 @@
 
 static int __init tg3_init(void)
 {
-	return pci_module_init(&tg3_driver);
+	return pci_register_driver(&tg3_driver);
 }
 
 static void __exit tg3_cleanup(void)
diff -ruN linux-2.6.18-rc2/drivers/net/tokenring/3c359.c linux/drivers/net/tokenring/3c359.c
--- linux-2.6.18-rc2/drivers/net/tokenring/3c359.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/tokenring/3c359.c	2006-07-19 17:18:13.000000000 +0200
@@ -1815,7 +1815,7 @@
 
 static int __init xl_pci_init (void)
 {
-	return pci_module_init (&xl_3c359_driver);
+	return pci_register_driver(&xl_3c359_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/net/tokenring/lanstreamer.c linux/drivers/net/tokenring/lanstreamer.c
--- linux-2.6.18-rc2/drivers/net/tokenring/lanstreamer.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/tokenring/lanstreamer.c	2006-07-19 17:18:39.000000000 +0200
@@ -1998,7 +1998,7 @@
 };
 
 static int __init streamer_init_module(void) {
-  return pci_module_init(&streamer_pci_driver);
+  return pci_register_driver(&streamer_pci_driver);
 }
 
 static void __exit streamer_cleanup_module(void) {
diff -ruN linux-2.6.18-rc2/drivers/net/tokenring/olympic.c linux/drivers/net/tokenring/olympic.c
--- linux-2.6.18-rc2/drivers/net/tokenring/olympic.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/tokenring/olympic.c	2006-07-19 17:19:07.000000000 +0200
@@ -1771,7 +1771,7 @@
 
 static int __init olympic_pci_init(void) 
 {
-	return pci_module_init (&olympic_driver) ; 
+	return pci_register_driver(&olympic_driver); 
 }
 
 static void __exit olympic_pci_cleanup(void)
diff -ruN linux-2.6.18-rc2/drivers/net/tulip/de2104x.c linux/drivers/net/tulip/de2104x.c
--- linux-2.6.18-rc2/drivers/net/tulip/de2104x.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/tulip/de2104x.c	2006-07-19 17:12:42.000000000 +0200
@@ -2172,7 +2172,7 @@
 #ifdef MODULE
 	printk("%s", version);
 #endif
-	return pci_module_init (&de_driver);
+	return pci_register_driver(&de_driver);
 }
 
 static void __exit de_exit (void)
diff -ruN linux-2.6.18-rc2/drivers/net/tulip/tulip_core.c linux/drivers/net/tulip/tulip_core.c
--- linux-2.6.18-rc2/drivers/net/tulip/tulip_core.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/tulip/tulip_core.c	2006-07-19 17:14:41.000000000 +0200
@@ -1849,7 +1849,7 @@
 	tulip_max_interrupt_work = max_interrupt_work;
 
 	/* probe for and init boards */
-	return pci_module_init (&tulip_driver);
+	return pci_register_driver(&tulip_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/net/tulip/winbond-840.c linux/drivers/net/tulip/winbond-840.c
--- linux-2.6.18-rc2/drivers/net/tulip/winbond-840.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/tulip/winbond-840.c	2006-07-19 17:16:06.000000000 +0200
@@ -1689,7 +1689,7 @@
 static int __init w840_init(void)
 {
 	printk(version);
-	return pci_module_init(&w840_driver);
+	return pci_register_driver(&w840_driver);
 }
 
 static void __exit w840_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/net/tulip/xircom_tulip_cb.c linux/drivers/net/tulip/xircom_tulip_cb.c
--- linux-2.6.18-rc2/drivers/net/tulip/xircom_tulip_cb.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/tulip/xircom_tulip_cb.c	2006-07-19 17:16:42.000000000 +0200
@@ -1707,7 +1707,7 @@
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&xircom_driver);
+	return pci_register_driver(&xircom_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/net/typhoon.c linux/drivers/net/typhoon.c
--- linux-2.6.18-rc2/drivers/net/typhoon.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/typhoon.c	2006-07-19 16:47:11.000000000 +0200
@@ -2660,7 +2660,7 @@
 static int __init
 typhoon_init(void)
 {
-	return pci_module_init(&typhoon_driver);
+	return pci_register_driver(&typhoon_driver);
 }
 
 static void __exit
diff -ruN linux-2.6.18-rc2/drivers/net/via-rhine.c linux/drivers/net/via-rhine.c
--- linux-2.6.18-rc2/drivers/net/via-rhine.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/via-rhine.c	2006-07-19 16:48:09.000000000 +0200
@@ -1941,7 +1941,7 @@
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&rhine_driver);
+	return pci_register_driver(&rhine_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/net/wan/dscc4.c linux/drivers/net/wan/dscc4.c
--- linux-2.6.18-rc2/drivers/net/wan/dscc4.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/wan/dscc4.c	2006-07-19 17:06:01.000000000 +0200
@@ -2062,7 +2062,7 @@
 
 static int __init dscc4_init_module(void)
 {
-	return pci_module_init(&dscc4_driver);
+	return pci_register_driver(&dscc4_driver);
 }
 
 static void __exit dscc4_cleanup_module(void)
diff -ruN linux-2.6.18-rc2/drivers/net/wan/farsync.c linux/drivers/net/wan/farsync.c
--- linux-2.6.18-rc2/drivers/net/wan/farsync.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/wan/farsync.c	2006-07-19 17:06:44.000000000 +0200
@@ -2697,7 +2697,7 @@
 	for (i = 0; i < FST_MAX_CARDS; i++)
 		fst_card_array[i] = NULL;
 	spin_lock_init(&fst_work_q_lock);
-	return pci_module_init(&fst_driver);
+	return pci_register_driver(&fst_driver);
 }
 
 static void __exit
diff -ruN linux-2.6.18-rc2/drivers/net/wan/lmc/lmc_main.c linux/drivers/net/wan/lmc/lmc_main.c
--- linux-2.6.18-rc2/drivers/net/wan/lmc/lmc_main.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/wan/lmc/lmc_main.c	2006-07-19 17:09:41.000000000 +0200
@@ -1790,7 +1790,7 @@
 
 static int __init init_lmc(void)
 {
-    return pci_module_init(&lmc_driver);
+    return pci_register_driver(&lmc_driver);
 }
 
 static void __exit exit_lmc(void)
diff -ruN linux-2.6.18-rc2/drivers/net/wan/pc300_drv.c linux/drivers/net/wan/pc300_drv.c
--- linux-2.6.18-rc2/drivers/net/wan/pc300_drv.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/wan/pc300_drv.c	2006-07-19 17:07:17.000000000 +0200
@@ -3677,7 +3677,7 @@
 
 static int __init cpc_init(void)
 {
-	return pci_module_init(&cpc_driver);
+	return pci_register_driver(&cpc_driver);
 }
 
 static void __exit cpc_cleanup_module(void)
diff -ruN linux-2.6.18-rc2/drivers/net/wan/pci200syn.c linux/drivers/net/wan/pci200syn.c
--- linux-2.6.18-rc2/drivers/net/wan/pci200syn.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/wan/pci200syn.c	2006-07-19 17:08:18.000000000 +0200
@@ -476,7 +476,7 @@
 		printk(KERN_ERR "pci200syn: Invalid PCI clock frequency\n");
 		return -EINVAL;
 	}
-	return pci_module_init(&pci200_pci_driver);
+	return pci_register_driver(&pci200_pci_driver);
 }
 
 
diff -ruN linux-2.6.18-rc2/drivers/net/wan/wanxl.c linux/drivers/net/wan/wanxl.c
--- linux-2.6.18-rc2/drivers/net/wan/wanxl.c	2006-07-18 13:37:09.000000000 +0200
+++ linux/drivers/net/wan/wanxl.c	2006-07-19 17:08:59.000000000 +0200
@@ -837,7 +837,7 @@
 #ifdef MODULE
 	printk(KERN_INFO "%s\n", version);
 #endif
-	return pci_module_init(&wanxl_pci_driver);
+	return pci_register_driver(&wanxl_pci_driver);
 }
 
 static void __exit wanxl_cleanup_module(void)
diff -ruN linux-2.6.18-rc2/drivers/net/wireless/atmel_pci.c linux/drivers/net/wireless/atmel_pci.c
--- linux-2.6.18-rc2/drivers/net/wireless/atmel_pci.c	2006-07-18 13:37:10.000000000 +0200
+++ linux/drivers/net/wireless/atmel_pci.c	2006-07-19 16:57:19.000000000 +0200
@@ -76,7 +76,7 @@
 
 static int __init atmel_init_module(void)
 {
-	return pci_module_init(&atmel_driver);
+	return pci_register_driver(&atmel_driver);
 }
 
 static void __exit atmel_cleanup_module(void)
diff -ruN linux-2.6.18-rc2/drivers/net/wireless/orinoco_nortel.c linux/drivers/net/wireless/orinoco_nortel.c
--- linux-2.6.18-rc2/drivers/net/wireless/orinoco_nortel.c	2006-07-18 13:37:10.000000000 +0200
+++ linux/drivers/net/wireless/orinoco_nortel.c	2006-07-19 17:03:50.000000000 +0200
@@ -304,7 +304,7 @@
 static int __init orinoco_nortel_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_nortel_driver);
+	return pci_register_driver(&orinoco_nortel_driver);
 }
 
 static void __exit orinoco_nortel_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/net/wireless/orinoco_pci.c linux/drivers/net/wireless/orinoco_pci.c
--- linux-2.6.18-rc2/drivers/net/wireless/orinoco_pci.c	2006-07-18 13:37:10.000000000 +0200
+++ linux/drivers/net/wireless/orinoco_pci.c	2006-07-19 17:04:18.000000000 +0200
@@ -244,7 +244,7 @@
 static int __init orinoco_pci_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_pci_driver);
+	return pci_register_driver(&orinoco_pci_driver);
 }
 
 static void __exit orinoco_pci_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/net/wireless/orinoco_plx.c linux/drivers/net/wireless/orinoco_plx.c
--- linux-2.6.18-rc2/drivers/net/wireless/orinoco_plx.c	2006-07-18 13:37:10.000000000 +0200
+++ linux/drivers/net/wireless/orinoco_plx.c	2006-07-19 17:04:38.000000000 +0200
@@ -351,7 +351,7 @@
 static int __init orinoco_plx_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_plx_driver);
+	return pci_register_driver(&orinoco_plx_driver);
 }
 
 static void __exit orinoco_plx_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/net/wireless/orinoco_tmd.c linux/drivers/net/wireless/orinoco_tmd.c
--- linux-2.6.18-rc2/drivers/net/wireless/orinoco_tmd.c	2006-07-18 13:37:10.000000000 +0200
+++ linux/drivers/net/wireless/orinoco_tmd.c	2006-07-19 17:05:11.000000000 +0200
@@ -228,7 +228,7 @@
 static int __init orinoco_tmd_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_tmd_driver);
+	return pci_register_driver(&orinoco_tmd_driver);
 }
 
 static void __exit orinoco_tmd_exit(void)
diff -ruN linux-2.6.18-rc2/drivers/net/wireless/prism54/islpci_hotplug.c linux/drivers/net/wireless/prism54/islpci_hotplug.c
--- linux-2.6.18-rc2/drivers/net/wireless/prism54/islpci_hotplug.c	2006-07-18 13:37:10.000000000 +0200
+++ linux/drivers/net/wireless/prism54/islpci_hotplug.c	2006-07-19 16:56:14.000000000 +0200
@@ -313,7 +313,7 @@
 
 	__bug_on_wrong_struct_sizes ();
 
-	return pci_module_init(&prism54_driver);
+	return pci_register_driver(&prism54_driver);
 }
 
 /* by the time prism54_module_exit() terminates, as a postcondition
diff -ruN linux-2.6.18-rc2/drivers/net/yellowfin.c linux/drivers/net/yellowfin.c
--- linux-2.6.18-rc2/drivers/net/yellowfin.c	2006-07-18 13:37:10.000000000 +0200
+++ linux/drivers/net/yellowfin.c	2006-07-19 17:11:48.000000000 +0200
@@ -1434,7 +1434,7 @@
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&yellowfin_driver);
+	return pci_register_driver(&yellowfin_driver);
 }
 
 


