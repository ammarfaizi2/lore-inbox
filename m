Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272229AbTHDUQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272230AbTHDUQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:16:56 -0400
Received: from thunk.org ([140.239.227.29]:47040 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S272229AbTHDUQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:16:49 -0400
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix 32/64-bit bug in ext3
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E19jkjT-0001p0-00@think.thunk.org>
Date: Mon, 04 Aug 2003 15:10:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch fixes a 32/64-bit bug in ext3.  We assign the number
of bytes written to an int instead of a ssize_t, which causes the top
32-bits of the return value from write() to be lopped off.  Please
apply to 2.6.0-test tree.  Thanks!!

						- Ted


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1595  -> 1.1596 
#	      fs/ext3/file.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/04	tytso@think.thunk.org	1.1596
# Fix 32/64-bit error in ext2_file_write; before, the top 32-bits of
# the return value was getting chopped off.
# --------------------------------------------
#
diff -Nru a/fs/ext3/file.c b/fs/ext3/file.c
--- a/fs/ext3/file.c	Mon Aug  4 14:46:41 2003
+++ b/fs/ext3/file.c	Mon Aug  4 14:46:41 2003
@@ -60,7 +60,8 @@
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode;
-	int ret, err;
+	ssize_t ret;
+	int err;
 
 	ret = generic_file_aio_write(iocb, buf, count, pos);
 
