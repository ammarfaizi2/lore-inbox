Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315684AbSEIK2r>; Thu, 9 May 2002 06:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315687AbSEIK2q>; Thu, 9 May 2002 06:28:46 -0400
Received: from stingr.net ([212.193.32.15]:55680 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S315684AbSEIK2n>;
	Thu, 9 May 2002 06:28:43 -0400
Date: Thu, 9 May 2002 14:28:41 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] Some useless cleanup
Message-ID: <20020509102841.GA1125@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look at this very funny cleanup changeset for 2.4
avaliable at linux-stingr.bkbits.net/comm

For those who don't have bk I including it here below.

Please give your comments. Maybe it is completely useless and anything
should stay as before, or maybe it is somewhat useful and this abstraction
will decrease possibility of bugs such as akpm worked around in 8139too

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.417   -> 1.422  
#	drivers/net/8139too.c	1.26    -> 1.27   
#	drivers/scsi/scsi_error.c	1.7     -> 1.8    
#	fs/jffs2/background.c	1.3     -> 1.4    
#	    fs/nfsd/nfssvc.c	1.8     -> 1.9    
#	         fs/buffer.c	1.62    -> 1.64   
#	   net/khttpd/main.c	1.3     -> 1.4    
#	drivers/mtd/devices/blkmtd.c	1.3     -> 1.4    
#	fs/reiserfs/journal.c	1.21    -> 1.22   
#	include/linux/sched.h	1.29    -> 1.31   
#	         mm/vmscan.c	1.59    -> 1.60   
#	    fs/jbd/journal.c	1.4     -> 1.5    
#	    kernel/softirq.c	1.8     -> 1.9    
#	drivers/usb/storage/usb.c	1.9     -> 1.10   
#	     drivers/md/md.c	1.30    -> 1.31   
#	drivers/mtd/mtdblock.c	1.8     -> 1.9    
#	           fs/exec.c	1.20    -> 1.22   
#	 fs/lockd/clntlock.c	1.3     -> 1.4    
#	    kernel/context.c	1.4     -> 1.5    
#	   drivers/acpi/os.c	1.8     -> 1.9    
#	   drivers/usb/hub.c	1.15    -> 1.16   
#	  net/sunrpc/sched.c	1.8     -> 1.9    
#	    fs/jffs/intrep.c	1.7     -> 1.8    
#	      fs/lockd/svc.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/06	stingray@proxy.sgu.ru	1.418
# task_t->comm cleanup: pilot
# --------------------------------------------
# 02/05/07	stingray@proxy.sgu.ru	1.419
# cut down the tails
# --------------------------------------------
# 02/05/07	stingray@boxster.stingr.net	1.420
# task_t->comm cleanup part 1: replace sprintfs in fs/*
# --------------------------------------------
# 02/05/07	stingray@boxster.stingr.net	1.421
# task_t->comm cleanup: less redundant dependencies
# --------------------------------------------
# 02/05/08	stingray@boxster.stingr.net	1.422
# task_t->comm cleanup part 2: drivers, net, and mm
# --------------------------------------------
#
diff -Nru a/drivers/acpi/os.c b/drivers/acpi/os.c
--- a/drivers/acpi/os.c	Thu May  9 14:18:32 2002
+++ b/drivers/acpi/os.c	Thu May  9 14:18:32 2002
@@ -568,7 +568,7 @@
 	PROC_NAME("acpi_os_queue_exec");
 
 	daemonize();
-	strcpy(current->comm, "kacpidpc");
+	set_current_title("kacpidpc");
     
 	if (!dpc || !dpc->function)
 		return AE_BAD_PARAMETER;
diff -Nru a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Thu May  9 14:18:32 2002
+++ b/drivers/md/md.c	Thu May  9 14:18:32 2002
@@ -2920,7 +2920,7 @@
 
 	daemonize();
 
-	sprintf(current->comm, thread->name);
+	set_current_title(thread->name);
 	md_init_signals();
 	md_flush_signals();
 	thread->tsk = current;
