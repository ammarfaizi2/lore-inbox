Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVCEPf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVCEPf7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVCEPf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:35:58 -0500
Received: from coderock.org ([193.77.147.115]:35235 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261911AbVCEPfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:35:20 -0500
Subject: [patch 01/12] list_for_each_entry: arch-i386-mm-pageattr.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, janitor@sternwelten.at
From: domen@coderock.org
Date: Sat, 05 Mar 2005 16:35:07 +0100
Message-Id: <20050305153508.7CFFD1EE1E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Make code more readable with list_for_each_entry*
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/mm/pageattr.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff -puN arch/i386/mm/pageattr.c~list-for-each-entry-safe-arch_i386_mm_pageattr arch/i386/mm/pageattr.c
--- kj/arch/i386/mm/pageattr.c~list-for-each-entry-safe-arch_i386_mm_pageattr	2005-03-05 16:09:04.000000000 +0100
+++ kj-domen/arch/i386/mm/pageattr.c	2005-03-05 16:09:04.000000000 +0100
@@ -189,7 +189,7 @@ int change_page_attr(struct page *page, 
 void global_flush_tlb(void)
 { 
 	LIST_HEAD(l);
-	struct list_head* n;
+	struct page *pg, *next;
 
 	BUG_ON(irqs_disabled());
 
@@ -197,12 +197,8 @@ void global_flush_tlb(void)
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
