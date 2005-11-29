Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbVK2X76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbVK2X76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbVK2X76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:59:58 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:31171 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751401AbVK2X74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:59:56 -0500
Date: Wed, 30 Nov 2005 00:59:55 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: linux-kernel@vger.kernel.org
Cc: Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051130000505.1009.25349.sendpatchset@thinktank.campus.ltu.se>
In-Reply-To: <20051130000425.1009.94647.sendpatchset@thinktank.campus.ltu.se>
References: <20051130000425.1009.94647.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 3/6] drivers/net: Replace pci_module_init() with pci_register_driver()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Replace obsolete pci_module_init() with pci_register_driver().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 3c59x.c                           |    2 +-
 8139cp.c                          |    2 +-
 8139too.c                         |    2 +-
 acenic.c                          |    2 +-
 amd8111e.c                        |    2 +-
 arcnet/com20020-pci.c             |    2 +-
 b44.c                             |    2 +-
 bnx2.c                            |    2 +-
 cassini.c                         |    2 +-
 chelsio/cxgb2.c                   |    2 +-
 defxx.c                           |    2 +-
 dl2k.c                            |    2 +-
 e100.c                            |    2 +-
 e1000/e1000_main.c                |    2 +-
 eepro100.c                        |    2 +-
 epic100.c                         |    2 +-
 fealnx.c                          |    2 +-
 forcedeth.c                       |    2 +-
 hp100.c                           |    2 +-
 irda/donauboe.c                   |    2 +-
 irda/vlsi_ir.c                    |    2 +-
 ixgb/ixgb_main.c                  |    2 +-
 natsemi.c                         |    2 +-
 ne2k-pci.c                        |    2 +-
 ns83820.c                         |    2 +-
 pci-skeleton.c                    |    2 +-
 pcnet32.c                         |    2 +-
 r8169.c                           |    2 +-
 rrunner.c                         |    2 +-
 s2io.c                            |    2 +-
 saa9730.c                         |    2 +-
 sis190.c                          |    2 +-
 sis900.c                          |    2 +-
 skfp/skfddi.c                     |    2 +-
 skge.c                            |    2 +-
 starfire.c                        |    2 +-
 sundance.c                        |    2 +-
 sungem.c                          |    2 +-
 tc35815.c                         |    2 +-
 tg3.c                             |    2 +-
 tokenring/3c359.c                 |    2 +-
 tokenring/lanstreamer.c           |    2 +-
 tokenring/olympic.c               |    2 +-
 tulip/de2104x.c                   |    2 +-
 tulip/de4x5.c                     |    2 +-
 tulip/dmfe.c                      |    2 +-
 tulip/tulip_core.c                |    2 +-
 tulip/uli526x.c                   |    2 +-
 tulip/winbond-840.c               |    2 +-
 tulip/xircom_tulip_cb.c           |    2 +-
 typhoon.c                         |    2 +-
 via-rhine.c                       |    2 +-
 via-velocity.c                    |    2 +-
 wan/dscc4.c                       |    2 +-
 wan/farsync.c                     |    2 +-
 wan/lmc/lmc_main.c                |    2 +-
 wan/pc300_drv.c                   |    2 +-
 wan/pci200syn.c                   |    2 +-
 wan/wanxl.c                       |    2 +-
 wireless/atmel_pci.c              |    2 +-
 wireless/ipw2100.c                |    2 +-
 wireless/ipw2200.c                |    2 +-
 wireless/orinoco_nortel.c         |    2 +-
 wireless/orinoco_pci.c            |    2 +-
 wireless/orinoco_plx.c            |    2 +-
 wireless/orinoco_tmd.c            |    2 +-
 wireless/prism54/islpci_hotplug.c |    2 +-
 yellowfin.c                       |    2 +-
 68 files changed, 68 insertions(+), 68 deletions(-)

diff -Narup a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c	2005-11-29 11:08:54.000000000 +0100
+++ b/drivers/net/3c59x.c	2005-11-29 19:05:58.000000000 +0100
@@ -3367,7 +3367,7 @@ static int __init vortex_init (void)
 {
 	int pci_rc, eisa_rc;
 
-	pci_rc = pci_module_init(&vortex_driver);
+	pci_rc = pci_register_driver(&vortex_driver);
 	eisa_rc = vortex_eisa_init();
 
 	if (pci_rc == 0)
diff -Narup a/drivers/net/8139cp.c b/drivers/net/8139cp.c
--- a/drivers/net/8139cp.c	2005-11-29 11:08:54.000000000 +0100
+++ b/drivers/net/8139cp.c	2005-11-29 19:06:01.000000000 +0100
@@ -1939,7 +1939,7 @@ static int __init cp_init (void)
 #ifdef MODULE
 	printk("%s", version);
 #endif
-	return pci_module_init (&cp_driver);
+	return pci_register_driver (&cp_driver);
 }
 
 static void __exit cp_exit (void)
