Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268162AbUH0ITn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268162AbUH0ITn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268892AbUH0ISD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:18:03 -0400
Received: from ozlabs.org ([203.10.76.45]:19072 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268162AbUH0IRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:17:42 -0400
Date: Fri, 27 Aug 2004 18:13:17 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove function prototype inside function
Message-ID: <20040827081317.GD11731@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I had a problem when compiling a 2.6 kernel with gcc 3.5 CVS. The
prototype for prio_tree_remove in mm/prio_tree.c is inside another
function. gcc 3.5 gets upset and removes the function completely.
Apparently this isnt valid C, so lets fix it up.

Details can be found here:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=17205

Signed-off-by: Anton Blanchard <anton@samba.org>

===== mm/prio_tree.c 1.7 vs edited =====
--- 1.7/mm/prio_tree.c	Mon Aug 23 18:15:12 2004
+++ edited/mm/prio_tree.c	Fri Aug 27 16:28:34 2004
@@ -81,6 +81,8 @@
 	return index_bits_to_maxindex[bits - 1];
 }
 
+static void prio_tree_remove(struct prio_tree_root *, struct prio_tree_node *);
+
 /*
  * Extend a priority search tree so that it can store a node with heap_index
  * max_heap_index. In the worst case, this algorithm takes O((log n)^2).
@@ -90,8 +92,6 @@
 static struct prio_tree_node *prio_tree_expand(struct prio_tree_root *root,
 		struct prio_tree_node *node, unsigned long max_heap_index)
 {
-	static void prio_tree_remove(struct prio_tree_root *,
-					struct prio_tree_node *);
 	struct prio_tree_node *first = NULL, *prev, *last = NULL;
 
 	if (max_heap_index > prio_tree_maxindex(root->index_bits))
