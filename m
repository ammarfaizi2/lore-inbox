Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVCaVN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVCaVN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 16:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVCaVN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 16:13:27 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:9139 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261943AbVCaVNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 16:13:08 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: fix warning on x86_64
Message-Id: <E1DH6yC-00019o-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 31 Mar 2005 23:12:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a couple of warnings when compiling on the x86_64
architecture.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc1-mm4/fs/fuse/file.c linux-fuse/fs/fuse/file.c
--- linux-2.6.12-rc1-mm4/fs/fuse/file.c	2005-03-31 21:52:18.000000000 +0200
+++ linux-fuse/fs/fuse/file.c	2005-03-31 21:52:00.000000000 +0200
@@ -420,7 +420,7 @@ static ssize_t fuse_direct_io(struct fil
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	unsigned nmax = write ? fc->max_write : fc->max_read;
+	size_t nmax = write ? fc->max_write : fc->max_read;
 	loff_t pos = *ppos;
 	ssize_t res = 0;
 	struct fuse_req *req = fuse_get_request(fc);
@@ -428,8 +428,8 @@ static ssize_t fuse_direct_io(struct fil
 		return -ERESTARTSYS;
 
 	while (count) {
-		unsigned tmp;
-		unsigned nres;
+		size_t tmp;
+		size_t nres;
 		size_t nbytes = min(count, nmax);
 		int err = fuse_get_user_pages(req, buf, nbytes, !write);
 		if (err) {

