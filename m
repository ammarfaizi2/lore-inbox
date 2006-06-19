Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWFSRyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWFSRyZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWFSRxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:53:52 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:16695 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S964805AbWFSRxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:53:50 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Mon, 19 Jun 2006 19:53:36 +0200
Message-Id: <20060619175336.24655.21390.sendpatchset@lappy>
In-Reply-To: <20060619175243.24655.76005.sendpatchset@lappy>
References: <20060619175243.24655.76005.sendpatchset@lappy>
Subject: [PATCH 5/6] mm: small cleanup of install_page()
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
