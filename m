Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWFMLXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWFMLXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 07:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWFMLWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 07:22:48 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:10235 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750990AbWFMLWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 07:22:37 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Tue, 13 Jun 2006 13:22:13 +0200
Message-Id: <20060613112213.27913.71168.sendpatchset@lappy>
In-Reply-To: <20060613112120.27913.71986.sendpatchset@lappy>
References: <20060613112120.27913.71986.sendpatchset@lappy>
Subject: [PATCH 5/6] mm: small cleanup of install_page()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Smallish cleanup to install_page(), could save a memory read
(haven't checked the asm output) and sure looks nicer.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---

Index: linux-2.6/mm/fremap.c
===================================================================
--- linux-2.6.orig/mm/fremap.c	2006-06-08 13:47:29.000000000 +0200
+++ linux-2.6/mm/fremap.c	2006-06-08 13:50:44.000000000 +0200
@@ -79,9 +79,9 @@ int install_page(struct mm_struct *mm, s
 		inc_mm_counter(mm, file_rss);
 
 	flush_icache_page(vma, page);
-	set_pte_at(mm, addr, pte, mk_pte(page, prot));
+	pte_val = mk_pte(page, prot);
+	set_pte_at(mm, addr, pte, pte_val);
 	page_add_file_rmap(page);
-	pte_val = *pte;
 	update_mmu_cache(vma, addr, pte_val);
 	err = 0;
 unlock:
