Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUKTCkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUKTCkv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUKTCkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:40:21 -0500
Received: from baikonur.stro.at ([213.239.196.228]:36232 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263093AbUKTCb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:31:59 -0500
Subject: [patch 6/9]  list_for_each_entry: 	arch-i386-mm-pageattr.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:31:58 +0100
Message-ID: <E1CVL2c-0000uE-Bq@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

Make code more readable with list_for_each_entry*
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/arch/i386/mm/pageattr.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff -puN arch/i386/mm/pageattr.c~list-for-each-entry-safe-arch_i386_mm_pageattr arch/i386/mm/pageattr.c
--- linux-2.6.10-rc2-bk4/arch/i386/mm/pageattr.c~list-for-each-entry-safe-arch_i386_mm_pageattr	2004-11-19 17:15:01.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/arch/i386/mm/pageattr.c	2004-11-19 17:15:02.000000000 +0100
@@ -178,7 +178,7 @@ int change_page_attr(struct page *page, 
 void global_flush_tlb(void)
 { 
 	LIST_HEAD(l);
-	struct list_head* n;
+	struct page *pg, *next;
 
 	BUG_ON(irqs_disabled());
 
@@ -186,12 +186,8 @@ void global_flush_tlb(void)
 	list_splice_init(&df_list, &l);
 	spin_unlock_irq(&cpa_lock);
 	flush_map();
-	n = l.next;
-	while (n != &l) {
-		struct page *pg = list_entry(n, struct page, lru);
-		n = n->next;
+	list_for_each_entry_safe(pg, next, &l, lru)
 		__free_page(pg);
-	}
 } 
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
_
