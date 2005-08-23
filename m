Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVHWUPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVHWUPr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVHWUPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:15:47 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:57997 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932320AbVHWUPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:15:46 -0400
Message-ID: <430B83F2.3080109@temple.edu>
Date: Tue, 23 Aug 2005 16:15:46 -0400
From: Nick Sillik <n.sillik@temple.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: reiserfs-dev@namesys.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [-mm PATCH] fix -Wundef warnings in reiser4 code
Content-Type: multipart/mixed;
 boundary="------------010609030107080206020705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010609030107080206020705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes the following wundef errors in fs/reiser4/* .

Signed-off-by: Nick Sillik <n.sillik@temple.edu>

--------------010609030107080206020705
Content-Type: text/x-patch;
 name="reiser4-wundef.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiser4-wundef.patch"

diff -urN linux-2.6.13-rc6-mm2/fs/reiser4/plugin/cryptcompress.c linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/cryptcompress.c
--- linux-2.6.13-rc6-mm2/fs/reiser4/plugin/cryptcompress.c	2005-08-23 15:51:47.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/cryptcompress.c	2005-08-23 16:08:32.000000000 -0400
@@ -597,7 +597,7 @@
 	return 0;
 }
 
-#if REISER4_TRACE
+#ifdef REISER4_TRACE
 #define reserve4cluster(inode, clust, msg)    __reserve4cluster(inode, clust)
 #else
 #define reserve4cluster(inode, clust, msg)    __reserve4cluster(inode, clust)
diff -urN linux-2.6.13-rc6-mm2/fs/reiser4/plugin/dir/hashed_dir.c linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/dir/hashed_dir.c
--- linux-2.6.13-rc6-mm2/fs/reiser4/plugin/dir/hashed_dir.c	2005-08-23 15:51:47.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/dir/hashed_dir.c	2005-08-23 16:09:27.000000000 -0400
@@ -1206,7 +1206,7 @@
 	reiser4_key *key;
 	/* how many entries with duplicate key was scanned so far. */
 	int non_uniq;
-#if REISER4_USE_COLLISION_LIMIT || REISER4_STATS
+#if defined(REISER4_USE_COLLISION_LIMIT) || defined(REISER4_STATS)
 	/* scan limit */
 	int max_non_uniq;
 #endif
diff -urN linux-2.6.13-rc6-mm2/fs/reiser4/plugin/item/cde.c linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/item/cde.c
--- linux-2.6.13-rc6-mm2/fs/reiser4/plugin/item/cde.c	2005-08-23 15:51:47.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/item/cde.c	2005-08-23 16:04:25.000000000 -0400
@@ -463,7 +463,7 @@
 	    (extract_dir_id_from_key(&item_key) == extract_dir_id_from_key(key));
 }
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 /* ->print() method for this item plugin. */
 reiser4_internal void
 print_cde(const char *prefix /* prefix to print */ ,
diff -urN linux-2.6.13-rc6-mm2/fs/reiser4/plugin/item/ctail.c linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/item/ctail.c
--- linux-2.6.13-rc6-mm2/fs/reiser4/plugin/item/ctail.c	2005-08-23 15:51:47.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/item/ctail.c	2005-08-23 16:04:50.000000000 -0400
@@ -195,7 +195,7 @@
 		return data->length;
 }
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 /* ->print() method for this item plugin. */
 reiser4_internal void
 print_ctail(const char *prefix /* prefix to print */ ,
diff -urN linux-2.6.13-rc6-mm2/fs/reiser4/plugin/item/internal.c linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/item/internal.c
--- linux-2.6.13-rc6-mm2/fs/reiser4/plugin/item/internal.c	2005-08-23 15:51:47.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/item/internal.c	2005-08-23 16:04:40.000000000 -0400
@@ -210,7 +210,7 @@
 	return 0;
 }
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 /* debugging aid: print human readable information about internal item at
    @coord  */
 reiser4_internal void
diff -urN linux-2.6.13-rc6-mm2/fs/reiser4/plugin/item/item.c linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/item/item.c
--- linux-2.6.13-rc6-mm2/fs/reiser4/plugin/item/item.c	2005-08-23 15:51:47.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/item/item.c	2005-08-23 16:05:45.000000000 -0400
@@ -350,7 +350,7 @@
 			.max_unit_key      = NULL,
 			.estimate          = NULL,
 			.item_data_by_flow = NULL,
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 			.print             = print_sd,
 			.item_stat         = item_stat_static_sd,
 #endif
