Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWIWQzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWIWQzG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 12:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWIWQzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 12:55:06 -0400
Received: from orion.profiwh.com ([85.93.165.28]:4115 "EHLO orion.profiwh.com")
	by vger.kernel.org with ESMTP id S1751317AbWIWQzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 12:55:03 -0400
Message-id: <91newa49121291221@wsc.cz>
Subject: [PATCH 2/3 -repost] pmc551 use kzalloc
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Date: Sat, 23 Sep 2006 12:55:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pmc551 use kzalloc

Use kzalloc instad of kmalloc+memset(0).

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit eb0edd8068cde9b5e6afaf09065a94cb83c10efd
tree a2f56ac7c0f5cb8e0e3dba707faa68cc8d5c9952
parent 22f07f42debab2cc3b6ab895d2fa2c34d192c25c
author Jiri Slaby <jirislaby@gmail.com> Tue, 19 Sep 2006 21:33:07 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Tue, 19 Sep 2006 21:33:07 +0200

 drivers/mtd/devices/pmc551.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
index 4d40236..62a9188 100644
--- a/drivers/mtd/devices/pmc551.c
+++ b/drivers/mtd/devices/pmc551.c
@@ -732,23 +732,20 @@ static int __init init_pmc551(void)
 			msize = length;
 		}
 
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
 
