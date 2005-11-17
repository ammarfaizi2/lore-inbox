Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbVKQTlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVKQTlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVKQTlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:41:36 -0500
Received: from gold.veritas.com ([143.127.12.110]:36665 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964826AbVKQTle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:41:34 -0500
Date: Thu, 17 Nov 2005 19:40:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] unpaged: copy_page_range vma
In-Reply-To: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511171939280.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Nov 2005 19:41:32.0705 (UTC) FILETIME=[E9AAD110:01C5EBAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For copy_one_pte's print_bad_pte to show the task correctly (instead
of "???"), dup_mmap must pass down parent vma rather than child vma.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 kernel/fork.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- unpaged10/kernel/fork.c	2005-11-17 13:53:21.000000000 +0000
+++ unpaged11/kernel/fork.c	2005-11-17 15:12:25.000000000 +0000
@@ -263,7 +263,7 @@ static inline int dup_mmap(struct mm_str
 		rb_parent = &tmp->vm_rb;
 
 		mm->map_count++;
-		retval = copy_page_range(mm, oldmm, tmp);
+		retval = copy_page_range(mm, oldmm, mpnt);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
