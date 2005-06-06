Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVFFT4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVFFT4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVFFTxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:53:39 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:60624 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261645AbVFFTvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:51:03 -0400
Date: Mon, 6 Jun 2005 20:51:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dup_mmap: update comment on new vma
Message-ID: <Pine.LNX.4.61.0506062049460.5000@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 06 Jun 2005 19:50:05.0770 (UTC) 
    FILETIME=[EFBB52A0:01C56AD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove part of comment on linking new vma in dup_mmap: since anon_vma
rmap came in, try_to_unmap_one knows the vma without needing find_vma.
But add a comment to note that here vma is inserted without mmap_sem.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 kernel/fork.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- 2.6.12-rc6/kernel/fork.c	2005-05-25 18:09:19.000000000 +0100
+++ linux/kernel/fork.c	2005-06-04 20:41:55.000000000 +0100
@@ -249,8 +249,9 @@ static inline int dup_mmap(struct mm_str
 
 		/*
 		 * Link in the new vma and copy the page table entries:
-		 * link in first so that swapoff can see swap entries,
-		 * and try_to_unmap_one's find_vma find the new vma.
+		 * link in first so that swapoff can see swap entries.
+		 * Note that, exceptionally, here the vma is inserted
+		 * without holding mm->mmap_sem.
 		 */
 		spin_lock(&mm->page_table_lock);
 		*pprev = tmp;