diff -Narup a/drivers/net/8139too.c b/drivers/net/8139too.c
--- a/drivers/net/8139too.c	2005-11-29 11:08:54.000000000 +0100
+++ b/drivers/net/8139too.c	2005-11-29 19:05:59.000000000 +0100
@@ -2635,7 +2635,7 @@ static int __init rtl8139_init_module (v
 	printk (KERN_INFO RTL8139_DRIVER_NAME "\n");
 #endif
 
-	return pci_module_init (&rtl8139_pci_driver);
+	return pci_register_driver (&rtl8139_pci_driver);
 }
 
 
diff -Narup a/drivers/net/acenic.c b/drivers/net/acenic.c
--- a/drivers/net/acenic.c	2005-11-29 11:08:54.000000000 +0100
+++ b/drivers/net/acenic.c	2005-11-29 19:05:59.000000000 +0100
@@ -730,7 +730,7 @@ static struct pci_driver acenic_pci_driv
 
 static int __init acenic_init(void)
 {
-	return pci_module_init(&acenic_pci_driver);
+	return pci_register_driver(&acenic_pci_driver);
 }
 
 static void __exit acenic_exit(void)
diff -Narup a/drivers/net/amd8111e.c b/drivers/net/amd8111e.c
--- a/drivers/net/amd8111e.c	2005-11-29 11:05:02.000000000 +0100
+++ b/drivers/net/amd8111e.c	2005-11-29 19:05:58.000000000 +0100
@@ -2159,7 +2159,7 @@ static struct pci_driver amd8111e_driver
 
 static int __init amd8111e_init(void)
 {
-	return pci_module_init(&amd8111e_driver);
+	return pci_register_driver(&amd8111e_driver);
 }
 
 static void __exit amd8111e_cleanup(void)
diff -Narup a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
--- a/drivers/net/arcnet/com20020-pci.c	2005-11-29 11:05:02.000000000 +0100
+++ b/drivers/net/arcnet/com20020-pci.c	2005-11-29 19:05:57.000000000 +0100
@@ -177,7 +177,7 @@ static struct pci_driver com20020pci_dri
 static int __init com20020pci_init(void)
 {
 	BUGLVL(D_NORMAL) printk(VERSION);
-	return pci_module_init(&com20020pci_driver);
+	return pci_register_driver(&com20020pci_driver);
 }
 
 static void __exit com20020pci_cleanup(void)
diff -Narup a/drivers/net/b44.c b/drivers/net/b44.c
--- a/drivers/net/b44.c	2005-11-29 11:08:54.000000000 +0100
+++ b/drivers/net/b44.c	2005-11-29 19:05:59.000000000 +0100
@@ -2133,7 +2133,7 @@ static int __init b44_init(void)
 	dma_desc_align_mask = ~(dma_desc_align_size - 1);
 	dma_desc_sync_size = max(dma_desc_align_size, sizeof(struct dma_desc));
 
-	return pci_module_init(&b44_driver);
+	return pci_register_driver(&b44_driver);
 }
 
 static void __exit b44_cleanup(void)
diff -Narup a/drivers/net/bnx2.c b/drivers/net/bnx2.c
--- a/drivers/net/bnx2.c	2005-11-29 11:08:54.000000000 +0100
+++ b/drivers/net/bnx2.c	2005-11-29 19:05:57.000000000 +0100
@@ -5849,7 +5849,7 @@ static struct pci_driver bnx2_pci_driver
 
 static int __init bnx2_init(void)
 {
-	return pci_module_init(&bnx2_pci_driver);
+	return pci_register_driver(&bnx2_pci_driver);
 }
 
 static void __exit bnx2_cleanup(void)
diff -Narup a/drivers/net/cassini.c b/drivers/net/cassini.c
--- a/drivers/net/cassini.c	2005-11-29 11:08:54.000000000 +0100
+++ b/drivers/net/cassini.c	2005-11-29 19:05:58.000000000 +0100
@@ -5224,7 +5224,7 @@ static int __init cas_init(void)
 	else
 		link_transition_timeout = 0;
 
-	return pci_module_init(&cas_driver);
+	return pci_register_driver(&cas_driver);
 }
 
 static void __exit cas_cleanup(void)
