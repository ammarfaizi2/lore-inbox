Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWCaR6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWCaR6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWCaR6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:58:41 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:49052 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932170AbWCaR6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:58:40 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:45:19 +0200)
Subject: [PATCH 7/10] fuse: consolidate device errors
References: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNt9-0005dc-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:58:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return consistent error values for the case when the opened device
file has no mount associated yet.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-03-31 18:55:31.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-03-31 18:55:32.000000000 +0200
@@ -739,7 +739,7 @@ static ssize_t fuse_dev_writev(struct fi
 	struct fuse_copy_state cs;
 	struct fuse_conn *fc = fuse_get_conn(file);
 	if (!fc)
-		return -ENODEV;
+		return -EPERM;
 
 	fuse_copy_init(&cs, fc, 0, NULL, iov, nr_segs);
 	if (nbytes < sizeof(struct fuse_out_header))
@@ -930,7 +930,7 @@ static int fuse_dev_fasync(int fd, struc
 {
 	struct fuse_conn *fc = fuse_get_conn(file);
 	if (!fc)
-		return -ENODEV;
+		return -EPERM;
 
 	/* No locking - fasync_helper does its own locking */
 	return fasync_helper(fd, file, on, &fc->fasync);
