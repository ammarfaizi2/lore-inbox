Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWJMQpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWJMQpC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWJMQpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:45:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:36301 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751355AbWJMQog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:44:36 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>
Message-Id: <20061013143556.15438.35419.sendpatchset@linux.site>
In-Reply-To: <20061013143516.15438.8802.sendpatchset@linux.site>
References: <20061013143516.15438.8802.sendpatchset@linux.site>
Subject: [patch 4/6] mm: comment mmap_sem / lock_page lockorder
Date: Fri, 13 Oct 2006 18:44:32 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few more examples to the mmap_sem / lock_page ordering.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -73,7 +73,7 @@ generic_file_direct_IO(int rw, struct ki
  *        ->mapping->tree_lock	(arch-dependent flush_dcache_mmap_lock)
  *
  *  ->mmap_sem
- *    ->lock_page		(access_process_vm)
+ *    ->lock_page		(page fault, sys_mmap, access_process_vm)
  *
  *  ->mmap_sem
  *    ->i_mutex			(msync)
Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -29,7 +29,7 @@
  * taken together; in truncation, i_mutex is taken outermost.
  *
  * mm->mmap_sem
- *   page->flags PG_locked (lock_page)
+ *   page->flags PG_locked (lock_page, eg from pagefault)
  *     mapping->i_mmap_lock
  *       anon_vma->lock
  *         mm->page_table_lock or pte_lock
