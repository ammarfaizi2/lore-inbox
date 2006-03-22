Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWCVPgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWCVPgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWCVPgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:36:36 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:20890 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751340AbWCVPgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:36:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Bc7mWl97kTZgbNDYTBD1l8VCfWBQy738R922MMwYsu/kkx1wP2xieLPIXqAo2KbxUgPG6CxRslP3PXCOYHyC7o6RvYflBJL5u4fEncxME+es9o6afphVY98lHXxxaqkkwqUELtoePAvrSPjidUpHkPJkNkl/4EttyHJfqN8tUpY=
Message-ID: <44216EFF.6050503@gmail.com>
Date: Wed, 22 Mar 2006 23:36:31 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [2.6.16 PATCH] some tail whitespace clean under subdirectory kernel
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans some tail whitespaces under subdirectory kernel.


diffstat
 capability.c |   20 ++++++++++----------
 fork.c       |   12 ++++++------
 signal.c     |   14 +++++++-------
 sys.c        |   38 +++++++++++++++++++-------------------
 timer.c      |   18 +++++++++---------
 5 files changed, 51 insertions(+), 51 deletions(-)

Signed-off-by: Yi Yang <yang.y.yi@gmail.com>

--- a/kernel/capability.c.orig	2006-03-22 23:04:30.000000000 +0800
+++ b/kernel/capability.c	2006-03-22 23:07:06.000000000 +0800
@@ -5,7 +5,7 @@
  *
  * Integrated into 2.1.97+,  Andrew G. Morgan <morgan@transmeta.com>
  * 30 May 2002:	Cleanup, Robert M. Love <rml@tech9.net>
- */ 
+ */
 
 #include <linux/capability.h>
 #include <linux/mm.h>
