Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbULOOSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbULOOSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 09:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbULOOSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 09:18:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28084 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262353AbULOORv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 09:17:51 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove #ifdefs from linux/mm.h
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Wed, 15 Dec 2004 14:17:39 +0000
Message-ID: <24248.1103120259@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch removes some now unnecessary #ifdefs from linux/mm.h. This
is possible because we're now using the proper vm_area_struct structure.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>lsdiff nommu-ifdef-2610rc3.diff 
linux-2.6.10-rc3-mm1-base/include/linux/mm.h

diff -uNrp linux-2.6.10-rc3-mm1-base/include/linux/mm.h linux-2.6.10-rc3-mm1-nommu-rb/include/linux/mm.h
--- linux-2.6.10-rc3-mm1-base/include/linux/mm.h	2004-12-13 17:34:21.000000000 +0000
+++ linux-2.6.10-rc3-mm1-nommu-rb/include/linux/mm.h	2004-12-15 13:38:04.000000000 +0000
@@ -724,14 +724,12 @@ struct vm_area_struct *vma_prio_tree_nex
 	for (prio_tree_iter_init(iter, root, begin, end), vma = NULL;	\
 		(vma = vma_prio_tree_next(vma, iter)); )
 
-#ifdef CONFIG_MMU
 static inline void vma_nonlinear_insert(struct vm_area_struct *vma,
 					struct list_head *list)
 {
 	vma->shared.vm_set.parent = NULL;
 	list_add_tail(&vma->shared.vm_set.list, list);
 }
-#endif
 
 /* mmap.c */
 extern void vma_adjust(struct vm_area_struct *vma, unsigned long start,
@@ -849,7 +847,6 @@ static inline void __vm_stat_account(str
 }
 #endif /* CONFIG_PROC_FS */
 
-#ifdef CONFIG_MMU
 static inline void vm_stat_account(struct vm_area_struct *vma)
 {
 	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
@@ -861,7 +858,6 @@ static inline void vm_stat_unaccount(str
 	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
 							-vma_pages(vma));
 }
-#endif
 
 /* update per process rss and vm hiwater data */
 extern void update_mem_hiwater(void);
