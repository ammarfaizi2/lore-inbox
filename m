Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSKRGVt>; Mon, 18 Nov 2002 01:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSKRGVt>; Mon, 18 Nov 2002 01:21:49 -0500
Received: from services.erkkila.org ([24.97.94.217]:48772 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id <S261524AbSKRGVs>;
	Mon, 18 Nov 2002 01:21:48 -0500
Message-ID: <3DD88826.2000505@erkkila.org>
Date: Mon, 18 Nov 2002 06:26:46 +0000
From: "Paul E. Erkkila" <pee@erkkila.org>
Reply-To: pee@erkkila.org
Organization: ErkkilaDotOrg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Goddard <agoddard@purdue.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.48 Compilation Failure
References: <Pine.LNX.4.44.0211180113460.22038-100000@dust.ebiz-gw.wintek.com>
In-Reply-To: <Pine.LNX.4.44.0211180113460.22038-100000@dust.ebiz-gw.wintek.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This will make it compile, and boot

I'll forwarn i have no idea wtf i'm doing , so you might
want to wait for a different patch... o.0

diff -Nru a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Mon Nov 18 06:20:34 2002
+++ b/fs/devfs/base.c	Mon Nov 18 06:20:34 2002
@@ -799,9 +799,9 @@
 struct devfs_inode     /*  This structure is for "persistent" inode storage  */
 {
     struct dentry *dentry;
-    time_t atime;
-    time_t mtime;
-    time_t ctime;
+    struct timespec atime;
+    struct timespec mtime;
+    struct timespec ctime;
     unsigned int ino;            /*  Inode number as seen in the VFS         */
     uid_t uid;
     gid_t gid;
@@ -2509,9 +2509,9 @@
     de->mode = inode->i_mode;
     de->inode.uid = inode->i_uid;
     de->inode.gid = inode->i_gid;
-    de->inode.atime = inode->i_atime.tv_sec;
-    de->inode.mtime = inode->i_mtime.tv_sec;
-    de->inode.ctime = inode->i_ctime.tv_sec;
+    de->inode.atime.tv_sec = inode->i_atime.tv_sec;
+    de->inode.mtime.tv_sec = inode->i_mtime.tv_sec;
+    de->inode.ctime.tv_sec = inode->i_ctime.tv_sec;
     if ( ( iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID) ) &&
 	 !is_devfsd_or_child (fs_info) )
 	devfsd_notify_de (de, DEVFSD_NOTIFY_CHANGE, inode->i_mode,
@@ -2610,9 +2610,9 @@
     inode->i_mode = de->mode;
     inode->i_uid = de->inode.uid;
     inode->i_gid = de->inode.gid;
-    inode->i_atime.tv_sec = de->inode.atime;
-    inode->i_mtime.tv_sec = de->inode.mtime;
-    inode->i_ctime.tv_sec = de->inode.ctime;
+    inode->i_atime.tv_sec = de->inode.atime.tv_sec;
+    inode->i_mtime.tv_sec = de->inode.mtime.tv_sec;
+    inode->i_ctime.tv_sec = de->inode.ctime.tv_sec;
     inode->i_atime.tv_nsec = 0;
     inode->i_mtime.tv_nsec = 0;
     inode->i_ctime.tv_nsec = 0;



Alex Goddard wrote:

>During make bzImage:
>
>gcc -Wp,-MD,fs/devfs/.base.o.d -D__KERNEL__ -Iinclude -Wall
>-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
>-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
>-march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include
>-DKBUILD_BASENAME=base -DKBUILD_MODNAME=devfs -DEXPORT_SYMTAB -c -o
>fs/devfs/base.o fs/devfs/base.c
>fs/devfs/base.c: In function `devfs_symlink':
>fs/devfs/base.c:3032: incompatible types in assignment
>fs/devfs/base.c:3033: incompatible types in assignment
>fs/devfs/base.c:3034: incompatible types in assignment
>fs/devfs/base.c: In function `devfs_mkdir':
>fs/devfs/base.c:3063: incompatible types in assignment
>fs/devfs/base.c:3064: incompatible types in assignment
>fs/devfs/base.c:3065: incompatible types in assignment
>fs/devfs/base.c: In function `devfs_mknod':
>fs/devfs/base.c:3132: incompatible types in assignment
>fs/devfs/base.c:3133: incompatible types in assignment
>fs/devfs/base.c:3134: incompatible types in assignment
>make[2]: *** [fs/devfs/base.o] Error 1
>make[1]: *** [fs/devfs] Error 2
>make: *** [fs] Error 2
>
>I'm unsure of exactly what other information would be needed by whomever 
>will go after this, but just say something and I'll send what you want.
>
>  
>