diff -Narup a/drivers/net/chelsio/cxgb2.c b/drivers/net/chelsio/cxgb2.c
--- a/drivers/net/chelsio/cxgb2.c	2005-11-29 11:05:02.000000000 +0100
+++ b/drivers/net/chelsio/cxgb2.c	2005-11-29 19:05:58.000000000 +0100
@@ -1244,7 +1244,7 @@ static struct pci_driver driver = {
 
 static int __init t1_init_module(void)
 {
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit t1_cleanup_module(void)
diff -Narup a/drivers/net/defxx.c b/drivers/net/defxx.c
--- a/drivers/net/defxx.c	2005-11-29 11:05:05.000000000 +0100
+++ b/drivers/net/defxx.c	2005-11-29 19:06:01.000000000 +0100
@@ -3444,7 +3444,7 @@ static int __init dfx_init(void)
 {
 	int rc_pci, rc_eisa;
 
-	rc_pci = pci_module_init(&dfx_driver);
+	rc_pci = pci_register_driver(&dfx_driver);
 	if (rc_pci >= 0) dfx_have_pci = 1;
 	
 	rc_eisa = dfx_eisa_init();
diff -Narup a/drivers/net/dl2k.c b/drivers/net/dl2k.c
--- a/drivers/net/dl2k.c	2005-11-29 11:05:07.000000000 +0100
+++ b/drivers/net/dl2k.c	2005-11-29 19:06:02.000000000 +0100
@@ -1848,7 +1848,7 @@ static struct pci_driver rio_driver = {
 static int __init
 rio_init (void)
 {
-	return pci_module_init (&rio_driver);
+	return pci_register_driver (&rio_driver);
 }
 
 static void __exit
diff -Narup a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c	2005-11-29 11:08:54.000000000 +0100
+++ b/drivers/net/e1000/e1000_main.c	2005-11-29 19:05:58.000000000 +0100
@@ -247,7 +247,7 @@ e1000_init_module(void)
 
 	printk(KERN_INFO "%s\n", e1000_copyright);
 
-	ret = pci_module_init(&e1000_driver);
+	ret = pci_register_driver(&e1000_driver);
 
 	return ret;
 }
diff -Narup a/drivers/net/e100.c b/drivers/net/e100.c
--- a/drivers/net/e100.c	2005-11-29 11:08:54.000000000 +0100
+++ b/drivers/net/e100.c	2005-11-29 19:05:58.000000000 +0100
@@ -2722,7 +2722,7 @@ static int __init e100_init_module(void)
 		printk(KERN_INFO PFX "%s, %s\n", DRV_DESCRIPTION, DRV_VERSION);
 		printk(KERN_INFO PFX "%s\n", DRV_COPYRIGHT);
 	}
-	return pci_module_init(&e100_driver);
+	return pci_register_driver(&e100_driver);
 }
 
 static void __exit e100_cleanup_module(void)
diff -Narup a/drivers/net/eepro100.c b/drivers/net/eepro100.c
--- a/drivers/net/eepro100.c	2005-11-29 11:05:04.000000000 +0100
+++ b/drivers/net/eepro100.c	2005-11-29 19:06:01.000000000 +0100
@@ -2391,7 +2391,7 @@ static int __init eepro100_init_module(v
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&eepro100_driver);
+	return pci_register_driver(&eepro100_driver);
 }
 
 static void __exit eepro100_cleanup_module(void)
diff -Narup a/drivers/net/epic100.c b/drivers/net/epic100.c
--- a/drivers/net/epic100.c	2005-11-29 11:08:54.000000000 +0100
+++ b/drivers/net/epic100.c	2005-11-29 19:06:01.000000000 +0100
@@ -1673,7 +1673,7 @@ static int __init epic_init (void)
 		version, version2, version3);
 #endif
 
-	return pci_module_init (&epic_driver);
+	return pci_register_driver (&epic_driver);
 }
 
 
diff -Narup a/drivers/net/fealnx.c b/drivers/net/fealnx.c
--- a/drivers/net/fealnx.c	2005-11-29 11:05:07.000000000 +0100
+++ b/drivers/net/fealnx.c	2005-11-29 19:06:01.000000000 +0100
@@ -1992,7 +1992,7 @@ static int __init fealnx_init(void)
 	printk(version);
 #endif
 
-	return pci_module_init(&fealnx_driver);
+	return pci_register_driver(&fealnx_driver);
 }
 
 static void __exit fealnx_exit(void)
