Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbTDRQCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTDRQCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:02:47 -0400
Received: from verein.lst.de ([212.34.181.86]:14605 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263144AbTDRQBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:01:16 -0400
Date: Fri, 18 Apr 2003 18:13:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devfs (7/7) - make devfs_generate_path static
Message-ID: <20030418181310.G363@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's just one caller in fs/devfs/base.c left.


diff -Nru a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Fri Apr 18 15:59:17 2003
+++ b/fs/devfs/base.c	Fri Apr 18 15:59:17 2003
@@ -1747,7 +1747,7 @@
  *	else a negative error code.
  */
 
-int devfs_generate_path (devfs_handle_t de, char *path, int buflen)
+static int devfs_generate_path (devfs_handle_t de, char *path, int buflen)
 {
     int pos;
 #define NAMEOF(de) ( (de)->mode ? (de)->name : (de)->u.name )
@@ -1867,7 +1867,6 @@
 EXPORT_SYMBOL(devfs_mk_symlink);
 EXPORT_SYMBOL(devfs_mk_dir);
 EXPORT_SYMBOL(devfs_remove);
-EXPORT_SYMBOL(devfs_generate_path);
 
 
 /**
diff -Nru a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h	Fri Apr 18 15:59:17 2003
+++ b/include/linux/devfs_fs_kernel.h	Fri Apr 18 15:59:17 2003
@@ -31,7 +31,6 @@
 	__attribute__((format (printf, 1, 2)));
 extern void devfs_remove(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
-extern int devfs_generate_path (devfs_handle_t de, char *path, int buflen);
 extern int devfs_register_tape(const char *name);
 extern void devfs_unregister_tape(int num);
 extern void devfs_create_partitions(struct gendisk *dev);
@@ -65,11 +64,6 @@
 }
 static inline void devfs_remove(const char *fmt, ...)
 {
-}
-static inline int devfs_generate_path (devfs_handle_t de, char *path,
-				       int buflen)
-{
-    return -ENOSYS;
 }
 static inline int devfs_register_tape (devfs_handle_t de)
 {
