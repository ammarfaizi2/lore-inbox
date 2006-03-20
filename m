Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWCTNJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWCTNJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWCTNJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:09:31 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:61107 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750920AbWCTNJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:09:30 -0500
Date: Mon, 20 Mar 2006 15:09:29 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mm: use kmem_cache_zalloc
Message-ID: <Pine.LNX.4.58.0603201507590.19005@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch converts mm/ to use the new kmem_cache_zalloc allocator.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

---

 mm/mmap.c |    6 ++----
 mm/slab.c |    3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

015a94e6deff683b6db8c4d917e1e117d0e0db5e
diff --git a/mm/mmap.c b/mm/mmap.c
index 47556d2..842dbc6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1048,12 +1048,11 @@ munmap_back:
 	 * specific mapper. the address has already been validated, but
 	 * not unmapped, but the maps are removed from the list.
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 	if (!vma) {
 		error = -ENOMEM;
 		goto unacct_error;
 	}
-	memset(vma, 0, sizeof(*vma));
 
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
@@ -1904,12 +1903,11 @@ unsigned long do_brk(unsigned long addr,
 	/*
 	 * create a vma struct for an anonymous mapping
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 	if (!vma) {
 		vm_unacct_memory(len >> PAGE_SHIFT);
 		return -ENOMEM;
 	}
-	memset(vma, 0, sizeof(*vma));
 
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
diff --git a/mm/slab.c b/mm/slab.c
index 5f3e14b..4b744ed 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1899,10 +1899,9 @@ kmem_cache_create (const char *name, siz
 	align = ralign;
 
 	/* Get cache's description obj. */
-	cachep = kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
+	cachep = kmem_cache_zalloc(&cache_cache, SLAB_KERNEL);
 	if (!cachep)
 		goto oops;
-	memset(cachep, 0, sizeof(struct kmem_cache));
 
 #if DEBUG
 	cachep->obj_size = size;
-- 
1.2.3

