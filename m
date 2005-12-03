Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVLCMRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVLCMRD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 07:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVLCMRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 07:17:01 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56580 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751211AbVLCMRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 07:17:00 -0500
Date: Sat, 3 Dec 2005 13:17:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/proc/: function prototypes belong into header files
Message-ID: <20051203121701.GB31395@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Function prototypes belong into header files.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/proc/generic.c  |    2 ++
 fs/proc/inode.c    |    2 +-
 fs/proc/internal.h |    4 ++++
 fs/proc/root.c     |    3 ++-
 4 files changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc3-mm1/fs/proc/internal.h.old	2005-12-03 11:28:20.000000000 +0100
+++ linux-2.6.15-rc3-mm1/fs/proc/internal.h	2005-12-03 11:30:53.000000000 +0100
@@ -37,6 +37,10 @@
 extern int proc_pid_status(struct task_struct *, char *);
 extern int proc_pid_statm(struct task_struct *, char *);
 
+void free_proc_entry(struct proc_dir_entry *de);
+
+int proc_init_inodecache(void);
+
 static inline struct task_struct *proc_task(struct inode *inode)
 {
 	return PROC_I(inode)->task;
--- linux-2.6.15-rc3-mm1/fs/proc/root.c.old	2005-12-03 11:28:41.000000000 +0100
+++ linux-2.6.15-rc3-mm1/fs/proc/root.c	2005-12-03 11:29:15.000000000 +0100
@@ -18,6 +18,8 @@
 #include <linux/bitops.h>
 #include <linux/smp_lock.h>
 
+#include "internal.h"
+
 struct proc_dir_entry *proc_net, *proc_net_stat, *proc_bus, *proc_root_fs, *proc_root_driver;
 
 #ifdef CONFIG_SYSCTL
@@ -36,7 +38,6 @@
 	.kill_sb	= kill_anon_super,
 };
 
-extern int __init proc_init_inodecache(void);
 void __init proc_root_init(void)
 {
 	int err = proc_init_inodecache();
--- linux-2.6.15-rc3-mm1/fs/proc/inode.c.old	2005-12-03 11:29:30.000000000 +0100
+++ linux-2.6.15-rc3-mm1/fs/proc/inode.c	2005-12-03 11:30:55.000000000 +0100
@@ -19,7 +19,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
-extern void free_proc_entry(struct proc_dir_entry *);
+#include "internal.h"
 
 static inline struct proc_dir_entry * de_get(struct proc_dir_entry *de)
 {
--- linux-2.6.15-rc3-mm1/fs/proc/generic.c.old	2005-12-03 11:29:59.000000000 +0100
+++ linux-2.6.15-rc3-mm1/fs/proc/generic.c	2005-12-03 11:30:34.000000000 +0100
@@ -21,6 +21,8 @@
 #include <linux/bitops.h>
 #include <asm/uaccess.h>
 
+#include "internal.h"
+
 static ssize_t proc_file_read(struct file *file, char __user *buf,
 			      size_t nbytes, loff_t *ppos);
 static ssize_t proc_file_write(struct file *file, const char __user *buffer,

