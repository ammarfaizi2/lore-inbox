Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbVISSVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbVISSVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVISSVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:21:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50562 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932549AbVISSVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:21:23 -0400
Date: Tue, 30 Aug 2005 17:52:04 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] s2io u64 use for uintptr_t
Message-ID: <20050830165204.GN9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	u64 is not uintptr_t; unsigned long is.
Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-base/drivers/net/s2io.c current/drivers/net/s2io.c
--- RC13-base/drivers/net/s2io.c	2005-08-30 03:24:42.000000000 -0400
+++ current/drivers/net/s2io.c	2005-08-30 03:25:18.000000000 -0400
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
