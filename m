Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263905AbTJOSYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTJOSYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:24:45 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:41499 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S263905AbTJOSYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:24:12 -0400
Date: Wed, 15 Oct 2003 19:24:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 6/7 write i_size_write
In-Reply-To: <Pine.LNX.4.44.0310151915590.5350-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0310151923200.5350-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm/shmem.c was converted to i_size_read in -test1, and the remaining
references to a file's naked i_size are safely protected by i_sem;
but surely shmem_file_write must use i_size_write to update i_size.

--- tmpfs5/mm/shmem.c	2003-10-15 15:39:14.391867448 +0100
+++ tmpfs6/mm/shmem.c	2003-10-15 15:39:25.386196056 +0100
@@ -1239,7 +1239,7 @@
 		pos += bytes;
 		buf += bytes;
 		if (pos > inode->i_size)
-			inode->i_size = pos;
+			i_size_write(inode, pos);
 
 		flush_dcache_page(page);
 		set_page_dirty(page);

