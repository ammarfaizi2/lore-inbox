Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbTJOS1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTJOS0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:26:37 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:61485 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263920AbTJOSY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:24:57 -0400
Date: Wed, 15 Oct 2003 19:24:53 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 7/7 write mark_page_accessed
In-Reply-To: <Pine.LNX.4.44.0310151915590.5350-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0310151924110.5350-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm/filemap.c's generic_file_aio_write_nolock changed SetPageReferenced
to mark_page_accessed in -test3: now follow that in shmem_file_write.

--- tmpfs6/mm/shmem.c	2003-10-15 15:39:25.386196056 +0100
+++ tmpfs7/mm/shmem.c	2003-10-15 15:39:36.380524664 +0100
@@ -1243,8 +1243,7 @@
 
 		flush_dcache_page(page);
 		set_page_dirty(page);
-		if (!PageReferenced(page))
-			SetPageReferenced(page);
+		mark_page_accessed(page);
 		page_cache_release(page);
 
 		if (left) {

