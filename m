Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSKSAA0>; Mon, 18 Nov 2002 19:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbSKSAA0>; Mon, 18 Nov 2002 19:00:26 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:32407 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264956AbSKSAAY>; Mon, 18 Nov 2002 19:00:24 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 18 Nov 2002 16:07:17 -0800
Message-Id: <200211190007.QAA00499@baldur.yggdrasil.com>
To: ak@suse.de, gzp@myhost.mynet, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] fix devfs compile problems was Re: Linux v2.5.48
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	I'd like to recommend that you apply this to fix
fs/devfs/base.c compilation problems instead of Andi's patch, as this
one ensures that {a,m,c}time will all have the same value even if
successive calls to get_seconds() might someday be able to return
different values.  Do you concur, Andi?

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.48/fs/devfs/base.c	2002-11-17 20:29:26.000000000 -0800
+++ linux/fs/devfs/base.c	2002-11-18 16:04:13.000000000 -0800
@@ -3029,9 +3029,7 @@
     de->vfs_deletable = TRUE;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
-    de->inode.atime = CURRENT_TIME;
-    de->inode.mtime = CURRENT_TIME;
-    de->inode.ctime = CURRENT_TIME;
+    de->inode.ctime = de->inode.mtime = de->inode.atime = get_seconds();
     if ( ( inode = _devfs_get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
 	return -ENOMEM;
     DPRINTK (DEBUG_DISABLED, "(%s): new VFS inode(%u): %p  dentry: %p\n",
@@ -3060,9 +3058,7 @@
 	return err;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
-    de->inode.atime = CURRENT_TIME;
-    de->inode.mtime = CURRENT_TIME;
-    de->inode.ctime = CURRENT_TIME;
+    de->inode.ctime = de->inode.mtime = de->inode.atime = get_seconds();
     if ( ( inode = _devfs_get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
 	return -ENOMEM;
     DPRINTK (DEBUG_DISABLED, "(%s): new VFS inode(%u): %p  dentry: %p\n",
@@ -3129,9 +3125,7 @@
 	return err;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
-    de->inode.atime = CURRENT_TIME;
-    de->inode.mtime = CURRENT_TIME;
-    de->inode.ctime = CURRENT_TIME;
+    de->inode.ctime = de->inode.mtime = de->inode.atime = get_seconds();
     if ( ( inode = _devfs_get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
 	return -ENOMEM;
     DPRINTK (DEBUG_I_MKNOD, ":   new VFS inode(%u): %p  dentry: %p\n",
