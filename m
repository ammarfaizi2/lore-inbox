Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVBOL4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVBOL4O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 06:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVBOL4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 06:56:14 -0500
Received: from mx1.mail.ru ([194.67.23.121]:47129 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261691AbVBOL4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 06:56:08 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] procfs: Fix sparse warnings
Date: Tue, 15 Feb 2005 14:55:55 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502151455.55711.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Index: linux-warnings/fs/proc/base.c
===================================================================
--- linux-warnings/fs/proc/base.c	(revision 25)
+++ linux-warnings/fs/proc/base.c	(revision 29)
@@ -689,7 +689,7 @@
 	.open		= mem_open,
 };
 
-static ssize_t oom_adjust_read(struct file *file, char *buf,
+static ssize_t oom_adjust_read(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
@@ -709,7 +709,7 @@
 	return count;
 }
 
-static ssize_t oom_adjust_write(struct file *file, const char *buf,
+static ssize_t oom_adjust_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
@@ -735,8 +735,8 @@
 }
 
 static struct file_operations proc_oom_adjust_operations = {
-	read:		oom_adjust_read,
-	write:		oom_adjust_write,
+	.read		= oom_adjust_read,
+	.write		= oom_adjust_write,
 };
 
 static struct inode_operations proc_mem_inode_operations = {
