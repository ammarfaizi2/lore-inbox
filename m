Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264266AbTCYWLr>; Tue, 25 Mar 2003 17:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264265AbTCYWLF>; Tue, 25 Mar 2003 17:11:05 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:41965 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262302AbTCYWJm>; Tue, 25 Mar 2003 17:09:42 -0500
Date: Tue, 25 Mar 2003 22:22:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 12/13 vm_enough_memory double counts
In-Reply-To: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303252221570.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stop vm_enough_memory double counting total_swapcache_pages: it dates
from the days when we didn't free swap when freeing swapcache page.

--- swap11/mm/mmap.c	Sun Mar 23 10:30:15 2003
+++ swap12/mm/mmap.c	Tue Mar 25 20:44:57 2003
@@ -82,14 +82,6 @@
 		free += nr_swap_pages;
 
 		/*
-		 * This double-counts: the nrpages are both in the
-		 * page-cache and in the swapper space. At the same time,
-		 * this compensates for the swap-space over-allocation
-		 * (ie "nr_swap_pages" being too small).
-		 */
-		free += total_swapcache_pages;
-
-		/*
 		 * The code below doesn't account for free space in the
 		 * inode and dentry slab cache, slab cache fragmentation,
 		 * inodes and dentries which will become freeable under

