Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbVALADc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbVALADc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbVAKXjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:39:17 -0500
Received: from coderock.org ([193.77.147.115]:62917 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262878AbVAKXe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:34:59 -0500
Subject: [patch 01/11] list_for_each_entry: arch-i386-mm-pageattr.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, janitor@sternwelten.at
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:34:51 +0100
Message-Id: <20050111233451.B1A0C1F225@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

Make code more readable with list_for_each_entry*
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/mm/pageattr.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff -puN arch/i386/mm/pageattr.c~list-for-each-entry-safe-arch_i386_mm_pageattr arch/i386/mm/pageattr.c
--- kj/arch/i386/mm/pageattr.c~list-for-each-entry-safe-arch_i386_mm_pageattr	2005-01-10 17:59:45.000000000 +0100
+++ kj-domen/arch/i386/mm/pageattr.c	2005-01-10 17:59:45.000000000 +0100
@@ -181,7 +181,7 @@ int change_page_attr(struct page *page, 
 void global_flush_tlb(void)
 { 
 	LIST_HEAD(l);
-	struct list_head* n;
+	struct page *pg, *next;
 
 	BUG_ON(irqs_disabled());
 
@@ -189,12 +189,8 @@ void global_flush_tlb(void)
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
