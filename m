Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVHWUQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVHWUQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVHWUQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:16:35 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:13586 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932363AbVHWUQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:16:34 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: follow_link() fix
Message-Id: <E1E7fBm-0006By-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Aug 2005 22:16:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up fuse_follow_link() and fuse_put_link() to conform to the new API.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2005-08-23 21:16:52.000000000 +0200
+++ linux/fs/fuse/dir.c	2005-08-23 21:18:24.000000000 +0200
@@ -596,13 +596,13 @@ static void free_link(char *link)
 		free_page((unsigned long) link);
 }
 
-static int fuse_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *fuse_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	nd_set_link(nd, read_link(dentry));
-	return 0;
+	return NULL;
 }
 
-static void fuse_put_link(struct dentry *dentry, struct nameidata *nd)
+static void fuse_put_link(struct dentry *dentry, struct nameidata *nd, void *c)
 {
 	free_link(nd_get_link(nd));
 }
