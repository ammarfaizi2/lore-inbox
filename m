Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932915AbWCVWhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915AbWCVWhv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932906AbWCVWhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:37:10 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:64496 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S932912AbWCVWg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:36:58 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223623.12658.40566.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 31/34] mm: cart-PG_reclaim3.patch
Date: Wed, 22 Mar 2006 23:36:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Add a third PG_flag to the page reclaim framework.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/page-flags.h |    1 +
 mm/hugetlb.c               |    3 ++-
 mm/page_alloc.c            |    3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6-git/include/linux/page-flags.h
===================================================================
--- linux-2.6-git.orig/include/linux/page-flags.h
+++ linux-2.6-git/include/linux/page-flags.h
@@ -77,6 +77,7 @@
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
 #define PG_reclaim2		20	/* reserved by the mm reclaim code */
+#define PG_reclaim3		21	/* reserved by the mm reclaim code */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
Index: linux-2.6-git/mm/page_alloc.c
===================================================================
--- linux-2.6-git.orig/mm/page_alloc.c
+++ linux-2.6-git/mm/page_alloc.c
@@ -151,6 +151,7 @@ static void bad_page(struct page *page)
 			1 << PG_locked	|
 			1 << PG_reclaim1 |
 			1 << PG_reclaim2 |
+			1 << PG_reclaim3 |
 			1 << PG_dirty	|
 			1 << PG_reclaim |
 			1 << PG_slab    |
@@ -363,6 +364,7 @@ static inline int free_pages_check(struc
 			1 << PG_locked	|
 			1 << PG_reclaim1 |
 			1 << PG_reclaim2 |
+			1 << PG_reclaim3 |
 			1 << PG_reclaim	|
 			1 << PG_slab	|
 			1 << PG_swapcache |
@@ -521,6 +523,7 @@ static int prep_new_page(struct page *pa
 			1 << PG_locked	|
 			1 << PG_reclaim1 |
 			1 << PG_reclaim2 |
+			1 << PG_reclaim3 |
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
 			1 << PG_slab    |
Index: linux-2.6-git/mm/hugetlb.c
===================================================================
--- linux-2.6-git.orig/mm/hugetlb.c
+++ linux-2.6-git/mm/hugetlb.c
@@ -153,7 +153,8 @@ static void update_and_free_page(struct 
 	for (i = 0; i < (HPAGE_SIZE / PAGE_SIZE); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
 				1 << PG_dirty | 1 << PG_reclaim1 | 1 << PG_reclaim2 |
-				1 << PG_reserved | 1 << PG_private | 1<< PG_writeback);
+				1 << PG_reclaim3 | 1 << PG_reserved | 1 << PG_private |
+				1<< PG_writeback);
 		set_page_count(&page[i], 0);
 	}
 	set_page_count(page, 1);
