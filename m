Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWGLPKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWGLPKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWGLPKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:10:05 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:55022 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751389AbWGLPKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:10:00 -0400
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 12 Jul 2006 17:09:59 +0200
Message-Id: <1152716999.6414.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/hypfs/hypfs_diag.c     |    2 
 arch/s390/kernel/compat_linux.c  |   19 +++---
 arch/s390/kernel/machine_kexec.c |    1 
 arch/s390/kernel/module.c        |    2 
 arch/s390/kernel/process.c       |    2 
 arch/s390/kernel/profile.c       |    2 
 arch/s390/kernel/s390_ext.c      |    2 
 arch/s390/kernel/time.c          |    2 
 arch/s390/kernel/traps.c         |   18 ++---
 arch/s390/lib/string.c           |    4 -
 arch/s390/mm/cmm.c               |    2 
 arch/s390/mm/fault.c             |    2 
 drivers/s390/block/dasd_devmap.c |    8 +-
 drivers/s390/block/dasd_eckd.c   |   20 +++---
 drivers/s390/block/dasd_fba.c    |    4 -
 drivers/s390/block/dasd_genhd.c  |    8 +-
 drivers/s390/block/dasd_ioctl.c  |    2 
 drivers/s390/block/xpram.c       |   63 +-------------------
 drivers/s390/char/con3215.c      |    2 
 drivers/s390/char/ctrlchar.c     |    2 
 drivers/s390/char/defkeymap.c    |    6 -
 drivers/s390/char/fs3270.c       |   12 +--
 drivers/s390/char/keyboard.c     |    6 -
 drivers/s390/char/raw3270.c      |   34 +++++-----
 drivers/s390/char/raw3270.h      |    2 
 drivers/s390/char/tape_34xx.c    |    6 -
 drivers/s390/char/tty3270.c      |   24 +++----
 drivers/s390/char/vmlogrdr.c     |    6 -
 drivers/s390/char/vmwatchdog.c   |    2 
 drivers/s390/cio/ccwgroup.c      |    2 
 drivers/s390/cio/chsc.c          |   34 ++++++++++
 drivers/s390/cio/cio.c           |    4 -
 drivers/s390/cio/cio.h           |    3 
 drivers/s390/cio/cmf.c           |    4 -
 drivers/s390/cio/css.c           |   36 +++++++++--
 drivers/s390/cio/css.h           |    4 -
 drivers/s390/cio/device.c        |   14 ++--
 drivers/s390/cio/device_fsm.c    |   85 +++++++++++++++++++++------
 drivers/s390/cio/device_pgid.c   |  122 +++++++++++++++++++++++++++++++--------
 drivers/s390/cio/device_status.c |    7 --
 drivers/s390/cio/qdio.c          |    2 
 drivers/s390/net/iucv.c          |    2 
 drivers/s390/net/qeth_main.c     |   16 ++---
 drivers/s390/net/qeth_sys.c      |    4 -
 drivers/s390/net/smsgiucv.c      |   14 ++--
 drivers/s390/s390mach.c          |   10 +++
 drivers/s390/scsi/zfcp_fsf.c     |    2 
 drivers/s390/scsi/zfcp_scsi.c    |   47 +++++++--------
 include/asm-s390/bug.h           |   11 +++
 include/asm-s390/ccwdev.h        |    2 
 include/asm-s390/cio.h           |    2 
 include/asm-s390/futex.h         |    5 -
 include/asm-s390/irqflags.h      |   18 +++--
 include/asm-s390/pgalloc.h       |    2 
 include/asm-s390/processor.h     |   16 ++---
 include/asm-s390/setup.h         |    3 
 56 files changed, 453 insertions(+), 283 deletions(-)

Cornelia Huck:
      [S390] subchannel register/unregister mutex.
      [S390] path grouping and path verifications fixes.

Heiko Carstens:
      [S390] __builtin_trap() and gcc version.
      [S390] raw_local_save_flags/raw_local_irq_restore type check
      [S390] cpu_relax() is supposed to have barrier() semantics.
      [S390] xpram module parameter parsing.
      [S390] Fix sparse warnings.

