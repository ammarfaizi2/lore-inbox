Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313045AbSDCDv4>; Tue, 2 Apr 2002 22:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313047AbSDCDvq>; Tue, 2 Apr 2002 22:51:46 -0500
Received: from CPE-203-51-31-188.nsw.bigpond.net.au ([203.51.31.188]:54402
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S313046AbSDCDvg>; Tue, 2 Apr 2002 22:51:36 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bitops cleanup 3/4
Date: Wed, 03 Apr 2002 13:18:24 +1000
Message-Id: <E16sbI0-0005ug-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply (no object code changes).

This changes everything arch specific PPC and i386 which should have
been unsigned long (it doesn't *matter*, but bad habits get copied).

I left the devfs ones for Richard to submit separately, since they
actually change the resulting code.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/arch/ppc/platforms/pmac_pic.c working-2.5.7-pre1-bitops/arch/ppc/platforms/pmac_pic.c
--- linux-2.5.7-pre1/arch/ppc/platforms/pmac_pic.c	Wed Feb 20 17:57:04 2002
+++ working-2.5.7-pre1-bitops/arch/ppc/platforms/pmac_pic.c	Sat Mar 16 12:59:37 2002
@@ -492,7 +492,7 @@
  * and disables all interrupts except for the nominated one.
  * sleep_restore_intrs() restores the states of all interrupt enables.
  */
-unsigned int sleep_save_mask[2];
+unsigned long sleep_save_mask[2];
 
 void __pmac
 pmac_sleep_save_intrs(int viaint)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/drivers/macintosh/adb.c working-2.5.7-pre1-bitops/drivers/macintosh/adb.c
--- linux-2.5.7-pre1/drivers/macintosh/adb.c	Wed Feb 20 17:55:08 2002
+++ working-2.5.7-pre1-bitops/drivers/macintosh/adb.c	Sat Mar 16 12:59:37 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/devfs_fs_kernel.h working-2.5.7-pre1-bitops/include/linux/devfs_fs_kernel.h
--- linux-2.5.7-pre1/include/linux/devfs_fs_kernel.h	Fri Mar 15 15:37:39 2002
+++ working-2.5.7-pre1-bitops/include/linux/devfs_fs_kernel.h	Sat Mar 16 13:54:53 2002
@@ -54,7 +54,7 @@
     unsigned char sem_initialised;
     unsigned int num_free;          /*  Num free in bits       */
     unsigned int length;            /*  Array length in bytes  */
-    __u32 *bits;
+    unsigned long *bits;
     struct semaphore semaphore;
 };
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/sunrpc/svcsock.h working-2.5.7-pre1-bitops/include/linux/sunrpc/svcsock.h
--- linux-2.5.7-pre1/include/linux/sunrpc/svcsock.h	Fri Mar 15 13:07:05 2002
+++ working-2.5.7-pre1-bitops/include/linux/sunrpc/svcsock.h	Sat Mar 16 12:59:37 2002
@@ -22,7 +22,7 @@
 
 	struct svc_serv *	sk_server;	/* service for this socket */
 	unsigned char		sk_inuse;	/* use count */
-	unsigned int		sk_flags;
+	unsigned long		sk_flags;
 #define	SK_BUSY		0			/* enqueued/receiving */
 #define	SK_CONN		1			/* conn pending */
 #define	SK_CLOSE	2			/* dead or dying */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-i386/thread_info.h working-2.5.7-pre1-bitops/include/asm-i386/thread_info.h
--- linux-2.5.7-pre1/include/asm-i386/thread_info.h	Sat Mar 16 13:03:31 2002
+++ working-2.5.7-pre1-bitops/include/asm-i386/thread_info.h	Sat Mar 16 13:46:30 2002
@@ -23,7 +23,7 @@
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
-	__u32			flags;		/* low level flags */
+	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
