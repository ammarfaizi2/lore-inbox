Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVC0Oh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVC0Oh3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 09:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVC0OhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 09:37:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12813 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261734AbVC0Oe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 09:34:59 -0500
Date: Sun, 27 Mar 2005 16:34:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/exit.c: make exit_mm static
Message-ID: <20050327143458.GK4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 3 Mar 2005

 include/linux/sched.h |    1 -
 kernel/exit.c         |    4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.11-rc5-mm1-full/include/linux/sched.h.old	2005-03-03 14:52:53.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/include/linux/sched.h	2005-03-03 14:55:02.000000000 +0100
@@ -1030,7 +1030,6 @@
 extern void flush_thread(void);
 extern void exit_thread(void);
 
-extern void exit_mm(struct task_struct *);
 extern void exit_files(struct task_struct *);
 extern void exit_signal(struct task_struct *);
 extern void __exit_signal(struct task_struct *);
--- linux-2.6.11-rc5-mm1-full/kernel/exit.c.old	2005-03-03 14:53:48.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/exit.c	2005-03-03 14:55:28.000000000 +0100
@@ -39,6 +39,8 @@
 
 int getrusage(struct task_struct *, int, struct rusage __user *);
 
+static void exit_mm(struct task_struct * tsk);
+
 static void __unhash_process(struct task_struct *p)
 {
 	nr_threads--;
@@ -475,7 +477,7 @@
  * Turn us into a lazy TLB process if we
  * aren't already..
  */
-void exit_mm(struct task_struct * tsk)
+static void exit_mm(struct task_struct * tsk)
 {
 	struct mm_struct *mm = tsk->mm;
 

