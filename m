Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbTF0UQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 16:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264768AbTF0UQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 16:16:49 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:21523 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S264763AbTF0UQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 16:16:47 -0400
Subject: PATCH 2.4.21 : make pid of type pid_t
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Jun 2003 22:31:01 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19Vzs5-000CSB-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
some function use int others use long for a pid. The right type is
pid_t (and most functions use it). This fixes some that use something else
than pid_t. The patches are work from daniele bellucci and me.

walter

--- kernel/fork.c.org   2003-06-23 21:48:41.000000000 +0200
+++ kernel/fork.c       2003-06-25 21:14:15.000000000 +0200
@@ -35,7 +35,7 @@
 
 int max_threads;
 unsigned long total_forks;     /* Handle normal Linux uptimes. */
-int last_pid;
+pid_t last_pid;
 
 struct task_struct *pidhash[PIDHASH_SZ];
 
@@ -84,11 +84,11 @@
 /* Protects next_safe and last_pid. */
 spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
 
-static int get_pid(unsigned long flags)
+static pid_t get_pid(unsigned long flags)
 {
-       static int next_safe = PID_MAX;
+       static pid_t next_safe = PID_MAX;
        struct task_struct *p;
-       int pid, beginpid;
+       pid_t pid, beginpid;
 
        if (flags & CLONE_PID)
                return current->pid;
@@ -566,11 +566,11 @@
        p->flags = new_flags;
 }
 
-long kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
        struct task_struct *task = current;
        unsigned old_task_dumpable;
-       long ret;
+       pid_t ret;
 
        /* lock out any potential ptracer */
        task_lock(task);
@@ -600,10 +600,10 @@
  * For an example that's using stack_top, see
  * arch/ia64/kernel/process.c.
  */
-int do_fork(unsigned long clone_flags, unsigned long stack_start,
+pid_t do_fork(unsigned long clone_flags, unsigned long stack_start,
            struct pt_regs *regs, unsigned long stack_size)
 {
-       int retval;
+       pid_t retval;
        struct task_struct *p;
        struct completion vfork;
 

-- 
