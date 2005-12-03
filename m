Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVLCP6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVLCP6x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVLCP5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:57:23 -0500
Received: from aveiro.procergs.com.br ([200.198.128.42]:55222 "EHLO
	aveiro.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751294AbVLCP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:57:17 -0500
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH 8/11] BLOCK: replace all uses of pci_module_init with pci_register_driver
In-Reply-To: <11336254303385-git-send-email-otavio@debian.org>
X-Mailer: git-send-email
Date: Sat, 3 Dec 2005 13:57:10 -0200
Message-Id: <11336254301475-git-send-email-otavio@debian.org>
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

 drivers/block/DAC960.c |    2 +-
 drivers/block/cciss.c  |    2 +-
 drivers/block/sx8.c    |    2 +-
 drivers/block/umem.c   |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

applies-to: 9ec2473b134892f141036a7e662282e3db3f15bd
c29562485d55591caa1cbf5eebd5ffb758eb6eb8
diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index 70eaa5c..fe044ee 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -7186,7 +7186,7 @@ static int DAC960_init_module(void)
 {
 	int ret;
 
-	ret =  pci_module_init(&DAC960_pci_driver);
+	ret =  pci_register_driver(&DAC960_pci_driver);
 #ifdef DAC960_GAM_MINOR
 	if (!ret)
 		DAC960_gam_init();
diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index a9e33db..1119a4d 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -3275,7 +3275,7 @@ static int __init cciss_init(void)
 	printk(KERN_INFO DRIVER_NAME "\n");
 
 	/* Register for our PCI devices */
-	return pci_module_init(&cciss_pci_driver);
+	return pci_register_driver(&cciss_pci_driver);
 }
 
 static void __exit cciss_cleanup(void)
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 1ded3b4..d0cafcf 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1774,7 +1774,7 @@ static void carm_remove_one (struct pci_
 
 static int __init carm_init(void)
 {
-	return pci_module_init(&carm_driver);
+	return pci_register_driver(&carm_driver);
 }
 
 static void __exit carm_exit(void)
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 0f48301..f5fd4f5 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -1185,7 +1185,7 @@ static int __init mm_init(void)
 
 	printk(KERN_INFO DRIVER_VERSION " : " DRIVER_DESC "\n");
 
-	retval = pci_module_init(&mm_pci_driver);
+	retval = pci_register_driver(&mm_pci_driver);
 	if (retval)
 		return -ENOMEM;
 
---
0.99.9k


