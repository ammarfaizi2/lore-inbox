Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261625AbTCYWEB>; Tue, 25 Mar 2003 17:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262132AbTCYWDS>; Tue, 25 Mar 2003 17:03:18 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31129 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262045AbTCYWCo>; Tue, 25 Mar 2003 17:02:44 -0500
Date: Tue, 25 Mar 2003 22:15:49 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 06/13 wrap below vm_start
In-Reply-To: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303252215050.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

objrmap must check lest address wrapped below vma->vm_start.

--- swap05/mm/rmap.c	Tue Mar 25 20:43:40 2003
+++ swap06/mm/rmap.c	Tue Mar 25 20:43:51 2003
@@ -100,12 +100,8 @@
 	unsigned long address;
 
 	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
-	if (loffset < vma->vm_pgoff)
-		goto out;
-
 	address = vma->vm_start + ((loffset - vma->vm_pgoff) << PAGE_SHIFT);
-
-	if (address >= vma->vm_end)
+	if (address < vma->vm_start || address >= vma->vm_end)
 		goto out;
 
 	pgd = pgd_offset(mm, address);