diff -Narup a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
--- a/drivers/net/forcedeth.c	2005-11-29 11:08:54.000000000 +0100
+++ b/drivers/net/forcedeth.c	2005-11-29 19:05:59.000000000 +0100
@@ -2720,7 +2720,7 @@ static struct pci_driver driver = {
 static int __init init_nic(void)
 {
 	printk(KERN_INFO "forcedeth.c: Reverse Engineered nForce ethernet driver. Version %s.\n", FORCEDETH_VERSION);
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit exit_nic(void)
diff -Narup a/drivers/net/hp100.c b/drivers/net/hp100.c
--- a/drivers/net/hp100.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/hp100.c	2005-11-29 19:05:58.000000000 +0100
@@ -3048,7 +3048,7 @@ static int __init hp100_module_init(void
 		goto out2;
 #endif
 #ifdef CONFIG_PCI
-	err = pci_module_init(&hp100_pci_driver);
+	err = pci_register_driver(&hp100_pci_driver);
 	if (err && err != -ENODEV) 
 		goto out3;
 #endif
diff -Narup a/drivers/net/irda/donauboe.c b/drivers/net/irda/donauboe.c
--- a/drivers/net/irda/donauboe.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/irda/donauboe.c	2005-11-29 19:05:57.000000000 +0100
@@ -1778,7 +1778,7 @@ static struct pci_driver donauboe_pci_dr
 static int __init
 donauboe_init (void)
 {
-  return pci_module_init(&donauboe_pci_driver);
+  return pci_register_driver(&donauboe_pci_driver);
 }
 
 static void __exit
diff -Narup a/drivers/net/irda/vlsi_ir.c b/drivers/net/irda/vlsi_ir.c
--- a/drivers/net/irda/vlsi_ir.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/irda/vlsi_ir.c	2005-11-29 19:05:57.000000000 +0100
@@ -1887,7 +1887,7 @@ static int __init vlsi_mod_init(void)
 		vlsi_proc_root->owner = THIS_MODULE;
 	}
 
-	ret = pci_module_init(&vlsi_irda_driver);
+	ret = pci_register_driver(&vlsi_irda_driver);
 
 	if (ret && vlsi_proc_root)
 		remove_proc_entry(PROC_DIR, NULL);
diff -Narup a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
--- a/drivers/net/ixgb/ixgb_main.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/ixgb/ixgb_main.c	2005-11-29 19:06:01.000000000 +0100
@@ -171,7 +171,7 @@ ixgb_init_module(void)
 
 	printk(KERN_INFO "%s\n", ixgb_copyright);
 
-	return pci_module_init(&ixgb_driver);
+	return pci_register_driver(&ixgb_driver);
 }
 
 module_init(ixgb_init_module);
diff -Narup a/drivers/net/natsemi.c b/drivers/net/natsemi.c
--- a/drivers/net/natsemi.c	2005-11-29 11:05:06.000000000 +0100
+++ b/drivers/net/natsemi.c	2005-11-29 19:06:01.000000000 +0100
@@ -3260,7 +3260,7 @@ static int __init natsemi_init_mod (void
 	printk(version);
 #endif
 
-	return pci_module_init (&natsemi_driver);
+	return pci_register_driver (&natsemi_driver);
 }
 
 static void __exit natsemi_exit_mod (void)
diff -Narup a/drivers/net/ne2k-pci.c b/drivers/net/ne2k-pci.c
--- a/drivers/net/ne2k-pci.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/ne2k-pci.c	2005-11-29 19:05:59.000000000 +0100
@@ -703,7 +703,7 @@ static int __init ne2k_pci_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&ne2k_driver);
+	return pci_register_driver (&ne2k_driver);
 }
 
 
