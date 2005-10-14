Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbVJNTWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVJNTWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 15:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVJNTWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 15:22:50 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:34950 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750907AbVJNTWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 15:22:48 -0400
Date: Fri, 14 Oct 2005 14:22:25 -0500
From: Robin Holt <holt@sgi.com>
To: linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, jgarzik@pobox.com,
       wli@holomorphy.com, Dave Hansen <haveblue@us.ibm.com>,
       Jack Steiner <steiner@americas.sgi.com>
Subject: [Patch 2/3] Export get_one_pte_map.
Message-ID: <20051014192225.GD14418@lnx-holt.americas.sgi.com>
References: <20051014192111.GB14418@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051014192111.GB14418@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add an export of get_one_pte_map.

Signed-off-by: Robin Holt <holt@sgi.com>


Index: linux-2.6/mm/mremap.c
===================================================================
--- linux-2.6.orig/mm/mremap.c	2005-09-28 15:05:56.000000000 -0500
+++ linux-2.6/mm/mremap.c	2005-10-14 11:32:11.276747477 -0500
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
+#include <linux/module.h>
 #include <linux/swap.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
@@ -50,7 +51,7 @@ end:
 	return pte;
 }
 
-static pte_t *get_one_pte_map(struct mm_struct *mm, unsigned long addr)
+pte_t *get_one_pte_map(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -70,6 +71,7 @@ static pte_t *get_one_pte_map(struct mm_
 
 	return pte_offset_map(pmd, addr);
 }
+EXPORT_SYMBOL(get_one_pte_map);
 
 static inline pte_t *alloc_one_pte_map(struct mm_struct *mm, unsigned long addr)
 {
Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h	2005-10-12 11:21:54.701122262 -0500
+++ linux-2.6/include/linux/mm.h	2005-10-14 09:04:29.191902399 -0500
@@ -733,6 +733,7 @@ int FASTCALL(set_page_dirty(struct page 
 int set_page_dirty_lock(struct page *page);
 int clear_page_dirty_for_io(struct page *page);
 
+extern pte_t *get_one_pte_map(struct mm_struct *mm, unsigned long addr);
 extern unsigned long do_mremap(unsigned long addr,
 			       unsigned long old_len, unsigned long new_len,
 			       unsigned long flags, unsigned long new_addr);