diff -Nru a/drivers/mtd/devices/blkmtd.c b/drivers/mtd/devices/blkmtd.c
--- a/drivers/mtd/devices/blkmtd.c	Thu May  9 14:18:32 2002
+++ b/drivers/mtd/devices/blkmtd.c	Thu May  9 14:18:32 2002
@@ -307,7 +307,7 @@
   DECLARE_WAITQUEUE(wait, tsk);
   DEBUG(1, "blkmtd: writetask: starting (pid = %d)\n", tsk->pid);
   daemonize();
-  strcpy(tsk->comm, "blkmtdd");
+  set_task_title(tsk, "blkmtdd");
   tsk->tty = NULL;
   spin_lock_irq(&tsk->sigmask_lock);
   sigfillset(&tsk->blocked);
diff -Nru a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
--- a/drivers/mtd/mtdblock.c	Thu May  9 14:18:32 2002
+++ b/drivers/mtd/mtdblock.c	Thu May  9 14:18:32 2002
@@ -487,7 +487,7 @@
 	tsk->pgrp = 1;
 	/* we might get involved when memory gets low, so use PF_MEMALLOC */
 	tsk->flags |= PF_MEMALLOC;
-	strcpy(tsk->comm, "mtdblockd");
+	set_task_title(tsk, "mtdblockd");
 	tsk->tty = NULL;
 	spin_lock_irq(&tsk->sigmask_lock);
 	sigfillset(&tsk->blocked);
