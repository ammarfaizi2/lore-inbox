Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268571AbRG3Mmf>; Mon, 30 Jul 2001 08:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268573AbRG3MmZ>; Mon, 30 Jul 2001 08:42:25 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:19863 "EHLO
	alloc.wat.veritas.com") by vger.kernel.org with ESMTP
	id <S268571AbRG3MmJ>; Mon, 30 Jul 2001 08:42:09 -0400
Date: Mon, 30 Jul 2001 13:44:23 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
X-X-Sender: <markhe@alloc.wat.veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] select_parent
Message-ID: <Pine.LNX.4.33.0107301335040.13705-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


  Minor patch.

  fs/dcache.c:select_parent() moves unused dentries to the head of the
unused list, ready for a call to prune_dcache().  However, it doesn't
clear the referenced-bit.  At worst, this could result in a bit of
extra work and a few unnecessary dentires reaped.

  Please apply.

Mark


diff -ur -X dontdiff linux-2.4.7/fs/dcache.c dcache-2.4.7/fs/dcache.c
--- linux-2.4.7/fs/dcache.c	Thu Jul  5 18:14:23 2001
+++ dcache-2.4.7/fs/dcache.c	Mon Jul 30 14:00:45 2001
@@ -491,6 +491,7 @@
 		if (!atomic_read(&dentry->d_count)) {
 			list_del(&dentry->d_lru);
 			list_add(&dentry->d_lru, dentry_unused.prev);
+			dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
 			found++;
 		}
 		/*

