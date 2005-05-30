Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVE3Kko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVE3Kko (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 06:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVE3Kka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 06:40:30 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:27915 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261373AbVE3Kij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 06:38:39 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] namespace: rename _mntput to mntput_no_expire
Message-Id: <E1Dchf5-0000Fs-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 30 May 2005 12:38:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames _mntput() to something a little more descriptive:
mntput_no_expire().

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/mount.h
===================================================================
--- linux.orig/include/linux/mount.h	2005-05-29 13:42:33.000000000 +0200
+++ linux/include/linux/mount.h	2005-05-29 13:42:37.000000000 +0200
@@ -47,7 +47,7 @@ static inline struct vfsmount *mntget(st
 
 extern void __mntput(struct vfsmount *mnt);
 
-static inline void _mntput(struct vfsmount *mnt)
+static inline void mntput_no_expire(struct vfsmount *mnt)
 {
 	if (mnt) {
 		if (atomic_dec_and_test(&mnt->mnt_count))
@@ -59,7 +59,7 @@ static inline void mntput(struct vfsmoun
 {
 	if (mnt) {
 		mnt->mnt_expiry_mark = 0;
-		_mntput(mnt);
+		mntput_no_expire(mnt);
 	}
 }
 
Index: linux/fs/namei.c
===================================================================
--- linux.orig/fs/namei.c	2005-05-29 13:42:33.000000000 +0200
+++ linux/fs/namei.c	2005-05-29 13:43:09.000000000 +0200
@@ -314,7 +314,7 @@ void path_release(struct nameidata *nd)
 void path_release_on_umount(struct nameidata *nd)
 {
 	dput(nd->dentry);
-	_mntput(nd->mnt);
+	mntput_no_expire(nd->mnt);
 }
 
 /*
