Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbVITSsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbVITSsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVITSsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:48:37 -0400
Received: from ppp-62-11-78-183.dialup.tiscali.it ([62.11.78.183]:15296 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965076AbVITSsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:48:24 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 6/7] update stale comment for removal of page->list
Date: Tue, 20 Sep 2005 20:45:56 +0200
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050920184556.14557.41582.stgit@zion.home.lan>
In-Reply-To: <20050920184513.14557.8152.stgit@zion.home.lan>
References: <20050920184513.14557.8152.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Update comment for the 2.6.6-rc1 conversion from page->list and
address_space->{clean,dirty,locked}_pages to radix tree tagging and ->lru.

I've mostly avoided to mention page lists (at least I've shortened the
comment).

CC: Hugh Dickins <hugh@veritas.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/linux/mm.h |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -350,7 +350,8 @@ static inline void put_page(struct page 
  * only one copy in memory, at most, normally.
  *
  * For the non-reserved pages, page_count(page) denotes a reference count.
- *   page_count() == 0 means the page is free.
+ *   page_count() == 0 means the page is free. page->lru is then used for
+ *   freelist management in the buddy allocator.
  *   page_count() == 1 means the page is used for exactly one purpose
  *   (e.g. a private data page of one process).
  *
@@ -376,10 +377,8 @@ static inline void put_page(struct page 
  * attaches, plus 1 if `private' contains something, plus one for
  * the page cache itself.
  *
- * All pages belonging to an inode are in these doubly linked lists:
- * mapping->clean_pages, mapping->dirty_pages and mapping->locked_pages;
- * using the page->list list_head. These fields are also used for
- * freelist managemet (when page_count()==0).
+ * Instead of keeping dirty/clean pages in per address-space lists, we instead
+ * now tag pages as dirty/under writeback in the radix tree.
  *
  * There is also a per-mapping radix tree mapping index to the page
  * in memory if present. The tree is rooted at mapping->root.  

