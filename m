Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbTHZOiT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbTHZOhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:37:55 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:36753 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S261382AbTHZOfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:35:18 -0400
To: <akpm@osdl.org>
Subject: [PATCH 2.6.0-test4]bad_inode dcl fixes
From: <ffrederick@prov-liege.be>
Cc: <linux-kernel@vger.kernel.org>
Date: Tue, 26 Aug 2003 17:00:08 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S261382AbTHZOfS/20030826143714Z+199247@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
        Here's a patch against 2.6.0-test4 bad_inode structures

Summary:
	-All operations assigned to EIO
        -_current?_EIO question

	Could you apply ?

Regards,
Fabian

--- orig/fs/bad_inode.c	2003-08-22 23:53:03.000000000 +0000
+++ edited/fs/bad_inode.c	2003-08-26 16:33:39.000000000 +0000
@@ -4,6 +4,8 @@
  *  Copyright (C) 1997, Stephen Tweedie
  *
  *  Provide stub functions for unreadable inodes
+ *  
+ *  Fabian Frederick : August 2003 - All file operations assigned to EIO
  */
 
 #include <linux/fs.h>
@@ -28,11 +30,18 @@
 
 #define EIO_ERROR ((void *) (return_EIO))
 
+/*
+ * Returned file & inode operations attached to bad inode
+ * (Is it the _real_ current EIO ? (Fab))
+ */ 
+
 static struct file_operations bad_file_ops =
 {
 	.llseek		= EIO_ERROR,
+	.aio_read	= EIO_ERROR,
 	.read		= EIO_ERROR,
 	.write		= EIO_ERROR,
+	.aio_write	= EIO_ERROR,
 	.readdir	= EIO_ERROR,
 	.poll		= EIO_ERROR,
 	.ioctl		= EIO_ERROR,
@@ -41,8 +50,14 @@
 	.flush		= EIO_ERROR,
 	.release	= EIO_ERROR,
 	.fsync		= EIO_ERROR,
+	.aio_fsync	= EIO_ERROR,
 	.fasync		= EIO_ERROR,
 	.lock		= EIO_ERROR,
+	.readv		= EIO_ERROR,
+	.writev		= EIO_ERROR,
+	.sendfile	= EIO_ERROR,
+	.sendpage	= EIO_ERROR,
+	.get_unmapped_area = EIO_ERROR,
 };
 
 struct inode_operations bad_inode_ops =
@@ -61,6 +76,11 @@
 	.truncate	= EIO_ERROR,
 	.permission	= EIO_ERROR,
 	.getattr	= EIO_ERROR,
+	.setattr	= EIO_ERROR,
+	.setxattr	= EIO_ERROR,
+	.getxattr	= EIO_ERROR,
+	.listxattr	= EIO_ERROR,
+	.removexattr	= EIO_ERROR,
 };
 
 


___________________________________



