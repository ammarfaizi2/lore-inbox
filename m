Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVAJUTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVAJUTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVAJUQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:16:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60902 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262502AbVAJUMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:12:39 -0500
Date: Mon, 10 Jan 2005 12:12:33 -0800 (PST)
From: Michael Werner <werner@mrcoffee.engr.sgi.com>
Message-Id: <200501102012.j0AKCXJr2075714@mrcoffee.engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.10-mm2] agpgart: Add agp_find_bridge function
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gives non-generic platforms a method for using
platform specific agp_find_bridge functions.

Signed-off-by: Mike Werner <werner@sgi.com>
---

 drivers/char/agp/backend.c  |    5 ++++-
 include/linux/agp_backend.h |    2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

# This is a BitKeeper generated diff -Nru style patch.
#
#   Add agp_find_bridge
# 
diff -Nru a/drivers/char/agp/backend.c b/drivers/char/agp/backend.c
--- a/drivers/char/agp/backend.c	2005-01-10 09:21:20 -08:00
+++ b/drivers/char/agp/backend.c	2005-01-10 09:21:20 -08:00
@@ -50,6 +50,9 @@
 	.minor = AGPGART_VERSION_MINOR,
 };
 
+struct agp_bridge_data *(*agp_find_bridge)(struct pci_dev *) =
+	&agp_generic_find_bridge;
+
 struct agp_bridge_data *agp_bridge;
 LIST_HEAD(agp_bridges);
 EXPORT_SYMBOL(agp_bridge);
@@ -63,7 +66,7 @@
 {
 	struct agp_bridge_data *bridge;
 
-	bridge = agp_generic_find_bridge(pdev);
+	bridge = agp_find_bridge(pdev);
 
 	if (!bridge)
 		return NULL;
diff -Nru a/include/linux/agp_backend.h b/include/linux/agp_backend.h
--- a/include/linux/agp_backend.h	2005-01-10 09:21:20 -08:00
+++ b/include/linux/agp_backend.h	2005-01-10 09:21:20 -08:00
@@ -94,6 +94,8 @@
 extern struct agp_bridge_data *agp_bridge;
 extern struct list_head agp_bridges;
 
+extern struct agp_bridge_data *(*agp_find_bridge)(struct pci_dev *);
+
 extern void agp_free_memory(struct agp_memory *);
 extern struct agp_memory *agp_allocate_memory(struct agp_bridge_data *, size_t, u32);
 extern int agp_copy_info(struct agp_bridge_data *, struct agp_kern_info *);