diff -Narup a/drivers/net/ns83820.c b/drivers/net/ns83820.c
--- a/drivers/net/ns83820.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/ns83820.c	2005-11-29 19:05:58.000000000 +0100
@@ -2175,7 +2175,7 @@ static struct pci_driver driver = {
 static int __init ns83820_init(void)
 {
 	printk(KERN_INFO "ns83820.c: National Semiconductor DP83820 10/100/1000 driver.\n");
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit ns83820_exit(void)
diff -Narup a/drivers/net/pci-skeleton.c b/drivers/net/pci-skeleton.c
--- a/drivers/net/pci-skeleton.c	2005-11-29 11:05:01.000000000 +0100
+++ b/drivers/net/pci-skeleton.c	2005-11-29 19:05:57.000000000 +0100
@@ -1963,7 +1963,7 @@ static int __init netdrv_init_module (vo
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&netdrv_pci_driver);
+	return pci_register_driver (&netdrv_pci_driver);
 }
 
 
diff -Narup a/drivers/net/pcnet32.c b/drivers/net/pcnet32.c
--- a/drivers/net/pcnet32.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/pcnet32.c	2005-11-29 19:05:59.000000000 +0100
@@ -2513,7 +2513,7 @@ static int __init pcnet32_init_module(vo
 	tx_start = tx_start_pt;
 
     /* find the PCI devices */
-    if (!pci_module_init(&pcnet32_driver))
+    if (!pci_register_driver(&pcnet32_driver))
 	pcnet32_have_pci = 1;
 
     /* should we find any remaining VLbus devices ? */
diff -Narup a/drivers/net/r8169.c b/drivers/net/r8169.c
--- a/drivers/net/r8169.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/r8169.c	2005-11-29 19:05:58.000000000 +0100
@@ -2713,7 +2713,7 @@ static struct pci_driver rtl8169_pci_dri
 static int __init
 rtl8169_init_module(void)
 {
-	return pci_module_init(&rtl8169_pci_driver);
+	return pci_register_driver(&rtl8169_pci_driver);
 }
 
 static void __exit
diff -Narup a/drivers/net/rrunner.c b/drivers/net/rrunner.c
--- a/drivers/net/rrunner.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/rrunner.c	2005-11-29 19:06:01.000000000 +0100
@@ -1737,7 +1737,7 @@ static struct pci_driver rr_driver = {
 
 static int __init rr_init_module(void)
 {
-	return pci_module_init(&rr_driver);
+	return pci_register_driver(&rr_driver);
 }
 
 static void __exit rr_cleanup_module(void)
diff -Narup a/drivers/net/s2io.c b/drivers/net/s2io.c
--- a/drivers/net/s2io.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/s2io.c	2005-11-29 19:06:00.000000000 +0100
@@ -6297,7 +6297,7 @@ static void __devexit s2io_rem_nic(struc
 
 int __init s2io_starter(void)
 {
-	return pci_module_init(&s2io_driver);
+	return pci_register_driver(&s2io_driver);
 }
 
 /**
diff -Narup a/drivers/net/saa9730.c b/drivers/net/saa9730.c
--- a/drivers/net/saa9730.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/saa9730.c	2005-11-29 19:06:00.000000000 +0100
@@ -1131,7 +1131,7 @@ static struct pci_driver saa9730_driver 
 
 static int __init saa9730_init(void)
 {
-	return pci_module_init(&saa9730_driver);
+	return pci_register_driver(&saa9730_driver);
 }
 
 static void __exit saa9730_cleanup(void)
diff -Narup a/drivers/net/sis190.c b/drivers/net/sis190.c
--- a/drivers/net/sis190.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/sis190.c	2005-11-29 19:05:57.000000000 +0100
@@ -1872,7 +1872,7 @@ static struct pci_driver sis190_pci_driv
 
 static int __init sis190_init_module(void)
 {
-	return pci_module_init(&sis190_pci_driver);
+	return pci_register_driver(&sis190_pci_driver);
 }
 
 static void __exit sis190_cleanup_module(void)
diff -Narup a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/sis900.c	2005-11-29 19:05:58.000000000 +0100
@@ -2410,7 +2410,7 @@ static int __init sis900_init_module(voi
 	printk(version);
 #endif
 
-	return pci_module_init(&sis900_pci_driver);
+	return pci_register_driver(&sis900_pci_driver);
 }
 
 static void __exit sis900_cleanup_module(void)
diff -Narup a/drivers/net/skfp/skfddi.c b/drivers/net/skfp/skfddi.c
--- a/drivers/net/skfp/skfddi.c	2005-11-29 11:05:02.000000000 +0100
+++ b/drivers/net/skfp/skfddi.c	2005-11-29 19:05:58.000000000 +0100
@@ -2280,7 +2280,7 @@ static struct pci_driver skfddi_pci_driv
 
 static int __init skfd_init(void)
 {
-	return pci_module_init(&skfddi_pci_driver);
+	return pci_register_driver(&skfddi_pci_driver);
 }
 
 static void __exit skfd_exit(void)
diff -Narup a/drivers/net/skge.c b/drivers/net/skge.c
--- a/drivers/net/skge.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/skge.c	2005-11-29 19:05:59.000000000 +0100
@@ -3419,7 +3419,7 @@ static struct pci_driver skge_driver = {
 
 static int __init skge_init_module(void)
 {
-	return pci_module_init(&skge_driver);
+	return pci_register_driver(&skge_driver);
 }
 
 static void __exit skge_cleanup_module(void)
diff -Narup a/drivers/net/starfire.c b/drivers/net/starfire.c
--- a/drivers/net/starfire.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/starfire.c	2005-11-29 19:06:01.000000000 +0100
@@ -2137,7 +2137,7 @@ static int __init starfire_init (void)
 		return -ENODEV;
 	}
 
-	return pci_module_init (&starfire_driver);
+	return pci_register_driver (&starfire_driver);
 }
 
 
diff -Narup a/drivers/net/sundance.c b/drivers/net/sundance.c
--- a/drivers/net/sundance.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/sundance.c	2005-11-29 19:06:01.000000000 +0100
@@ -1806,7 +1806,7 @@ static int __init sundance_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&sundance_driver);
+	return pci_register_driver(&sundance_driver);
 }
 
 static void __exit sundance_exit(void)
diff -Narup a/drivers/net/sungem.c b/drivers/net/sungem.c
--- a/drivers/net/sungem.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/sungem.c	2005-11-29 19:05:58.000000000 +0100
@@ -3190,7 +3190,7 @@ static struct pci_driver gem_driver = {
 
 static int __init gem_init(void)
 {
-	return pci_module_init(&gem_driver);
+	return pci_register_driver(&gem_driver);
 }
 
 static void __exit gem_cleanup(void)
diff -Narup a/drivers/net/tc35815.c b/drivers/net/tc35815.c
--- a/drivers/net/tc35815.c	2005-11-29 11:05:03.000000000 +0100
+++ b/drivers/net/tc35815.c	2005-11-29 19:05:59.000000000 +0100
@@ -1725,7 +1725,7 @@ static struct pci_driver tc35815_driver 
 
 static int __init tc35815_init_module(void)
 {
-	return pci_module_init(&tc35815_driver);
+	return pci_register_driver(&tc35815_driver);
 }
 
 static void __exit tc35815_cleanup_module(void)
diff -Narup a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/tg3.c	2005-11-29 19:06:01.000000000 +0100
@@ -10879,7 +10879,7 @@ static struct pci_driver tg3_driver = {
 
 static int __init tg3_init(void)
 {
-	return pci_module_init(&tg3_driver);
+	return pci_register_driver(&tg3_driver);
 }
 
 static void __exit tg3_cleanup(void)
diff -Narup a/drivers/net/tokenring/3c359.c b/drivers/net/tokenring/3c359.c
--- a/drivers/net/tokenring/3c359.c	2005-11-29 11:05:07.000000000 +0100
+++ b/drivers/net/tokenring/3c359.c	2005-11-29 19:06:02.000000000 +0100
@@ -1816,7 +1816,7 @@ static struct pci_driver xl_3c359_driver
 
 static int __init xl_pci_init (void)
 {
-	return pci_module_init (&xl_3c359_driver);
+	return pci_register_driver (&xl_3c359_driver);
 }
 
 
diff -Narup a/drivers/net/tokenring/lanstreamer.c b/drivers/net/tokenring/lanstreamer.c
--- a/drivers/net/tokenring/lanstreamer.c	2005-11-29 11:05:07.000000000 +0100
+++ b/drivers/net/tokenring/lanstreamer.c	2005-11-29 19:06:02.000000000 +0100
@@ -1998,7 +1998,7 @@ static struct pci_driver streamer_pci_dr
 };
 
 static int __init streamer_init_module(void) {
-  return pci_module_init(&streamer_pci_driver);
+  return pci_register_driver(&streamer_pci_driver);
 }
 
 static void __exit streamer_cleanup_module(void) {
diff -Narup a/drivers/net/tokenring/olympic.c b/drivers/net/tokenring/olympic.c
--- a/drivers/net/tokenring/olympic.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/tokenring/olympic.c	2005-11-29 19:06:02.000000000 +0100
@@ -1771,7 +1771,7 @@ static struct pci_driver olympic_driver 
 
 static int __init olympic_pci_init(void) 
 {
-	return pci_module_init (&olympic_driver) ; 
+	return pci_register_driver (&olympic_driver) ; 
 }
 
 static void __exit olympic_pci_cleanup(void)
diff -Narup a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
--- a/drivers/net/tulip/de2104x.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/tulip/de2104x.c	2005-11-29 19:06:00.000000000 +0100
@@ -2178,7 +2178,7 @@ static int __init de_init (void)
 #ifdef MODULE
 	printk("%s", version);
 #endif
-	return pci_module_init (&de_driver);
+	return pci_register_driver (&de_driver);
 }
 
 static void __exit de_exit (void)
diff -Narup a/drivers/net/tulip/de4x5.c b/drivers/net/tulip/de4x5.c
--- a/drivers/net/tulip/de4x5.c	2005-11-29 11:05:04.000000000 +0100
+++ b/drivers/net/tulip/de4x5.c	2005-11-29 19:06:00.000000000 +0100
@@ -5755,7 +5755,7 @@ static int __init de4x5_module_init (voi
 	int err = 0;
 
 #ifdef CONFIG_PCI
-	err = pci_module_init (&de4x5_pci_driver);
+	err = pci_register_driver (&de4x5_pci_driver);
 #endif
 #ifdef CONFIG_EISA
 	err |= eisa_driver_register (&de4x5_eisa_driver);
diff -Narup a/drivers/net/tulip/dmfe.c b/drivers/net/tulip/dmfe.c
--- a/drivers/net/tulip/dmfe.c	2005-11-29 11:05:04.000000000 +0100
+++ b/drivers/net/tulip/dmfe.c	2005-11-29 19:06:01.000000000 +0100
@@ -2039,7 +2039,7 @@ static int __init dmfe_init_module(void)
 	if (HPNA_NoiseFloor > 15)
 		HPNA_NoiseFloor = 0;
 
-	rc = pci_module_init(&dmfe_driver);
+	rc = pci_register_driver(&dmfe_driver);
 	if (rc < 0)
 		return rc;
 
diff -Narup a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
--- a/drivers/net/tulip/tulip_core.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/tulip/tulip_core.c	2005-11-29 19:06:00.000000000 +0100
@@ -1854,7 +1854,7 @@ static int __init tulip_init (void)
 	tulip_max_interrupt_work = max_interrupt_work;
 
 	/* probe for and init boards */
-	return pci_module_init (&tulip_driver);
+	return pci_register_driver (&tulip_driver);
 }
 
 
diff -Narup a/drivers/net/tulip/uli526x.c b/drivers/net/tulip/uli526x.c
--- a/drivers/net/tulip/uli526x.c	2005-11-29 11:05:04.000000000 +0100
+++ b/drivers/net/tulip/uli526x.c	2005-11-29 19:06:00.000000000 +0100
@@ -1725,7 +1725,7 @@ static int __init uli526x_init_module(vo
 		break;
 	}
 
-	rc = pci_module_init(&uli526x_driver);
+	rc = pci_register_driver(&uli526x_driver);
 	if (rc < 0)
 		return rc;
 
diff -Narup a/drivers/net/tulip/winbond-840.c b/drivers/net/tulip/winbond-840.c
--- a/drivers/net/tulip/winbond-840.c	2005-11-29 11:05:04.000000000 +0100
+++ b/drivers/net/tulip/winbond-840.c	2005-11-29 19:06:00.000000000 +0100
@@ -1705,7 +1705,7 @@ static struct pci_driver w840_driver = {
 static int __init w840_init(void)
 {
 	printk(version);
-	return pci_module_init(&w840_driver);
+	return pci_register_driver(&w840_driver);
 }
 
 static void __exit w840_exit(void)
diff -Narup a/drivers/net/tulip/xircom_tulip_cb.c b/drivers/net/tulip/xircom_tulip_cb.c
--- a/drivers/net/tulip/xircom_tulip_cb.c	2005-11-29 11:05:04.000000000 +0100
+++ b/drivers/net/tulip/xircom_tulip_cb.c	2005-11-29 19:06:01.000000000 +0100
@@ -1727,7 +1727,7 @@ static int __init xircom_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&xircom_driver);
+	return pci_register_driver(&xircom_driver);
 }
 
 
diff -Narup a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/typhoon.c	2005-11-29 19:06:02.000000000 +0100
@@ -2659,7 +2659,7 @@ static struct pci_driver typhoon_driver 
 static int __init
 typhoon_init(void)
 {
-	return pci_module_init(&typhoon_driver);
+	return pci_register_driver(&typhoon_driver);
 }
 
 static void __exit
diff -Narup a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/via-rhine.c	2005-11-29 19:05:59.000000000 +0100
@@ -2049,7 +2049,7 @@ static int __init rhine_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&rhine_driver);
+	return pci_register_driver(&rhine_driver);
 }
 
 
