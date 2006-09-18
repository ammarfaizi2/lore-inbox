Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751960AbWIRWrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbWIRWrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 18:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbWIRWrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 18:47:47 -0400
Received: from av1.karneval.cz ([81.27.192.123]:11621 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1751960AbWIRWrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 18:47:37 -0400
Message-id: <91292349121291221@karneval.cz>
Subject: [PATCH 3/4] pmc551 use kzalloc
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Mark Ferrell <mferrell@mvista.com>
Cc: <linux-mtd@lists.infradead.org>
Date: Tue, 19 Sep 2006 00:47:34 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pmc551 use kzalloc

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 912ff3e53f760cb166988fcd46fc173f8e4c22e7
tree 8dbed23771076f4cb714ffe9115849150791f13a
parent f562d858f77d4a83f55cf7fa962cd4dbef3eb0d6
author Jiri Slaby <xslaby@anemoi.localdomain> Tue, 19 Sep 2006 00:32:53 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Tue, 19 Sep 2006 00:32:53 +0200

 drivers/mtd/devices/pmc551.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
index 0ee22ca..5f5de9c 100644
--- a/drivers/mtd/devices/pmc551.c
+++ b/drivers/mtd/devices/pmc551.c
@@ -725,23 +725,20 @@ static int __init init_pmc551(void)
 		} else
 			msize = length;
 
-		mtd = kmalloc(sizeof(struct mtd_info), GFP_KERNEL);
+		mtd = kzalloc(sizeof(struct mtd_info), GFP_KERNEL);
 		if (!mtd) {
 			printk(KERN_NOTICE "pmc551: Cannot allocate new MTD "
 				"device.\n");
 			break;
 		}
 
-		memset(mtd, 0, sizeof(struct mtd_info));
-
-		priv = kmalloc(sizeof(struct mypriv), GFP_KERNEL);
+		priv = kzalloc(sizeof(struct mypriv), GFP_KERNEL);
 		if (!priv) {
 			printk(KERN_NOTICE "pmc551: Cannot allocate new MTD "
 				"device.\n");
 			kfree(mtd);
 			break;
 		}
-		memset(priv, 0, sizeof(*priv));
 		mtd->priv = priv;
 		priv->dev = PCI_Device;
 
