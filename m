Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVBOQuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVBOQuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 11:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVBOQux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 11:50:53 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:44745 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261785AbVBOQuP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 11:50:15 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 15 Feb 2005 17:43:09 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] minor bttv driver update
Message-ID: <20050215164309.GA13440@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a new PCI Subsystem ID and a PM fix from Pavel.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/bttv-cards.c  |    4 +++-
 drivers/media/video/bttv-driver.c |    4 ++--
 drivers/media/video/bttv.h        |    2 +-
 drivers/media/video/bttvp.h       |    2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

Index: linux-2.6.11-rc4/drivers/media/video/bttv.h
===================================================================
--- linux-2.6.11-rc4.orig/drivers/media/video/bttv.h	2005-02-14 15:22:19.000000000 +0100
+++ linux-2.6.11-rc4/drivers/media/video/bttv.h	2005-02-15 12:29:56.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: bttv.h,v 1.14 2005/01/07 13:11:19 kraxel Exp $
+ * $Id: bttv.h,v 1.15 2005/01/24 17:37:23 kraxel Exp $
  *
  *  bttv - Bt848 frame grabber driver
  *
Index: linux-2.6.11-rc4/drivers/media/video/bttvp.h
===================================================================
--- linux-2.6.11-rc4.orig/drivers/media/video/bttvp.h	2005-02-14 15:25:54.000000000 +0100
+++ linux-2.6.11-rc4/drivers/media/video/bttvp.h	2005-02-15 12:29:56.000000000 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttvp.h,v 1.15 2004/12/14 15:33:30 kraxel Exp $
+    $Id: bttvp.h,v 1.16 2005/01/24 17:37:23 kraxel Exp $
 
     bttv - Bt848 frame grabber driver
 
Index: linux-2.6.11-rc4/drivers/media/video/bttv-driver.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/media/video/bttv-driver.c	2005-02-14 15:24:27.000000000 +0100
+++ linux-2.6.11-rc4/drivers/media/video/bttv-driver.c	2005-02-15 12:30:02.000000000 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-driver.c,v 1.34 2005/01/07 13:11:19 kraxel Exp $
+    $Id: bttv-driver.c,v 1.36 2005/02/15 10:51:53 kraxel Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -3921,7 +3921,7 @@ static void __devexit bttv_remove(struct
         return;
 }
 
-static int bttv_suspend(struct pci_dev *pci_dev, u32 state)
+static int bttv_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {
         struct bttv *btv = pci_get_drvdata(pci_dev);
 	struct bttv_buffer_set idle;
Index: linux-2.6.11-rc4/drivers/media/video/bttv-cards.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/media/video/bttv-cards.c	2005-02-14 15:23:26.000000000 +0100
+++ linux-2.6.11-rc4/drivers/media/video/bttv-cards.c	2005-02-15 12:29:56.000000000 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-cards.c,v 1.42 2005/01/13 17:22:33 kraxel Exp $
+    $Id: bttv-cards.c,v 1.44 2005/01/31 11:35:05 kraxel Exp $
 
     bttv-cards.c
 
@@ -170,6 +170,8 @@ static struct CARD {
 	// some cards ship with byteswapped IDs ...
 	{ 0x1200bd11, BTTV_PINNACLE,      "Pinnacle PCTV [bswap]" },
 	{ 0xff00bd11, BTTV_PINNACLE,      "Pinnacle PCTV [bswap]" },
+	// this seems to happen as well ...
+	{ 0xff1211bd, BTTV_PINNACLE,      "Pinnacle PCTV" },
 
 	{ 0x3000121a, BTTV_VOODOOTV_FM,   "3Dfx VoodooTV FM/ VoodooTV 200" },
 	{ 0x263710b4, BTTV_VOODOOTV_FM,   "3Dfx VoodooTV FM/ VoodooTV 200" },

-- 
#define printk(args...) fprintf(stderr, ## args)
