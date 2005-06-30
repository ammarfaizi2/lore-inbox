Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263036AbVF3UHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbVF3UHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbVF3UGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:06:41 -0400
Received: from unused.mind.net ([69.9.134.98]:34469 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262987AbVF3Trf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:47:35 -0400
Date: Thu, 30 Jun 2005 12:46:13 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Karsten Wiese <annabellesgarden@yahoo.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-37
In-Reply-To: <200506301952.22022.annabellesgarden@yahoo.de>
Message-ID: <Pine.LNX.4.58.0506301238450.20655@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050629193804.GA6256@elte.hu>
 <200506300136.01061.annabellesgarden@yahoo.de> <200506301952.22022.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

-50-37 wouldn't compile out of the box on my debug config.
Here's a couple minor cleanups:

--- linux-2.6.12-RT-V0.7.50-37.orig/include/linux/preempt.h	2005-06-30 12:36:37.000000000 -0700
+++ linux-2.6.12-RT-V0.7.50-37/include/linux/preempt.h	2005-06-30 12:23:38.000000000 -0700
@@ -8,6 +8,7 @@
 
 #include <linux/config.h>
 #include <linux/linkage.h>
+#include <linux/thread_info.h>
 
 #if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_CRITICAL_TIMING)
   extern void notrace add_preempt_count(unsigned int val);
--- linux-2.6.12-RT-V0.7.50-37.orig/kernel/rt.c	2005-06-30 12:36:37.000000000 -0700
+++ linux-2.6.12-RT-V0.7.50-37/kernel/rt.c	2005-06-30 12:30:55.000000000 -0700
@@ -450,7 +450,7 @@
 #ifdef CONFIG_DEBUG_PREEMPT
 	if (task->lock_count) {
 		static int once = 1;
-		if (once > 0)
+		if (once > 0) {
 			once--;
 			printk("BUG: nonzero lock count %d at exit time?\n",
 				task->lock_count);
@@ -925,7 +925,7 @@
 static int
 capture_lock(struct rt_mutex_waiter *waiter, struct task_struct *task)
 {
-	struct thread_info *ti = current_thread_info();
+	//struct thread_info *ti = current_thread_info();
 	struct rt_mutex *lock = waiter->lock;
 	unsigned long flags;
 	int ret = 0;
@@ -1411,7 +1411,7 @@
  */
 static void __up_mutex(struct rt_mutex *lock, int save_state __EIP_DECL__)
 {
-	struct thread_info *ti = current_thread_info();
+	//struct thread_info *ti = current_thread_info();
 	struct task_struct *old_owner, *new_owner;
 	struct rt_mutex_waiter *w;
 	unsigned long flags;


FYI, a diff against include/linux/compile.h also made it into the the 
-50-37 patch.


--ww