@@ -54,18 +54,18 @@ asmlinkage long sys_capget(cap_user_head
 
      if (version != _LINUX_CAPABILITY_VERSION) {
 	     if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
-		     return -EFAULT; 
+		     return -EFAULT;
              return -EINVAL;
      }
 
      if (get_user(pid, &header->pid))
 	     return -EFAULT;
 
-     if (pid < 0) 
+     if (pid < 0)
              return -EINVAL;
 
      spin_lock(&task_capability_lock);
-     read_lock(&tasklist_lock); 
+     read_lock(&tasklist_lock);
 
      if (pid && pid != current->pid) {
 	     target = find_task_by_pid(pid);
@@ -79,11 +79,11 @@ asmlinkage long sys_capget(cap_user_head
      ret = security_capget(target, &data.effective, &data.inheritable, &data.permitted);
 
 out:
-     read_unlock(&tasklist_lock); 
+     read_unlock(&tasklist_lock);
      spin_unlock(&task_capability_lock);
 
      if (!ret && copy_to_user(dataptr, &data, sizeof data))
-          return -EFAULT; 
+          return -EFAULT;
 
      return ret;
 }
@@ -177,16 +177,16 @@ asmlinkage long sys_capset(cap_user_head
      pid_t pid;
 
      if (get_user(version, &header->version))
-	     return -EFAULT; 
+	     return -EFAULT;
 
      if (version != _LINUX_CAPABILITY_VERSION) {
 	     if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
-		     return -EFAULT; 
+		     return -EFAULT;
              return -EINVAL;
      }
 
      if (get_user(pid, &header->pid))
-	     return -EFAULT; 
+	     return -EFAULT;
 
      if (pid && pid != current->pid && !capable(CAP_SETPCAP))
              return -EPERM;
@@ -194,7 +194,7 @@ asmlinkage long sys_capset(cap_user_head
      if (copy_from_user(&effective, &data->effective, sizeof(effective)) ||
 	 copy_from_user(&inheritable, &data->inheritable, sizeof(inheritable)) ||
 	 copy_from_user(&permitted, &data->permitted, sizeof(permitted)))
-	     return -EFAULT; 
+	     return -EFAULT;
 
      spin_lock(&task_capability_lock);
      read_lock(&tasklist_lock);
--- a/kernel/fork.c.orig	2006-03-22 23:04:47.000000000 +0800
+++ b/kernel/fork.c	2006-03-22 23:11:18.000000000 +0800
@@ -245,7 +245,7 @@ static inline int dup_mmap(struct mm_str
 			get_file(file);
 			if (tmp->vm_flags & VM_DENYWRITE)
 				atomic_dec(&inode->i_writecount);
-      
+
 			/* insert tmp into the share list, just after mpnt */
 			spin_lock(&file->f_mapping->i_mmap_lock);
 			tmp->vm_truncate_count = mpnt->vm_truncate_count;
@@ -701,8 +701,8 @@ static struct files_struct *dup_fd(struc
 	/* compute the remainder to be cleared */
 	size = (new_fdt->max_fds - open_files) * sizeof(struct file *);
 
-	/* This is long word aligned thus could use a optimized version */ 
-	memset(new_fds, 0, size); 
+	/* This is long word aligned thus could use a optimized version */
+	memset(new_fds, 0, size);
 
 	if (new_fdt->max_fdset > open_files) {
 		int left = (new_fdt->max_fdset-open_files)/8;
@@ -1078,7 +1078,7 @@ static task_t *copy_process(unsigned lon
 
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
-	   
+
 	p->parent_exec_id = p->self_exec_id;
 
 	/* ok, now we should be set up.. */
@@ -1357,10 +1357,10 @@ void __init proc_caches_init(void)
 	signal_cachep = kmem_cache_create("signal_cache",
 			sizeof(struct signal_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
-	files_cachep = kmem_cache_create("files_cache", 
+	files_cachep = kmem_cache_create("files_cache",
 			sizeof(struct files_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
-	fs_cachep = kmem_cache_create("fs_cache", 
+	fs_cachep = kmem_cache_create("fs_cache",
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 	vm_area_cachep = kmem_cache_create("vm_area_struct",
--- a/kernel/signal.c.orig	2006-03-22 23:05:10.000000000 +0800
+++ b/kernel/signal.c	2006-03-22 23:12:53.000000000 +0800
@@ -545,7 +545,7 @@ static int __dequeue_signal(struct sigpe
 }
 
 /*
- * Dequeue a signal and return the element to the caller, which is 
+ * Dequeue a signal and return the element to the caller, which is
  * expected to free it.
  *
  * All callers have to hold the siglock.
@@ -765,7 +765,7 @@ static void handle_stop_signal(int sig, 
 			 * running the handler.  With the TIF_SIGPENDING
 			 * flag set, the thread will pause and acquire the
 			 * siglock that we hold now and until we've queued
-			 * the pending signal. 
+			 * the pending signal.
 			 *
 			 * Wake up the stopped thread _after_ setting
 			 * TIF_SIGPENDING
@@ -1297,7 +1297,7 @@ send_sig_info(int sig, struct siginfo *i
 	 * lists) in order to avoid races with "p->sighand"
 	 * going away or changing from under us.
 	 */
-	read_lock(&tasklist_lock);  
+	read_lock(&tasklist_lock);
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 	ret = specific_send_sig_info(sig, info, p);
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
@@ -1369,12 +1369,12 @@ kill_proc(pid_t pid, int sig, int priv)
  * These functions support sending signals using preallocated sigqueue
  * structures.  This is needed "because realtime applications cannot
  * afford to lose notifications of asynchronous events, like timer
- * expirations or I/O completions".  In the case of Posix Timers 
+ * expirations or I/O completions".  In the case of Posix Timers
  * we allocate the sigqueue structure from the timer_create.  If this
  * allocation fails we are able to report the failure to the application
  * with an EAGAIN error.
  */
- 
+
 struct sigqueue *sigqueue_alloc(void)
 {
 	struct sigqueue *q;
@@ -1517,7 +1517,7 @@ send_group_sigqueue(int sig, struct sigq
 			BUG();
 		q->info.si_overrun++;
 		goto out;
-	} 
+	}
 
 	/*
 	 * Put this signal on the shared-pending queue.
@@ -2501,7 +2501,7 @@ do_sigaction(int sig, struct k_sigaction
 	return 0;
 }
 
-int 
+int
 do_sigaltstack (const stack_t __user *uss, stack_t __user *uoss, unsigned long sp)
 {
 	stack_t oss;
--- a/kernel/sys.c.orig	2006-03-22 23:05:23.000000000 +0800
+++ b/kernel/sys.c	2006-03-22 23:13:58.000000000 +0800
@@ -92,7 +92,7 @@ int cad_pid = 1;
 /*
  *	Notifier list for kernel code which wants to be called
  *	at shutdown. This is used to stop any idling DMA operations
- *	and the like. 
+ *	and the like.
  */
 
 static struct notifier_block *reboot_notifier_list;
@@ -107,7 +107,7 @@ static DEFINE_RWLOCK(notifier_lock);
  *
  *	Currently always returns zero.
  */
- 
+
 int notifier_chain_register(struct notifier_block **list, struct notifier_block *n)
 {
 	write_lock(&notifier_lock);
@@ -134,7 +134,7 @@ EXPORT_SYMBOL(notifier_chain_register);
  *
  *	Returns zero on success, or %-ENOENT on failure.
  */
- 
+
 int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n)
 {
 	write_lock(&notifier_lock);
@@ -169,7 +169,7 @@ EXPORT_SYMBOL(notifier_chain_unregister)
  *	Otherwise, the return value is the return value
  *	of the last notifier function called.
  */
- 
+
 int __kprobes notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
 {
 	int ret=NOTIFY_DONE;
@@ -199,7 +199,7 @@ EXPORT_SYMBOL(notifier_call_chain);
  *	Currently always returns zero, as notifier_chain_register
  *	always returns zero.
  */
- 
+
 int register_reboot_notifier(struct notifier_block * nb)
 {
 	return notifier_chain_register(&reboot_notifier_list, nb);
@@ -216,7 +216,7 @@ EXPORT_SYMBOL(register_reboot_notifier);
  *
  *	Returns zero on success, or %-ENOENT on failure.
  */
- 
+
 int unregister_reboot_notifier(struct notifier_block * nb)
 {
 	return notifier_chain_unregister(&reboot_notifier_list, nb);
@@ -595,7 +595,7 @@ void ctrl_alt_del(void)
  *
  * The general idea is that a program which uses just setregid() will be
  * 100% compatible with BSD.  A program which uses just setgid() will be
- * 100% compatible with POSIX with saved IDs. 
+ * 100% compatible with POSIX with saved IDs.
  *
  * SMP: There are not races, the GIDs are checked only by filesystem
  *      operations (as far as semantic preservation is concerned).
@@ -647,7 +647,7 @@ asmlinkage long sys_setregid(gid_t rgid,
 }
 
 /*
- * setgid() is implemented like SysV w/ SAVED_IDS 
+ * setgid() is implemented like SysV w/ SAVED_IDS
  *
  * SMP: Same implicit races as above.
  */
@@ -685,7 +685,7 @@ asmlinkage long sys_setgid(gid_t gid)
 	proc_id_connector(current, PROC_EVENT_GID);
 	return 0;
 }
-  
+
 static int set_user(uid_t new_ruid, int dumpclear)
 {
 	struct user_struct *new_user;
@@ -725,7 +725,7 @@ static int set_user(uid_t new_ruid, int 
  *
  * The general idea is that a program which uses just setreuid() will be
  * 100% compatible with BSD.  A program which uses just setuid() will be
- * 100% compatible with POSIX with saved IDs. 
+ * 100% compatible with POSIX with saved IDs.
  */
 asmlinkage long sys_setreuid(uid_t ruid, uid_t euid)
 {
@@ -780,15 +780,15 @@ asmlinkage long sys_setreuid(uid_t ruid,
 
 		
 /*
- * setuid() is implemented like SysV with SAVED_IDS 
- * 
+ * setuid() is implemented like SysV with SAVED_IDS
+ *
  * Note that SAVED_ID's is deficient in that a setuid root program
- * like sendmail, for example, cannot set its uid to be a normal 
+ * like sendmail, for example, cannot set its uid to be a normal
  * user and then switch back, because if you're root, setuid() sets
  * the saved uid too.  If you don't like this, blame the bright people
  * in the POSIX committee and/or USG.  Note that the BSD-style setreuid()
  * will allow a root program to temporarily drop privileges and be able to
- * regain them by swapping the real and effective uid.  
+ * regain them by swapping the real and effective uid.
  */
 asmlinkage long sys_setuid(uid_t uid)
 {
@@ -953,7 +953,7 @@ asmlinkage long sys_setfsuid(uid_t uid)
 		return old_fsuid;
 
 	if (uid == current->uid || uid == current->euid ||
-	    uid == current->suid || uid == current->fsuid || 
+	    uid == current->suid || uid == current->fsuid ||
 	    capable(CAP_SETUID))
 	{
 		if (uid != old_fsuid)
@@ -984,7 +984,7 @@ asmlinkage long sys_setfsgid(gid_t gid)
 		return old_fsgid;
 
 	if (gid == current->gid || gid == current->egid ||
-	    gid == current->sgid || gid == current->fsgid || 
+	    gid == current->sgid || gid == current->fsgid ||
 	    capable(CAP_SETGID))
 	{
 		if (gid != old_fsgid)
@@ -1454,7 +1454,7 @@ out:
  *	SMP: Our groups are copy-on-write. We can set them safely
  *	without another task interfering.
  */
- 
+
 asmlinkage long sys_setgroups(int gidsetsize, gid_t __user *grouplist)
 {
 	struct group_info *group_info;
@@ -1608,7 +1608,7 @@ asmlinkage long sys_getrlimit(unsigned i
 /*
  *	Back compatibility for getrlimit. Needed for some apps.
  */
- 
+
 asmlinkage long sys_old_getrlimit(unsigned int resource, struct rlimit __user *rlim)
 {
 	struct rlimit x;
@@ -1765,7 +1765,7 @@ asmlinkage long sys_umask(int mask)
 	mask = xchg(&current->fs->umask, mask & S_IRWXUGO);
 	return mask;
 }
-    
+
 asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 			  unsigned long arg4, unsigned long arg5)
 {
--- a/kernel/timer.c.orig	2006-03-22 23:05:36.000000000 +0800
+++ b/kernel/timer.c	2006-03-22 23:14:46.000000000 +0800
@@ -436,7 +436,7 @@ static inline void __run_timers(tvec_bas
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
  		int index = base->timer_jiffies & TVR_MASK;
- 
+
 		/*
 		 * Cascade timers:
 		 */
@@ -445,7 +445,7 @@ static inline void __run_timers(tvec_bas
 				(!cascade(base, &base->tv3, INDEX(1))) &&
 					!cascade(base, &base->tv4, INDEX(2)))
 			cascade(base, &base->tv5, INDEX(3));
-		++base->timer_jiffies; 
+		++base->timer_jiffies;
 		list_splice_init(base->tv1.vec + index, &work_list);
 		while (!list_empty(head)) {
 			void (*fn)(unsigned long);
@@ -570,9 +570,9 @@ found:
 unsigned long tick_usec = TICK_USEC; 		/* USER_HZ period (usec) */
 unsigned long tick_nsec = TICK_NSEC;		/* ACTHZ period (nsec) */
 
-/* 
- * The current time 
- * wall_to_monotonic is what we need to add to xtime (or xtime corrected 
+/*
+ * The current time
+ * wall_to_monotonic is what we need to add to xtime (or xtime corrected
  * for sub jiffie times) to get to monotonic time.  Monotonic is pegged
  * at zero at system boot time, so wall_to_monotonic will be negative,
  * however, we will ALWAYS keep the tv_nsec part positive so we can use
@@ -824,7 +824,7 @@ static void update_wall_time(unsigned lo
 }
 
 /*
- * Called from the timer interrupt handler to charge one tick to the current 
+ * Called from the timer interrupt handler to charge one tick to the current
  * process.  user_tick is 1 if the tick is user time, 0 for system.
  */
 void update_process_times(int user_tick)
@@ -931,7 +931,7 @@ static inline void update_times(void)
 	}
 	calc_load(ticks);
 }
-  
+
 /*
  * The 64-bit jiffies value is not atomic - you MUST NOT read it
  * without sampling the sequence number in xtime_lock.
@@ -1169,7 +1169,7 @@ asmlinkage long sys_gettid(void)
 
 /*
  * sys_sysinfo - fill in sysinfo struct
- */ 
+ */
 asmlinkage long sys_sysinfo(struct sysinfo __user *info)
 {
 	struct sysinfo val;
@@ -1320,7 +1320,7 @@ static void __devinit migrate_timers(int
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static int __devinit timer_cpu_notify(struct notifier_block *self, 
+static int __devinit timer_cpu_notify(struct notifier_block *self,
 				unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;


