Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSG2WII>; Mon, 29 Jul 2002 18:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318182AbSG2WHJ>; Mon, 29 Jul 2002 18:07:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:57381 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S318175AbSG2WG5>; Mon, 29 Jul 2002 18:06:57 -0400
Date: Mon, 29 Jul 2002 23:10:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] vmacct5/9 remove unhelpful vm_unacct_vma
In-Reply-To: <Pine.LNX.4.21.0207292257001.1184-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0207292309210.1184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove vm_unacct_vma function: it's only used in one place,
which can do it better by using vm_unacct_memory directly.

--- vmacct4/mm/mmap.c	Mon Jul 29 19:23:46 2002
+++ vmacct5/mm/mmap.c	Mon Jul 29 19:23:46 2002
@@ -131,13 +131,6 @@
 	return 0;
 }
 
-void vm_unacct_vma(struct vm_area_struct *vma)
-{
-	int len = vma->vm_end - vma->vm_start;
-	if (vma->vm_flags & VM_ACCOUNT)
-		vm_unacct_memory(len >> PAGE_SHIFT);
-}
-
 /* Remove one vm structure from the inode's i_mapping address space. */
 static inline void __remove_shared_vm_struct(struct vm_area_struct *vma)
 {
@@ -1225,7 +1218,7 @@
 		 * removal
 		 */
 		if (mpnt->vm_flags & VM_ACCOUNT)
-			vm_unacct_vma(mpnt);
+			vm_unacct_memory((end - start) >> PAGE_SHIFT);
 
 		mm->map_count--;
 		unmap_page_range(tlb, mpnt, start, end);

