Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272827AbTHEPqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272836AbTHEPqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:46:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:7186 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S272827AbTHEPq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:46:27 -0400
Date: Tue, 5 Aug 2003 16:48:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Randy Dunlap <rddunlap@osdl.org>,
       Leann Ogasawara <ogasawara@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] revert to static = {0}
Message-ID: <Pine.LNX.4.44.0308051638040.1471-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please revert to static zero initialization of a const: when thus
initialized it's linked into a readonly cacheline shared between cpus;
otherwise it's linked into bss, likely to be in a dirty cacheline
bouncing between cpus.

--- 2.6.0-test2-bk/mm/shmem.c	Tue Aug  5 15:57:31 2003
+++ linux/mm/shmem.c	Tue Aug  5 16:16:55 2003
@@ -296,7 +296,7 @@
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	struct page *page = NULL;
 	swp_entry_t *entry;
-	static const swp_entry_t unswapped;
+	static const swp_entry_t unswapped = {0};
 
 	if (sgp != SGP_WRITE &&
 	    ((loff_t) index << PAGE_CACHE_SHIFT) >= i_size_read(inode))

