Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269967AbRHNBfP>; Mon, 13 Aug 2001 21:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269973AbRHNBe3>; Mon, 13 Aug 2001 21:34:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64731 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269963AbRHNBeR>;
	Mon, 13 Aug 2001 21:34:17 -0400
Date: Mon, 13 Aug 2001 21:34:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (8/11) fs/super.c fixes
In-Reply-To: <Pine.GSO.4.21.0108132133540.10579-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108132134170.10579-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part 8/11

Cleanup: ->kern_mnt is gone. Nothing uses it anymore.

diff -urN S9-pre3-kern_mount/fs/super.c S9-pre3-kern_mnt/fs/super.c
--- S9-pre3-kern_mount/fs/super.c	Mon Aug 13 21:21:28 2001
+++ S9-pre3-kern_mnt/fs/super.c	Mon Aug 13 21:21:28 2001
@@ -1197,7 +1197,6 @@
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
-	type->kern_mnt = mnt;
 	up_write(&sb->s_umount);
 	up(&mount_sem);
 	return mnt;
diff -urN S9-pre3-kern_mount/include/linux/fs.h S9-pre3-kern_mnt/include/linux/fs.h
--- S9-pre3-kern_mount/include/linux/fs.h	Mon Aug 13 21:21:27 2001
+++ S9-pre3-kern_mnt/include/linux/fs.h	Mon Aug 13 21:21:28 2001
@@ -89,12 +89,7 @@
 #define FS_NO_PRELIM	4 /* prevent preloading of dentries, even if
 			   * FS_NO_DCACHE is not set.
 			   */
-#define FS_SINGLE	8 /*
-			   * Filesystem that can have only one superblock;
-			   * kernel-wide vfsmnt is placed in ->kern_mnt by
-			   * kern_mount() which must be called _after_
-			   * register_filesystem().
-			   */
+#define FS_SINGLE	8 /* Filesystem that can have only one superblock */
 #define FS_NOMOUNT	16 /* Never mount from userland */
 #define FS_LITTER	32 /* Keeps the tree in dcache */
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
@@ -914,7 +909,6 @@
 	int fs_flags;
 	struct super_block *(*read_super) (struct super_block *, void *, int);
 	struct module *owner;
-	struct vfsmount *kern_mnt; /* For kernel mount, if it's FS_SINGLE fs */
 	struct file_system_type * next;
 	struct list_head fs_supers;
 };


