Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVCaVAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVCaVAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 16:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVCaVAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 16:00:50 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:4531 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261587AbVCaU7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 15:59:24 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: 2/3 add offset to fuse_dirent
Message-Id: <E1DH6kz-000176-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 31 Mar 2005 22:59:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an offset field to fuse_dirent structure.  This will
give userspace filesystems more flexibility in implementing a readdir
method.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc1-mm4/fs/fuse/dir.c linux-fuse/fs/fuse/dir.c
--- linux-2.6.12-rc1-mm4/fs/fuse/dir.c	2005-03-31 21:43:42.000000000 +0200
+++ linux-fuse/fs/fuse/dir.c	2005-03-31 21:49:39.000000000 +0200
@@ -483,7 +483,7 @@ static int parse_dirfile(char *buf, size
 			break;
 
 		over = filldir(dstbuf, dirent->name, dirent->namelen,
-			       file->f_pos, dirent->ino, dirent->type);
+			       dirent->off, dirent->ino, dirent->type);
 		if (over)
 			break;
 
diff -rup linux-2.6.12-rc1-mm4/include/linux/fuse.h linux-fuse/include/linux/fuse.h
--- linux-2.6.12-rc1-mm4/include/linux/fuse.h	2005-03-31 21:49:56.000000000 +0200
+++ linux-fuse/include/linux/fuse.h	2005-03-31 21:49:39.000000000 +0200
@@ -237,6 +237,7 @@ struct fuse_out_header {
 
 struct fuse_dirent {
 	__u64	ino;
+	__u64	off;
 	__u32	namelen;
 	__u32	type;
 	char name[0];

