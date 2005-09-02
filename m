Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbVIBTPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVIBTPd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbVIBTPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:15:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3237 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750900AbVIBTPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:15:32 -0400
Date: Fri, 2 Sep 2005 20:15:29 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] s2io u64 use for uintptr_t
Message-ID: <20050902191529.GE5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

u64 is not uintptr_t; unsigned long is...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-segment/drivers/net/s2io.c RC13-s2io-u64/drivers/net/s2io.c
--- RC13-segment/drivers/net/s2io.c	2005-09-02 03:33:39.000000000 -0400
+++ RC13-s2io-u64/drivers/net/s2io.c	2005-09-02 03:34:23.000000000 -0400
@@ -354,7 +354,7 @@
 	int lst_size, lst_per_page;
 	struct net_device *dev = nic->dev;
 #ifdef CONFIG_2BUFF_MODE
-	u64 tmp;
+	unsigned long tmp;
 	buffAdd_t *ba;
 #endif
 
@@ -542,18 +542,18 @@
 				    (BUF0_LEN + ALIGN_SIZE, GFP_KERNEL);
 				if (!ba->ba_0_org)
 					return -ENOMEM;
-				tmp = (u64) ba->ba_0_org;
+				tmp = (unsigned long) ba->ba_0_org;
 				tmp += ALIGN_SIZE;
-				tmp &= ~((u64) ALIGN_SIZE);
+				tmp &= ~((unsigned long) ALIGN_SIZE);
 				ba->ba_0 = (void *) tmp;
 
 				ba->ba_1_org = (void *) kmalloc
 				    (BUF1_LEN + ALIGN_SIZE, GFP_KERNEL);
 				if (!ba->ba_1_org)
 					return -ENOMEM;
-				tmp = (u64) ba->ba_1_org;
+				tmp = (unsigned long) ba->ba_1_org;
 				tmp += ALIGN_SIZE;
-				tmp &= ~((u64) ALIGN_SIZE);
+				tmp &= ~((unsigned long) ALIGN_SIZE);
 				ba->ba_1 = (void *) tmp;
 				k++;
 			}
