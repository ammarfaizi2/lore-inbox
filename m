Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284461AbRLPGmj>; Sun, 16 Dec 2001 01:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284470AbRLPGm3>; Sun, 16 Dec 2001 01:42:29 -0500
Received: from m1.cs.man.ac.uk ([130.88.192.2]:8207 "EHLO m1.cs.man.ac.uk")
	by vger.kernel.org with ESMTP id <S284461AbRLPGmQ>;
	Sun, 16 Dec 2001 01:42:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: John Peter Tapsell <tapselj0@cs.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] small binutil patch, kernel 2.4.17-rc1
Date: Sun, 16 Dec 2001 06:41:58 +0000
X-Mailer: KMail [version 1.2]
Cc: marcelo@conectiva.com.br
MIME-Version: 1.0
Message-Id: <01121606415800.09315@eng024>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more fixes with the problem exposed with the new binutils.
It is a simple replace of  __exit  with __devexit in 3 files.

[cc me please]
john.tapsell@cs.man.ac.uk   

-----------------------------

diff -urN linux/drivers/char/synclink.c linux_new/drivers/char/synclink.c
--- linux/drivers/char/synclink.c	Fri Sep 14 22:39:59 2001
+++ linux_new/drivers/char/synclink.c	Sat Dec 15 06:02:42 2001
@@ -926,7 +926,7 @@
 
 static int __init synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
-static void __exit synclink_remove_one (struct pci_dev *dev);
+static void __devexit synclink_remove_one (struct pci_dev *dev);
 
 static struct pci_device_id synclink_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_MICROGATE, PCI_DEVICE_ID_MICROGATE_USC, PCI_ANY_ID, 
PCI_ANY_ID, },
@@ -940,7 +940,7 @@
 	name:		"synclink",
 	id_table:	synclink_pci_tbl,
 	probe:		synclink_init_one,
-	remove:		synclink_remove_one,
+	remove:		__devexit_p(synclink_remove_one),
 };
 
 static struct tty_driver serial_driver, callout_driver;
@@ -8219,7 +8219,7 @@
 	return 0;
 }
 
-static void __exit synclink_remove_one (struct pci_dev *dev)
+static void __devexit synclink_remove_one (struct pci_dev *dev)
 {
 }
 
diff -urN linux/drivers/char/wdt_pci.c linux_new/drivers/char/wdt_pci.c
--- linux/drivers/char/wdt_pci.c	Fri Sep  7 17:28:38 2001
+++ linux_new/drivers/char/wdt_pci.c	Sat Dec 15 06:01:51 2001
@@ -560,7 +560,7 @@
 }
 
 
-static void __exit wdtpci_remove_one (struct pci_dev *pdev)
+static void __devexit wdtpci_remove_one (struct pci_dev *pdev)
 {
 	/* here we assume only one device will ever have
 	 * been picked up and registered by probe function */
@@ -585,7 +585,7 @@
 	name:		"wdt-pci",
 	id_table:	wdtpci_pci_tbl,
 	probe:		wdtpci_init_one,
-	remove:		wdtpci_remove_one,
+	remove:		__devexit_p(wdtpci_remove_one),
 };
 
 
diff -urN linux/drivers/sound/via82cxxx_audio.c 
linux_new/drivers/sound/via82cxxx_audio.c
--- linux/drivers/sound/via82cxxx_audio.c	Sat Dec 15 06:10:01 2001
+++ linux_new/drivers/sound/via82cxxx_audio.c	Sat Dec 15 05:58:07 2001
@@ -365,7 +365,7 @@
 	name:		VIA_MODULE_NAME,
 	id_table:	via_pci_tbl,
 	probe:		via_init_one,
-	remove:		via_remove_one,
+	remove:		__devexit_p(via_remove_one),
 };
 
 
@@ -3271,7 +3271,7 @@
 }
 
 
-static void __exit via_remove_one (struct pci_dev *pdev)
+static void __devexit via_remove_one (struct pci_dev *pdev)
 {
 	struct via_info *card;
 
