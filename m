Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289191AbSBDWLp>; Mon, 4 Feb 2002 17:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289198AbSBDWLf>; Mon, 4 Feb 2002 17:11:35 -0500
Received: from [217.9.226.246] ([217.9.226.246]:49024 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S289191AbSBDWLT>; Mon, 4 Feb 2002 17:11:19 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.3-dj1] Radix tree page cache
In-Reply-To: <87zo2pybv0.fsf@fadata.bg>
X-No-CC: Post to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <87zo2pybv0.fsf@fadata.bg>
Date: 05 Feb 2002 00:10:34 +0200
Message-ID: <87sn8g525h.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Momchil" == Momchil Velikov <velco@fadata.bg> writes:

Momchil> This is the radix tree page cache patch against 2.5.3-dj1. Changes
Momchil> from the previous release - couple of bug fixes.

Ok, here goes an additional one, let it _actually_ use the mempools.

Regards,
-velco

diff -Nru a/lib/radix-tree.c b/lib/radix-tree.c
--- a/lib/radix-tree.c	Tue Feb  5 00:06:57 2002
+++ b/lib/radix-tree.c	Tue Feb  5 00:06:57 2002
@@ -56,12 +56,6 @@
 #define radix_tree_node_free(node) \
 	mempool_free((node), radix_tree_node_pool);
 
-#define radix_tree_node_alloc(root) \
-	kmem_cache_alloc(radix_tree_node_cachep, (root)->gfp_mask)
-#define radix_tree_node_free(node) \
-	kmem_cache_free(radix_tree_node_cachep, (node))
-
-
 /*
  * Return the maximum key, which can be store into a radix tree
  * with height HEIGHT.
