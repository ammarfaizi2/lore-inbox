Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbVK2X7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbVK2X7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVK2X7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:59:37 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:29635 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751412AbVK2X7g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:59:36 -0500
Date: Wed, 30 Nov 2005 00:59:34 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: linux-kernel@vger.kernel.org
Cc: Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051130000445.1009.27295.sendpatchset@thinktank.campus.ltu.se>
In-Reply-To: <20051130000425.1009.94647.sendpatchset@thinktank.campus.ltu.se>
References: <20051130000425.1009.94647.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 2/6] drivers/block: Replace pci_module_init() with pci_register_driver()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Replace obsolete pci_module_init() with pci_register_driver().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 block/DAC960.c                     |    2 +-
 block/cciss.c                      |    2 +-
 block/sx8.c                        |    2 +-
 block/umem.c                       |    2 +-
 media/radio/radio-gemtek-pci.c     |    2 +-
 media/radio/radio-maxiradio.c      |    2 +-
 media/video/bttv-driver.c          |    2 +-
 media/video/saa7134/saa7134-core.c |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff -Narup a/drivers/block/cciss.c b/drivers/block/cciss.c
--- a/drivers/block/cciss.c	2005-11-29 11:08:50.000000000 +0100
+++ b/drivers/block/cciss.c	2005-11-29 16:42:41.000000000 +0100
@@ -3275,7 +3275,7 @@ static int __init cciss_init(void)
 	printk(KERN_INFO DRIVER_NAME "\n");
 
 	/* Register for our PCI devices */
-	return pci_module_init(&cciss_pci_driver);
+	return pci_register_driver(&cciss_pci_driver);
 }
 
 static void __exit cciss_cleanup(void)
diff -Narup a/drivers/block/DAC960.c b/drivers/block/DAC960.c
--- a/drivers/block/DAC960.c	2005-11-29 11:08:50.000000000 +0100
+++ b/drivers/block/DAC960.c	2005-11-29 16:37:11.000000000 +0100
@@ -7186,7 +7186,7 @@ static int DAC960_init_module(void)
 {
 	int ret;
 
-	ret =  pci_module_init(&DAC960_pci_driver);
+	ret =  pci_register_driver(&DAC960_pci_driver);
 #ifdef DAC960_GAM_MINOR
 	if (!ret)
 		DAC960_gam_init();
diff -Narup a/drivers/block/sx8.c b/drivers/block/sx8.c
--- a/drivers/block/sx8.c	2005-11-29 11:08:50.000000000 +0100
+++ b/drivers/block/sx8.c	2005-11-29 16:43:57.000000000 +0100
@@ -1774,7 +1774,7 @@ static void carm_remove_one (struct pci_
 
 static int __init carm_init(void)
 {
-	return pci_module_init(&carm_driver);
+	return pci_register_driver(&carm_driver);
 }
 
 static void __exit carm_exit(void)
diff -Narup a/drivers/block/umem.c b/drivers/block/umem.c
--- a/drivers/block/umem.c	2005-11-29 11:04:53.000000000 +0100
+++ b/drivers/block/umem.c	2005-11-29 16:44:47.000000000 +0100
@@ -1185,7 +1185,7 @@ static int __init mm_init(void)
 
 	printk(KERN_INFO DRIVER_VERSION " : " DRIVER_DESC "\n");
 
-	retval = pci_module_init(&mm_pci_driver);
+	retval = pci_register_driver(&mm_pci_driver);
 	if (retval)
 		return -ENOMEM;
 
diff -Narup a/drivers/media/radio/radio-gemtek-pci.c b/drivers/media/radio/radio-gemtek-pci.c
--- a/drivers/media/radio/radio-gemtek-pci.c	2005-11-29 11:05:11.000000000 +0100
+++ b/drivers/media/radio/radio-gemtek-pci.c	2005-11-29 16:51:44.000000000 +0100
@@ -394,7 +394,7 @@ static struct pci_driver gemtek_pci_driv
 
 static int __init gemtek_pci_init_module( void )
 {
-	return pci_module_init( &gemtek_pci_driver );
+	return pci_register_driver( &gemtek_pci_driver );
 }
 
 static void __exit gemtek_pci_cleanup_module( void )
diff -Narup a/drivers/media/radio/radio-maxiradio.c b/drivers/media/radio/radio-maxiradio.c
--- a/drivers/media/radio/radio-maxiradio.c	2005-11-29 11:05:11.000000000 +0100
+++ b/drivers/media/radio/radio-maxiradio.c	2005-11-29 16:52:16.000000000 +0100
@@ -337,7 +337,7 @@ static struct pci_driver maxiradio_drive
 
 static int __init maxiradio_radio_init(void)
 {
-	return pci_module_init(&maxiradio_driver);
+	return pci_register_driver(&maxiradio_driver);
 }
 
 static void __exit maxiradio_radio_exit(void)
diff -Narup a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
--- a/drivers/media/video/bttv-driver.c	2005-11-29 11:08:53.000000000 +0100
+++ b/drivers/media/video/bttv-driver.c	2005-11-29 16:48:41.000000000 +0100
@@ -4220,7 +4220,7 @@ static int bttv_init_module(void)
 	bttv_check_chipset();
 
 	bus_register(&bttv_sub_bus_type);
-	return pci_module_init(&bttv_pci_driver);
+	return pci_register_driver(&bttv_pci_driver);
 }
 
 static void bttv_cleanup_module(void)
diff -Narup a/drivers/media/video/saa7134/saa7134-core.c b/drivers/media/video/saa7134/saa7134-core.c
--- a/drivers/media/video/saa7134/saa7134-core.c	2005-11-29 11:08:53.000000000 +0100
+++ b/drivers/media/video/saa7134/saa7134-core.c	2005-11-29 16:50:37.000000000 +0100
@@ -1144,7 +1144,7 @@ static int saa7134_init(void)
 	printk(KERN_INFO "saa7130/34: snapshot date %04d-%02d-%02d\n",
 	       SNAPSHOT/10000, (SNAPSHOT/100)%100, SNAPSHOT%100);
 #endif
-	return pci_module_init(&saa7134_pci_driver);
+	return pci_register_driver(&saa7134_pci_driver);
 }
 
 static void saa7134_fini(void)
