Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263443AbVCEAgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263443AbVCEAgv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbVCEALB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:11:01 -0500
Received: from rev.193.226.232.215.euroweb.hu ([193.226.232.215]:7866 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263186AbVCDXZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:25:32 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: use generic_file_llseek
Message-Id: <E1D7MAU-0005nI-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 05 Mar 2005 00:25:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

This patch adds generic_file_llseek to fuse_file_operations and
fuse_dir_operations, replacing the implicit default_llseek.

Please Apply.

Thanks,
Miklos

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.11-mm1/fs/fuse/dir.c linux-fuse/fs/fuse/dir.c
--- linux-2.6.11-mm1/fs/fuse/dir.c	2005-03-04 23:26:59.000000000 +0100
+++ linux-fuse/fs/fuse/dir.c	2005-03-04 23:32:36.000000000 +0100
@@ -894,6 +894,7 @@ static struct inode_operations fuse_dir_
 };
 
 static struct file_operations fuse_dir_operations = {
+	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.readdir	= fuse_readdir,
 	.open		= fuse_dir_open,
diff -rup linux-2.6.11-mm1/fs/fuse/file.c linux-fuse/fs/fuse/file.c
--- linux-2.6.11-mm1/fs/fuse/file.c	2005-03-04 23:26:59.000000000 +0100
+++ linux-fuse/fs/fuse/file.c	2005-03-04 23:32:36.000000000 +0100
@@ -517,6 +517,7 @@ static int fuse_set_page_dirty(struct pa
 }
 
 static struct file_operations fuse_file_operations = {
+	.llseek		= generic_file_llseek,
 	.read		= fuse_file_read,
 	.write		= fuse_file_write,
 	.mmap		= fuse_file_mmap,
