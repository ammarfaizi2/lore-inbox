Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVCNUuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVCNUuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVCNUuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:50:01 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:8380
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S261894AbVCNUtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:49:43 -0500
Date: Mon, 14 Mar 2005 20:49:42 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] fs/proc/base.c - fix sparse errors
Message-ID: <20050314204942.GA32406@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rewrite initialiser for proc_oom_adjust_operations,
and add __user annotations to oom_adjust_{read|write}

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urN -X ../dontdiff linux-2.6.11-bk10/fs/proc/base.c linux-2.6.11-bk10-procfs/fs/proc/base.c
--- linux-2.6.11-bk10/fs/proc/base.c	2005-03-14 14:45:00.000000000 +0000
+++ linux-2.6.11-bk10-procfs/fs/proc/base.c	2005-03-14 20:43:39.000000000 +0000
@@ -715,7 +715,7 @@
 	.open		= mem_open,
 };
 
-static ssize_t oom_adjust_read(struct file *file, char *buf,
+static ssize_t oom_adjust_read(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
@@ -735,7 +735,7 @@
 	return count;
 }
 
-static ssize_t oom_adjust_write(struct file *file, const char *buf,
+static ssize_t oom_adjust_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
@@ -761,8 +761,8 @@
 }
 
 static struct file_operations proc_oom_adjust_operations = {
-	read:		oom_adjust_read,
-	write:		oom_adjust_write,
+	.read		= oom_adjust_read,
+	.write		= oom_adjust_write,
 };
 
 static struct inode_operations proc_mem_inode_operations = {

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fs-proc-base.patch"

diff -urN -X ../dontdiff linux-2.6.11-bk10/fs/proc/base.c linux-2.6.11-bk10-procfs/fs/proc/base.c
--- linux-2.6.11-bk10/fs/proc/base.c	2005-03-14 14:45:00.000000000 +0000
+++ linux-2.6.11-bk10-procfs/fs/proc/base.c	2005-03-14 20:43:39.000000000 +0000
@@ -715,7 +715,7 @@
 	.open		= mem_open,
 };
 
-static ssize_t oom_adjust_read(struct file *file, char *buf,
+static ssize_t oom_adjust_read(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
@@ -735,7 +735,7 @@
 	return count;
 }
 
-static ssize_t oom_adjust_write(struct file *file, const char *buf,
+static ssize_t oom_adjust_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
@@ -761,8 +761,8 @@
 }
 
 static struct file_operations proc_oom_adjust_operations = {
-	read:		oom_adjust_read,
-	write:		oom_adjust_write,
+	.read		= oom_adjust_read,
+	.write		= oom_adjust_write,
 };
 
 static struct inode_operations proc_mem_inode_operations = {

--XsQoSWH+UP9D9v3l--
