Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVHLSEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVHLSEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVHLSEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:04:47 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:1184 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S1750717AbVHLSEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:04:46 -0400
Subject: [patch 03/39] add swap cache mapping comment
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 19:31:35 +0200
Message-Id: <20050812173135.7E18C24E0AC@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add some more comments about page->mapping and swapper_space, explaining their
(historical and current) relationship. Such material can be extracted from the
old GIT history (which I used for reference), but having it in the source is
more useful.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/./mm/swap_state.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN ./mm/swap_state.c~swap-cache-mapping-comment ./mm/swap_state.c
--- linux-2.6.git/./mm/swap_state.c~swap-cache-mapping-comment	2005-08-11 11:12:57.000000000 +0200
+++ linux-2.6.git-paolo/./mm/swap_state.c	2005-08-11 11:12:57.000000000 +0200
@@ -21,6 +21,11 @@
  * swapper_space is a fiction, retained to simplify the path through
  * vmscan's shrink_list, to make sync_page look nicer, and to allow
  * future use of radix_tree tags in the swap cache.
+ *
+ * In 2.4 and until 2.6.6 pages in the swap cache also had page->mapping ==
+ * &swapper_space (this was the definition of PageSwapCache), but this is no
+ * more true. Instead, we use page->flags for that, and page->mapping is
+ * *ignored* here. However, also take a look at page_mapping().
  */
 static struct address_space_operations swap_aops = {
 	.writepage	= swap_writepage,
_
