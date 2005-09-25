Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVIYPzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVIYPzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVIYPzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:55:09 -0400
Received: from gold.veritas.com ([143.127.12.110]:40875 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932235AbVIYPzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:55:07 -0400
Date: Sun, 25 Sep 2005 16:54:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 09/21] mm: exit_mmap need not reset
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251654040.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 15:55:06.0969 (UTC) FILETIME=[800B4490:01C5C1E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

exit_mmap resets various mm_struct fields, but the mm is well on its way
out, and none of those fields matter by this point.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/mmap.c |    6 ------
 1 files changed, 6 deletions(-)

--- mm08/mm/mmap.c	2005-09-24 19:28:01.000000000 +0100
+++ mm09/mm/mmap.c	2005-09-24 19:28:15.000000000 +0100
@@ -1944,12 +1944,6 @@ void exit_mmap(struct mm_struct *mm)
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, 0);
 	tlb_finish_mmu(tlb, 0, end);
 
-	mm->mmap = mm->mmap_cache = NULL;
-	mm->mm_rb = RB_ROOT;
-	set_mm_counter(mm, rss, 0);
-	mm->total_vm = 0;
-	mm->locked_vm = 0;
-
 	spin_unlock(&mm->page_table_lock);
 
 	/*
