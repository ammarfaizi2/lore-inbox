Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbULLTXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbULLTXc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 14:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbULLTWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 14:22:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25104 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262111AbULLTVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:21:08 -0500
Date: Sun, 12 Dec 2004 20:20:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/exit.c: make a function static
Message-ID: <20041212192052.GX22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


diffstat output:
 include/linux/sched.h |    1 -
 kernel/exit.c         |    4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/linux/sched.h.old	2004-12-12 02:48:14.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/sched.h	2004-12-12 02:48:19.000000000 +0100
@@ -915,7 +915,6 @@
 extern void flush_thread(void);
 extern void exit_thread(void);
 
-extern void exit_mm(struct task_struct *);
 extern void exit_files(struct task_struct *);
 extern void exit_signal(struct task_struct *);
 extern void __exit_signal(struct task_struct *);
--- linux-2.6.10-rc2-mm4-full/kernel/exit.c.old	2004-12-12 02:48:26.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/exit.c	2004-12-12 02:48:47.000000000 +0100
@@ -39,6 +39,8 @@
 
 int getrusage(struct task_struct *, int, struct rusage __user *);
 
+static void exit_mm(struct task_struct *tsk);
+
 static void __unhash_process(struct task_struct *p)
 {
 	nr_threads--;
@@ -510,7 +512,7 @@
 	mmput(mm);
 }
 
-void exit_mm(struct task_struct *tsk)
+static void exit_mm(struct task_struct *tsk)
 {
 	__exit_mm(tsk);
 }

