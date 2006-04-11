Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWDKLDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWDKLDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWDKLDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:03:31 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:39331 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750740AbWDKLDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:03:31 -0400
Date: Tue, 11 Apr 2006 14:03:28 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: add splice_write and splice_read to documentation
Message-ID: <Pine.LNX.4.58.0604111402550.15286@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch adds the new splice_write and splice_read file operations to
Documentation/filesystems/vfs.txt.

Cc: Jens Axboe <axboe@suse.de>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 vfs.txt |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index adaa899..73a79c0 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -694,7 +694,7 @@ struct file_operations
 ----------------------
 
 This describes how the VFS can manipulate an open file. As of kernel
-2.6.13, the following members are defined:
+2.6.17, the following members are defined:
 
 struct file_operations {
 	loff_t (*llseek) (struct file *, loff_t, int);
@@ -723,6 +723,8 @@ struct file_operations {
 	int (*check_flags)(int);
 	int (*dir_notify)(struct file *filp, unsigned long arg);
 	int (*flock) (struct file *, int, struct file_lock *);
+	ssize_t (*splice_write)(struct inode *, struct file *, size_t, unsigned int);
+	ssize_t (*splice_read)(struct file *, struct inode *, size_t, unsigned int);
 };
 
 Again, all methods are called without any locks being held, unless
@@ -790,6 +792,12 @@ otherwise noted.
 
   flock: called by the flock(2) system call
 
+  splice_write: called by the VFS to splice data from a pipe to a file. This
+  	method is used by the splice(2) system call
+
+  splice_read: called by the VFS to splice data from file to a pipe. This
+  	method is used by the splice(2) system call
+
 Note that the file operations are implemented by the specific
 filesystem in which the inode resides. When opening a device node
 (character or block special) most filesystems will call special
