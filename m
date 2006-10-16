Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422752AbWJPQbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422752AbWJPQbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422783AbWJPQa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:30:58 -0400
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:64666 "EHLO
	mail-gw3.sa.ew.hu") by vger.kernel.org with ESMTP id S1422747AbWJPQ2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:37 -0400
Message-Id: <20061016162757.542121000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:17 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 08/12] fuse: minor cleanup in fuse_dentry_revalidate
Content-Disposition: inline; filename=fuse_dentry_revalidate_cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded code from fuse_dentry_revalidate().  This made some
sense while the validity time could wrap around, but now it's a very
obvious no-op.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-10-16 16:21:20.000000000 +0200
+++ linux/fs/fuse/dir.c	2006-10-16 16:21:29.000000000 +0200
@@ -140,9 +140,6 @@ static int fuse_dentry_revalidate(struct
 		struct fuse_req *req;
 		struct dentry *parent;
 
-		/* Doesn't hurt to "reset" the validity timeout */
-		fuse_invalidate_entry_cache(entry);
-
 		/* For negative dentries, always do a fresh lookup */
 		if (!inode)
 			return 0;

--
