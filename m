Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVBRXss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVBRXss (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVBRXss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:48:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34066 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261565AbVBRXsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:48:14 -0500
Date: Sat, 19 Feb 2005 00:48:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: phil.el@wanadoo.fr
Cc: oprofile-list@lists.sf.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] oprofile: make some code static
Message-ID: <20050218234809.GD4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/oprofile/buffer_sync.c  |    6 +++---
 drivers/oprofile/cpu_buffer.c   |    2 +-
 drivers/oprofile/event_buffer.c |    7 ++++---
 3 files changed, 8 insertions(+), 7 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/oprofile/buffer_sync.c.old	2005-02-17 22:18:31.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/oprofile/buffer_sync.c	2005-02-17 22:19:25.000000000 +0100
@@ -34,9 +34,9 @@
  
 static LIST_HEAD(dying_tasks);
 static LIST_HEAD(dead_tasks);
-cpumask_t marked_cpus = CPU_MASK_NONE;
+static cpumask_t marked_cpus = CPU_MASK_NONE;
 static DEFINE_SPINLOCK(task_mortuary);
-void process_task_mortuary(void);
+static void process_task_mortuary(void);
 
 
 /* Take ownership of the task struct and place it on the
@@ -422,7 +422,7 @@
  * and to have reached the list, it must have gone through
  * one full sync already.
  */
-void process_task_mortuary(void)
+static void process_task_mortuary(void)
 {
 	struct list_head * pos;
 	struct list_head * pos2;
--- linux-2.6.11-rc3-mm2-full/drivers/oprofile/cpu_buffer.c.old	2005-02-17 22:20:01.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/oprofile/cpu_buffer.c	2005-02-17 22:20:10.000000000 +0100
@@ -32,7 +32,7 @@
 static void wq_sync_buffer(void *);
 
 #define DEFAULT_TIMER_EXPIRE (HZ / 10)
-int work_enabled;
+static int work_enabled;
 
 void free_cpu_buffers(void)
 {
--- linux-2.6.11-rc3-mm2-full/drivers/oprofile/event_buffer.c.old	2005-02-17 22:20:45.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/oprofile/event_buffer.c	2005-02-17 22:21:38.000000000 +0100
@@ -94,7 +94,7 @@
 }
 
  
-int event_buffer_open(struct inode * inode, struct file * file)
+static int event_buffer_open(struct inode * inode, struct file * file)
 {
 	int err = -EPERM;
 
@@ -130,7 +130,7 @@
 }
 
 
-int event_buffer_release(struct inode * inode, struct file * file)
+static int event_buffer_release(struct inode * inode, struct file * file)
 {
 	oprofile_stop();
 	oprofile_shutdown();
@@ -142,7 +142,8 @@
 }
 
 
-ssize_t event_buffer_read(struct file * file, char __user * buf, size_t count, loff_t * offset)
+static ssize_t event_buffer_read(struct file * file, char __user * buf,
+				 size_t count, loff_t * offset)
 {
 	int retval = -EINVAL;
 	size_t const max = buffer_size * sizeof(unsigned long);

