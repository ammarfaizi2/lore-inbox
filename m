Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422766AbWJPQ3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422766AbWJPQ3P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422758AbWJPQ2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:28:48 -0400
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:1435 "EHLO
	mail-gw3.sa.ew.hu") by vger.kernel.org with ESMTP id S1422757AbWJPQ2l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:41 -0400
Message-Id: <20061016162752.767422000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:16 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 07/12] fuse: update userspace interface to version 7.8
Content-Disposition: inline; filename=fuse_interface_update.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to the RELEASE message which specifies that a FLUSH
operation should be performed as well.  This interface update is
needed for the FreeBSD port, and doesn't actually touch the Linux
implementation at all.

Also rename the unused 'flush_flags' in the FLUSH message to 'unused'.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2006-10-16 16:17:31.000000000 +0200
+++ linux/include/linux/fuse.h	2006-10-16 16:21:26.000000000 +0200
@@ -15,7 +15,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 7
+#define FUSE_KERNEL_MINOR_VERSION 8
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -92,6 +92,11 @@ struct fuse_file_lock {
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
 
+/**
+ * Release flags
+ */
+#define FUSE_RELEASE_FLUSH	(1 << 0)
+
 enum fuse_opcode {
 	FUSE_LOOKUP	   = 1,
 	FUSE_FORGET	   = 2,  /* no reply */
@@ -205,12 +210,13 @@ struct fuse_open_out {
 struct fuse_release_in {
 	__u64	fh;
 	__u32	flags;
-	__u32	padding;
+	__u32	release_flags;
+	__u64	lock_owner;
 };
 
 struct fuse_flush_in {
 	__u64	fh;
-	__u32	flush_flags;
+	__u32	unused;
 	__u32	padding;
 	__u64	lock_owner;
 };

--