diff -Nru a/drivers/net/8139too.c b/drivers/net/8139too.c
--- a/drivers/net/8139too.c	Thu May  9 14:18:32 2002
+++ b/drivers/net/8139too.c	Thu May  9 14:18:32 2002
@@ -1563,8 +1563,7 @@
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-	strncpy (current->comm, dev->name, sizeof(current->comm) - 1);
-	current->comm[sizeof(current->comm) - 1] = '\0';
+	set_current_title(dev->name);
 
 	while (1) {
 		timeout = next_tick;
diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Thu May  9 14:18:32 2002
+++ b/drivers/scsi/scsi_error.c	Thu May  9 14:18:32 2002
@@ -1873,7 +1873,7 @@
 	 * Set the name of this process.
 	 */
 
-	sprintf(current->comm, "scsi_eh_%d", host->host_no);
+	set_current_title("scsi_eh_%d", host->host_no);
 
 	host->eh_wait = &sem;
 	host->ehandler = current;
diff -Nru a/drivers/usb/hub.c b/drivers/usb/hub.c
--- a/drivers/usb/hub.c	Thu May  9 14:18:32 2002
+++ b/drivers/usb/hub.c	Thu May  9 14:18:32 2002
@@ -907,7 +907,7 @@
 	reparent_to_init();
 
 	/* Setup a nice name */
-	strcpy(current->comm, "khubd");
+	set_current_title("khubd");
 
 	/* Send me a signal to get me die (for debugging) */
 	do {
diff -Nru a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
--- a/drivers/usb/storage/usb.c	Thu May  9 14:18:32 2002
+++ b/drivers/usb/storage/usb.c	Thu May  9 14:18:32 2002
@@ -328,7 +328,7 @@
 	spin_unlock_irq(&current->sigmask_lock);
 
 	/* set our name for identification purposes */
-	sprintf(current->comm, "usb-storage-%d", us->host_number);
+	set_current_title("usb-storage-%d", us->host_number);
 
 	unlock_kernel();
 
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Thu May  9 14:18:32 2002
+++ b/fs/buffer.c	Thu May  9 14:18:32 2002
@@ -2978,7 +2978,7 @@
 
 	tsk->session = 1;
 	tsk->pgrp = 1;
-	strcpy(tsk->comm, "bdflush");
+	set_task_title(tsk, "bdflush");
 
 	/* avoid getting signals */
 	spin_lock_irq(&tsk->sigmask_lock);
@@ -3028,7 +3028,7 @@
 
 	tsk->session = 1;
 	tsk->pgrp = 1;
-	strcpy(tsk->comm, "kupdated");
+	set_task_title(tsk, "kupdated");
 
 	/* sigstop and sigcont will stop and wakeup kupdate */
 	spin_lock_irq(&tsk->sigmask_lock);
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Thu May  9 14:18:32 2002
+++ b/fs/exec.c	Thu May  9 14:18:32 2002
@@ -35,6 +35,7 @@
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/personality.h>
+#include <linux/compiler.h>
 #define __NO_VERSION__
 #include <linux/module.h>
 
@@ -554,15 +555,13 @@
 
 	if (current->euid == current->uid && current->egid == current->gid)
 		current->mm->dumpable = 1;
-	name = bprm->filename;
-	for (i=0; (ch = *(name++)) != '\0';) {
-		if (ch == '/')
-			i = 0;
-		else
-			if (i < 15)
-				current->comm[i++] = ch;
-	}
-	current->comm[i] = '\0';
+
+	if (likely(name = strrchr(bprm->filename, '/')))
+		name++;
+	else
+		name = bprm->filename;
+
+	set_current_title(name);
 
 	flush_thread();
 
diff -Nru a/fs/jbd/journal.c b/fs/jbd/journal.c
--- a/fs/jbd/journal.c	Thu May  9 14:18:32 2002
+++ b/fs/jbd/journal.c	Thu May  9 14:18:32 2002
@@ -210,7 +210,7 @@
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-	sprintf(current->comm, "kjournald");
+	set_current_title("kjournald");
 
 	/* Set up an interval timer which can be used to trigger a
            commit wakeup after the commit interval expires */
diff -Nru a/fs/jffs/intrep.c b/fs/jffs/intrep.c
--- a/fs/jffs/intrep.c	Thu May  9 14:18:32 2002
+++ b/fs/jffs/intrep.c	Thu May  9 14:18:32 2002
@@ -3354,7 +3354,7 @@
 	siginitsetinv (&current->blocked, sigmask(SIGHUP) | sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
-	strcpy(current->comm, "jffs_gcd");
+	set_current_title("jffs_gcd");
 
 	D1(printk (KERN_NOTICE "jffs_garbage_collect_thread(): Starting infinite loop.\n"));
 
diff -Nru a/fs/jffs2/background.c b/fs/jffs2/background.c
--- a/fs/jffs2/background.c	Thu May  9 14:18:32 2002
+++ b/fs/jffs2/background.c	Thu May  9 14:18:32 2002
@@ -104,7 +104,7 @@
 	c->gc_task = current;
 	up(&c->gc_thread_start);
 
-        sprintf(current->comm, "jffs2_gcd_mtd%d", c->mtd->index);
+        set_current_title("jffs2_gcd_mtd%d", c->mtd->index);
 
 	/* FIXME in the 2.2 backport */
 	current->nice = 10;
diff -Nru a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
--- a/fs/lockd/clntlock.c	Thu May  9 14:18:32 2002
+++ b/fs/lockd/clntlock.c	Thu May  9 14:18:32 2002
@@ -203,9 +203,7 @@
 
 	daemonize();
 	reparent_to_init();
-	snprintf(current->comm, sizeof(current->comm),
-		 "%s-reclaim",
-		 host->h_name);
+	set_current_title("%s-reclaim", host->h_name);
 
 	/* This one ensures that our parent doesn't terminate while the
 	 * reclaim is in progress */
diff -Nru a/fs/lockd/svc.c b/fs/lockd/svc.c
--- a/fs/lockd/svc.c	Thu May  9 14:18:32 2002
+++ b/fs/lockd/svc.c	Thu May  9 14:18:32 2002
@@ -99,7 +99,7 @@
 
 	daemonize();
 	reparent_to_init();
-	sprintf(current->comm, "lockd");
+	set_current_title("lockd");
 
 	/* Process request with signals blocked.  */
 	spin_lock_irq(&current->sigmask_lock);
diff -Nru a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
--- a/fs/nfsd/nfssvc.c	Thu May  9 14:18:32 2002
+++ b/fs/nfsd/nfssvc.c	Thu May  9 14:18:32 2002
@@ -161,7 +161,7 @@
 	MOD_INC_USE_COUNT;
 	lock_kernel();
 	daemonize();
-	sprintf(current->comm, "nfsd");
+	set_current_title("nfsd");
 	current->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
 
 	nfsdstats.th_cnt++;
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Thu May  9 14:18:32 2002
+++ b/fs/reiserfs/journal.c	Thu May  9 14:18:32 2002
@@ -1872,7 +1872,7 @@
   recalc_sigpending(current);
   spin_unlock_irq(&current->sigmask_lock);
 
-  sprintf(current->comm, "kreiserfsd") ;
+  set_current_title("kreiserfsd") ;
   lock_kernel() ;
   while(1) {
 
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu May  9 14:18:32 2002
+++ b/include/linux/sched.h	Thu May  9 14:18:32 2002
@@ -110,6 +110,15 @@
 	__set_current_state(state_value)
 #endif
 
+#define TASK_TITLE_MAX	15
+#define __TASK_TITLE_SZ	(TASK_TITLE_MAX + 1)
+
+#define set_task_title(tsk, arg...) \
+	snprintf(tsk->comm, sizeof(tsk->comm), ##arg)
+
+#define set_current_title(arg...) \
+	snprintf(current->comm, sizeof(current->comm), ##arg)
+
 /*
  * Scheduling policies
  */
@@ -379,7 +388,7 @@
 /* limits */
 	struct rlimit rlim[RLIM_NLIMITS];
 	unsigned short used_math;
-	char comm[16];
+	char comm[__TASK_TITLE_SZ];
 /* file system info */
 	int link_count, total_link_count;
 	struct tty_struct *tty; /* NULL if no tty */
diff -Nru a/kernel/context.c b/kernel/context.c
--- a/kernel/context.c	Thu May  9 14:18:32 2002
+++ b/kernel/context.c	Thu May  9 14:18:32 2002
@@ -71,7 +71,7 @@
 	struct k_sigaction sa;
 
 	daemonize();
-	strcpy(curtask->comm, "keventd");
+	set_task_title(curtask, "keventd");
 	keventd_running = 1;
 	keventd_task = curtask;
 
diff -Nru a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c	Thu May  9 14:18:32 2002
+++ b/kernel/softirq.c	Thu May  9 14:18:32 2002
@@ -373,7 +373,7 @@
 	while (smp_processor_id() != cpu)
 		schedule();
 
-	sprintf(current->comm, "ksoftirqd_CPU%d", bind_cpu);
+	set_current_title("ksoftirqd_CPU%d", bind_cpu);
 
 	__set_current_state(TASK_INTERRUPTIBLE);
 	mb();
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Thu May  9 14:18:32 2002
+++ b/mm/vmscan.c	Thu May  9 14:18:32 2002
@@ -704,7 +704,7 @@
 	DECLARE_WAITQUEUE(wait, tsk);
 
 	daemonize();
-	strcpy(tsk->comm, "kswapd");
+	set_task_title(tsk, "kswapd");
 	sigfillset(&tsk->blocked);
 	
 	/*
diff -Nru a/net/khttpd/main.c b/net/khttpd/main.c
--- a/net/khttpd/main.c	Thu May  9 14:18:32 2002
+++ b/net/khttpd/main.c	Thu May  9 14:18:32 2002
@@ -105,7 +105,7 @@
 	if (cpu_pointer!=NULL)
 	CPUNR=(int)*(int*)cpu_pointer;
 
-	sprintf(current->comm,"khttpd - %i",CPUNR);
+	set_current_title("khttpd - %i", CPUNR);
 	daemonize();
 	
 	init_waitqueue_head(&(DummyWQ[CPUNR]));
@@ -195,7 +195,7 @@
 	DECLARE_WAIT_QUEUE_HEAD(WQ);
 	
 	
-	sprintf(current->comm,"khttpd manager");
+	set_current_title("khttpd manager");
 	daemonize();
 	
 
diff -Nru a/net/sunrpc/sched.c b/net/sunrpc/sched.c
--- a/net/sunrpc/sched.c	Thu May  9 14:18:32 2002
+++ b/net/sunrpc/sched.c	Thu May  9 14:18:32 2002
@@ -1067,7 +1067,7 @@
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-	strcpy(current->comm, "rpciod");
+	set_current_title("rpciod");
 
 	dprintk("RPC: rpciod starting (pid %d)\n", rpciod_pid);
 	while (rpciod_users) {



-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
