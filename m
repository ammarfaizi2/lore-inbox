Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130475AbRBAOyf>; Thu, 1 Feb 2001 09:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130477AbRBAOyR>; Thu, 1 Feb 2001 09:54:17 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:15885 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S130474AbRBAOyG>; Thu, 1 Feb 2001 09:54:06 -0500
Date: Thu, 1 Feb 2001 14:54:00 +0000 (GMT)
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com
Subject: [PATCH] schedule_timeout() srcdocs
Message-ID: <Pine.LNX.4.21.0102011451590.4123-100000@mrworry.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The below fixes some minor things and attempts to add srcdocs
for schedule_timeout(). Can people look at it and comment if there's
more gotcha's that should be commented on there ?

It's against 2.4.0ac12

thanks
john

--- kernel/kmod.old.c	Thu Feb  1 14:39:40 2001
+++ kernel/kmod.c	Thu Feb  1 14:40:27 2001
@@ -157,19 +157,18 @@ static int exec_modprobe(void * module_n
 }
 
 /**
- *	request_module - try to load a kernel module
- *	@module_name: Name of module
+ * request_module - try to load a kernel module
+ * @module_name: Name of module
  *
- * 	Load a module using the user mode module loader. The function returns
- *	zero on success or a negative errno code on failure. Note that a
- * 	successful module load does not mean the module did not then unload
- *	and exit on an error of its own. Callers must check that the service
- *	they requested is now available not blindly invoke it.
+ * Load a module using the user mode module loader. The function returns
+ * zero on success or a negative errno code on failure. Note that a
+ * successful module load does not mean the module did not then unload
+ * and exit on an error of its own. Callers must check that the service
+ * they requested is now available not blindly invoke it.
  *
- *	If module auto-loading support is disabled then this function
- *	becomes a no-operation.
+ * If module auto-loading support is disabled then this function
+ * becomes a no-operation.
  */
- 
 int request_module(const char * module_name)
 {
 	pid_t pid;
--- kernel/sched.old.c	Mon Jan 29 11:22:36 2001
+++ kernel/sched.c	Thu Feb  1 14:36:31 2001
@@ -366,6 +366,32 @@ static void process_timeout(unsigned lon
 	wake_up_process(p);
 }
 
+/**
+ * schedule_timeout - sleep until timeout
+ * @timeout: timeout value in jiffies
+ *
+ * Make the current task sleep until @timeout jiffies have
+ * elapsed. The routine will return immediately unless
+ * the current task state has been set (see set_current_state()).
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
+ * pass before the routine returns. The routine will return 0
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task. In this case the remaining time
+ * in jiffies will be returned, or 0 if the timer expired in time
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this 
+ * routine returns.
+ *
+ * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT will schedule
+ * the CPU away without a bound on the timeout. In this case the return
+ * value will be %MAX_SCHEDULE_TIMEOUT.
+ *
+ * In all cases the return value is guaranteed to be non-negative.
+ */
 signed long schedule_timeout(signed long timeout)
 {
 	struct timer_list timer;
--- Documentation/DocBook/Makefile.old	Thu Feb  1 14:24:08 2001
+++ Documentation/DocBook/Makefile	Thu Feb  1 14:41:10 2001
@@ -79,6 +79,8 @@ APISOURCES :=	$(TOPDIR)/drivers/media/vi
 		$(TOPDIR)/drivers/usb/usb.c \
 		$(TOPDIR)/fs/locks.c \
 		$(TOPDIR)/fs/devfs/base.c \
+		$(TOPDIR)/kernel/kmod.c \
+		$(TOPDIR)/kernel/sched.c \
 		$(TOPDIR)/kernel/sysctl.c \
 		$(TOPDIR)/kernel/pm.c \
 		$(TOPDIR)/kernel/ksyms.c \
--- Documentation/DocBook/kernel-api.old.tmpl	Mon Jan 29 11:21:57 2001
+++ Documentation/DocBook/kernel-api.tmpl	Thu Feb  1 14:38:47 2001
@@ -36,13 +36,17 @@
 <toc></toc>
 
   <chapter id="Basics">
-     <title>Driver Basic</title>
+     <title>Driver Basics</title>
      <sect1><title>Driver Entry and Exit points</title>
 !Iinclude/linux/init.h
      </sect1>
 
      <sect1><title>Atomics</title>
 !Iinclude/asm-i386/atomic.h
+     </sect1>
+
+     <sect1><title>Delaying, scheduling, and timer routines</title>
+!Ekernel/sched.c
      </sect1>
   </chapter>
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