diff -Narup a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
--- a/drivers/net/via-velocity.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/via-velocity.c	2005-11-29 19:05:58.000000000 +0100
@@ -2241,7 +2241,7 @@ static int __init velocity_init_module(v
 	int ret;
 
 	velocity_register_notifier();
-	ret = pci_module_init(&velocity_driver);
+	ret = pci_register_driver(&velocity_driver);
 	if (ret < 0)
 		velocity_unregister_notifier();
 	return ret;
diff -Narup a/drivers/net/wan/dscc4.c b/drivers/net/wan/dscc4.c
--- a/drivers/net/wan/dscc4.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/wan/dscc4.c	2005-11-29 19:05:59.000000000 +0100
@@ -2061,7 +2061,7 @@ static struct pci_driver dscc4_driver = 
 
 static int __init dscc4_init_module(void)
 {
-	return pci_module_init(&dscc4_driver);
+	return pci_register_driver(&dscc4_driver);
 }
 
 static void __exit dscc4_cleanup_module(void)
diff -Narup a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
--- a/drivers/net/wan/farsync.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/wan/farsync.c	2005-11-29 19:05:59.000000000 +0100
@@ -2697,7 +2697,7 @@ fst_init(void)
 	for (i = 0; i < FST_MAX_CARDS; i++)
 		fst_card_array[i] = NULL;
 	spin_lock_init(&fst_work_q_lock);
-	return pci_module_init(&fst_driver);
+	return pci_register_driver(&fst_driver);
 }
 
 static void __exit
