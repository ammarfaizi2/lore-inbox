Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbVKIOSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbVKIOSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVKIOOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:14:19 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:18924 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750827AbVKIOOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:14:04 -0500
Message-Id: <20051109141443.364108000@localhost.localdomain>
References: <20051109134938.757187000@localhost.localdomain>
Date: Wed, 09 Nov 2005 21:49:41 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 03/16] radixtree: sync with mainline
Content-Disposition: inline; filename=radixtree-sync-with-mainline.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch from Christoph Lameter:

[PATCH] radix-tree: Remove unnecessary indirections and clean up code

is only partially merged into -mm tree. This patch completes it.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 lib/radix-tree.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

--- linux-2.6.14-mm1.orig/lib/radix-tree.c
+++ linux-2.6.14-mm1/lib/radix-tree.c
@@ -291,27 +291,25 @@ static inline void **__lookup_slot(struc
 				   unsigned long index)
 {
 	unsigned int height, shift;
-	struct radix_tree_node **slot;
+	struct radix_tree_node *slot;
 
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
-	slot = &root->rnode;
+	slot = root->rnode;
 
 	while (height > 0) {
-		if (*slot == NULL)
+		if (slot == NULL)
 			return NULL;
 
-		slot = (struct radix_tree_node **)
-			((*slot)->slots +
-				((index >> shift) & RADIX_TREE_MAP_MASK));
+		slot = slot->slots[(index >> shift) & RADIX_TREE_MAP_MASK];
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
 
-	return (void **)slot;
+	return slot;
 }
 
 /**

--
