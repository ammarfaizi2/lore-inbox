Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTDVTYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTDVTYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:24:10 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:62080 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263432AbTDVTXn (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:23:43 -0400
Message-Id: <200304221935.h3MJZkLq004912@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk3 - #if cleanup fs/* (3/6)
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Apr 2003 15:35:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the fs/* subtree

--- linux-2.5.68-bk3/fs/cifs/cifs_debug.c.dist	2003-04-07 13:31:18.000000000 -0400
+++ linux-2.5.68-bk3/fs/cifs/cifs_debug.c	2003-04-22 15:06:43.007045944 -0400
@@ -56,7 +56,7 @@
 	}
 }
 
-#if CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 int
 cifs_debug_data_read(char *buf, char **beginBuffer, off_t offset,
 		     int count, int *eof, void *data)
--- linux-2.5.68-bk3/fs/cifs/cifsfs.c.dist	2003-04-07 13:31:42.000000000 -0400
+++ linux-2.5.68-bk3/fs/cifs/cifsfs.c	2003-04-22 15:06:58.510982233 -0400
@@ -410,7 +410,7 @@
 init_cifs(void)
 {
 	int rc = 0;
-#if CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	cifs_proc_init();
 #endif
 	INIT_LIST_HEAD(&GlobalServerList);	/* BB not implemented yet */
@@ -446,7 +446,7 @@
 		}
 		cifs_destroy_inodecache();
 	}
-#if CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	cifs_proc_clean();
 #endif
 	return rc;
@@ -456,7 +456,7 @@
 exit_cifs(void)
 {
 	cFYI(0, ("In unregister ie exit_cifs"));
-#if CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	cifs_proc_clean();
 #endif
     	unregister_filesystem(&cifs_fs_type);
--- linux-2.5.68-bk3/fs/coda/sysctl.c.dist	2003-04-07 13:31:02.000000000 -0400
+++ linux-2.5.68-bk3/fs/coda/sysctl.c	2003-04-22 15:08:51.449585716 -0400
@@ -244,7 +244,7 @@
 	}
 #endif
 
-#if CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
         remove_proc_entry("cache_inv_stats", proc_fs_coda);
         remove_proc_entry("vfs_stats", proc_fs_coda);
 	remove_proc_entry("coda", proc_root_fs);
--- linux-2.5.68-bk3/fs/intermezzo/methods.c.dist	2003-04-07 13:32:50.000000000 -0400
+++ linux-2.5.68-bk3/fs/intermezzo/methods.c	2003-04-22 15:09:05.036870833 -0400
@@ -145,7 +145,7 @@
 {
         if ( strlen(cache_type) == strlen("ext2") &&
              memcmp(cache_type, "ext2", strlen("ext2")) == 0 ) {
-#if CONFIG_EXT2_FS
+#ifdef CONFIG_EXT2_FS
                 ops->o_trops = &presto_ext2_journal_ops;
 #else
                 ops->o_trops = NULL;
--- linux-2.5.68-bk3/fs/intermezzo/sysctl.c.dist	2003-04-07 13:30:44.000000000 -0400
+++ linux-2.5.68-bk3/fs/intermezzo/sysctl.c	2003-04-22 15:08:58.018741598 -0400
@@ -358,7 +358,7 @@
 	 */
 	PRESTO_FREE(presto_table[PRESTO_PRIMARY_CTLCNT].child, sizeof(ctl_table) * total_entries);
 
-#if CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	remove_proc_entry("mounts", proc_fs_intermezzo);
 	remove_proc_entry("intermezzo", proc_root_fs);
 #endif
--- linux-2.5.68-bk3/fs/jffs/inode-v23.c.dist	2003-04-07 13:31:50.000000000 -0400
+++ linux-2.5.68-bk3/fs/jffs/inode-v23.c	2003-04-22 15:10:03.960411439 -0400
@@ -55,7 +55,7 @@
 
 #include "jffs_fm.h"
 #include "intrep.h"
-#if CONFIG_JFFS_PROC_FS
+#ifdef CONFIG_JFFS_PROC_FS
 #include "jffs_proc.h"
 #endif
 
--- linux-2.5.68-bk3/fs/ncpfs/ncplib_kernel.c.dist	2003-04-07 13:31:18.000000000 -0400
+++ linux-2.5.68-bk3/fs/ncpfs/ncplib_kernel.c	2003-04-22 15:09:11.789850460 -0400
@@ -695,7 +695,7 @@
 	__u32 dirent;
 
 	if (!inode) {
-#if CONFIG_NCPFS_DEBUGDENTRY
+#ifdef CONFIG_NCPFS_DEBUGDENTRY
 		PRINTK("ncpfs: ncpdel2: dentry->d_inode == NULL\n");
 #endif
 		return 0xFF;	/* Any error */
--- linux-2.5.68-bk3/fs/nfsd/nfssvc.c.dist	2003-04-07 13:31:44.000000000 -0400
+++ linux-2.5.68-bk3/fs/nfsd/nfssvc.c	2003-04-22 15:06:37.084831717 -0400
@@ -103,7 +103,7 @@
 		if (error < 0)
 			goto failure;
 
-#if CONFIG_NFSD_TCP
+#ifdef CONFIG_NFSD_TCP
 		error = svc_makesock(nfsd_serv, IPPROTO_TCP, port);
 		if (error < 0)
 			goto failure;
--- linux-2.5.68-bk3/fs/partitions/check.c.dist	2003-04-22 13:57:46.000000000 -0400
+++ linux-2.5.68-bk3/fs/partitions/check.c	2003-04-22 15:09:23.718978009 -0400
@@ -38,7 +38,7 @@
 #include "ultrix.h"
 #include "efi.h"
 
-#if CONFIG_BLK_DEV_MD
+#ifdef CONFIG_BLK_DEV_MD
 extern void md_autodetect_dev(dev_t dev);
 #endif
 
@@ -323,7 +323,7 @@
 			if (!size)
 				continue;
 			add_partition(disk, j, from, size);
-#if CONFIG_BLK_DEV_MD
+#ifdef CONFIG_BLK_DEV_MD
 			if (!state->parts[j].flags)
 				continue;
 			md_autodetect_dev(bdev->bd_dev+j);
@@ -358,7 +358,7 @@
 		if (!size)
 			continue;
 		add_partition(disk, p, from, size);
-#if CONFIG_BLK_DEV_MD
+#ifdef CONFIG_BLK_DEV_MD
 		if (state->parts[p].flags)
 			md_autodetect_dev(bdev->bd_dev+p);
 #endif

