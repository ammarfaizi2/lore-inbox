Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313109AbSDJOKN>; Wed, 10 Apr 2002 10:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSDJOKM>; Wed, 10 Apr 2002 10:10:12 -0400
Received: from [62.221.7.202] ([62.221.7.202]:48266 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S313109AbSDJOKK>; Wed, 10 Apr 2002 10:10:10 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.8-pre3 set_bit cleanup IV
Date: Wed, 10 Apr 2002 23:45:45 +1000
Message-Id: <E16vIPx-0002Yy-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changes everything arch specific PPC and i386 which should have
been unsigned long (it doesn't *matter*, but bad habits get copied to
where it does matter).

No object code changes,
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.8-pre1.19752/include/asm-i386/thread_info.h linux-2.5.8-pre1.19752.updated/include/asm-i386/thread_info.h
--- linux-2.5.8-pre1.19752/include/asm-i386/thread_info.h	Wed Feb 20 17:56:40 2002
+++ linux-2.5.8-pre1.19752.updated/include/asm-i386/thread_info.h	Thu Apr  4 15:50:09 2002
@@ -23,7 +23,7 @@
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
-	__u32			flags;		/* low level flags */
+	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.8-pre1.19752/arch/ppc/platforms/pmac_pic.c linux-2.5.8-pre1.19752.updated/arch/ppc/platforms/pmac_pic.c
--- linux-2.5.8-pre1.19752/arch/ppc/platforms/pmac_pic.c	Wed Feb 20 17:57:04 2002
+++ linux-2.5.8-pre1.19752.updated/arch/ppc/platforms/pmac_pic.c	Thu Apr  4 15:50:09 2002
@@ -492,7 +492,7 @@
  * and disables all interrupts except for the nominated one.
  * sleep_restore_intrs() restores the states of all interrupt enables.
  */
-unsigned int sleep_save_mask[2];
+unsigned long sleep_save_mask[2];
 
 void __pmac
 pmac_sleep_save_intrs(int viaint)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.8-pre1.19752/drivers/macintosh/adb.c linux-2.5.8-pre1.19752.updated/drivers/macintosh/adb.c
--- linux-2.5.8-pre1.19752/drivers/macintosh/adb.c	Wed Feb 20 17:55:08 2002
+++ linux-2.5.8-pre1.19752.updated/drivers/macintosh/adb.c	Thu Apr  4 15:50:09 2002
@@ -77,7 +77,7 @@
 static int adb_got_sleep = 0;
 static int adb_inited = 0;
 static pid_t adb_probe_task_pid;
-static int adb_probe_task_flag;
+static unsigned long adb_probe_task_flag;
 static wait_queue_head_t adb_probe_task_wq;
 static int sleepy_trackpad;
 int __adb_probe_sync;
@@ -439,7 +439,7 @@
 }
 
 static struct adb_request adb_sreq;
-static int adb_sreq_lock; // Use semaphore ! */ 
+static unsigned long adb_sreq_lock; // Use semaphore ! */ 
 
 int
 adb_request(struct adb_request *req, void (*done)(struct adb_request *),

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
