Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVCaUz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVCaUz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 15:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVCaUz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 15:55:28 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:2995 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261562AbVCaUzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 15:55:06 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: 1/3 add padding
Message-Id: <E1DH6go-00016V-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 31 Mar 2005 22:54:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add padding to structures to make sizes the same on 32bit and 64bit
archs.  Initial testing and test machine generously provided by Franco
Broi.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc1-mm4/include/linux/fuse.h linux-fuse/include/linux/fuse.h
--- linux-2.6.12-rc1-mm4/include/linux/fuse.h	2005-03-31 21:43:52.000000000 +0200
+++ linux-fuse/include/linux/fuse.h	2005-03-31 21:48:42.000000000 +0200
@@ -25,6 +25,9 @@
 /** The minor number of the fuse character device */
 #define FUSE_MINOR 229
 
+/* Make sure all structures are padded to 64bit boundary, so 32bit
+   userspace works under 64bit kernels */
+
 struct fuse_attr {
 	__u64	ino;
 	__u64	size;
@@ -126,6 +129,7 @@ struct fuse_mknod_in {
 
 struct fuse_mkdir_in {
 	__u32	mode;
+	__u32	padding;
 };
 
 struct fuse_rename_in {
@@ -138,32 +142,38 @@ struct fuse_link_in {
 
 struct fuse_setattr_in {
 	__u32	valid;
+	__u32	padding;
 	struct fuse_attr attr;
 };
 
 struct fuse_open_in {
 	__u32	flags;
+	__u32	padding;
 };
 
 struct fuse_open_out {
 	__u64	fh;
 	__u32	open_flags;
+	__u32	padding;
 };
 
 struct fuse_release_in {
 	__u64	fh;
 	__u32	flags;
+	__u32	padding;
 };
 
 struct fuse_flush_in {
 	__u64	fh;
 	__u32	flush_flags;
+	__u32	padding;
 };
 
 struct fuse_read_in {
 	__u64	fh;
 	__u64	offset;
 	__u32	size;
+	__u32	padding;
 };
 
 struct fuse_write_in {
@@ -175,6 +185,7 @@ struct fuse_write_in {
 
 struct fuse_write_out {
 	__u32	size;
+	__u32	padding;
 };
 
 struct fuse_statfs_out {
@@ -184,6 +195,7 @@ struct fuse_statfs_out {
 struct fuse_fsync_in {
 	__u64	fh;
 	__u32	fsync_flags;
+	__u32	padding;
 };
 
 struct fuse_setxattr_in {
@@ -193,10 +205,12 @@ struct fuse_setxattr_in {
 
 struct fuse_getxattr_in {
 	__u32	size;
+	__u32	padding;
 };
 
 struct fuse_getxattr_out {
 	__u32	size;
+	__u32	padding;
 };
 
 struct fuse_init_in_out {
@@ -212,6 +226,7 @@ struct fuse_in_header {
 	__u32	uid;
 	__u32	gid;
 	__u32	pid;
+	__u32	padding;
 };
 
 struct fuse_out_header {

