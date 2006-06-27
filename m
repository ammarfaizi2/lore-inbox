Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWF0S32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWF0S32 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWF0S32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:29:28 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:3557 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030262AbWF0S3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:29:13 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Tue, 27 Jun 2006 20:29:06 +0200
Message-Id: <20060627182906.20891.66543.sendpatchset@lappy>
In-Reply-To: <20060627182801.20891.11456.sendpatchset@lappy>
References: <20060627182801.20891.11456.sendpatchset@lappy>
Subject: [PATCH 5/5] mm: small cleanup of install_page()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Smallish cleanup to install_page(), could save a memory read
(haven't checked the asm output) and sure looks nicer.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---

---
 mm/fremap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6-mm/mm/fremap.c
===================================================================
--- 2.6-mm.orig/mm/fremap.c	2006-06-19 16:20:52.000000000 +0200
+++ 2.6-mm/mm/fremap.c	2006-06-19 16:20:57.000000000 +0200
@@ -79,9 +79,9 @@ int install_page(struct mm_struct *mm, s
 		inc_mm_counter(mm, file_rss);
 
 	flush_icache_page(vma, page);
-	set_pte_at(mm, addr, pte, mk_pte(page, prot));
+	pte_val = mk_pte(page, prot);
+	set_pte_at(mm, addr, pte, pte_val);
 	page_add_file_rmap(page);
-	pte_val = *pte;
 	update_mmu_cache(vma, addr, pte_val);
 	lazy_mmu_prot_update(pte_val);
 	err = 0;