@@ -403,7 +403,7 @@
 			.max_unit_key      = NULL,
 			.estimate          = NULL,
 			.item_data_by_flow = NULL,
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 			.print             = print_de,
 			.item_stat         = NULL,
 #endif
@@ -460,7 +460,7 @@
 			.max_unit_key      = unit_key_cde,
 			.estimate          = estimate_cde,
 			.item_data_by_flow = NULL
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 			, .print           = print_cde,
 			.item_stat         = NULL
 #endif
@@ -517,7 +517,7 @@
 			.max_unit_key      = NULL,
 			.estimate          = NULL,
 			.item_data_by_flow = NULL
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 			, .print           = print_internal,
 			.item_stat         = NULL
 #endif
@@ -678,7 +678,7 @@
 			.max_unit_key      = unit_key_tail,
 			.estimate          = estimate_ctail,
 			.item_data_by_flow = NULL
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 			, .print           = print_ctail,
 			.item_stat         = NULL
 #endif
@@ -738,7 +738,7 @@
 			.max_unit_key      = NULL,
 			.estimate          = NULL,
 			.item_data_by_flow = NULL,
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 			.print             = NULL,
 			.item_stat         = NULL,
 #endif
diff -urN linux-2.6.13-rc6-mm2/fs/reiser4/plugin/item/sde.c linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/item/sde.c
--- linux-2.6.13-rc6-mm2/fs/reiser4/plugin/item/sde.c	2005-08-23 15:51:47.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/item/sde.c	2005-08-23 16:04:07.000000000 -0400
@@ -18,7 +18,7 @@
 #include <linux/dcache.h>	/* for struct dentry */
 #include <linux/quotaops.h>
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 reiser4_internal void
 print_de(const char *prefix /* prefix to print */ ,
 	 coord_t * coord /* item to print */ )
diff -urN linux-2.6.13-rc6-mm2/fs/reiser4/plugin/node/node40.c linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/node/node40.c
--- linux-2.6.13-rc6-mm2/fs/reiser4/plugin/node/node40.c	2005-08-23 15:51:47.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/node/node40.c	2005-08-23 16:08:59.000000000 -0400
@@ -445,7 +445,7 @@
 	assert("nikita-3214",
 	       equi(found, keyeq(&node40_ih_at(node, left)->key, key)));
 
-#if REISER4_STATS
+#ifdef REISER4_STATS
 	NODE_ADDSTAT(node, found, !!found);
 	NODE_ADDSTAT(node, pos, left);
 	if (items > 1)
diff -urN linux-2.6.13-rc6-mm2/fs/reiser4/plugin/plugin.c linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/plugin.c
--- linux-2.6.13-rc6-mm2/fs/reiser4/plugin/plugin.c	2005-08-23 15:51:47.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/fs/reiser4/plugin/plugin.c	2005-08-23 16:08:15.000000000 -0400
@@ -323,7 +323,7 @@
 	return &plugins[type_id].plugins_list;
 }
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 /* print human readable plugin information */
 reiser4_internal void
 print_plugin(const char *prefix /* prefix to print */ ,
diff -urN linux-2.6.13-rc6-mm2/fs/reiser4/seal.c linux-2.6.13-rc6-mm2-patched/fs/reiser4/seal.c
--- linux-2.6.13-rc6-mm2/fs/reiser4/seal.c	2005-08-23 15:51:47.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/fs/reiser4/seal.c	2005-08-23 16:02:47.000000000 -0400
@@ -209,7 +209,7 @@
 	return UNDER_SPIN(jnode, ZJNODE(node), (seal->version == node->version));
 }
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 /* debugging function: print human readable form of @seal. */
 reiser4_internal void
 print_seal(const char *prefix, const seal_t * seal)
diff -urN linux-2.6.13-rc6-mm2/fs/reiser4/super.c linux-2.6.13-rc6-mm2-patched/fs/reiser4/super.c
--- linux-2.6.13-rc6-mm2/fs/reiser4/super.c	2005-08-23 15:51:47.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/fs/reiser4/super.c	2005-08-23 16:02:55.000000000 -0400
@@ -378,7 +378,7 @@
 #endif
 }
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 /*
  * debugging function: output human readable information about file system
  * parameters

--------------010609030107080206020705--
