Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265522AbSKFCYl>; Tue, 5 Nov 2002 21:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265537AbSKFCYl>; Tue, 5 Nov 2002 21:24:41 -0500
Received: from holomorphy.com ([66.224.33.161]:64923 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265522AbSKFCYk>;
	Tue, 5 Nov 2002 21:24:40 -0500
To: linux-kernel@vger.kernel.org
Subject: [3/7] hugetlb: remove unlink_vma()
Message-Id: <E189Fwj-0002YN-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 05 Nov 2002 18:29:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused function unlink_vma().

 hugetlbpage.c |   19 -------------------
 1 files changed, 19 deletions(-)


diff -urpN hugetlbfs-2.5.46-1/arch/i386/mm/hugetlbpage.c hugetlbfs-2.5.46-2/arch/i386/mm/hugetlbpage.c
--- hugetlbfs-2.5.46-1/arch/i386/mm/hugetlbpage.c	2002-11-05 11:00:42.000000000 -0800
+++ hugetlbfs-2.5.46-2/arch/i386/mm/hugetlbpage.c	2002-11-05 11:07:53.000000000 -0800
@@ -261,25 +261,6 @@ void zap_hugepage_range(struct vm_area_s
 	spin_unlock(&mm->page_table_lock);
 }
 
-static void unlink_vma(struct vm_area_struct *mpnt)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-
-	vma = mm->mmap;
-	if (vma == mpnt) {
-		mm->mmap = vma->vm_next;
-	} else {
-		while (vma->vm_next != mpnt) {
-			vma = vma->vm_next;
-		}
-		vma->vm_next = mpnt->vm_next;
-	}
-	rb_erase(&mpnt->vm_rb, &mm->mm_rb);
-	mm->mmap_cache = NULL;
-	mm->map_count--;
-}
-
 static struct inode *set_new_inode(unsigned long len, int prot, int flag, int key)
 {
 	struct inode *inode;
