Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUEWUyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUEWUyl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUEWUyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 16:54:41 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:42880 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262927AbUEWUyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 16:54:40 -0400
Subject: [PATCH] kernel/fork.c is broken by the new rmap
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 23 May 2004 15:54:31 -0500
Message-Id: <1085345676.10930.38.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If your architecture makes use of flush_dcache_mm_lock() then you get
this:

kernel/fork.c: In function `dup_mmap':
kernel/fork.c:336: `mapping' undeclared (first use in this function)
kernel/fork.c:336: (Each undeclared identifier is reported only once
kernel/fork.c:336: for each function it appears in.)

James

===== kernel/fork.c 1.181 vs edited =====
--- 1.181/kernel/fork.c	Sat May 22 16:56:30 2004
+++ edited/kernel/fork.c	Sun May 23 15:27:29 2004
@@ -333,9 +333,9 @@
       
 			/* insert tmp into the share list, just after mpnt */
 			spin_lock(&file->f_mapping->i_mmap_lock);
-			flush_dcache_mmap_lock(mapping);
+			flush_dcache_mmap_lock(file->f_mapping);
 			vma_prio_tree_add(tmp, mpnt);
-			flush_dcache_mmap_unlock(mapping);
+			flush_dcache_mmap_unlock(file->f_mapping);
 			spin_unlock(&file->f_mapping->i_mmap_lock);
 		}
 


