Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbWJJVsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbWJJVsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030520AbWJJVsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:48:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31163 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030518AbWJJVr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:47:58 -0400
To: torvalds@osdl.org
Subject: [PATCH] gfp annotations: radix_tree_root
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPS9-0007P8-DR@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:47:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


struct radix_tree_root has unused upper bits of ->gfp_mask reused for
tags bitmap.  Annotated.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/radix-tree.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 637d556..aa9bfd0 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -160,13 +160,13 @@ static inline int tag_get(struct radix_t
 
 static inline void root_tag_set(struct radix_tree_root *root, unsigned int tag)
 {
-	root->gfp_mask |= (1 << (tag + __GFP_BITS_SHIFT));
+	root->gfp_mask |= (__force gfp_t)(1 << (tag + __GFP_BITS_SHIFT));
 }
 
 
 static inline void root_tag_clear(struct radix_tree_root *root, unsigned int tag)
 {
-	root->gfp_mask &= ~(1 << (tag + __GFP_BITS_SHIFT));
+	root->gfp_mask &= (__force gfp_t)~(1 << (tag + __GFP_BITS_SHIFT));
 }
 
 static inline void root_tag_clear_all(struct radix_tree_root *root)
@@ -176,7 +176,7 @@ static inline void root_tag_clear_all(st
 
 static inline int root_tag_get(struct radix_tree_root *root, unsigned int tag)
 {
-	return root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT));
+	return (__force unsigned)root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT));
 }
 
 /*
-- 
1.4.2.GIT


