Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWC1XAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWC1XAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWC1W7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:59:14 -0500
Received: from [198.99.130.12] ([198.99.130.12]:23235 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964781AbWC1W7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:59:02 -0500
Message-Id: <200603282300.k2SN0Fci022997@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       viro@zeniv.linux.org.uk
Subject: [PATCH 8/10] UML - __user annotations
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Mar 2006 18:00:15 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

uml: __user annotations (hppfs)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

 fs/hppfs/hppfs_kern.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
index a44dc58..8469826 100644
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -216,10 +216,10 @@ static struct dentry *hppfs_lookup(struc
 static struct inode_operations hppfs_file_iops = {
 };
 
-static ssize_t read_proc(struct file *file, char *buf, ssize_t count,
+static ssize_t read_proc(struct file *file, char __user *buf, ssize_t count,
 			 loff_t *ppos, int is_user)
 {
-	ssize_t (*read)(struct file *, char *, size_t, loff_t *);
+	ssize_t (*read)(struct file *, char __user *, size_t, loff_t *);
 	ssize_t n;
 
 	read = file->f_dentry->d_inode->i_fop->read;
@@ -236,7 +236,7 @@ static ssize_t read_proc(struct file *fi
 	return n;
 }
 
-static ssize_t hppfs_read_file(int fd, char *buf, ssize_t count)
+static ssize_t hppfs_read_file(int fd, char __user *buf, ssize_t count)
 {
 	ssize_t n;
 	int cur, err;
@@ -274,7 +274,7 @@ static ssize_t hppfs_read_file(int fd, c
 	return n;
 }
 
-static ssize_t hppfs_read(struct file *file, char *buf, size_t count,
+static ssize_t hppfs_read(struct file *file, char __user *buf, size_t count,
 			  loff_t *ppos)
 {
 	struct hppfs_private *hppfs = file->private_data;
@@ -313,12 +313,12 @@ static ssize_t hppfs_read(struct file *f
 	return(count);
 }
 
-static ssize_t hppfs_write(struct file *file, const char *buf, size_t len,
+static ssize_t hppfs_write(struct file *file, const char __user *buf, size_t len,
 			   loff_t *ppos)
 {
 	struct hppfs_private *data = file->private_data;
 	struct file *proc_file = data->proc_file;
-	ssize_t (*write)(struct file *, const char *, size_t, loff_t *);
+	ssize_t (*write)(struct file *, const char __user *, size_t, loff_t *);
 	int err;
 
 	write = proc_file->f_dentry->d_inode->i_fop->write;
@@ -658,7 +658,7 @@ static struct super_operations hppfs_sbo
 	.statfs		= hppfs_statfs,
 };
 
-static int hppfs_readlink(struct dentry *dentry, char *buffer, int buflen)
+static int hppfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
 	struct file *proc_file;
 	struct dentry *proc_dentry;

