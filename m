Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWGLPMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWGLPMc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWGLPMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:12:32 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:5223 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751393AbWGLPMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:12:30 -0400
Date: Wed, 12 Jul 2006 17:12:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: Fix sparse warnings.
Message-ID: <20060712151229.GC10588@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Fix sparse warnings.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/hypfs/hypfs_diag.c     |    2 -
 arch/s390/kernel/compat_linux.c  |   19 +++++++++------
 arch/s390/kernel/module.c        |    2 -
 arch/s390/kernel/process.c       |    2 -
 arch/s390/kernel/profile.c       |    2 -
 arch/s390/kernel/s390_ext.c      |    2 -
 arch/s390/kernel/time.c          |    2 -
 arch/s390/kernel/traps.c         |   18 +++++++-------
 arch/s390/lib/string.c           |    4 +--
 arch/s390/mm/cmm.c               |    2 -
 arch/s390/mm/fault.c             |    2 -
 drivers/s390/block/dasd_devmap.c |    8 +++---
 drivers/s390/block/dasd_eckd.c   |   20 ++++++++--------
 drivers/s390/block/dasd_fba.c    |    4 +--
 drivers/s390/block/dasd_genhd.c  |    8 +++---
 drivers/s390/block/dasd_ioctl.c  |    2 -
 drivers/s390/char/con3215.c      |    2 -
 drivers/s390/char/ctrlchar.c     |    2 -
 drivers/s390/char/defkeymap.c    |    6 ++--
 drivers/s390/char/fs3270.c       |   12 ++++-----
 drivers/s390/char/keyboard.c     |    6 ++--
 drivers/s390/char/raw3270.c      |   34 ++++++++++++++--------------
 drivers/s390/char/raw3270.h      |    2 -
 drivers/s390/char/tape_34xx.c    |    6 ++--
 drivers/s390/char/tty3270.c      |   24 +++++++++----------
 drivers/s390/char/vmlogrdr.c     |    6 ++--
 drivers/s390/char/vmwatchdog.c   |    2 -
 drivers/s390/cio/ccwgroup.c      |    2 -
 drivers/s390/cio/cio.c           |    2 -
 drivers/s390/cio/cmf.c           |    4 +--
 drivers/s390/cio/device.c        |    8 +++---
 drivers/s390/cio/qdio.c          |    2 -
 drivers/s390/net/iucv.c          |    2 -
 drivers/s390/net/qeth_main.c     |   16 ++++++-------
 drivers/s390/net/qeth_sys.c      |    4 +--
 drivers/s390/net/smsgiucv.c      |   14 +++++------
 drivers/s390/scsi/zfcp_fsf.c     |    2 -
 drivers/s390/scsi/zfcp_scsi.c    |   47 +++++++++++++++++++--------------------
 include/asm-s390/ccwdev.h        |    2 -
 include/asm-s390/pgalloc.h       |    2 -
 40 files changed, 156 insertions(+), 152 deletions(-)

