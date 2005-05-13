Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVEMKq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVEMKq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 06:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVEMKq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 06:46:28 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:20243 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262337AbVEMKqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 06:46:11 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] make umount_tree() static
Message-Id: <E1DWXg2-000189-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 May 2005 12:45:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make umount_tree() static, since it's not used outside namespace.c in
either -linus or -mm:

> grep -rlw umount_tree linux-2.6.12-rc4-mm1/
linux-2.6.12-rc4-mm1/fs/namespace.c
linux-2.6.12-rc4-mm1/include/linux/namespace.h

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/namespace.h
===================================================================
--- linux.orig/include/linux/namespace.h	2005-05-13 11:03:50.000000000 +0200
+++ linux/include/linux/namespace.h	2005-05-13 11:59:06.000000000 +0200
@@ -12,7 +12,6 @@ struct namespace {
 	struct rw_semaphore	sem;
 };
 
-extern void umount_tree(struct vfsmount *);
 extern int copy_namespace(int, struct task_struct *);
 extern void __put_namespace(struct namespace *namespace);
 
Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-13 11:58:53.000000000 +0200
+++ linux/fs/namespace.c	2005-05-13 11:59:06.000000000 +0200
@@ -337,7 +337,7 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
-void umount_tree(struct vfsmount *mnt)
+static void umount_tree(struct vfsmount *mnt)
 {
 	struct vfsmount *p;
 	LIST_HEAD(kill);
