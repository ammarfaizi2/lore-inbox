Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264606AbTH2U7p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264612AbTH2U7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:59:44 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:35879 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S264606AbTH2U7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:59:33 -0400
Date: Fri, 29 Aug 2003 22:01:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swapon note error
Message-ID: <Pine.LNX.4.44.0308292158500.1816-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's good that swapon fails on a tmpfs file ("swapfile has holes"),
but not good that it then hangs up: note error from setup_swap_extents.

Hugh

--- 2.6.0-test4-mm3-1/mm/swapfile.c	Mon Aug 11 14:20:43 2003
+++ linux/mm/swapfile.c	Fri Aug 29 20:53:33 2003
@@ -1403,7 +1403,8 @@
 	p->max = maxpages;
 	p->pages = nr_good_pages;
 
-	if (setup_swap_extents(p))
+	error = setup_swap_extents(p);
+	if (error)
 		goto bad_swap;
 
 	swap_list_lock();

