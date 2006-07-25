Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWGYJBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWGYJBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWGYJBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:01:51 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:10126 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751325AbWGYJBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:01:50 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-mm@kvack.org
Subject: [PATCH][Doc] Add kerneldocs for some functions in mm/memory.c
Date: Tue, 25 Jul 2006 11:03:34 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607251103.34787.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are already documented quite well with long comments.
Now add kerneldoc style header to make this turn up in everyones favorite
doc format.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit 39c068bce1d63f6c1345c1ddfda1841d9fd20c74
tree dbaacbfd0d8049251eb821f7b35d169767044ddf
parent 1bf23f2d14d5e8da05d7ea05505ef92cd780f69f
author Rolf Eike Beer <eike-kernel@sf-tec.de> Tue, 25 Jul 2006 10:58:33 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Tue, 25 Jul 2006 10:58:33 +0200

 mm/memory.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)


NOTE:

This needs some review. I was searching for a documentation of this 
functions, so what I write down here is what I think to have learned.
Might be slightly or completely wrong.


diff --git a/mm/memory.c b/mm/memory.c
index 109e986..5a8885d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1226,7 +1226,12 @@ out:
 	return retval;
 }
 
-/*
+/**
+ * vm_insert_page - insert single page into user vma
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @page: source kernel page
+ *
  * This allows drivers to insert individual pages they've allocated
  * into a user vma.
  *
@@ -1318,7 +1323,16 @@ static inline int remap_pud_range(struct
 	return 0;
 }
 
-/*  Note: this is only safe if the mm semaphore is held when called. */
+/**
+ * remap_pfn_range - remap kernel memory to userspace
+ * @vma: user vma to map to
+ * @addr: target user address to start at
+ * @pfn: physical address of kernel memory
+ * @size: size of map area
+ * @prot: page protection flags for this mapping
+ *
+ *  Note: this is only safe if the mm semaphore is held when called.
+ */
 int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		    unsigned long pfn, unsigned long size, pgprot_t prot)
 {
@@ -1785,9 +1799,10 @@ void unmap_mapping_range(struct address_
 }
 EXPORT_SYMBOL(unmap_mapping_range);
 
-/*
- * Handle all mappings that got truncated by a "truncate()"
- * system call.
+/**
+ * vmtruncate - unmap mappings "freed" by truncate() syscall
+ * @inode: inode of the file used
+ * @offset: file offset to start truncating
  *
  * NOTE! We have to be ready to update the memory sharing
  * between the file and the memory map for a potential last
@@ -1856,11 +1871,16 @@ int vmtruncate_range(struct inode *inode
 }
 EXPORT_UNUSED_SYMBOL(vmtruncate_range);  /*  June 2006  */
 
-/* 
+/**
+ * swapin_readahead - swap in pages in hope we need them soon
+ * @entry: swap entry of this memory
+ * @addr: address to start
+ * @vma: user vma this addresses belong to
+ *
  * Primitive swap readahead code. We simply read an aligned block of
  * (1 << page_cluster) entries in the swap area. This method is chosen
  * because it doesn't cost us any seek time.  We also make sure to queue
- * the 'original' request together with the readahead ones...  
+ * the 'original' request together with the readahead ones...
  *
  * This has been extended to use the NUMA policies from the mm triggering
  * the readahead.