Martin Schwidefsky:
      [S390] fix futex_atomic_cmpxchg_inatomic

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index efa74af..1785bce 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -403,7 +403,7 @@ static void *diag204_get_buffer(enum dia
 		*pages = 1;
 		return diag204_alloc_rbuf();
 	} else {/* INFO_EXT */
-		*pages = diag204(SUBC_RSI | INFO_EXT, 0, 0);
+		*pages = diag204(SUBC_RSI | INFO_EXT, 0, NULL);
 		if (*pages <= 0)
 			return ERR_PTR(-ENOSYS);
 		else
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index cabb4ff..785c9f7 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
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
diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index fbde6a9..60b1ea9 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -63,6 +63,7 @@ NORET_TYPE void
 machine_kexec(struct kimage *image)
 {
 	clear_all_subchannels();
+	cio_reset_channel_paths();
 
 	/* Disable lowcore protection */
 	ctl_clear_bit(0,28);
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index c271cda..d989ed4 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -119,7 +119,7 @@ module_frob_arch_sections(Elf_Ehdr *hdr,
 	int nrela, i, j;
 
 	/* Find symbol table and string table. */
-	symtab = 0;
+	symtab = NULL;
 	for (i = 0; i < hdr->e_shnum; i++)
 		switch (sechdrs[i].sh_type) {
 		case SHT_SYMTAB:
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 78c8e55..d3cbfa3 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -172,7 +172,7 @@ void show_regs(struct pt_regs *regs)
 	show_registers(regs);
 	/* Show stack backtrace if pt_regs is from kernel mode */
 	if (!(regs->psw.mask & PSW_MASK_PSTATE))
-		show_trace(0,(unsigned long *) regs->gprs[15]);
+		show_trace(NULL, (unsigned long *) regs->gprs[15]);
 }
 
 extern void kernel_thread_starter(void);
diff --git a/arch/s390/kernel/profile.c b/arch/s390/kernel/profile.c
index 7ba777e..b81aa1f 100644
--- a/arch/s390/kernel/profile.c
+++ b/arch/s390/kernel/profile.c
@@ -13,7 +13,7 @@ static struct proc_dir_entry * root_irq_
 void init_irq_proc(void)
 {
 	/* create /proc/irq */
-	root_irq_dir = proc_mkdir("irq", 0);
+	root_irq_dir = proc_mkdir("irq", NULL);
 
 	/* create /proc/irq/prof_cpu_mask */
 	create_prof_cpu_mask(root_irq_dir);
diff --git a/arch/s390/kernel/s390_ext.c b/arch/s390/kernel/s390_ext.c
index 207bc51..c1b3835 100644
--- a/arch/s390/kernel/s390_ext.c
+++ b/arch/s390/kernel/s390_ext.c
@@ -24,7 +24,7 @@ #include <asm/irq.h>
  * (0x1202 external call, 0x1004 cpu timer, 0x2401 hwc console, 0x4000
  * iucv and 0x2603 pfault) this is always the first element. 
  */
-ext_int_info_t *ext_int_hash[256] = { 0, };
+ext_int_info_t *ext_int_hash[256] = { NULL, };
 
 static inline int ext_hash(__u16 code)
 {
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index f7fe9bc..74e6178 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -379,7 +379,7 @@ void __init time_init(void)
                                 -xtime.tv_sec, -xtime.tv_nsec);
 
 	/* request the clock comparator external interrupt */
-        if (register_early_external_interrupt(0x1004, 0,
+	if (register_early_external_interrupt(0x1004, NULL,
 					      &ext_int_info_cc) != 0)
                 panic("Couldn't request external interrupt 0x1004");
 
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 12240c0..bde1d1d 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
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
@@ -559,10 +559,10 @@ #endif
 
 asmlinkage void data_exception(struct pt_regs * regs, long interruption_code)
 {
-	__u16 *location;
+	__u16 __user *location;
 	int signal = 0;
 
-	location = (__u16 *) get_check_address(regs);
+	location = get_check_address(regs);
 
 	/*
 	 * We got all needed information from the lowcore and can
diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index 8240cc7..ae5cf5d 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
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
 
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 81be2fe..ceea51c 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -161,7 +161,7 @@ cmm_thread(void *dummy)
 static void
 cmm_start_thread(void)
 {
-	kernel_thread(cmm_thread, 0, 0);
+	kernel_thread(cmm_thread, NULL, 0);
 }
 
 static void
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 833d594..7cd8257 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -144,7 +144,7 @@ #endif
 #endif
 	si.si_signo = SIGSEGV;
 	si.si_code = si_code;
-	si.si_addr = (void *) address;
+	si.si_addr = (void __user *) address;
 	force_sig_info(SIGSEGV, &si, current);
 }
 
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index d729538..7f6fdac 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
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
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 2e655f4..39c2281 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
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
 
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 808434d..e85015b 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -44,8 +44,8 @@ struct dasd_fba_private {
 };
 
 static struct ccw_device_id dasd_fba_ids[] = {
-	{ CCW_DEVICE_DEVTYPE (0x6310, 0, 0x9336, 0), driver_info: 0x1},
-	{ CCW_DEVICE_DEVTYPE (0x3880, 0, 0x3370, 0), driver_info: 0x2},
+	{ CCW_DEVICE_DEVTYPE (0x6310, 0, 0x9336, 0), .driver_info = 0x1},
+	{ CCW_DEVICE_DEVTYPE (0x3880, 0, 0x3370, 0), .driver_info = 0x2},
 	{ /* end of list */ },
 };
 
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 12c7d29..4c272b7 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
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
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index e97f531..8fed360 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -345,7 +345,7 @@ dasd_ioctl_set_ro(struct block_device *b
 	if (bdev != bdev->bd_contains)
 		// ro setting is not allowed for partitions
 		return -EINVAL;
-	if (get_user(intval, (int *)argp))
+	if (get_user(intval, (int __user *)argp))
 		return -EFAULT;
 
 	set_disk_ro(bdev->bd_disk, intval);
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 4c1e56b..4cd879c 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -71,11 +71,11 @@ static int xpram_devs;
 /*
  * Parameter parsing functions.
  */
-static int devs = XPRAM_DEVS;
-static unsigned int sizes[XPRAM_MAX_DEVS];
+static int __initdata devs = XPRAM_DEVS;
+static char __initdata *sizes[XPRAM_MAX_DEVS];
 
 module_param(devs, int, 0);
-module_param_array(sizes, int, NULL, 0);
+module_param_array(sizes, charp, NULL, 0);
 
 MODULE_PARM_DESC(devs, "number of devices (\"partitions\"), " \
 		 "the default is " __MODULE_STRING(XPRAM_DEVS) "\n");
@@ -86,59 +86,6 @@ MODULE_PARM_DESC(sizes, "list of device 
 		 "claimed by explicit sizes\n");
 MODULE_LICENSE("GPL");
 
-#ifndef MODULE
-/*
- * Parses the kernel parameters given in the kernel parameter line.
- * The expected format is
- *           <number_of_partitions>[","<partition_size>]*
- * where
- *           devices is a positive integer that initializes xpram_devs
- *           each size is a non-negative integer possibly followed by a
- *           magnitude (k,K,m,M,g,G), the list of sizes initialises
- *           xpram_sizes
- *
- * Arguments
- *           str: substring of kernel parameter line that contains xprams
- *                kernel parameters.
- *
- * Result    0 on success, -EINVAL else -- only for Version > 2.3
- *
- * Side effects
- *           the global variabls devs is set to the value of
- *           <number_of_partitions> and sizes[i] is set to the i-th
- *           partition size (if provided). A parsing error of a value
- *           results in this value being set to -EINVAL.
- */
-static int __init xpram_setup (char *str)
-{
-	char *cp;
-	int i;
-
-	devs = simple_strtoul(str, &cp, 10);
-	if (cp <= str || devs > XPRAM_MAX_DEVS)
-		return 0;
-	for (i = 0; (i < devs) && (*cp++ == ','); i++) {
-		sizes[i] = simple_strtoul(cp, &cp, 10);
-		if (*cp == 'g' || *cp == 'G') {
-			sizes[i] <<= 20;
-			cp++;
-		} else if (*cp == 'm' || *cp == 'M') {
-			sizes[i] <<= 10;
-			cp++;
-		} else if (*cp == 'k' || *cp == 'K')
-			cp++;
-		while (isspace(*cp)) cp++;
-	}
-	if (*cp == ',' && i >= devs)
-		PRINT_WARN("partition sizes list has too many entries.\n");
-	else if (*cp != 0)
-		PRINT_WARN("ignored '%s' at end of parameter string.\n", cp);
-	return 1;
-}
-
-__setup("xpram_parts=", xpram_setup);
-#endif
-
 /*
  * Copy expanded memory page (4kB) into main memory                  
  * Arguments                                                         
@@ -374,7 +321,9 @@ static int __init xpram_setup_sizes(unsi
 	mem_needed = 0;
 	mem_auto_no = 0;
 	for (i = 0; i < xpram_devs; i++) {
-		xpram_sizes[i] = (sizes[i] + 3) & -4UL;
+		if (sizes[i])
+			xpram_sizes[i] =
+				(memparse(sizes[i], &sizes[i]) + 3) & -4UL;
 		if (xpram_sizes[i])
 			mem_needed += xpram_sizes[i];
 		else
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index f25c6d1..2fa566f 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -693,7 +693,7 @@ raw3215_probe (struct ccw_device *cdev)
 				       GFP_KERNEL|GFP_DMA);
 	if (raw->buffer == NULL) {
 		spin_lock(&raw3215_device_lock);
-		raw3215[line] = 0;
+		raw3215[line] = NULL;
 		spin_unlock(&raw3215_device_lock);
 		kfree(raw);
 		return -ENOMEM;
diff --git a/drivers/s390/char/ctrlchar.c b/drivers/s390/char/ctrlchar.c
index 0ea6f36..d83eb63 100644
--- a/drivers/s390/char/ctrlchar.c
+++ b/drivers/s390/char/ctrlchar.c
@@ -23,7 +23,7 @@ ctrlchar_handle_sysrq(void *tty)
 	handle_sysrq(ctrlchar_sysrq_key, NULL, (struct tty_struct *) tty);
 }
 
-static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq, 0);
+static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq, NULL);
 #endif
 
 
diff --git a/drivers/s390/char/defkeymap.c b/drivers/s390/char/defkeymap.c
index ca15adb..17027d9 100644
--- a/drivers/s390/char/defkeymap.c
+++ b/drivers/s390/char/defkeymap.c
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
diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 6099c14..ef004d0 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
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
diff --git a/drivers/s390/char/keyboard.c b/drivers/s390/char/keyboard.c
index 547ef90..3be0656 100644
--- a/drivers/s390/char/keyboard.c
+++ b/drivers/s390/char/keyboard.c
@@ -103,7 +103,7 @@ out_maps:
 out_kbd:
 	kfree(kbd);
 out:
-	return 0;
+	return NULL;
 }
 
 void
@@ -304,7 +304,7 @@ #ifdef CONFIG_MAGIC_SYSRQ	       /* Hand
 		if (kbd->sysrq) {
 			if (kbd->sysrq == K(KT_LATIN, '-')) {
 				kbd->sysrq = 0;
-				handle_sysrq(value, 0, kbd->tty);
+				handle_sysrq(value, NULL, kbd->tty);
 				return;
 			}
 			if (value == '-') {
@@ -363,7 +363,7 @@ #endif
 			/* disallocate map */
 			key_map = kbd->key_maps[tmp.kb_table];
 			if (key_map) {
-			    kbd->key_maps[tmp.kb_table] = 0;
+			    kbd->key_maps[tmp.kb_table] = NULL;
 			    kfree(key_map);
 			}
 			break;
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index e95b56f..95e285b 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
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
diff --git a/drivers/s390/char/raw3270.h b/drivers/s390/char/raw3270.h
index b635bf8..90beaa8 100644
--- a/drivers/s390/char/raw3270.h
+++ b/drivers/s390/char/raw3270.h
@@ -231,7 +231,7 @@ alloc_string(struct list_head *free_list
 		INIT_LIST_HEAD(&cs->update);
 		return cs;
 	}
-	return 0;
+	return NULL;
 }
 
 static inline unsigned long
diff --git a/drivers/s390/char/tape_34xx.c b/drivers/s390/char/tape_34xx.c
index 48b4d30..7b95dab 100644
--- a/drivers/s390/char/tape_34xx.c
+++ b/drivers/s390/char/tape_34xx.c
@@ -1309,9 +1309,9 @@ #endif
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
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index f496f23..2971804 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
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
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index c625b69..6cb2304 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
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
diff --git a/drivers/s390/char/vmwatchdog.c b/drivers/s390/char/vmwatchdog.c
index 5acc0ac..807320a 100644
--- a/drivers/s390/char/vmwatchdog.c
+++ b/drivers/s390/char/vmwatchdog.c
@@ -193,7 +193,7 @@ static int vmwdt_ioctl(struct inode *i, 
 		return 0;
 	case WDIOC_GETSTATUS:
 	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, (int *)arg);
+		return put_user(0, (int __user *)arg);
 	case WDIOC_GETTEMP:
 		return -EINVAL;
 	case WDIOC_SETOPTIONS:
diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index c7319a0..f26a2ee 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -319,7 +319,7 @@ ccwgroup_online_store (struct device *de
 	if (!try_module_get(gdrv->owner))
 		return -EINVAL;
 
-	value = simple_strtoul(buf, 0, 0);
+	value = simple_strtoul(buf, NULL, 0);
 	ret = count;
 	if (value == 1)
 		ccwgroup_set_online(gdev);
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index a01f3bb..61ce3f1 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1464,6 +1464,40 @@ chsc_get_chp_desc(struct subchannel *sch
 	return desc;
 }
 
+static int reset_channel_path(struct channel_path *chp)
+{
+	int cc;
+
+	cc = rchp(chp->id);
+	switch (cc) {
+	case 0:
+		return 0;
+	case 2:
+		return -EBUSY;
+	default:
+		return -ENODEV;
+	}
+}
+
+static void reset_channel_paths_css(struct channel_subsystem *css)
+{
+	int i;
+
+	for (i = 0; i <= __MAX_CHPID; i++) {
+		if (css->chps[i])
+			reset_channel_path(css->chps[i]);
+	}
+}
+
+void cio_reset_channel_paths(void)
+{
+	int i;
+
+	for (i = 0; i <= __MAX_CSSID; i++) {
+		if (css[i] && css[i]->valid)
+			reset_channel_paths_css(css[i]);
+	}
+}
 
 static int __init
 chsc_alloc_sei_area(void)
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 6fec90e..89320c1 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -519,6 +519,7 @@ cio_validate_subchannel (struct subchann
 	memset(sch, 0, sizeof(struct subchannel));
 
 	spin_lock_init(&sch->lock);
+	mutex_init(&sch->reg_mutex);
 
 	/* Set a name for the subchannel */
 	snprintf (sch->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x", schid.ssid,
@@ -797,7 +798,7 @@ struct subchannel *
 cio_get_console_subchannel(void)
 {
 	if (!console_subchannel_in_use)
-		return 0;
+		return NULL;
 	return &console_subchannel;
 }
 
@@ -875,5 +876,6 @@ void
 reipl(unsigned long devno)
 {
 	clear_all_subchannels();
+	cio_reset_channel_paths();
 	do_reipl(devno);
 }
diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index 0ca9873..4541c1a 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -2,6 +2,7 @@ #ifndef S390_CIO_H
 #define S390_CIO_H
 
 #include "schid.h"
+#include <linux/mutex.h>
 
 /*
  * where we put the ssd info
@@ -87,7 +88,7 @@ struct orb {
 struct subchannel {
 	struct subchannel_id schid;
 	spinlock_t lock;	/* subchannel lock */
-
+	struct mutex reg_mutex;
 	enum {
 		SUBCHANNEL_TYPE_IO = 0,
 		SUBCHANNEL_TYPE_CHSC = 1,
diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 1c3e8e9..0df3af1 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
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
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 1d3be80..13eeea3 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -108,6 +108,24 @@ css_subchannel_release(struct device *de
 
 extern int css_get_ssd_info(struct subchannel *sch);
 
+
+int css_sch_device_register(struct subchannel *sch)
+{
+	int ret;
+
+	mutex_lock(&sch->reg_mutex);
+	ret = device_register(&sch->dev);
+	mutex_unlock(&sch->reg_mutex);
+	return ret;
+}
+
+void css_sch_device_unregister(struct subchannel *sch)
+{
+	mutex_lock(&sch->reg_mutex);
+	device_unregister(&sch->dev);
+	mutex_unlock(&sch->reg_mutex);
+}
+
 static int
 css_register_subchannel(struct subchannel *sch)
 {
@@ -119,7 +137,7 @@ css_register_subchannel(struct subchanne
 	sch->dev.release = &css_subchannel_release;
 	
 	/* make it known to the system */
-	ret = device_register(&sch->dev);
+	ret = css_sch_device_register(sch);
 	if (ret)
 		printk (KERN_WARNING "%s: could not register %s\n",
 			__func__, sch->dev.bus_id);
@@ -250,7 +268,7 @@ css_evaluate_subchannel(struct subchanne
 		 * The device will be killed automatically.
 		 */
 		cio_disable_subchannel(sch);
-		device_unregister(&sch->dev);
+		css_sch_device_unregister(sch);
 		/* Reset intparm to zeroes. */
 		sch->schib.pmcw.intparm = 0;
 		cio_modify(sch);
@@ -264,7 +282,7 @@ css_evaluate_subchannel(struct subchanne
 		 * away in any case.
 		 */
 		if (!disc) {
-			device_unregister(&sch->dev);
+			css_sch_device_unregister(sch);
 			/* Reset intparm to zeroes. */
 			sch->schib.pmcw.intparm = 0;
 			cio_modify(sch);
@@ -605,9 +623,13 @@ init_channel_subsystem (void)
 		ret = device_register(&css[i]->device);
 		if (ret)
 			goto out_free;
-		if (css_characteristics_avail && css_chsc_characteristics.secm)
-			device_create_file(&css[i]->device,
-					   &dev_attr_cm_enable);
+		if (css_characteristics_avail &&
+		    css_chsc_characteristics.secm) {
+			ret = device_create_file(&css[i]->device,
+						 &dev_attr_cm_enable);
+			if (ret)
+				goto out_device;
+		}
 	}
 	css_init_done = 1;
 
@@ -615,6 +637,8 @@ init_channel_subsystem (void)
 
 	for_each_subchannel(__init_channel_subsystem, NULL);
 	return 0;
+out_device:
+	device_unregister(&css[i]->device);
 out_free:
 	kfree(css[i]);
 out_unregister:
diff --git a/drivers/s390/cio/css.h b/drivers/s390/cio/css.h
index e210f89..8aabb4a 100644
--- a/drivers/s390/cio/css.h
+++ b/drivers/s390/cio/css.h
@@ -100,7 +100,7 @@ struct ccw_device_private {
 	struct qdio_irq *qdio_data;
 	struct irb irb;		/* device status */
 	struct senseid senseid;	/* SenseID info */
-	struct pgid pgid;	/* path group ID */
+	struct pgid pgid[8];	/* path group IDs per chpid*/
 	struct ccw1 iccws[2];	/* ccws for SNID/SID/SPGID commands */
 	struct work_struct kick_work;
 	wait_queue_head_t wait_q;
@@ -136,6 +136,8 @@ extern struct bus_type css_bus_type;
 extern struct css_driver io_subchannel_driver;
 
 extern int css_probe_device(struct subchannel_id);
+extern int css_sch_device_register(struct subchannel *);
+extern void css_sch_device_unregister(struct subchannel *);
 extern struct subchannel * get_subchannel_by_schid(struct subchannel_id);
 extern int css_init_done;
 extern int for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 67f0de6..585fa04 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -100,7 +100,7 @@ ccw_uevent (struct device *dev, char **e
 	if ((buffer_size - length <= 0) || (i >= num_envp))
 		return -ENOMEM;
 
-	envp[i] = 0;
+	envp[i] = NULL;
 
 	return 0;
 }
@@ -280,7 +280,7 @@ ccw_device_remove_disconnected(struct cc
 	 * 'throw away device'.
 	 */
 	sch = to_subchannel(cdev->dev.parent);
-	device_unregister(&sch->dev);
+	css_sch_device_unregister(sch);
 	/* Reset intparm to zeroes. */
 	sch->schib.pmcw.intparm = 0;
 	cio_modify(sch);
@@ -625,7 +625,7 @@ ccw_device_do_unreg_rereg(void *data)
 					other_sch->schib.pmcw.intparm = 0;
 					cio_modify(other_sch);
 				}
-				device_unregister(&other_sch->dev);
+				css_sch_device_unregister(other_sch);
 			}
 		}
 		/* Update ssd info here. */
@@ -709,7 +709,7 @@ ccw_device_call_sch_unregister(void *dat
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
-	device_unregister(&sch->dev);
+	css_sch_device_unregister(sch);
 	/* Reset intparm to zeroes. */
 	sch->schib.pmcw.intparm = 0;
 	cio_modify(sch);
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
 
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index cb1af0b..ac6e0c7 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -378,6 +378,56 @@ ccw_device_done(struct ccw_device *cdev,
 		put_device (&cdev->dev);
 }
 
+static inline int cmp_pgid(struct pgid *p1, struct pgid *p2)
+{
+	char *c1;
+	char *c2;
+
+	c1 = (char *)p1;
+	c2 = (char *)p2;
+
+	return memcmp(c1 + 1, c2 + 1, sizeof(struct pgid) - 1);
+}
+
+static void __ccw_device_get_common_pgid(struct ccw_device *cdev)
+{
+	int i;
+	int last;
+
+	last = 0;
+	for (i = 0; i < 8; i++) {
+		if (cdev->private->pgid[i].inf.ps.state1 == SNID_STATE1_RESET)
+			/* No PGID yet */
+			continue;
+		if (cdev->private->pgid[last].inf.ps.state1 ==
+		    SNID_STATE1_RESET) {
+			/* First non-zero PGID */
+			last = i;
+			continue;
+		}
+		if (cmp_pgid(&cdev->private->pgid[i],
+			     &cdev->private->pgid[last]) == 0)
+			/* Non-conflicting PGIDs */
+			continue;
+
+		/* PGID mismatch, can't pathgroup. */
+		CIO_MSG_EVENT(0, "SNID - pgid mismatch for device "
+			      "0.%x.%04x, can't pathgroup\n",
+			      cdev->private->ssid, cdev->private->devno);
+		cdev->private->options.pgroup = 0;
+		return;
+	}
+	if (cdev->private->pgid[last].inf.ps.state1 ==
+	    SNID_STATE1_RESET)
+		/* No previous pgid found */
+		memcpy(&cdev->private->pgid[0], &css[0]->global_pgid,
+		       sizeof(struct pgid));
+	else
+		/* Use existing pgid */
+		memcpy(&cdev->private->pgid[0], &cdev->private->pgid[last],
+		       sizeof(struct pgid));
+}
+
 /*
  * Function called from device_pgid.c after sense path ground has completed.
  */
@@ -388,24 +438,26 @@ ccw_device_sense_pgid_done(struct ccw_de
 
 	sch = to_subchannel(cdev->dev.parent);
 	switch (err) {
-	case 0:
-		/* Start Path Group verification. */
-		sch->vpm = 0;	/* Start with no path groups set. */
-		cdev->private->state = DEV_STATE_VERIFY;
-		ccw_device_verify_start(cdev);
+	case -EOPNOTSUPP: /* path grouping not supported, use nop instead. */
+		cdev->private->options.pgroup = 0;
+		break;
+	case 0: /* success */
+	case -EACCES: /* partial success, some paths not operational */
+		/* Check if all pgids are equal or 0. */
+		__ccw_device_get_common_pgid(cdev);
 		break;
 	case -ETIME:		/* Sense path group id stopped by timeout. */
 	case -EUSERS:		/* device is reserved for someone else. */
 		ccw_device_done(cdev, DEV_STATE_BOXED);
-		break;
-	case -EOPNOTSUPP: /* path grouping not supported, just set online. */
-		cdev->private->options.pgroup = 0;
-		ccw_device_done(cdev, DEV_STATE_ONLINE);
-		break;
+		return;
 	default:
 		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
-		break;
+		return;
 	}
+	/* Start Path Group verification. */
+	sch->vpm = 0;	/* Start with no path groups set. */
+	cdev->private->state = DEV_STATE_VERIFY;
+	ccw_device_verify_start(cdev);
 }
 
 /*
@@ -562,8 +614,9 @@ ccw_device_online(struct ccw_device *cde
 	}
 	/* Do we want to do path grouping? */
 	if (!cdev->private->options.pgroup) {
-		/* No, set state online immediately. */
-		ccw_device_done(cdev, DEV_STATE_ONLINE);
+		/* Start initial path verification. */
+		cdev->private->state = DEV_STATE_VERIFY;
+		ccw_device_verify_start(cdev);
 		return 0;
 	}
 	/* Do a SensePGID first. */
@@ -609,6 +662,7 @@ ccw_device_offline(struct ccw_device *cd
 	/* Are we doing path grouping? */
 	if (!cdev->private->options.pgroup) {
 		/* No, set state offline immediately. */
+		sch->vpm = 0;
 		ccw_device_done(cdev, DEV_STATE_OFFLINE);
 		return 0;
 	}
@@ -705,8 +759,6 @@ ccw_device_online_verify(struct ccw_devi
 {
 	struct subchannel *sch;
 
-	if (!cdev->private->options.pgroup)
-		return;
 	if (cdev->private->state == DEV_STATE_W4SENSE) {
 		cdev->private->flags.doverify = 1;
 		return;
@@ -995,8 +1047,7 @@ static void
 ccw_device_wait4io_verify(struct ccw_device *cdev, enum dev_event dev_event)
 {
 	/* When the I/O has terminated, we have to start verification. */
-	if (cdev->private->options.pgroup)
-		cdev->private->flags.doverify = 1;
+	cdev->private->flags.doverify = 1;
 }
 
 static void
diff --git a/drivers/s390/cio/device_pgid.c b/drivers/s390/cio/device_pgid.c
index 54cb64e..32610fd 100644
--- a/drivers/s390/cio/device_pgid.c
+++ b/drivers/s390/cio/device_pgid.c
@@ -33,12 +33,17 @@ __ccw_device_sense_pgid_start(struct ccw
 	struct subchannel *sch;
 	struct ccw1 *ccw;
 	int ret;
+	int i;
 
 	sch = to_subchannel(cdev->dev.parent);
+	/* Return if we already checked on all paths. */
+	if (cdev->private->imask == 0)
+		return (sch->lpm == 0) ? -ENODEV : -EACCES;
+	i = 8 - ffs(cdev->private->imask);
+
 	/* Setup sense path group id channel program. */
 	ccw = cdev->private->iccws;
 	ccw->cmd_code = CCW_CMD_SENSE_PGID;
-	ccw->cda = (__u32) __pa (&cdev->private->pgid);
 	ccw->count = sizeof (struct pgid);
 	ccw->flags = CCW_FLAG_SLI;
 
@@ -48,6 +53,7 @@ __ccw_device_sense_pgid_start(struct ccw
 	ret = -ENODEV;
 	while (cdev->private->imask != 0) {
 		/* Try every path multiple times. */
+		ccw->cda = (__u32) __pa (&cdev->private->pgid[i]);
 		if (cdev->private->iretry > 0) {
 			cdev->private->iretry--;
 			ret = cio_start (sch, cdev->private->iccws, 
@@ -64,7 +70,9 @@ __ccw_device_sense_pgid_start(struct ccw
 		}
 		cdev->private->imask >>= 1;
 		cdev->private->iretry = 5;
+		i++;
 	}
+
 	return ret;
 }
 
@@ -76,7 +84,7 @@ ccw_device_sense_pgid_start(struct ccw_d
 	cdev->private->state = DEV_STATE_SENSE_PGID;
 	cdev->private->imask = 0x80;
 	cdev->private->iretry = 5;
-	memset (&cdev->private->pgid, 0, sizeof (struct pgid));
+	memset (&cdev->private->pgid, 0, sizeof (cdev->private->pgid));
 	ret = __ccw_device_sense_pgid_start(cdev);
 	if (ret && ret != -EBUSY)
 		ccw_device_sense_pgid_done(cdev, ret);
@@ -91,6 +99,7 @@ __ccw_device_check_sense_pgid(struct ccw
 {
 	struct subchannel *sch;
 	struct irb *irb;
+	int i;
 
 	sch = to_subchannel(cdev->dev.parent);
 	irb = &cdev->private->irb;
@@ -124,7 +133,8 @@ __ccw_device_check_sense_pgid(struct ccw
 			      sch->schid.sch_no, sch->orb.lpm);
 		return -EACCES;
 	}
-	if (cdev->private->pgid.inf.ps.state2 == SNID_STATE2_RESVD_ELSE) {
+	i = 8 - ffs(cdev->private->imask);
+	if (cdev->private->pgid[i].inf.ps.state2 == SNID_STATE2_RESVD_ELSE) {
 		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel 0.%x.%04x "
 			      "is reserved by someone else\n",
 			      cdev->private->devno, sch->schid.ssid,
@@ -162,12 +172,6 @@ ccw_device_sense_pgid_irq(struct ccw_dev
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
 	switch (ret) {
 	/* 0, -ETIME, -EOPNOTSUPP, -EAGAIN, -EACCES or -EUSERS */
-	case 0:			/* Sense Path Group ID successful. */
-		if (cdev->private->pgid.inf.ps.state1 == SNID_STATE1_RESET)
-			memcpy(&cdev->private->pgid, &css[0]->global_pgid,
-			       sizeof(struct pgid));
-		ccw_device_sense_pgid_done(cdev, 0);
-		break;
 	case -EOPNOTSUPP:	/* Sense Path Group ID not supported */
 		ccw_device_sense_pgid_done(cdev, -EOPNOTSUPP);
 		break;
@@ -176,13 +180,15 @@ ccw_device_sense_pgid_irq(struct ccw_dev
 		break;
 	case -EACCES:		/* channel is not operational. */
 		sch->lpm &= ~cdev->private->imask;
+		/* Fall through. */
+	case 0:			/* Sense Path Group ID successful. */
 		cdev->private->imask >>= 1;
 		cdev->private->iretry = 5;
 		/* Fall through. */
 	case -EAGAIN:		/* Try again. */
 		ret = __ccw_device_sense_pgid_start(cdev);
 		if (ret != 0 && ret != -EBUSY)
-			ccw_device_sense_pgid_done(cdev, -ENODEV);
+			ccw_device_sense_pgid_done(cdev, ret);
 		break;
 	case -EUSERS:		/* device is reserved for someone else. */
 		ccw_device_sense_pgid_done(cdev, -EUSERS);
@@ -203,20 +209,20 @@ __ccw_device_do_pgid(struct ccw_device *
 	sch = to_subchannel(cdev->dev.parent);
 
 	/* Setup sense path group id channel program. */
-	cdev->private->pgid.inf.fc = func;
+	cdev->private->pgid[0].inf.fc = func;
 	ccw = cdev->private->iccws;
 	if (!cdev->private->flags.pgid_single) {
-		cdev->private->pgid.inf.fc |= SPID_FUNC_MULTI_PATH;
+		cdev->private->pgid[0].inf.fc |= SPID_FUNC_MULTI_PATH;
 		ccw->cmd_code = CCW_CMD_SUSPEND_RECONN;
 		ccw->cda = 0;
 		ccw->count = 0;
 		ccw->flags = CCW_FLAG_SLI | CCW_FLAG_CC;
 		ccw++;
 	} else
-		cdev->private->pgid.inf.fc |= SPID_FUNC_SINGLE_PATH;
+		cdev->private->pgid[0].inf.fc |= SPID_FUNC_SINGLE_PATH;
 
 	ccw->cmd_code = CCW_CMD_SET_PGID;
-	ccw->cda = (__u32) __pa (&cdev->private->pgid);
+	ccw->cda = (__u32) __pa (&cdev->private->pgid[0]);
 	ccw->count = sizeof (struct pgid);
 	ccw->flags = CCW_FLAG_SLI;
 
@@ -244,6 +250,48 @@ __ccw_device_do_pgid(struct ccw_device *
 }
 
 /*
+ * Helper function to send a nop ccw down a path.
+ */
+static int __ccw_device_do_nop(struct ccw_device *cdev)
+{
+	struct subchannel *sch;
+	struct ccw1 *ccw;
+	int ret;
+
+	sch = to_subchannel(cdev->dev.parent);
+
+	/* Setup nop channel program. */
+	ccw = cdev->private->iccws;
+	ccw->cmd_code = CCW_CMD_NOOP;
+	ccw->cda = 0;
+	ccw->count = 0;
+	ccw->flags = CCW_FLAG_SLI;
+
+	/* Reset device status. */
+	memset(&cdev->private->irb, 0, sizeof(struct irb));
+
+	/* Try multiple times. */
+	ret = -ENODEV;
+	if (cdev->private->iretry > 0) {
+		cdev->private->iretry--;
+		ret = cio_start (sch, cdev->private->iccws,
+				 cdev->private->imask);
+		/* ret is 0, -EBUSY, -EACCES or -ENODEV */
+		if ((ret != -EACCES) && (ret != -ENODEV))
+			return ret;
+	}
+	/* nop command failed on this path. Switch it off. */
+	sch->lpm &= ~cdev->private->imask;
+	sch->vpm &= ~cdev->private->imask;
+	CIO_MSG_EVENT(2, "NOP - Device %04x on Subchannel "
+		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
+		      cdev->private->devno, sch->schid.ssid,
+		      sch->schid.sch_no, cdev->private->imask);
+	return ret;
+}
+
+
+/*
  * Called from interrupt context to check if a valid answer
  * to Set Path Group ID was received.
  */
@@ -282,6 +330,29 @@ __ccw_device_check_pgid(struct ccw_devic
 	return 0;
 }
 
+/*
+ * Called from interrupt context to check the path status after a nop has
+ * been send.
+ */
+static int __ccw_device_check_nop(struct ccw_device *cdev)
+{
+	struct subchannel *sch;
+	struct irb *irb;
+
+	sch = to_subchannel(cdev->dev.parent);
+	irb = &cdev->private->irb;
+	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC))
+		return -ETIME;
+	if (irb->scsw.cc == 3) {
+		CIO_MSG_EVENT(2, "NOP - Device %04x on Subchannel 0.%x.%04x,"
+			      " lpm %02X, became 'not operational'\n",
+			      cdev->private->devno, sch->schid.ssid,
+			      sch->schid.sch_no, cdev->private->imask);
+		return -EACCES;
+	}
+	return 0;
+}
+
 static void
 __ccw_device_verify_start(struct ccw_device *cdev)
 {
@@ -296,9 +367,12 @@ __ccw_device_verify_start(struct ccw_dev
 			if ((sch->vpm & imask) != (sch->lpm & imask))
 				break;
 		cdev->private->imask = imask;
-		func = (sch->vpm & imask) ?
-			SPID_FUNC_RESIGN : SPID_FUNC_ESTABLISH;
-		ret = __ccw_device_do_pgid(cdev, func);
+		if (cdev->private->options.pgroup) {
+			func = (sch->vpm & imask) ?
+				SPID_FUNC_RESIGN : SPID_FUNC_ESTABLISH;
+			ret = __ccw_device_do_pgid(cdev, func);
+		} else
+			ret = __ccw_device_do_nop(cdev);
 		if (ret == 0 || ret == -EBUSY)
 			return;
 		cdev->private->iretry = 5;
@@ -327,7 +401,10 @@ ccw_device_verify_irq(struct ccw_device 
 	if (ccw_device_accumulate_and_sense(cdev, irb) != 0)
 		return;
 	sch = to_subchannel(cdev->dev.parent);
-	ret = __ccw_device_check_pgid(cdev);
+	if (cdev->private->options.pgroup)
+		ret = __ccw_device_check_pgid(cdev);
+	else
+		ret = __ccw_device_check_nop(cdev);
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
 	switch (ret) {
 	/* 0, -ETIME, -EAGAIN, -EOPNOTSUPP or -EACCES */
@@ -345,11 +422,10 @@ ccw_device_verify_irq(struct ccw_device 
 		 * One of those strange devices which claim to be able
 		 * to do multipathing but not for Set Path Group ID.
 		 */
-		if (cdev->private->flags.pgid_single) {
-			ccw_device_verify_done(cdev, -EOPNOTSUPP);
-			break;
-		}
-		cdev->private->flags.pgid_single = 1;
+		if (cdev->private->flags.pgid_single)
+			cdev->private->options.pgroup = 0;
+		else
+			cdev->private->flags.pgid_single = 1;
 		/* fall through. */
 	case -EAGAIN:		/* Try again. */
 		__ccw_device_verify_start(cdev);
diff --git a/drivers/s390/cio/device_status.c b/drivers/s390/cio/device_status.c
index 14bef2c..caf148d 100644
--- a/drivers/s390/cio/device_status.c
+++ b/drivers/s390/cio/device_status.c
@@ -67,8 +67,7 @@ ccw_device_path_notoper(struct ccw_devic
 		      sch->schib.pmcw.pnom);
 
 	sch->lpm &= ~sch->schib.pmcw.pnom;
-	if (cdev->private->options.pgroup)
-		cdev->private->flags.doverify = 1;
+	cdev->private->flags.doverify = 1;
 }
 
 /*
@@ -180,7 +179,7 @@ ccw_device_accumulate_esw(struct ccw_dev
 	cdev_irb->esw.esw0.erw.auth = irb->esw.esw0.erw.auth;
 	/* Copy path verification required flag. */
 	cdev_irb->esw.esw0.erw.pvrf = irb->esw.esw0.erw.pvrf;
-	if (irb->esw.esw0.erw.pvrf && cdev->private->options.pgroup)
+	if (irb->esw.esw0.erw.pvrf)
 		cdev->private->flags.doverify = 1;
 	/* Copy concurrent sense bit. */
 	cdev_irb->esw.esw0.erw.cons = irb->esw.esw0.erw.cons;
@@ -354,7 +353,7 @@ ccw_device_accumulate_basic_sense(struct
 	}
 	/* Check if path verification is required. */
 	if (ccw_device_accumulate_esw_valid(irb) &&
-	    irb->esw.esw0.erw.pvrf && cdev->private->options.pgroup) 
+	    irb->esw.esw0.erw.pvrf)
 		cdev->private->flags.doverify = 1;
 }
 
diff --git a/drivers/s390/cio/qdio.c b/drivers/s390/cio/qdio.c
index b70039a..7c93a87 100644
--- a/drivers/s390/cio/qdio.c
+++ b/drivers/s390/cio/qdio.c
@@ -2735,7 +2735,7 @@ qdio_free(struct ccw_device *cdev)
 	QDIO_DBF_TEXT1(0,trace,dbf_text);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
-	cdev->private->qdio_data = 0;
+	cdev->private->qdio_data = NULL;
 
 	up(&irq_ptr->setting_up_sema);
 
diff --git a/drivers/s390/net/iucv.c b/drivers/s390/net/iucv.c
index 189a492..0e863df 100644
--- a/drivers/s390/net/iucv.c
+++ b/drivers/s390/net/iucv.c
@@ -692,7 +692,7 @@ iucv_retrieve_buffer (void)
 	iucv_debug(1, "entering");
 	if (iucv_cpuid != -1) {
 		smp_call_function_on(iucv_retrieve_buffer_cpuid,
-				     0, 0, 1, iucv_cpuid);
+				     NULL, 0, 1, iucv_cpuid);
 		/* Release the cpu reserved by iucv_declare_buffer. */
 		smp_put_cpu(iucv_cpuid);
 		iucv_cpuid = -1;
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index 4caced2..103c414 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
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
diff --git a/drivers/s390/net/qeth_sys.c b/drivers/s390/net/qeth_sys.c
index 185a9cf..001497b 100644
--- a/drivers/s390/net/qeth_sys.c
+++ b/drivers/s390/net/qeth_sys.c
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
diff --git a/drivers/s390/net/smsgiucv.c b/drivers/s390/net/smsgiucv.c
index 72118ee..b8179c2 100644
--- a/drivers/s390/net/smsgiucv.c
+++ b/drivers/s390/net/smsgiucv.c
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
diff --git a/drivers/s390/s390mach.c b/drivers/s390/s390mach.c
index ffb3677..5399c5d 100644
--- a/drivers/s390/s390mach.c
+++ b/drivers/s390/s390mach.c
@@ -111,6 +111,16 @@ repeat:
 			break;
 		case CRW_RSC_CPATH:
 			pr_debug("source is channel path %02X\n", crw[0].rsid);
+			/*
+			 * Check for solicited machine checks. These are
+			 * created by reset channel path and need not be
+			 * reported to the common I/O layer.
+			 */
+			if (crw[chain].slct) {
+				DBG(KERN_INFO"solicited machine check for "
+				    "channel path %02X\n", crw[0].rsid);
+				break;
+			}
 			switch (crw[0].erc) {
 			case CRW_ERC_IPARM: /* Path has come. */
 				ret = chp_process_crw(crw[0].rsid, 1);
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 6335f92..31db2b0 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -2227,7 +2227,7 @@ zfcp_fsf_exchange_port_data(struct zfcp_
 	/* setup new FSF request */
 	retval = zfcp_fsf_req_create(adapter, FSF_QTCB_EXCHANGE_PORT_DATA,
 				     erp_action ? ZFCP_REQ_AUTO_CLEANUP : 0,
-				     0, &lock_flags, &fsf_req);
+				     NULL, &lock_flags, &fsf_req);
 	if (retval < 0) {
 		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
                               "exchange port data request for"
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index 46e14f2..671f4a6 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
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
diff --git a/include/asm-s390/bug.h b/include/asm-s390/bug.h
index 7ddaa05..8768983 100644
--- a/include/asm-s390/bug.h
+++ b/include/asm-s390/bug.h
@@ -5,9 +5,18 @@ #include <linux/kernel.h>
 
 #ifdef CONFIG_BUG
 
+static inline __attribute__((noreturn)) void __do_illegal_op(void)
+{
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 3)
+	__builtin_trap();
+#else
+	asm volatile(".long 0");
+#endif
+}
+
 #define BUG() do { \
 	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	__builtin_trap(); \
+	__do_illegal_op(); \
 } while (0)
 
 #define HAVE_ARCH_BUG
diff --git a/include/asm-s390/ccwdev.h b/include/asm-s390/ccwdev.h
index 12456cb..58c70ac 100644
--- a/include/asm-s390/ccwdev.h
+++ b/include/asm-s390/ccwdev.h
@@ -63,7 +63,7 @@ ccw_device_id_match(const struct ccw_dev
 		return id;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /* The struct ccw device is our replacement for the globally accessible
diff --git a/include/asm-s390/cio.h b/include/asm-s390/cio.h
index 2b16193..28fdd6e 100644
--- a/include/asm-s390/cio.h
+++ b/include/asm-s390/cio.h
@@ -276,6 +276,8 @@ extern void wait_cons_dev(void);
 
 extern void clear_all_subchannels(void);
 
+extern void cio_reset_channel_paths(void);
+
 extern void css_schedule_reprobe(void);
 
 #endif
diff --git a/include/asm-s390/futex.h b/include/asm-s390/futex.h
index 1802775..ffedf14 100644
--- a/include/asm-s390/futex.h
+++ b/include/asm-s390/futex.h
@@ -98,9 +98,10 @@ futex_atomic_cmpxchg_inatomic(int __user
 
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
-	asm volatile("   cs   %1,%4,0(%5)\n"
+	asm volatile("   sacf 256\n"
+		     "   cs   %1,%4,0(%5)\n"
 		     "0: lr   %0,%1\n"
-		     "1:\n"
+		     "1: sacf 0\n"
 #ifndef __s390x__
 		     ".section __ex_table,\"a\"\n"
 		     "   .align 4\n"
diff --git a/include/asm-s390/irqflags.h b/include/asm-s390/irqflags.h
index 65f4db6..3b566a5 100644
--- a/include/asm-s390/irqflags.h
+++ b/include/asm-s390/irqflags.h
@@ -25,16 +25,22 @@ #define raw_local_irq_disable() ({ \
 	__flags; \
 	})
 
-#define raw_local_save_flags(x) \
-	__asm__ __volatile__("stosm 0(%1),0" : "=m" (x) : "a" (&x), "m" (x) )
-
-#define raw_local_irq_restore(x) \
-	__asm__ __volatile__("ssm   0(%0)" : : "a" (&x), "m" (x) : "memory")
+#define raw_local_save_flags(x)							\
+do {										\
+	typecheck(unsigned long, x);						\
+	__asm__ __volatile__("stosm 0(%1),0" : "=m" (x) : "a" (&x), "m" (x) );	\
+} while (0)
+
+#define raw_local_irq_restore(x)						\
+do {										\
+	typecheck(unsigned long, x);						\
+	__asm__ __volatile__("ssm   0(%0)" : : "a" (&x), "m" (x) : "memory");	\
+} while (0)
 
 #define raw_irqs_disabled()		\
 ({					\
 	unsigned long flags;		\
-	local_save_flags(flags);	\
+	raw_local_save_flags(flags);	\
 	!((flags >> __FLAG_SHIFT) & 3);	\
 })
 
diff --git a/include/asm-s390/pgalloc.h b/include/asm-s390/pgalloc.h
index 3002fda..a78e853 100644
--- a/include/asm-s390/pgalloc.h
+++ b/include/asm-s390/pgalloc.h
@@ -142,7 +142,7 @@ pte_alloc_one(struct mm_struct *mm, unsi
 	pte_t *pte = pte_alloc_one_kernel(mm, vmaddr);
 	if (pte)
 		return virt_to_page(pte);
-	return 0;
+	return NULL;
 }
 
 static inline void pte_free_kernel(pte_t *pte)
diff --git a/include/asm-s390/processor.h b/include/asm-s390/processor.h
index c5cbc4b..5b71d37 100644
--- a/include/asm-s390/processor.h
+++ b/include/asm-s390/processor.h
@@ -199,15 +199,13 @@ #define KSTK_ESP(tsk)	(task_pt_regs(tsk)
 /*
  * Give up the time slice of the virtual PU.
  */
-#ifndef __s390x__
-# define cpu_relax()	asm volatile ("diag 0,0,68" : : : "memory")
-#else /* __s390x__ */
-# define cpu_relax() \
-	do { \
-		if (MACHINE_HAS_DIAG44) \
-			asm volatile ("diag 0,0,68" : : : "memory"); \
-	} while (0)
-#endif /* __s390x__ */
+static inline void cpu_relax(void)
+{
+	if (MACHINE_HAS_DIAG44)
+		asm volatile ("diag 0,0,68" : : : "memory");
+	else
+		barrier();
+}
 
 /*
  * Set PSW to specified value.
diff --git a/include/asm-s390/setup.h b/include/asm-s390/setup.h
index da3fd4a..19e3197 100644
--- a/include/asm-s390/setup.h
+++ b/include/asm-s390/setup.h
@@ -40,15 +40,16 @@ extern unsigned long machine_flags;
 #define MACHINE_IS_VM		(machine_flags & 1)
 #define MACHINE_IS_P390		(machine_flags & 4)
 #define MACHINE_HAS_MVPG	(machine_flags & 16)
-#define MACHINE_HAS_DIAG44	(machine_flags & 32)
 #define MACHINE_HAS_IDTE	(machine_flags & 128)
 
 #ifndef __s390x__
 #define MACHINE_HAS_IEEE	(machine_flags & 2)
 #define MACHINE_HAS_CSP		(machine_flags & 8)
+#define MACHINE_HAS_DIAG44	(1)
 #else /* __s390x__ */
 #define MACHINE_HAS_IEEE	(1)
 #define MACHINE_HAS_CSP		(1)
+#define MACHINE_HAS_DIAG44	(machine_flags & 32)
 #endif /* __s390x__ */
 
 