diff -Narup a/drivers/net/wan/lmc/lmc_main.c b/drivers/net/wan/lmc/lmc_main.c
--- a/drivers/net/wan/lmc/lmc_main.c	2005-11-29 11:05:03.000000000 +0100
+++ b/drivers/net/wan/lmc/lmc_main.c	2005-11-29 19:05:59.000000000 +0100
@@ -1790,7 +1790,7 @@ static struct pci_driver lmc_driver = {
 
 static int __init init_lmc(void)
 {
-    return pci_module_init(&lmc_driver);
+    return pci_register_driver(&lmc_driver);
 }
 
 static void __exit exit_lmc(void)
diff -Narup a/drivers/net/wan/pc300_drv.c b/drivers/net/wan/pc300_drv.c
--- a/drivers/net/wan/pc300_drv.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/wan/pc300_drv.c	2005-11-29 19:05:59.000000000 +0100
@@ -3677,7 +3677,7 @@ static struct pci_driver cpc_driver = {
 
 static int __init cpc_init(void)
 {
-	return pci_module_init(&cpc_driver);
+	return pci_register_driver(&cpc_driver);
 }
 
 static void __exit cpc_cleanup_module(void)
diff -Narup a/drivers/net/wan/pci200syn.c b/drivers/net/wan/pci200syn.c
--- a/drivers/net/wan/pci200syn.c	2005-11-29 11:05:03.000000000 +0100
+++ b/drivers/net/wan/pci200syn.c	2005-11-29 19:05:59.000000000 +0100
@@ -468,7 +468,7 @@ static int __init pci200_init_module(voi
 		printk(KERN_ERR "pci200syn: Invalid PCI clock frequency\n");
 		return -EINVAL;
 	}
-	return pci_module_init(&pci200_pci_driver);
+	return pci_register_driver(&pci200_pci_driver);
 }
 
 
diff -Narup a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
--- a/drivers/net/wan/wanxl.c	2005-11-29 11:05:03.000000000 +0100
+++ b/drivers/net/wan/wanxl.c	2005-11-29 19:05:59.000000000 +0100
@@ -822,7 +822,7 @@ static int __init wanxl_init_module(void
 #ifdef MODULE
 	printk(KERN_INFO "%s\n", version);
 #endif
-	return pci_module_init(&wanxl_pci_driver);
+	return pci_register_driver(&wanxl_pci_driver);
 }
 
 static void __exit wanxl_cleanup_module(void)
diff -Narup a/drivers/net/wireless/atmel_pci.c b/drivers/net/wireless/atmel_pci.c
--- a/drivers/net/wireless/atmel_pci.c	2005-11-29 11:08:55.000000000 +0100
+++ b/drivers/net/wireless/atmel_pci.c	2005-11-29 19:06:00.000000000 +0100
@@ -77,7 +77,7 @@ static void __devexit atmel_pci_remove(s
 
 static int __init atmel_init_module(void)
 {
-	return pci_module_init(&atmel_driver);
+	return pci_register_driver(&atmel_driver);
 }
 
 static void __exit atmel_cleanup_module(void)
diff -Narup a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
--- a/drivers/net/wireless/ipw2100.c	2005-11-29 11:08:56.000000000 +0100
+++ b/drivers/net/wireless/ipw2100.c	2005-11-29 19:06:00.000000000 +0100
@@ -6856,7 +6856,7 @@ static int __init ipw2100_init(void)
 	printk(KERN_INFO DRV_NAME ": %s, %s\n", DRV_DESCRIPTION, DRV_VERSION);
 	printk(KERN_INFO DRV_NAME ": %s\n", DRV_COPYRIGHT);
 
-	ret = pci_module_init(&ipw2100_pci_driver);
+	ret = pci_register_driver(&ipw2100_pci_driver);
 
 #ifdef CONFIG_IPW_DEBUG
 	ipw2100_debug_level = debug;
diff -Narup a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
--- a/drivers/net/wireless/ipw2200.c	2005-11-29 11:08:56.000000000 +0100
+++ b/drivers/net/wireless/ipw2200.c	2005-11-29 19:06:00.000000000 +0100
@@ -11221,7 +11221,7 @@ static int __init ipw_init(void)
 	printk(KERN_INFO DRV_NAME ": " DRV_DESCRIPTION ", " DRV_VERSION "\n");
 	printk(KERN_INFO DRV_NAME ": " DRV_COPYRIGHT "\n");
 
-	ret = pci_module_init(&ipw_driver);
+	ret = pci_register_driver(&ipw_driver);
 	if (ret) {
 		IPW_ERROR("Unable to initialize PCI module\n");
 		return ret;
diff -Narup a/drivers/net/wireless/orinoco_nortel.c b/drivers/net/wireless/orinoco_nortel.c
--- a/drivers/net/wireless/orinoco_nortel.c	2005-11-29 11:08:56.000000000 +0100
+++ b/drivers/net/wireless/orinoco_nortel.c	2005-11-29 19:06:00.000000000 +0100
@@ -287,7 +287,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init nortel_pci_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&nortel_pci_driver);
+	return pci_register_driver(&nortel_pci_driver);
 }
 
 static void __exit nortel_pci_exit(void)
diff -Narup a/drivers/net/wireless/orinoco_pci.c b/drivers/net/wireless/orinoco_pci.c
--- a/drivers/net/wireless/orinoco_pci.c	2005-11-29 11:08:56.000000000 +0100
+++ b/drivers/net/wireless/orinoco_pci.c	2005-11-29 19:06:00.000000000 +0100
@@ -379,7 +379,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_pci_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_pci_driver);
+	return pci_register_driver(&orinoco_pci_driver);
 }
 
 static void __exit orinoco_pci_exit(void)
