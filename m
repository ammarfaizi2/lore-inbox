Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423242AbWANAk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423242AbWANAk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423243AbWANAk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:40:57 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:13742 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1423242AbWANAk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:40:56 -0500
Message-Id: <20060114004028.711485000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:39:49 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] add /sys/fs
Content-Disposition: inline; filename=sys_fs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an empty /sys/fs, which filesystems can use.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2006-01-13 21:52:18.000000000 +0100
+++ linux/include/linux/fs.h	2006-01-13 22:51:37.000000000 +0100
@@ -1297,6 +1297,9 @@ extern void mnt_set_mountpoint(struct vf
 
 extern int vfs_statfs(struct super_block *, struct kstatfs *);
 
+/* /sys/fs */
+extern struct subsystem fs_subsys;
+
 #define FLOCK_VERIFY_READ  1
 #define FLOCK_VERIFY_WRITE 2
 
Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2006-01-13 21:52:16.000000000 +0100
+++ linux/fs/namespace.c	2006-01-13 22:51:37.000000000 +0100
@@ -48,6 +48,10 @@ static int hash_mask __read_mostly, hash
 static kmem_cache_t *mnt_cache;
 static struct rw_semaphore namespace_sem;
 
+/* /sys/fs */
+decl_subsys(fs, NULL, NULL);
+EXPORT_SYMBOL(fs_subsys);
+
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
 	unsigned long tmp = ((unsigned long)mnt / L1_CACHE_BYTES);
@@ -1725,6 +1729,7 @@ void __init mnt_init(unsigned long mempa
 		i--;
 	} while (i);
 	sysfs_init();
+	subsystem_register(&fs_subsys);
 	init_rootfs();
 	init_mount_tree();
 }

--
