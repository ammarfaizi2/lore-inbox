Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbUJXPyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUJXPyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbUJXPua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:50:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:51492 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261519AbUJXPrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:47:20 -0400
Date: Sun, 24 Oct 2004 16:46:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: William Irwin <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] statm: fix negative data
In-Reply-To: <Pine.LNX.4.44.0410241644000.12023-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0410241645550.12023-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sixth "data" field of /proc/$pid/statm was sometimes negative: text
is a subset of shared_vm, and so was subtracted twice from total_vm.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
 fs/proc/task_mmu.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.10-rc1/fs/proc/task_mmu.c	2004-10-23 12:44:06.000000000 +0100
+++ linux/fs/proc/task_mmu.c	2004-10-23 20:43:24.000000000 +0100
@@ -40,7 +40,7 @@ int task_statm(struct mm_struct *mm, int
 	*shared = mm->shared_vm;
 	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
 								>> PAGE_SHIFT;
-	*data = mm->total_vm - mm->shared_vm - *text;
+	*data = mm->total_vm - mm->shared_vm;
 	*resident = mm->rss;
 	return mm->total_vm;
 }

