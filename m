Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVLCP6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVLCP6x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVLCP5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:57:22 -0500
Received: from covilha.procergs.com.br ([200.198.128.244]:45773 "EHLO
	covilha.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751289AbVLCP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:57:17 -0500
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH 9/11] MEDIA: replace all uses of pci_module_init with pci_register_driver
In-Reply-To: <11336254301475-git-send-email-otavio@debian.org>
X-Mailer: git-send-email
Date: Sat, 3 Dec 2005 13:57:10 -0200
Message-Id: <11336254301170-git-send-email-otavio@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Otavio Salvador <otavio@debian.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Otavio Salvador <otavio@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace all calls to pci_module_init, that's deprecated and
will be removed in future, with pci_register_driver that should be
the used function now.

Signed-off-by: Otavio Salvador <otavio@debian.org>


---

 drivers/media/radio/radio-gemtek-pci.c     |    2 +-
 drivers/media/radio/radio-maxiradio.c      |    2 +-
 drivers/media/video/bttv-driver.c          |    2 +-
 drivers/media/video/saa7134/saa7134-core.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

applies-to: f72516fc599b70f5507e6cf69b256b0da72b3646
fc3bbed930173e0784960f17cf67c229e652f6a0
diff --git a/drivers/media/radio/radio-gemtek-pci.c b/drivers/media/radio/radio-gemtek-pci.c
index 630cc78..78b2888 100644
--- a/drivers/media/radio/radio-gemtek-pci.c
+++ b/drivers/media/radio/radio-gemtek-pci.c
@@ -394,7 +394,7 @@ static struct pci_driver gemtek_pci_driv
 
 static int __init gemtek_pci_init_module( void )
 {
-	return pci_module_init( &gemtek_pci_driver );
+	return pci_register_driver( &gemtek_pci_driver );
 }
 
 static void __exit gemtek_pci_cleanup_module( void )
diff --git a/drivers/media/radio/radio-maxiradio.c b/drivers/media/radio/radio-maxiradio.c
index 02d39a5..7b33d8f 100644
--- a/drivers/media/radio/radio-maxiradio.c
+++ b/drivers/media/radio/radio-maxiradio.c
@@ -337,7 +337,7 @@ static struct pci_driver maxiradio_drive
 
 static int __init maxiradio_radio_init(void)
 {
-	return pci_module_init(&maxiradio_driver);
+	return pci_register_driver(&maxiradio_driver);
 }
 
 static void __exit maxiradio_radio_exit(void)
diff --git a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
index 3c58a2a..cfb720d 100644
--- a/drivers/media/video/bttv-driver.c
+++ b/drivers/media/video/bttv-driver.c
@@ -4253,7 +4253,7 @@ static int bttv_init_module(void)
 	bttv_check_chipset();
 
 	bus_register(&bttv_sub_bus_type);
-	return pci_module_init(&bttv_pci_driver);
+	return pci_register_driver(&bttv_pci_driver);
 }
 
 static void bttv_cleanup_module(void)
diff --git a/drivers/media/video/saa7134/saa7134-core.c b/drivers/media/video/saa7134/saa7134-core.c
index 1a093bf..18aa5d4 100644
--- a/drivers/media/video/saa7134/saa7134-core.c
+++ b/drivers/media/video/saa7134/saa7134-core.c
@@ -1155,7 +1155,7 @@ static int saa7134_init(void)
 	printk(KERN_INFO "saa7130/34: snapshot date %04d-%02d-%02d\n",
 	       SNAPSHOT/10000, (SNAPSHOT/100)%100, SNAPSHOT%100);
 #endif
-	return pci_module_init(&saa7134_pci_driver);
+	return pci_register_driver(&saa7134_pci_driver);
 }
 
 static void saa7134_fini(void)
---
0.99.9k


