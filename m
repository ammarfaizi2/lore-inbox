Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263160AbVGNVpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbVGNVpD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 17:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbVGNVoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:44:44 -0400
Received: from coderock.org ([193.77.147.115]:11937 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S263152AbVGNVoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:44:14 -0400
Message-Id: <20050714214402.256252000@homer>
Date: Thu, 14 Jul 2005 23:44:00 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Victor Fusco <victor@cetuc.puc-rio.br>,
       domen@coderock.org
Subject: [patch 2/5] lib/radix-tree: Fix "nocast type" warnings
Content-Disposition: inline; filename=sparse-include_linux_radix-tree.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"

File/Subsystem:lib/radix-tree

Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>

--

---
 include/linux/radix-tree.h |    4 ++--
 lib/radix-tree.c           |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: quilt/include/linux/radix-tree.h
===================================================================
--- quilt.orig/include/linux/radix-tree.h
+++ quilt/include/linux/radix-tree.h
@@ -24,7 +24,7 @@
 
 struct radix_tree_root {
 	unsigned int		height;
-	int			gfp_mask;
+	unsigned int		gfp_mask;
 	struct radix_tree_node	*rnode;
 };
 
@@ -50,7 +50,7 @@ void *radix_tree_delete(struct radix_tre
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
-int radix_tree_preload(int gfp_mask);
+int radix_tree_preload(unsigned int __nocast gfp_mask);
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,
 			unsigned long index, int tag);
Index: quilt/lib/radix-tree.c
===================================================================
--- quilt.orig/lib/radix-tree.c
+++ quilt/lib/radix-tree.c
@@ -109,7 +109,7 @@ radix_tree_node_free(struct radix_tree_n
  * success, return zero, with preemption disabled.  On error, return -ENOMEM
  * with preemption not disabled.
  */
-int radix_tree_preload(int gfp_mask)
+int radix_tree_preload(unsigned int __nocast gfp_mask)
 {
 	struct radix_tree_preload *rtp;
 	struct radix_tree_node *node;

--
