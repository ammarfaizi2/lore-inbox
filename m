Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUFBUFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUFBUFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUFBUFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:05:38 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:47095 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263971AbUFBUFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:05:35 -0400
Date: Wed, 2 Jun 2004 21:05:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swapper_space.i_mmap_nonlinear
Message-ID: <Pine.LNX.4.44.0406022103500.27696-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize swapper_space.i_mmap_nonlinear, so mapping_mapped reports
false on it (as it used to do).  Update comment on swapper_space,
now more fields are used than those initialized explicitly.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 mm/swap_state.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- 2.6.7-rc2/mm/swap_state.c	2004-05-30 11:36:40.000000000 +0100
+++ linux/mm/swap_state.c	2004-06-02 16:31:21.890093952 +0100
@@ -19,7 +19,8 @@
 
 /*
  * swapper_space is a fiction, retained to simplify the path through
- * vmscan's shrink_list.  Only those fields initialized below are used.
+ * vmscan's shrink_list, to make sync_page look nicer, and to allow
+ * future use of radix_tree tags in the swap cache.
  */
 static struct address_space_operations swap_aops = {
 	.writepage	= swap_writepage,
@@ -36,6 +37,7 @@ struct address_space swapper_space = {
 	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
 	.tree_lock	= SPIN_LOCK_UNLOCKED,
 	.a_ops		= &swap_aops,
+	.i_mmap_nonlinear = LIST_HEAD_INIT(swapper_space.i_mmap_nonlinear),
 	.backing_dev_info = &swap_backing_dev_info,
 };
 

