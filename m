Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSKRMgv>; Mon, 18 Nov 2002 07:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSKRMgv>; Mon, 18 Nov 2002 07:36:51 -0500
Received: from ns.suse.de ([213.95.15.193]:26895 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262394AbSKRMgt>;
	Mon, 18 Nov 2002 07:36:49 -0500
To: "Gabor Z. Papp" <gzp@myhost.mynet>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] fix devfs compile problems was Re: Linux v2.5.48
References: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com.suse.lists.linux.kernel> <66aa.3dd8ae09.31d44@gzp1.gzp.hu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Nov 2002 13:43:49 +0100
In-Reply-To: "Gabor Z. Papp"'s message of "18 Nov 2002 10:12:07 +0100"
Message-ID: <p73heefujy2.fsf_-_@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Gabor Z. Papp" <gzp@myhost.mynet> writes:


> fs/devfs/base.c:3033: incompatible types in assignment
> fs/devfs/base.c:3034: incompatible types in assignment
> fs/devfs/base.c: In function `devfs_mkdir':
> fs/devfs/base.c:3063: incompatible types in assignment
> fs/devfs/base.c:3064: incompatible types in assignment
> fs/devfs/base.c:3065: incompatible types in assignment
> fs/devfs/base.c: In function `devfs_mknod':
> fs/devfs/base.c:3132: incompatible types in assignment
> fs/devfs/base.c:3133: incompatible types in assignment
> fs/devfs/base.c:3134: incompatible types in assignment

Side effect from the nsec stat patch. 
Here is a patch:

Linus, please consider applying.

-Andi

--- linux-2.5.48-work/fs/devfs/base.c-o	2002-11-18 13:39:07.000000000 +0100
+++ linux-2.5.48-work/fs/devfs/base.c	2002-11-18 13:41:12.000000000 +0100
@@ -3029,9 +3029,9 @@
     de->vfs_deletable = TRUE;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
-    de->inode.atime = CURRENT_TIME;
-    de->inode.mtime = CURRENT_TIME;
-    de->inode.ctime = CURRENT_TIME;
+    de->inode.atime = get_seconds();
+    de->inode.mtime = get_seconds();
+    de->inode.ctime = get_seconds();
     if ( ( inode = _devfs_get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
 	return -ENOMEM;
     DPRINTK (DEBUG_DISABLED, "(%s): new VFS inode(%u): %p  dentry: %p\n",
@@ -3060,9 +3060,9 @@
 	return err;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
-    de->inode.atime = CURRENT_TIME;
-    de->inode.mtime = CURRENT_TIME;
-    de->inode.ctime = CURRENT_TIME;
+    de->inode.atime = get_seconds();
+    de->inode.mtime = get_seconds();
+    de->inode.ctime = get_seconds();
     if ( ( inode = _devfs_get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
 	return -ENOMEM;
     DPRINTK (DEBUG_DISABLED, "(%s): new VFS inode(%u): %p  dentry: %p\n",
@@ -3129,9 +3129,9 @@
 	return err;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
-    de->inode.atime = CURRENT_TIME;
-    de->inode.mtime = CURRENT_TIME;
-    de->inode.ctime = CURRENT_TIME;
+    de->inode.atime = get_seconds();
+    de->inode.mtime = get_seconds();
+    de->inode.ctime = get_seconds();
     if ( ( inode = _devfs_get_vfs_inode (dir->i_sb, de, dentry) ) == NULL )
 	return -ENOMEM;
     DPRINTK (DEBUG_I_MKNOD, ":   new VFS inode(%u): %p  dentry: %p\n",



-Andi