diff -urpN linux-2.6/arch/s390/hypfs/hypfs_diag.c linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c
--- linux-2.6/arch/s390/hypfs/hypfs_diag.c	2006-07-12 16:25:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c	2006-07-12 16:25:30.000000000 +0200
@@ -403,7 +403,7 @@ static void *diag204_get_buffer(enum dia
 		*pages = 1;
 		return diag204_alloc_rbuf();
 	} else {/* INFO_EXT */
-		*pages = diag204(SUBC_RSI | INFO_EXT, 0, 0);
+		*pages = diag204(SUBC_RSI | INFO_EXT, 0, NULL);
 		if (*pages <= 0)
 			return ERR_PTR(-ENOSYS);
 		else
diff -urpN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-patched/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	2006-07-12 16:25:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_linux.c	2006-07-12 16:25:30.000000000 +0200
@@ -409,7 +409,7 @@ asmlinkage long sys32_sysinfo(struct sys
 	mm_segment_t old_fs = get_fs ();
 	
 	set_fs (KERNEL_DS);
-	ret = sys_sysinfo(&s);
+	ret = sys_sysinfo((struct sysinfo __user *) &s);
 	set_fs (old_fs);
 	err = put_user (s.uptime, &info->uptime);
 	err |= __put_user (s.loads[0], &info->loads[0]);
@@ -438,7 +438,7 @@ asmlinkage long sys32_sched_rr_get_inter
 	mm_segment_t old_fs = get_fs ();
 	
 	set_fs (KERNEL_DS);
-	ret = sys_sched_rr_get_interval(pid, &t);
+	ret = sys_sched_rr_get_interval(pid, (struct timespec __user *) &t);
 	set_fs (old_fs);
 	if (put_compat_timespec(&t, interval))
 		return -EFAULT;
@@ -464,7 +464,10 @@ asmlinkage long sys32_rt_sigprocmask(int
 		}
 	}
 	set_fs (KERNEL_DS);
-	ret = sys_rt_sigprocmask(how, set ? &s : NULL, oset ? &s : NULL, sigsetsize);
+	ret = sys_rt_sigprocmask(how,
+				 set ? (sigset_t __user *) &s : NULL,
+				 oset ? (sigset_t __user *) &s : NULL,
+				 sigsetsize);
 	set_fs (old_fs);
 	if (ret) return ret;
 	if (oset) {
@@ -489,7 +492,7 @@ asmlinkage long sys32_rt_sigpending(comp
 	mm_segment_t old_fs = get_fs();
 		
 	set_fs (KERNEL_DS);
-	ret = sys_rt_sigpending(&s, sigsetsize);
+	ret = sys_rt_sigpending((sigset_t __user *) &s, sigsetsize);
 	set_fs (old_fs);
 	if (!ret) {
 		switch (_NSIG_WORDS) {
@@ -514,7 +517,7 @@ sys32_rt_sigqueueinfo(int pid, int sig, 
 	if (copy_siginfo_from_user32(&info, uinfo))
 		return -EFAULT;
 	set_fs (KERNEL_DS);
-	ret = sys_rt_sigqueueinfo(pid, sig, &info);
+	ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *) &info);
 	set_fs (old_fs);
 	return ret;
 }
@@ -674,7 +677,8 @@ asmlinkage long sys32_sendfile(int out_f
 		return -EFAULT;
 		
 	set_fs(KERNEL_DS);
-	ret = sys_sendfile(out_fd, in_fd, offset ? &of : NULL, count);
+	ret = sys_sendfile(out_fd, in_fd,
+			   offset ? (off_t __user *) &of : NULL, count);
 	set_fs(old_fs);
 	
 	if (offset && put_user(of, offset))
@@ -694,7 +698,8 @@ asmlinkage long sys32_sendfile64(int out
 		return -EFAULT;
 		
 	set_fs(KERNEL_DS);
-	ret = sys_sendfile64(out_fd, in_fd, offset ? &lof : NULL, count);
+	ret = sys_sendfile64(out_fd, in_fd,
+			     offset ? (loff_t __user *) &lof : NULL, count);
 	set_fs(old_fs);
 	
 	if (offset && put_user(lof, offset))
diff -urpN linux-2.6/arch/s390/kernel/module.c linux-2.6-patched/arch/s390/kernel/module.c
--- linux-2.6/arch/s390/kernel/module.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/module.c	2006-07-12 16:25:30.000000000 +0200
@@ -119,7 +119,7 @@ module_frob_arch_sections(Elf_Ehdr *hdr,
 	int nrela, i, j;
 
 	/* Find symbol table and string table. */
-	symtab = 0;
+	symtab = NULL;
 	for (i = 0; i < hdr->e_shnum; i++)
 		switch (sechdrs[i].sh_type) {
 		case SHT_SYMTAB:
diff -urpN linux-2.6/arch/s390/kernel/process.c linux-2.6-patched/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	2006-07-12 16:25:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/process.c	2006-07-12 16:25:30.000000000 +0200
@@ -172,7 +172,7 @@ void show_regs(struct pt_regs *regs)
 	show_registers(regs);
 	/* Show stack backtrace if pt_regs is from kernel mode */
 	if (!(regs->psw.mask & PSW_MASK_PSTATE))
-		show_trace(0,(unsigned long *) regs->gprs[15]);
+		show_trace(NULL, (unsigned long *) regs->gprs[15]);
 }
 
 extern void kernel_thread_starter(void);
diff -urpN linux-2.6/arch/s390/kernel/profile.c linux-2.6-patched/arch/s390/kernel/profile.c
--- linux-2.6/arch/s390/kernel/profile.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/profile.c	2006-07-12 16:25:30.000000000 +0200
@@ -13,7 +13,7 @@ static struct proc_dir_entry * root_irq_
 void init_irq_proc(void)
 {
 	/* create /proc/irq */
-	root_irq_dir = proc_mkdir("irq", 0);
+	root_irq_dir = proc_mkdir("irq", NULL);
 
 	/* create /proc/irq/prof_cpu_mask */
 	create_prof_cpu_mask(root_irq_dir);
diff -urpN linux-2.6/arch/s390/kernel/s390_ext.c linux-2.6-patched/arch/s390/kernel/s390_ext.c
--- linux-2.6/arch/s390/kernel/s390_ext.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/s390_ext.c	2006-07-12 16:25:30.000000000 +0200
@@ -24,7 +24,7 @@
  * (0x1202 external call, 0x1004 cpu timer, 0x2401 hwc console, 0x4000
  * iucv and 0x2603 pfault) this is always the first element. 
  */
-ext_int_info_t *ext_int_hash[256] = { 0, };
+ext_int_info_t *ext_int_hash[256] = { NULL, };
 
 static inline int ext_hash(__u16 code)
 {
diff -urpN linux-2.6/arch/s390/kernel/time.c linux-2.6-patched/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2006-07-12 16:25:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/time.c	2006-07-12 16:25:30.000000000 +0200
@@ -379,7 +379,7 @@ void __init time_init(void)
                                 -xtime.tv_sec, -xtime.tv_nsec);
 
 	/* request the clock comparator external interrupt */
-        if (register_early_external_interrupt(0x1004, 0,
+	if (register_early_external_interrupt(0x1004, NULL,
 					      &ext_int_info_cc) != 0)
                 panic("Couldn't request external interrupt 0x1004");
 
diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2006-07-12 16:25:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2006-07-12 16:25:30.000000000 +0200
@@ -170,7 +170,7 @@ void show_stack(struct task_struct *task
  */
 void dump_stack(void)
 {
-	show_stack(0, 0);
+	show_stack(NULL, NULL);
 }
 
 EXPORT_SYMBOL(dump_stack);
@@ -331,9 +331,9 @@ static void inline do_trap(long interrup
         }
 }
 
-static inline void *get_check_address(struct pt_regs *regs)
+static inline void __user *get_check_address(struct pt_regs *regs)
 {
-	return (void *)((regs->psw.addr-S390_lowcore.pgm_ilc) & PSW_ADDR_INSN);
+	return (void __user *)((regs->psw.addr-S390_lowcore.pgm_ilc) & PSW_ADDR_INSN);
 }
 
 void do_single_step(struct pt_regs *regs)
@@ -360,7 +360,7 @@ asmlinkage void name(struct pt_regs * re
         info.si_signo = signr; \
         info.si_errno = 0; \
         info.si_code = sicode; \
-        info.si_addr = (void *)siaddr; \
+	info.si_addr = siaddr; \
         do_trap(interruption_code, signr, str, regs, &info); \
 }
 
@@ -392,7 +392,7 @@ DO_ERROR_INFO(SIGILL,  "translation exce
 	      ILL_ILLOPN, get_check_address(regs))
 
 static inline void
-do_fp_trap(struct pt_regs *regs, void *location,
+do_fp_trap(struct pt_regs *regs, void __user *location,
            int fpc, long interruption_code)
 {
 	siginfo_t si;
@@ -424,10 +424,10 @@ asmlinkage void illegal_op(struct pt_reg
 {
 	siginfo_t info;
         __u8 opcode[6];
-	__u16 *location;
+	__u16 __user *location;
 	int signal = 0;
 
-	location = (__u16 *) get_check_address(regs);
+	location = get_check_address(regs);
 
 	/*
 	 * We got all needed information from the lowcore and can
@@ -559,10 +559,10 @@ DO_ERROR_INFO(SIGILL, "specification exc
 
 asmlinkage void data_exception(struct pt_regs * regs, long interruption_code)
 {
-	__u16 *location;
+	__u16 __user *location;
 	int signal = 0;
 
-	location = (__u16 *) get_check_address(regs);
+	location = get_check_address(regs);
 
 	/*
 	 * We got all needed information from the lowcore and can
diff -urpN linux-2.6/arch/s390/lib/string.c linux-2.6-patched/arch/s390/lib/string.c
--- linux-2.6/arch/s390/lib/string.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/string.c	2006-07-12 16:25:30.000000000 +0200
@@ -233,7 +233,7 @@ char * strrchr(const char * s, int c)
 		       if (s[len] == (char) c)
 			       return (char *) s + len;
 	       } while (--len > 0);
-       return 0;
+       return NULL;
 }
 EXPORT_SYMBOL(strrchr);
 
@@ -267,7 +267,7 @@ char * strstr(const char * s1,const char
 			return (char *) s1;
 		s1++;
 	}
-	return 0;
+	return NULL;
 }
 EXPORT_SYMBOL(strstr);
 
diff -urpN linux-2.6/arch/s390/mm/cmm.c linux-2.6-patched/arch/s390/mm/cmm.c
--- linux-2.6/arch/s390/mm/cmm.c	2006-07-12 16:25:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/cmm.c	2006-07-12 16:25:30.000000000 +0200
@@ -161,7 +161,7 @@ cmm_thread(void *dummy)
 static void
 cmm_start_thread(void)
 {
-	kernel_thread(cmm_thread, 0, 0);
+	kernel_thread(cmm_thread, NULL, 0);
 }
 
 static void
diff -urpN linux-2.6/arch/s390/mm/fault.c linux-2.6-patched/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	2006-07-12 16:25:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/fault.c	2006-07-12 16:25:30.000000000 +0200
@@ -144,7 +144,7 @@ static void do_sigsegv(struct pt_regs *r
 #endif
 	si.si_signo = SIGSEGV;
 	si.si_code = si_code;
-	si.si_addr = (void *) address;
+	si.si_addr = (void __user *) address;
 	force_sig_info(SIGSEGV, &si, current);
 }
 
diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-07-12 16:25:30.000000000 +0200
@@ -394,7 +394,7 @@ dasd_add_busid(char *bus_id, int feature
 	if (!new)
 		return ERR_PTR(-ENOMEM);
 	spin_lock(&dasd_devmap_lock);
-	devmap = 0;
+	devmap = NULL;
 	hash = dasd_hash_busid(bus_id);
 	list_for_each_entry(tmp, &dasd_hashlists[hash], list)
 		if (strncmp(tmp->bus_id, bus_id, BUS_ID_SIZE) == 0) {
@@ -406,10 +406,10 @@ dasd_add_busid(char *bus_id, int feature
 		new->devindex = dasd_max_devindex++;
 		strncpy(new->bus_id, bus_id, BUS_ID_SIZE);
 		new->features = features;
-		new->device = 0;
+		new->device = NULL;
 		list_add(&new->list, &dasd_hashlists[hash]);
 		devmap = new;
-		new = 0;
+		new = NULL;
 	}
 	spin_unlock(&dasd_devmap_lock);
 	kfree(new);
@@ -479,7 +479,7 @@ dasd_device_from_devindex(int devindex)
 	int i;
 
 	spin_lock(&dasd_devmap_lock);
-	devmap = 0;
+	devmap = NULL;
 	for (i = 0; (i < 256) && !devmap; i++)
 		list_for_each_entry(tmp, &dasd_hashlists[i], list)
 			if (tmp->devindex == devindex) {
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2006-07-12 16:25:30.000000000 +0200
@@ -65,16 +65,16 @@ struct dasd_eckd_private {
 /* The ccw bus type uses this table to find devices that it sends to
  * dasd_eckd_probe */
 static struct ccw_device_id dasd_eckd_ids[] = {
-	{ CCW_DEVICE_DEVTYPE (0x3990, 0, 0x3390, 0), driver_info: 0x1},
-	{ CCW_DEVICE_DEVTYPE (0x2105, 0, 0x3390, 0), driver_info: 0x2},
-	{ CCW_DEVICE_DEVTYPE (0x3880, 0, 0x3390, 0), driver_info: 0x3},
-	{ CCW_DEVICE_DEVTYPE (0x3990, 0, 0x3380, 0), driver_info: 0x4},
-	{ CCW_DEVICE_DEVTYPE (0x2105, 0, 0x3380, 0), driver_info: 0x5},
-	{ CCW_DEVICE_DEVTYPE (0x9343, 0, 0x9345, 0), driver_info: 0x6},
-	{ CCW_DEVICE_DEVTYPE (0x2107, 0, 0x3390, 0), driver_info: 0x7},
-	{ CCW_DEVICE_DEVTYPE (0x2107, 0, 0x3380, 0), driver_info: 0x8},
-	{ CCW_DEVICE_DEVTYPE (0x1750, 0, 0x3390, 0), driver_info: 0x9},
-	{ CCW_DEVICE_DEVTYPE (0x1750, 0, 0x3380, 0), driver_info: 0xa},
+	{ CCW_DEVICE_DEVTYPE (0x3990, 0, 0x3390, 0), .driver_info = 0x1},
+	{ CCW_DEVICE_DEVTYPE (0x2105, 0, 0x3390, 0), .driver_info = 0x2},
+	{ CCW_DEVICE_DEVTYPE (0x3880, 0, 0x3390, 0), .driver_info = 0x3},
+	{ CCW_DEVICE_DEVTYPE (0x3990, 0, 0x3380, 0), .driver_info = 0x4},
+	{ CCW_DEVICE_DEVTYPE (0x2105, 0, 0x3380, 0), .driver_info = 0x5},
+	{ CCW_DEVICE_DEVTYPE (0x9343, 0, 0x9345, 0), .driver_info = 0x6},
+	{ CCW_DEVICE_DEVTYPE (0x2107, 0, 0x3390, 0), .driver_info = 0x7},
+	{ CCW_DEVICE_DEVTYPE (0x2107, 0, 0x3380, 0), .driver_info = 0x8},
+	{ CCW_DEVICE_DEVTYPE (0x1750, 0, 0x3390, 0), .driver_info = 0x9},
+	{ CCW_DEVICE_DEVTYPE (0x1750, 0, 0x3380, 0), .driver_info = 0xa},
 	{ /* end of list */ },
 };
 
diff -urpN linux-2.6/drivers/s390/block/dasd_fba.c linux-2.6-patched/drivers/s390/block/dasd_fba.c
--- linux-2.6/drivers/s390/block/dasd_fba.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_fba.c	2006-07-12 16:25:30.000000000 +0200
@@ -44,8 +44,8 @@ struct dasd_fba_private {
 };
 
 static struct ccw_device_id dasd_fba_ids[] = {
-	{ CCW_DEVICE_DEVTYPE (0x6310, 0, 0x9336, 0), driver_info: 0x1},
-	{ CCW_DEVICE_DEVTYPE (0x3880, 0, 0x3370, 0), driver_info: 0x2},
+	{ CCW_DEVICE_DEVTYPE (0x6310, 0, 0x9336, 0), .driver_info = 0x1},
+	{ CCW_DEVICE_DEVTYPE (0x3880, 0, 0x3370, 0), .driver_info = 0x2},
 	{ /* end of list */ },
 };
 
diff -urpN linux-2.6/drivers/s390/block/dasd_genhd.c linux-2.6-patched/drivers/s390/block/dasd_genhd.c
--- linux-2.6/drivers/s390/block/dasd_genhd.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_genhd.c	2006-07-12 16:25:30.000000000 +0200
@@ -84,9 +84,9 @@ void
 dasd_gendisk_free(struct dasd_device *device)
 {
 	del_gendisk(device->gdp);
-	device->gdp->queue = 0;
+	device->gdp->queue = NULL;
 	put_disk(device->gdp);
-	device->gdp = 0;
+	device->gdp = NULL;
 }
 
 /*
@@ -136,7 +136,7 @@ dasd_destroy_partitions(struct dasd_devi
 	 * device->bdev to lower the offline open_count limit again.
 	 */
 	bdev = device->bdev;
-	device->bdev = 0;
+	device->bdev = NULL;
 
 	/*
 	 * See fs/partition/check.c:delete_partition
@@ -145,7 +145,7 @@ dasd_destroy_partitions(struct dasd_devi
 	 */
 	memset(&bpart, 0, sizeof(struct blkpg_partition));
 	memset(&barg, 0, sizeof(struct blkpg_ioctl_arg));
-	barg.data = &bpart;
+	barg.data = (void __user *) &bpart;
 	barg.op = BLKPG_DEL_PARTITION;
 	for (bpart.pno = device->gdp->minors - 1; bpart.pno > 0; bpart.pno--)
 		ioctl_by_bdev(bdev, BLKPG, (unsigned long) &barg);
diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2006-07-12 16:25:30.000000000 +0200
@@ -345,7 +345,7 @@ dasd_ioctl_set_ro(struct block_device *b
 	if (bdev != bdev->bd_contains)
 		// ro setting is not allowed for partitions
 		return -EINVAL;
-	if (get_user(intval, (int *)argp))
+	if (get_user(intval, (int __user *)argp))
 		return -EFAULT;
 
 	set_disk_ro(bdev->bd_disk, intval);
diff -urpN linux-2.6/drivers/s390/char/con3215.c linux-2.6-patched/drivers/s390/char/con3215.c
--- linux-2.6/drivers/s390/char/con3215.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/con3215.c	2006-07-12 16:25:30.000000000 +0200
@@ -693,7 +693,7 @@ raw3215_probe (struct ccw_device *cdev)
 				       GFP_KERNEL|GFP_DMA);
 	if (raw->buffer == NULL) {
 		spin_lock(&raw3215_device_lock);
-		raw3215[line] = 0;
+		raw3215[line] = NULL;
 		spin_unlock(&raw3215_device_lock);
 		kfree(raw);
 		return -ENOMEM;
diff -urpN linux-2.6/drivers/s390/char/ctrlchar.c linux-2.6-patched/drivers/s390/char/ctrlchar.c
--- linux-2.6/drivers/s390/char/ctrlchar.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/ctrlchar.c	2006-07-12 16:25:30.000000000 +0200
@@ -23,7 +23,7 @@ ctrlchar_handle_sysrq(void *tty)
 	handle_sysrq(ctrlchar_sysrq_key, NULL, (struct tty_struct *) tty);
 }
 
-static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq, 0);
+static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq, NULL);
 #endif
 
 
diff -urpN linux-2.6/drivers/s390/char/defkeymap.c linux-2.6-patched/drivers/s390/char/defkeymap.c
--- linux-2.6/drivers/s390/char/defkeymap.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/defkeymap.c	2006-07-12 16:25:30.000000000 +0200
@@ -83,8 +83,8 @@ static u_short shift_ctrl_map[NR_KEYS] =
 };
 
 ushort *key_maps[MAX_NR_KEYMAPS] = {
-	plain_map, shift_map, 0, 0,
-	ctrl_map, shift_ctrl_map,	0
+	plain_map, shift_map, NULL, NULL,
+	ctrl_map, shift_ctrl_map, NULL,
 };
 
 unsigned int keymap_count = 4;
@@ -145,7 +145,7 @@ char *func_table[MAX_NR_FUNC] = {
 	func_buf + 97,
 	func_buf + 103,
 	func_buf + 109,
-	0,
+	NULL,
 };
 
 struct kbdiacr accent_table[MAX_DIACR] = {
diff -urpN linux-2.6/drivers/s390/char/fs3270.c linux-2.6-patched/drivers/s390/char/fs3270.c
--- linux-2.6/drivers/s390/char/fs3270.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/fs3270.c	2006-07-12 16:25:30.000000000 +0200
@@ -236,7 +236,7 @@ fs3270_irq(struct fs3270 *fp, struct raw
  * Process reads from fullscreen 3270.
  */
 static ssize_t
-fs3270_read(struct file *filp, char *data, size_t count, loff_t *off)
+fs3270_read(struct file *filp, char __user *data, size_t count, loff_t *off)
 {
 	struct fs3270 *fp;
 	struct raw3270_request *rq;
@@ -281,7 +281,7 @@ fs3270_read(struct file *filp, char *dat
  * Process writes to fullscreen 3270.
  */
 static ssize_t
-fs3270_write(struct file *filp, const char *data, size_t count, loff_t *off)
+fs3270_write(struct file *filp, const char __user *data, size_t count, loff_t *off)
 {
 	struct fs3270 *fp;
 	struct raw3270_request *rq;
@@ -338,10 +338,10 @@ fs3270_ioctl(struct file *filp, unsigned
 		fp->write_command = arg;
 		break;
 	case TUBGETI:
-		rc = put_user(fp->read_command, (char *) arg);
+		rc = put_user(fp->read_command, (char __user *) arg);
 		break;
 	case TUBGETO:
-		rc = put_user(fp->write_command,(char *) arg);
+		rc = put_user(fp->write_command,(char __user *) arg);
 		break;
 	case TUBGETMOD:
 		iocb.model = fp->view.model;
@@ -350,7 +350,7 @@ fs3270_ioctl(struct file *filp, unsigned
 		iocb.pf_cnt = 24;
 		iocb.re_cnt = 20;
 		iocb.map = 0;
-		if (copy_to_user((char *) arg, &iocb,
+		if (copy_to_user((char __user *) arg, &iocb,
 				 sizeof(struct raw3270_iocb)))
 			rc = -EFAULT;
 		break;
@@ -479,7 +479,7 @@ fs3270_close(struct inode *inode, struct
 	struct fs3270 *fp;
 
 	fp = filp->private_data;
-	filp->private_data = 0;
+	filp->private_data = NULL;
 	if (fp) {
 		fp->fs_pid = 0;
 		raw3270_reset(&fp->view);
diff -urpN linux-2.6/drivers/s390/char/keyboard.c linux-2.6-patched/drivers/s390/char/keyboard.c
--- linux-2.6/drivers/s390/char/keyboard.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/keyboard.c	2006-07-12 16:25:30.000000000 +0200
@@ -103,7 +103,7 @@ out_maps:
 out_kbd:
 	kfree(kbd);
 out:
-	return 0;
+	return NULL;
 }
 
 void
@@ -304,7 +304,7 @@ kbd_keycode(struct kbd_data *kbd, unsign
 		if (kbd->sysrq) {
 			if (kbd->sysrq == K(KT_LATIN, '-')) {
 				kbd->sysrq = 0;
-				handle_sysrq(value, 0, kbd->tty);
+				handle_sysrq(value, NULL, kbd->tty);
 				return;
 			}
 			if (value == '-') {
@@ -363,7 +363,7 @@ do_kdsk_ioctl(struct kbd_data *kbd, stru
 			/* disallocate map */
 			key_map = kbd->key_maps[tmp.kb_table];
 			if (key_map) {
-			    kbd->key_maps[tmp.kb_table] = 0;
+			    kbd->key_maps[tmp.kb_table] = NULL;
 			    kfree(key_map);
 			}
 			break;
diff -urpN linux-2.6/drivers/s390/char/raw3270.c linux-2.6-patched/drivers/s390/char/raw3270.c
--- linux-2.6/drivers/s390/char/raw3270.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/raw3270.c	2006-07-12 16:25:30.000000000 +0200
@@ -555,7 +555,7 @@ raw3270_start_init(struct raw3270 *rp, s
 #ifdef CONFIG_TN3270_CONSOLE
 	if (raw3270_registered == 0) {
 		spin_lock_irqsave(get_ccwdev_lock(view->dev->cdev), flags);
-		rq->callback = 0;
+		rq->callback = NULL;
 		rc = __raw3270_start(rp, view, rq);
 		if (rc == 0)
 			while (!raw3270_request_final(rq)) {
@@ -719,8 +719,8 @@ raw3270_size_device(struct raw3270 *rp)
 		rc = __raw3270_size_device_vm(rp);
 	else
 		rc = __raw3270_size_device(rp);
-	raw3270_init_view.dev = 0;
-	rp->view = 0;
+	raw3270_init_view.dev = NULL;
+	rp->view = NULL;
 	up(&raw3270_init_sem);
 	if (rc == 0) {	/* Found something. */
 		/* Try to find a model. */
@@ -761,8 +761,8 @@ raw3270_reset_device(struct raw3270 *rp)
 	rp->view = &raw3270_init_view;
 	raw3270_init_view.dev = rp;
 	rc = raw3270_start_init(rp, &raw3270_init_view, &rp->init_request);
-	raw3270_init_view.dev = 0;
-	rp->view = 0;
+	raw3270_init_view.dev = NULL;
+	rp->view = NULL;
 	up(&raw3270_init_sem);
 	return rc;
 }
@@ -934,7 +934,7 @@ raw3270_activate_view(struct raw3270_vie
 	else if (!test_bit(RAW3270_FLAGS_READY, &rp->flags))
 		rc = -ENODEV;
 	else {
-		oldview = 0;
+		oldview = NULL;
 		if (rp->view) {
 			oldview = rp->view;
 			oldview->fn->deactivate(oldview);
@@ -951,7 +951,7 @@ raw3270_activate_view(struct raw3270_vie
 						rp->view = nv;
 						if (nv->fn->activate(nv) == 0)
 							break;
-						rp->view = 0;
+						rp->view = NULL;
 					}
 			}
 		}
@@ -975,7 +975,7 @@ raw3270_deactivate_view(struct raw3270_v
 	spin_lock_irqsave(get_ccwdev_lock(rp->cdev), flags);
 	if (rp->view == view) {
 		view->fn->deactivate(view);
-		rp->view = 0;
+		rp->view = NULL;
 		/* Move deactivated view to end of list. */
 		list_del_init(&view->list);
 		list_add_tail(&view->list, &rp->view_list);
@@ -985,7 +985,7 @@ raw3270_deactivate_view(struct raw3270_v
 				rp->view = view;
 				if (view->fn->activate(view) == 0)
 					break;
-				rp->view = 0;
+				rp->view = NULL;
 			}
 		}
 	}
@@ -1076,7 +1076,7 @@ raw3270_del_view(struct raw3270_view *vi
 	spin_lock_irqsave(get_ccwdev_lock(rp->cdev), flags);
 	if (rp->view == view) {
 		view->fn->deactivate(view);
-		rp->view = 0;
+		rp->view = NULL;
 	}
 	list_del_init(&view->list);
 	if (!rp->view && test_bit(RAW3270_FLAGS_READY, &rp->flags)) {
@@ -1117,9 +1117,9 @@ raw3270_delete_device(struct raw3270 *rp
 
 	/* Disconnect from ccw_device. */
 	cdev = rp->cdev;
-	rp->cdev = 0;
-	cdev->dev.driver_data = 0;
-	cdev->handler = 0;
+	rp->cdev = NULL;
+	cdev->dev.driver_data = NULL;
+	cdev->handler = NULL;
 
 	/* Put ccw_device structure. */
 	put_device(&cdev->dev);
@@ -1144,7 +1144,7 @@ raw3270_model_show(struct device *dev, s
 	return snprintf(buf, PAGE_SIZE, "%i\n",
 			((struct raw3270 *) dev->driver_data)->model);
 }
-static DEVICE_ATTR(model, 0444, raw3270_model_show, 0);
+static DEVICE_ATTR(model, 0444, raw3270_model_show, NULL);
 
 static ssize_t
 raw3270_rows_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -1152,7 +1152,7 @@ raw3270_rows_show(struct device *dev, st
 	return snprintf(buf, PAGE_SIZE, "%i\n",
 			((struct raw3270 *) dev->driver_data)->rows);
 }
-static DEVICE_ATTR(rows, 0444, raw3270_rows_show, 0);
+static DEVICE_ATTR(rows, 0444, raw3270_rows_show, NULL);
 
 static ssize_t
 raw3270_columns_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -1160,7 +1160,7 @@ raw3270_columns_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%i\n",
 			((struct raw3270 *) dev->driver_data)->cols);
 }
-static DEVICE_ATTR(columns, 0444, raw3270_columns_show, 0);
+static DEVICE_ATTR(columns, 0444, raw3270_columns_show, NULL);
 
 static struct attribute * raw3270_attrs[] = {
 	&dev_attr_model.attr,
@@ -1296,7 +1296,7 @@ raw3270_remove (struct ccw_device *cdev)
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	if (rp->view) {
 		rp->view->fn->deactivate(rp->view);
-		rp->view = 0;
+		rp->view = NULL;
 	}
 	while (!list_empty(&rp->view_list)) {
 		v = list_entry(rp->view_list.next, struct raw3270_view, list);
diff -urpN linux-2.6/drivers/s390/char/raw3270.h linux-2.6-patched/drivers/s390/char/raw3270.h
--- linux-2.6/drivers/s390/char/raw3270.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/raw3270.h	2006-07-12 16:25:30.000000000 +0200
@@ -231,7 +231,7 @@ alloc_string(struct list_head *free_list
 		INIT_LIST_HEAD(&cs->update);
 		return cs;
 	}
-	return 0;
+	return NULL;
 }
 
 static inline unsigned long
diff -urpN linux-2.6/drivers/s390/char/tape_34xx.c linux-2.6-patched/drivers/s390/char/tape_34xx.c
--- linux-2.6/drivers/s390/char/tape_34xx.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_34xx.c	2006-07-12 16:25:30.000000000 +0200
@@ -1309,9 +1309,9 @@ static struct tape_discipline tape_disci
 };
 
 static struct ccw_device_id tape_34xx_ids[] = {
-	{ CCW_DEVICE_DEVTYPE(0x3480, 0, 0x3480, 0), driver_info: tape_3480},
-	{ CCW_DEVICE_DEVTYPE(0x3490, 0, 0x3490, 0), driver_info: tape_3490},
-	{ /* end of list */ }
+	{ CCW_DEVICE_DEVTYPE(0x3480, 0, 0x3480, 0), .driver_info = tape_3480},
+	{ CCW_DEVICE_DEVTYPE(0x3490, 0, 0x3490, 0), .driver_info = tape_3490},
+	{ /* end of list */ },
 };
 
 static int
diff -urpN linux-2.6/drivers/s390/char/tty3270.c linux-2.6-patched/drivers/s390/char/tty3270.c
--- linux-2.6/drivers/s390/char/tty3270.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tty3270.c	2006-07-12 16:25:30.000000000 +0200
@@ -437,7 +437,7 @@ tty3270_rcl_add(struct tty3270 *tp, char
 {
 	struct string *s;
 
-	tp->rcl_walk = 0;
+	tp->rcl_walk = NULL;
 	if (len <= 0)
 		return;
 	if (tp->rcl_nr >= tp->rcl_max) {
@@ -466,12 +466,12 @@ tty3270_rcl_backward(struct kbd_data *kb
 		else if (!list_empty(&tp->rcl_lines))
 			tp->rcl_walk = tp->rcl_lines.prev;
 		s = tp->rcl_walk ? 
-			list_entry(tp->rcl_walk, struct string, list) : 0;
+			list_entry(tp->rcl_walk, struct string, list) : NULL;
 		if (tp->rcl_walk) {
 			s = list_entry(tp->rcl_walk, struct string, list);
 			tty3270_update_prompt(tp, s->string, s->len);
 		} else
-			tty3270_update_prompt(tp, 0, 0);
+			tty3270_update_prompt(tp, NULL, 0);
 		tty3270_set_timer(tp, 1);
 	}
 	spin_unlock_bh(&tp->view.lock);
@@ -553,7 +553,7 @@ tty3270_read_tasklet(struct raw3270_requ
 	 * has to be emitted to the tty and for 0x6d the screen
 	 * needs to be redrawn.
 	 */
-	input = 0;
+	input = NULL;
 	len = 0;
 	if (tp->input->string[0] == 0x7d) {
 		/* Enter: write input to tty. */
@@ -567,7 +567,7 @@ tty3270_read_tasklet(struct raw3270_requ
 			tty3270_update_status(tp);
 		}
 		/* Clear input area. */
-		tty3270_update_prompt(tp, 0, 0);
+		tty3270_update_prompt(tp, NULL, 0);
 		tty3270_set_timer(tp, 1);
 	} else if (tp->input->string[0] == 0x6d) {
 		/* Display has been cleared. Redraw. */
@@ -808,8 +808,8 @@ tty3270_release(struct raw3270_view *vie
 	tp = (struct tty3270 *) view;
 	tty = tp->tty;
 	if (tty) {
-		tty->driver_data = 0;
-		tp->tty = tp->kbd->tty = 0;
+		tty->driver_data = NULL;
+		tp->tty = tp->kbd->tty = NULL;
 		tty_hangup(tty);
 		raw3270_put_view(&tp->view);
 	}
@@ -948,8 +948,8 @@ tty3270_close(struct tty_struct *tty, st
 		return;
 	tp = (struct tty3270 *) tty->driver_data;
 	if (tp) {
-		tty->driver_data = 0;
-		tp->tty = tp->kbd->tty = 0;
+		tty->driver_data = NULL;
+		tp->tty = tp->kbd->tty = NULL;
 		raw3270_put_view(&tp->view);
 	}
 }
@@ -1673,7 +1673,7 @@ tty3270_set_termios(struct tty_struct *t
 		new = L_ECHO(tty) ? TF_INPUT: TF_INPUTN;
 		if (new != tp->inattr) {
 			tp->inattr = new;
-			tty3270_update_prompt(tp, 0, 0);
+			tty3270_update_prompt(tp, NULL, 0);
 			tty3270_set_timer(tp, 1);
 		}
 	}
@@ -1759,7 +1759,7 @@ void
 tty3270_notifier(int index, int active)
 {
 	if (active)
-		tty_register_device(tty3270_driver, index, 0);
+		tty_register_device(tty3270_driver, index, NULL);
 	else
 		tty_unregister_device(tty3270_driver, index);
 }
@@ -1818,7 +1818,7 @@ tty3270_exit(void)
 
 	raw3270_unregister_notifier(tty3270_notifier);
 	driver = tty3270_driver;
-	tty3270_driver = 0;
+	tty3270_driver = NULL;
 	tty_unregister_driver(driver);
 	tty3270_del_views();
 }
diff -urpN linux-2.6/drivers/s390/char/vmlogrdr.c linux-2.6-patched/drivers/s390/char/vmlogrdr.c
--- linux-2.6/drivers/s390/char/vmlogrdr.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/vmlogrdr.c	2006-07-12 16:25:30.000000000 +0200
@@ -86,8 +86,8 @@ struct vmlogrdr_priv_t {
  */
 static int vmlogrdr_open(struct inode *, struct file *);
 static int vmlogrdr_release(struct inode *, struct file *);
-static ssize_t vmlogrdr_read (struct file *filp, char *data, size_t count,
-			       loff_t * ppos);
+static ssize_t vmlogrdr_read (struct file *filp, char __user *data,
+			      size_t count, loff_t * ppos);
 
 static struct file_operations vmlogrdr_fops = {
 	.owner   = THIS_MODULE,
@@ -515,7 +515,7 @@ vmlogrdr_receive_data(struct vmlogrdr_pr
 
 
 static ssize_t
-vmlogrdr_read (struct file *filp, char *data, size_t count, loff_t * ppos)
+vmlogrdr_read(struct file *filp, char __user *data, size_t count, loff_t * ppos)
 {
 	int rc;
 	struct vmlogrdr_priv_t * priv = filp->private_data;
diff -urpN linux-2.6/drivers/s390/char/vmwatchdog.c linux-2.6-patched/drivers/s390/char/vmwatchdog.c
--- linux-2.6/drivers/s390/char/vmwatchdog.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/vmwatchdog.c	2006-07-12 16:25:30.000000000 +0200
@@ -193,7 +193,7 @@ static int vmwdt_ioctl(struct inode *i, 
 		return 0;
 	case WDIOC_GETSTATUS:
 	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, (int *)arg);
+		return put_user(0, (int __user *)arg);
 	case WDIOC_GETTEMP:
 		return -EINVAL;
 	case WDIOC_SETOPTIONS:
diff -urpN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-patched/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/ccwgroup.c	2006-07-12 16:25:30.000000000 +0200
@@ -319,7 +319,7 @@ ccwgroup_online_store (struct device *de
 	if (!try_module_get(gdrv->owner))
 		return -EINVAL;
 
-	value = simple_strtoul(buf, 0, 0);
+	value = simple_strtoul(buf, NULL, 0);
 	ret = count;
 	if (value == 1)
 		ccwgroup_set_online(gdev);
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-07-12 16:25:30.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-07-12 16:25:30.000000000 +0200
@@ -798,7 +798,7 @@ struct subchannel *
 cio_get_console_subchannel(void)
 {
 	if (!console_subchannel_in_use)
-		return 0;
+		return NULL;
 	return &console_subchannel;
 }
 
diff -urpN linux-2.6/drivers/s390/cio/cmf.c linux-2.6-patched/drivers/s390/cio/cmf.c
--- linux-2.6/drivers/s390/cio/cmf.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cmf.c	2006-07-12 16:25:30.000000000 +0200
@@ -1140,7 +1140,7 @@ static struct attribute *cmf_attributes[
 	&dev_attr_avg_device_disconnect_time.attr,
 	&dev_attr_avg_control_unit_queuing_time.attr,
 	&dev_attr_avg_device_active_only_time.attr,
-	0,
+	NULL,
 };
 
 static struct attribute_group cmf_attr_group = {
@@ -1160,7 +1160,7 @@ static struct attribute *cmf_attributes_
 	&dev_attr_avg_device_active_only_time.attr,
 	&dev_attr_avg_device_busy_time.attr,
 	&dev_attr_avg_initial_command_response_time.attr,
-	0,
+	NULL,
 };
 
 static struct attribute_group cmf_attr_group_ext = {
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-07-12 16:25:26.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-07-12 16:25:30.000000000 +0200
@@ -100,7 +100,7 @@ ccw_uevent (struct device *dev, char **e
 	if ((buffer_size - length <= 0) || (i >= num_envp))
 		return -ENOMEM;
 
-	envp[i] = 0;
+	envp[i] = NULL;
 
 	return 0;
 }
@@ -1057,7 +1057,7 @@ get_ccwdev_by_busid(struct ccw_driver *c
 				 __ccwdev_check_busid);
 	put_driver(drv);
 
-	return dev ? to_ccwdev(dev) : 0;
+	return dev ? to_ccwdev(dev) : NULL;
 }
 
 /************************** device driver handling ************************/
@@ -1082,7 +1082,7 @@ ccw_device_probe (struct device *dev)
 	ret = cdrv->probe ? cdrv->probe(cdev) : -ENODEV;
 
 	if (ret) {
-		cdev->drv = 0;
+		cdev->drv = NULL;
 		return ret;
 	}
 
@@ -1113,7 +1113,7 @@ ccw_device_remove (struct device *dev)
 				 ret, cdev->dev.bus_id);
 	}
 	ccw_device_set_timeout(cdev, 0);
-	cdev->drv = 0;
+	cdev->drv = NULL;
 	return 0;
 }
 
diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-07-12 16:25:30.000000000 +0200
@@ -2735,7 +2735,7 @@ qdio_free(struct ccw_device *cdev)
 	QDIO_DBF_TEXT1(0,trace,dbf_text);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
-	cdev->private->qdio_data = 0;
+	cdev->private->qdio_data = NULL;
 
 	up(&irq_ptr->setting_up_sema);
 
diff -urpN linux-2.6/drivers/s390/net/iucv.c linux-2.6-patched/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/iucv.c	2006-07-12 16:25:30.000000000 +0200
@@ -692,7 +692,7 @@ iucv_retrieve_buffer (void)
 	iucv_debug(1, "entering");
 	if (iucv_cpuid != -1) {
 		smp_call_function_on(iucv_retrieve_buffer_cpuid,
-				     0, 0, 1, iucv_cpuid);
+				     NULL, 0, 1, iucv_cpuid);
 		/* Release the cpu reserved by iucv_declare_buffer. */
 		smp_put_cpu(iucv_cpuid);
 		iucv_cpuid = -1;
diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2006-07-12 16:25:30.000000000 +0200
@@ -4804,7 +4804,7 @@ static struct qeth_cmd_buffer *
 qeth_get_setassparms_cmd(struct qeth_card *, enum qeth_ipa_funcs,
 			 __u16, __u16, enum qeth_prot_versions);
 static int
-qeth_arp_query(struct qeth_card *card, char *udata)
+qeth_arp_query(struct qeth_card *card, char __user *udata)
 {
 	struct qeth_cmd_buffer *iob;
 	struct qeth_arp_query_info qinfo = {0, };
@@ -4937,7 +4937,7 @@ qeth_get_adapter_cmd(struct qeth_card *c
  * function to send SNMP commands to OSA-E card
  */
 static int
-qeth_snmp_command(struct qeth_card *card, char *udata)
+qeth_snmp_command(struct qeth_card *card, char __user *udata)
 {
 	struct qeth_cmd_buffer *iob;
 	struct qeth_ipa_cmd *cmd;
@@ -7909,9 +7909,9 @@ qeth_set_online(struct ccwgroup_device *
 }
 
 static struct ccw_device_id qeth_ids[] = {
-	{CCW_DEVICE(0x1731, 0x01), driver_info:QETH_CARD_TYPE_OSAE},
-	{CCW_DEVICE(0x1731, 0x05), driver_info:QETH_CARD_TYPE_IQD},
-	{CCW_DEVICE(0x1731, 0x06), driver_info:QETH_CARD_TYPE_OSN},
+	{CCW_DEVICE(0x1731, 0x01), .driver_info = QETH_CARD_TYPE_OSAE},
+	{CCW_DEVICE(0x1731, 0x05), .driver_info = QETH_CARD_TYPE_IQD},
+	{CCW_DEVICE(0x1731, 0x06), .driver_info = QETH_CARD_TYPE_OSN},
 	{},
 };
 MODULE_DEVICE_TABLE(ccw, qeth_ids);
@@ -8380,7 +8380,7 @@ out:
 
 static struct notifier_block qeth_ip_notifier = {
 	qeth_ip_event,
-	0
+	NULL,
 };
 
 #ifdef CONFIG_QETH_IPV6
@@ -8433,7 +8433,7 @@ out:
 
 static struct notifier_block qeth_ip6_notifier = {
 	qeth_ip6_event,
-	0
+	NULL,
 };
 #endif
 
@@ -8460,7 +8460,7 @@ qeth_reboot_event(struct notifier_block 
 
 static struct notifier_block qeth_reboot_notifier = {
 	qeth_reboot_event,
-	0
+	NULL,
 };
 
 static int
diff -urpN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-patched/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_sys.c	2006-07-12 16:25:30.000000000 +0200
@@ -1755,7 +1755,7 @@ qeth_driver_group_store(struct device_dr
 }
 
 
-static DRIVER_ATTR(group, 0200, 0, qeth_driver_group_store);
+static DRIVER_ATTR(group, 0200, NULL, qeth_driver_group_store);
 
 static ssize_t
 qeth_driver_notifier_register_store(struct device_driver *ddrv, const char *buf,
@@ -1783,7 +1783,7 @@ qeth_driver_notifier_register_store(stru
 	return count;
 }
 
-static DRIVER_ATTR(notifier_register, 0200, 0,
+static DRIVER_ATTR(notifier_register, 0200, NULL,
 		   qeth_driver_notifier_register_store);
 
 int
diff -urpN linux-2.6/drivers/s390/net/smsgiucv.c linux-2.6-patched/drivers/s390/net/smsgiucv.c
--- linux-2.6/drivers/s390/net/smsgiucv.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/smsgiucv.c	2006-07-12 16:25:30.000000000 +0200
@@ -66,7 +66,7 @@ smsg_message_pending(iucv_MessagePending
 		return;
 	}
 	rc = iucv_receive(eib->ippathid, eib->ipmsgid, eib->iptrgcls,
-			  msg, len, 0, 0, 0);
+			  msg, len, NULL, NULL, NULL);
 	if (rc == 0) {
 		msg[len] = 0;
 		EBCASC(msg, len);
@@ -122,7 +122,7 @@ smsg_unregister_callback(char *prefix, v
 	struct smsg_callback *cb, *tmp;
 
 	spin_lock(&smsg_list_lock);
-	cb = 0;
+	cb = NULL;
 	list_for_each_entry(tmp, &smsg_list, list)
 		if (tmp->callback == callback &&
 		    strcmp(tmp->prefix, prefix) == 0) {
@@ -139,7 +139,7 @@ smsg_exit(void)
 {
 	if (smsg_handle > 0) {
 		cpcmd("SET SMSG OFF", NULL, 0, NULL);
-		iucv_sever(smsg_pathid, 0);
+		iucv_sever(smsg_pathid, NULL);
 		iucv_unregister_program(smsg_handle);
 		driver_unregister(&smsg_driver);
 	}
@@ -162,19 +162,19 @@ smsg_init(void)
 		return rc;
 	}
 	smsg_handle = iucv_register_program("SMSGIUCV        ", "*MSG    ",
-					    pgmmask, &smsg_ops, 0);
+					    pgmmask, &smsg_ops, NULL);
 	if (!smsg_handle) {
 		printk(KERN_ERR "SMSGIUCV: failed to register to iucv");
 		driver_unregister(&smsg_driver);
 		return -EIO;	/* better errno ? */
 	}
-	rc = iucv_connect (&smsg_pathid, 255, 0, "*MSG    ", 0, 0, 0, 0,
-			   smsg_handle, 0);
+	rc = iucv_connect (&smsg_pathid, 255, NULL, "*MSG    ", NULL, 0,
+			   NULL, NULL, smsg_handle, NULL);
 	if (rc) {
 		printk(KERN_ERR "SMSGIUCV: failed to connect to *MSG");
 		iucv_unregister_program(smsg_handle);
 		driver_unregister(&smsg_driver);
-		smsg_handle = 0;
+		smsg_handle = NULL;
 		return -EIO;
 	}
 	cpcmd("SET SMSG IUCV", NULL, 0, NULL);
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c	2006-07-12 16:25:30.000000000 +0200
@@ -2227,7 +2227,7 @@ zfcp_fsf_exchange_port_data(struct zfcp_
 	/* setup new FSF request */
 	retval = zfcp_fsf_req_create(adapter, FSF_QTCB_EXCHANGE_PORT_DATA,
 				     erp_action ? ZFCP_REQ_AUTO_CLEANUP : 0,
-				     0, &lock_flags, &fsf_req);
+				     NULL, &lock_flags, &fsf_req);
 	if (retval < 0) {
 		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
                               "exchange port data request for"
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c	2006-07-12 16:25:30.000000000 +0200
@@ -44,30 +44,29 @@ struct scsi_transport_template *zfcp_tra
 
 struct zfcp_data zfcp_data = {
 	.scsi_host_template = {
-	      name:	               ZFCP_NAME,
-	      proc_name:               "zfcp",
-	      proc_info:               NULL,
-	      detect:	               NULL,
-	      slave_alloc:             zfcp_scsi_slave_alloc,
-	      slave_configure:         zfcp_scsi_slave_configure,
-	      slave_destroy:           zfcp_scsi_slave_destroy,
-	      queuecommand:            zfcp_scsi_queuecommand,
-	      eh_abort_handler:        zfcp_scsi_eh_abort_handler,
-	      eh_device_reset_handler: zfcp_scsi_eh_device_reset_handler,
-	      eh_bus_reset_handler:    zfcp_scsi_eh_bus_reset_handler,
-	      eh_host_reset_handler:   zfcp_scsi_eh_host_reset_handler,
-			               /* FIXME(openfcp): Tune */
-	      can_queue:               4096,
-	      this_id:	               -1,
-	      /*
-	       * FIXME:
-	       * one less? can zfcp_create_sbale cope with it?
-	       */
-	      sg_tablesize:            ZFCP_MAX_SBALES_PER_REQ,
-	      cmd_per_lun:             1,
-	      unchecked_isa_dma:       0,
-	      use_clustering:          1,
-	      sdev_attrs:              zfcp_sysfs_sdev_attrs,
+		.name			= ZFCP_NAME,
+		.proc_name		= "zfcp",
+		.proc_info		= NULL,
+		.detect			= NULL,
+		.slave_alloc		= zfcp_scsi_slave_alloc,
+		.slave_configure	= zfcp_scsi_slave_configure,
+		.slave_destroy		= zfcp_scsi_slave_destroy,
+		.queuecommand		= zfcp_scsi_queuecommand,
+		.eh_abort_handler	= zfcp_scsi_eh_abort_handler,
+		.eh_device_reset_handler = zfcp_scsi_eh_device_reset_handler,
+		.eh_bus_reset_handler	= zfcp_scsi_eh_bus_reset_handler,
+		.eh_host_reset_handler	= zfcp_scsi_eh_host_reset_handler,
+		.can_queue		= 4096,
+		.this_id		= -1,
+		/*
+		 * FIXME:
+		 * one less? can zfcp_create_sbale cope with it?
+		 */
+		.sg_tablesize		= ZFCP_MAX_SBALES_PER_REQ,
+		.cmd_per_lun		= 1,
+		.unchecked_isa_dma	= 0,
+		.use_clustering		= 1,
+		.sdev_attrs		= zfcp_sysfs_sdev_attrs,
 	},
 	.driver_version = ZFCP_VERSION,
 	/* rest initialised with zeros */
diff -urpN linux-2.6/include/asm-s390/ccwdev.h linux-2.6-patched/include/asm-s390/ccwdev.h
--- linux-2.6/include/asm-s390/ccwdev.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/ccwdev.h	2006-07-12 16:25:30.000000000 +0200
@@ -63,7 +63,7 @@ ccw_device_id_match(const struct ccw_dev
 		return id;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /* The struct ccw device is our replacement for the globally accessible
diff -urpN linux-2.6/include/asm-s390/pgalloc.h linux-2.6-patched/include/asm-s390/pgalloc.h
--- linux-2.6/include/asm-s390/pgalloc.h	2006-07-12 16:25:14.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/pgalloc.h	2006-07-12 16:25:30.000000000 +0200
@@ -142,7 +142,7 @@ pte_alloc_one(struct mm_struct *mm, unsi
 	pte_t *pte = pte_alloc_one_kernel(mm, vmaddr);
 	if (pte)
 		return virt_to_page(pte);
-	return 0;
+	return NULL;
 }
 
 static inline void pte_free_kernel(pte_t *pte)