diff -Narup a/drivers/net/wireless/orinoco_plx.c b/drivers/net/wireless/orinoco_plx.c
--- a/drivers/net/wireless/orinoco_plx.c	2005-11-29 11:08:56.000000000 +0100
+++ b/drivers/net/wireless/orinoco_plx.c	2005-11-29 19:06:00.000000000 +0100
@@ -382,7 +382,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_plx_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_plx_driver);
+	return pci_register_driver(&orinoco_plx_driver);
 }
 
 static void __exit orinoco_plx_exit(void)
diff -Narup a/drivers/net/wireless/orinoco_tmd.c b/drivers/net/wireless/orinoco_tmd.c
--- a/drivers/net/wireless/orinoco_tmd.c	2005-11-29 11:08:56.000000000 +0100
+++ b/drivers/net/wireless/orinoco_tmd.c	2005-11-29 19:06:00.000000000 +0100
@@ -239,7 +239,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_tmd_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_tmd_driver);
+	return pci_register_driver(&orinoco_tmd_driver);
 }
 
 static void __exit orinoco_tmd_exit(void)
diff -Narup a/drivers/net/wireless/prism54/islpci_hotplug.c b/drivers/net/wireless/prism54/islpci_hotplug.c
--- a/drivers/net/wireless/prism54/islpci_hotplug.c	2005-11-29 11:08:56.000000000 +0100
+++ b/drivers/net/wireless/prism54/islpci_hotplug.c	2005-11-29 19:06:00.000000000 +0100
@@ -312,7 +312,7 @@ prism54_module_init(void)
 
 	__bug_on_wrong_struct_sizes ();
 
-	return pci_module_init(&prism54_driver);
+	return pci_register_driver(&prism54_driver);
 }
 
 /* by the time prism54_module_exit() terminates, as a postcondition
diff -Narup a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
--- a/drivers/net/yellowfin.c	2005-11-29 11:05:04.000000000 +0100
+++ b/drivers/net/yellowfin.c	2005-11-29 19:05:59.000000000 +0100
@@ -1474,7 +1474,7 @@ static int __init yellowfin_init (void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&yellowfin_driver);
+	return pci_register_driver (&yellowfin_driver);
 }
 
 
