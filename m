Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSKLIYf>; Tue, 12 Nov 2002 03:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbSKLIYf>; Tue, 12 Nov 2002 03:24:35 -0500
Received: from holomorphy.com ([66.224.33.161]:41145 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261368AbSKLIYd>;
	Tue, 12 Nov 2002 03:24:33 -0500
To: linux-kernel@vger.kernel.org
Subject: [6/11] hugetlb: remove direct usage of struct inode
Message-Id: <E18BWPl-0005KG-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 00:28:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the last direct usage of struct inode within the hugetlb functions.

 hugetlbpage.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


diff -urpN htlb-2.5.47-5/arch/i386/mm/hugetlbpage.c htlb-2.5.47-6/arch/i386/mm/hugetlbpage.c
--- htlb-2.5.47-5/arch/i386/mm/hugetlbpage.c	2002-11-11 21:49:53.000000000 -0800
+++ htlb-2.5.47-6/arch/i386/mm/hugetlbpage.c	2002-11-11 21:55:12.000000000 -0800
@@ -398,13 +398,13 @@ static int alloc_shared_hugetlb_pages(in
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	struct inode *inode;
+	struct hugetlb_key *hugetlb_key;
 	int retval = -ENOMEM;
 	int newalloc = 0;
 
-	inode = (struct inode *)alloc_key(key, len, prot, flag, &newalloc);
-	if (IS_ERR(inode)) {
-		retval = PTR_ERR(inode);
+	hugetlb_key = alloc_key(key, len, prot, flag, &newalloc);
+	if (IS_ERR(hugetlb_key)) {
+		retval = PTR_ERR(hugetlb_key);
 		spin_unlock(&htlbpage_lock);
 		goto out_err;
 	} else
@@ -421,7 +421,7 @@ static int alloc_shared_hugetlb_pages(in
 		goto freeinode;
 	}
 
-	retval = prefault_key((struct hugetlb_key *)inode, vma);
+	retval = prefault_key(hugetlb_key, vma);
 	if (retval)
 		goto out;
 
@@ -429,7 +429,7 @@ static int alloc_shared_hugetlb_pages(in
 	vma->vm_ops = &hugetlb_vm_ops;
 	spin_unlock(&mm->page_table_lock);
 	spin_lock(&htlbpage_lock);
-	clear_key_busy((struct hugetlb_key *)inode);
+	clear_key_busy(hugetlb_key);
 	spin_unlock(&htlbpage_lock);
 	return retval;
 out:
@@ -448,7 +448,7 @@ out:
 out_err: spin_unlock(&htlbpage_lock);
 freeinode:
 	if (newalloc)
-		release_key((struct hugetlb_key *)inode);
+		release_key(hugetlb_key);
 	return retval;
 }
 
