Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSJAP1N>; Tue, 1 Oct 2002 11:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbSJAP1M>; Tue, 1 Oct 2002 11:27:12 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:36236 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S261852AbSJAP0W>; Tue, 1 Oct 2002 11:26:22 -0400
Date: Tue, 1 Oct 2002 16:32:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@digeo.com>, Zlatko Clausic <zlatko.calusic@iskon.hr>,
       Alessandro Suardi <alessandro.suardi@oracle.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] Oracle startup split_vma fix
In-Reply-To: <dny99icwp0.fsf@magla.zg.iskon.hr>
Message-ID: <Pine.LNX.4.44.0210011621490.1203-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi and Zlatko Calusic independently reported that
Oracle cannot start on recent 2.5: excellent research by Zlatko
quickly pointed to vm_pgoff buglet in the new split_vma.

Patch below against 2.5.40 or 2.5.40-mm1: please apply.

--- 2.5.40/mm/mmap.c	Tue Oct  1 15:33:04 2002
+++ linux/mm/mmap.c	Tue Oct  1 15:53:06 2002
@@ -1058,7 +1058,7 @@
 	if (new_below) {
 		new->vm_end = addr;
 		vma->vm_start = addr;
-		vma->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
+		vma->vm_pgoff += ((addr - new->vm_start) >> PAGE_SHIFT);
 	} else {
 		vma->vm_end = addr;
 		new->vm_start = addr;

