Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbVIAWDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbVIAWDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbVIAWDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:03:07 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:2440 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030431AbVIAWDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:03:01 -0400
Date: Fri, 2 Sep 2005 00:02:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 10/10] use task_thread_info()
Message-ID: <Pine.LNX.4.61.0509020002200.12309@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This converts all remaining direct accesses to the thread_info to use 
task_thread_info() instead. These uses were not clear enough to fit in one 
of two previous patches, so wrapping them in task_thread_info() leaves the 
behaviour (i.e. variable type) unchanged.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/alpha/kernel/process.c         |   10 +++----
 arch/alpha/kernel/ptrace.c          |   40 +++++++++++++++----------------
 arch/alpha/kernel/smp.c             |    2 -
 arch/arm/kernel/process.c           |    6 ++--
 arch/arm/kernel/ptrace.c            |   10 +++----
 arch/arm26/kernel/process.c         |    2 -
 arch/arm26/kernel/ptrace.c          |    6 ++--
 arch/cris/arch-v10/kernel/process.c |    4 +--
 arch/cris/arch-v10/kernel/ptrace.c  |    4 +--
 arch/cris/arch-v32/kernel/process.c |    6 ++--
 arch/cris/arch-v32/kernel/ptrace.c  |    6 ++--
 arch/cris/arch-v32/kernel/smp.c     |    4 +--
 arch/cris/arch-v32/mm/tlb.c         |    4 +--
 arch/frv/kernel/process.c           |    2 -
 arch/i386/kernel/process.c          |    4 +--
 arch/i386/kernel/vm86.c             |    2 -
 arch/ia64/kernel/signal.c           |   10 +++----
 arch/m32r/kernel/smpboot.c          |    2 -
 arch/mips/kernel/process.c          |    2 -
 arch/mips/sibyte/cfe/smp.c          |    2 -
 arch/parisc/kernel/process.c        |    2 -
 arch/parisc/kernel/smp.c            |    2 -
 arch/ppc/kernel/process.c           |    2 -
 arch/ppc/kernel/smp.c               |    4 +--
 arch/ppc64/kernel/pSeries_smp.c     |    2 -
 arch/ppc64/kernel/process.c         |    4 +--
 arch/ppc64/kernel/smp.c             |    4 +--
 arch/s390/kernel/process.c          |    4 +--
 arch/sh/kernel/process.c            |    2 -
 arch/sh/kernel/smp.c                |    2 -
 arch/sparc/kernel/process.c         |    6 ++--
 arch/sparc/kernel/ptrace.c          |    4 +--
 arch/sparc/kernel/sun4d_smp.c       |    2 -
 arch/sparc/kernel/sun4m_smp.c       |    2 -
 arch/sparc/kernel/traps.c           |    4 +--
 arch/sparc64/kernel/process.c       |    6 ++--
 arch/sparc64/kernel/ptrace.c        |   46 ++++++++++++++++++------------------
 arch/sparc64/kernel/setup.c         |    2 -
 arch/sparc64/kernel/smp.c           |    2 -
 arch/sparc64/kernel/traps.c         |    2 -
 arch/um/kernel/process_kern.c       |    2 -
 arch/um/kernel/skas/process_kern.c  |    4 +--
 arch/um/kernel/tt/exec_kern.c       |    2 -
 arch/um/kernel/tt/process_kern.c    |    6 ++--
 arch/x86_64/kernel/i387.c           |    2 -
 arch/x86_64/kernel/i8259.c          |    2 -
 arch/x86_64/kernel/process.c        |    6 ++--
 arch/x86_64/kernel/smpboot.c        |    2 -
 arch/x86_64/kernel/traps.c          |    4 +--
 include/asm-alpha/mmu_context.h     |    6 ++--
 include/asm-alpha/processor.h       |    2 -
 include/asm-alpha/system.h          |    2 -
 include/asm-arm/system.h            |    2 -
 include/asm-arm/thread_info.h       |    4 +--
 include/asm-arm26/system.h          |    2 -
 include/asm-arm26/thread_info.h     |    4 +--
 include/asm-cris/processor.h        |    2 -
 include/asm-i386/i387.h             |    8 +++---
 include/asm-mips/system.h           |    2 -
 include/asm-ppc64/ptrace-common.h   |    4 +--
 include/asm-sparc/system.h          |    2 -
 include/asm-sparc64/elf.h           |    2 -
 include/asm-sparc64/mmu_context.h   |    2 -
 include/asm-sparc64/processor.h     |    4 +--
 include/asm-sparc64/system.h        |    4 +--
 include/asm-x86_64/i387.h           |    8 +++---
 include/linux/sched.h               |    2 -
 67 files changed, 162 insertions(+), 162 deletions(-)

Index: linux-2.6-mm/arch/alpha/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/alpha/kernel/process.c	2005-09-01 21:04:56.337239556 +0200
+++ linux-2.6-mm/arch/alpha/kernel/process.c	2005-09-01 21:05:02.421194356 +0200
@@ -271,7 +271,7 @@ copy_thread(int nr, unsigned long clone_
 {
 	extern void ret_from_fork(void);
 
-	struct thread_info *childti = p->thread_info;
+	struct thread_info *childti = task_thread_info(p);
 	struct pt_regs * childregs;
 	struct switch_stack * childstack, *stack;
 	unsigned long stack_offset, settls;
@@ -426,7 +426,7 @@ dump_elf_task(elf_greg_t *dest, struct t
 	struct thread_info *ti;
 	struct pt_regs *pt;
 
-	ti = task->thread_info;
+	ti = task_thread_info(task);
 	pt = (struct pt_regs *)((unsigned long)ti + 2*PAGE_SIZE) - 1;
 
 	dump_elf_thread(dest, pt, ti);
@@ -441,7 +441,7 @@ dump_elf_task_fp(elf_fpreg_t *dest, stru
 	struct pt_regs *pt;
 	struct switch_stack *sw;
 
-	ti = task->thread_info;
+	ti = task_thread_info(task);
 	pt = (struct pt_regs *)((unsigned long)ti + 2*PAGE_SIZE) - 1;
 	sw = (struct switch_stack *)pt - 1;
 
@@ -488,7 +488,7 @@ unsigned long
 thread_saved_pc(task_t *t)
 {
 	unsigned long base = (unsigned long)t->stack;
-	unsigned long fp, sp = t->thread_info->pcb.ksp;
+	unsigned long fp, sp = task_thread_info(t)->pcb.ksp;
 
 	if (sp > base && sp+6*8 < base + 16*1024) {
 		fp = ((unsigned long*)sp)[6];
@@ -518,7 +518,7 @@ get_wchan(struct task_struct *p)
 
 	pc = thread_saved_pc(p);
 	if (in_sched_functions(pc)) {
-		schedule_frame = ((unsigned long *)p->thread_info->pcb.ksp)[6];
+		schedule_frame = ((unsigned long *)task_thread_info(p)->pcb.ksp)[6];
 		return ((unsigned long *)schedule_frame)[12];
 	}
 	return pc;
Index: linux-2.6-mm/arch/alpha/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/alpha/kernel/ptrace.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/alpha/kernel/ptrace.c	2005-09-01 21:05:02.437191607 +0200
@@ -103,14 +103,14 @@ get_reg_addr(struct task_struct * task, 
 	unsigned long *addr;
 
 	if (regno == 30) {
-		addr = &task->thread_info->pcb.usp;
+		addr = &task_thread_info(task)->pcb.usp;
 	} else if (regno == 65) {
-		addr = &task->thread_info->pcb.unique;
+		addr = &task_thread_info(task)->pcb.unique;
 	} else if (regno == 31 || regno > 65) {
 		zero = 0;
 		addr = &zero;
 	} else {
-		addr = (void *)task->thread_info + regoff[regno];
+		addr = (void *)task_thread_info(task) + regoff[regno];
 	}
 	return addr;
 }
@@ -125,7 +125,7 @@ get_reg(struct task_struct * task, unsig
 	if (regno == 63) {
 		unsigned long fpcr = *get_reg_addr(task, regno);
 		unsigned long swcr
-		  = task->thread_info->ieee_state & IEEE_SW_MASK;
+		  = task_thread_info(task)->ieee_state & IEEE_SW_MASK;
 		swcr = swcr_update_status(swcr, fpcr);
 		return fpcr | swcr;
 	}
@@ -139,8 +139,8 @@ static int
 put_reg(struct task_struct *task, unsigned long regno, unsigned long data)
 {
 	if (regno == 63) {
-		task->thread_info->ieee_state
-		  = ((task->thread_info->ieee_state & ~IEEE_SW_MASK)
+		task_thread_info(task)->ieee_state
+		  = ((task_thread_info(task)->ieee_state & ~IEEE_SW_MASK)
 		     | (data & IEEE_SW_MASK));
 		data = (data & FPCR_DYN_MASK) | ieee_swcr_to_fpcr(data);
 	}
@@ -188,35 +188,35 @@ ptrace_set_bpt(struct task_struct * chil
 		 * branch (emulation can be tricky for fp branches).
 		 */
 		displ = ((s32)(insn << 11)) >> 9;
-		child->thread_info->bpt_addr[nsaved++] = pc + 4;
+		task_thread_info(child)->bpt_addr[nsaved++] = pc + 4;
 		if (displ)		/* guard against unoptimized code */
-			child->thread_info->bpt_addr[nsaved++]
+			task_thread_info(child)->bpt_addr[nsaved++]
 			  = pc + 4 + displ;
 		DBG(DBG_BPT, ("execing branch\n"));
 	} else if (op_code == 0x1a) {
 		reg_b = (insn >> 16) & 0x1f;
-		child->thread_info->bpt_addr[nsaved++] = get_reg(child, reg_b);
+		task_thread_info(child)->bpt_addr[nsaved++] = get_reg(child, reg_b);
 		DBG(DBG_BPT, ("execing jump\n"));
 	} else {
-		child->thread_info->bpt_addr[nsaved++] = pc + 4;
+		task_thread_info(child)->bpt_addr[nsaved++] = pc + 4;
 		DBG(DBG_BPT, ("execing normal insn\n"));
 	}
 
 	/* install breakpoints: */
 	for (i = 0; i < nsaved; ++i) {
-		res = read_int(child, child->thread_info->bpt_addr[i],
+		res = read_int(child, task_thread_info(child)->bpt_addr[i],
 			       (int *) &insn);
 		if (res < 0)
 			return res;
-		child->thread_info->bpt_insn[i] = insn;
+		task_thread_info(child)->bpt_insn[i] = insn;
 		DBG(DBG_BPT, ("    -> next_pc=%lx\n",
-			      child->thread_info->bpt_addr[i]));
-		res = write_int(child, child->thread_info->bpt_addr[i],
+			      task_thread_info(child)->bpt_addr[i]));
+		res = write_int(child, task_thread_info(child)->bpt_addr[i],
 				BREAKINST);
 		if (res < 0)
 			return res;
 	}
-	child->thread_info->bpt_nsaved = nsaved;
+	task_thread_info(child)->bpt_nsaved = nsaved;
 	return 0;
 }
 
@@ -227,9 +227,9 @@ ptrace_set_bpt(struct task_struct * chil
 int
 ptrace_cancel_bpt(struct task_struct * child)
 {
-	int i, nsaved = child->thread_info->bpt_nsaved;
+	int i, nsaved = task_thread_info(child)->bpt_nsaved;
 
-	child->thread_info->bpt_nsaved = 0;
+	task_thread_info(child)->bpt_nsaved = 0;
 
 	if (nsaved > 2) {
 		printk("ptrace_cancel_bpt: bogus nsaved: %d!\n", nsaved);
@@ -237,8 +237,8 @@ ptrace_cancel_bpt(struct task_struct * c
 	}
 
 	for (i = 0; i < nsaved; ++i) {
-		write_int(child, child->thread_info->bpt_addr[i],
-			  child->thread_info->bpt_insn[i]);
+		write_int(child, task_thread_info(child)->bpt_addr[i],
+			  task_thread_info(child)->bpt_insn[i]);
 	}
 	return (nsaved != 0);
 }
@@ -369,7 +369,7 @@ do_sys_ptrace(long request, long pid, lo
 		if (!valid_signal(data))
 			break;
 		/* Mark single stepping.  */
-		child->thread_info->bpt_nsaved = -1;
+		task_thread_info(child)->bpt_nsaved = -1;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->exit_code = data;
 		wake_up_process(child);
Index: linux-2.6-mm/arch/alpha/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/alpha/kernel/smp.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/alpha/kernel/smp.c	2005-09-01 21:05:02.456188344 +0200
@@ -302,7 +302,7 @@ secondary_cpu_start(int cpuid, struct ta
 		 + hwrpb->processor_offset
 		 + cpuid * hwrpb->processor_size);
 	hwpcb = (struct pcb_struct *) cpu->hwpcb;
-	ipcb = &idle->thread_info->pcb;
+	ipcb = &task_thread_info(idle)->pcb;
 
 	/* Initialize the CPU's HWPCB to something just good enough for
 	   us to get started.  Immediately after starting, we'll swpctx
Index: linux-2.6-mm/arch/arm/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/arm/kernel/process.c	2005-09-01 21:04:56.337239556 +0200
+++ linux-2.6-mm/arch/arm/kernel/process.c	2005-09-01 21:05:02.493181989 +0200
@@ -330,10 +330,10 @@ void flush_thread(void)
 void release_thread(struct task_struct *dead_task)
 {
 #if defined(CONFIG_VFP)
-	vfp_release_thread(&dead_task->thread_info->vfpstate);
+	vfp_release_thread(&task_thread_info(dead_task)->vfpstate);
 #endif
 #if defined(CONFIG_IWMMXT)
-	iwmmxt_task_release(dead_task->thread_info);
+	iwmmxt_task_release(task_thread_info(dead_task));
 #endif
 }
 
@@ -343,7 +343,7 @@ int
 copy_thread(int nr, unsigned long clone_flags, unsigned long stack_start,
 	    unsigned long stk_sz, struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *thread = p->thread_info;
+	struct thread_info *thread = task_thread_info(p);
 	struct pt_regs *childregs;
 
 	childregs = ((struct pt_regs *)((unsigned long)thread + THREAD_START_SP)) - 1;
Index: linux-2.6-mm/arch/arm/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/arm/kernel/ptrace.c	2005-09-01 21:04:56.354236636 +0200
+++ linux-2.6-mm/arch/arm/kernel/ptrace.c	2005-09-01 21:05:02.503180271 +0200
@@ -595,7 +595,7 @@ static int ptrace_setregs(struct task_st
  */
 static int ptrace_getfpregs(struct task_struct *tsk, void __user *ufp)
 {
-	return copy_to_user(ufp, &tsk->thread_info->fpstate,
+	return copy_to_user(ufp, &task_thread_info(tsk)->fpstate,
 			    sizeof(struct user_fp)) ? -EFAULT : 0;
 }
 
@@ -604,7 +604,7 @@ static int ptrace_getfpregs(struct task_
  */
 static int ptrace_setfpregs(struct task_struct *tsk, void __user *ufp)
 {
-	struct thread_info *thread = tsk->thread_info;
+	struct thread_info *thread = task_thread_info(tsk);
 	thread->used_cp[1] = thread->used_cp[2] = 1;
 	return copy_from_user(&thread->fpstate, ufp,
 			      sizeof(struct user_fp)) ? -EFAULT : 0;
@@ -617,7 +617,7 @@ static int ptrace_setfpregs(struct task_
  */
 static int ptrace_getwmmxregs(struct task_struct *tsk, void __user *ufp)
 {
-	struct thread_info *thread = tsk->thread_info;
+	struct thread_info *thread = task_thread_info(tsk);
 	void *ptr = &thread->fpstate;
 
 	if (!test_ti_thread_flag(thread, TIF_USING_IWMMXT))
@@ -634,7 +634,7 @@ static int ptrace_getwmmxregs(struct tas
  */
 static int ptrace_setwmmxregs(struct task_struct *tsk, void __user *ufp)
 {
-	struct thread_info *thread = tsk->thread_info;
+	struct thread_info *thread = task_thread_info(tsk);
 	void *ptr = &thread->fpstate;
 
 	if (!test_ti_thread_flag(thread, TIF_USING_IWMMXT))
@@ -770,7 +770,7 @@ static int do_ptrace(int request, struct
 #endif
 
 		case PTRACE_GET_THREAD_AREA:
-			ret = put_user(child->thread_info->tp_value,
+			ret = put_user(task_thread_info(child)->tp_value,
 				       (unsigned long __user *) data);
 			break;
 
Index: linux-2.6-mm/arch/arm26/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/arm26/kernel/process.c	2005-09-01 21:04:49.474418601 +0200
+++ linux-2.6-mm/arch/arm26/kernel/process.c	2005-09-01 21:05:02.504180099 +0200
@@ -279,7 +279,7 @@ int
 copy_thread(int nr, unsigned long clone_flags, unsigned long stack_start,
 	    unsigned long unused, struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *thread = p->thread_info;
+	struct thread_info *thread = task_thread_info(p);
 	struct pt_regs *childregs;
 
 	childregs = __get_user_regs(thread);
Index: linux-2.6-mm/arch/arm26/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/arm26/kernel/ptrace.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/arm26/kernel/ptrace.c	2005-09-01 21:05:02.539174087 +0200
@@ -51,7 +51,7 @@
 static inline struct pt_regs *
 get_user_regs(struct task_struct *task)
 {
-	return __get_user_regs(task->thread_info);
+	return __get_user_regs(task_thread_info(task));
 }
 
 /*
@@ -532,7 +532,7 @@ static int ptrace_setregs(struct task_st
  */
 static int ptrace_getfpregs(struct task_struct *tsk, void *ufp)
 {
-	return copy_to_user(ufp, &tsk->thread_info->fpstate,
+	return copy_to_user(ufp, &task_thread_info(tsk)->fpstate,
 			    sizeof(struct user_fp)) ? -EFAULT : 0;
 }
 
@@ -542,7 +542,7 @@ static int ptrace_getfpregs(struct task_
 static int ptrace_setfpregs(struct task_struct *tsk, void *ufp)
 {
 	set_stopped_child_used_math(tsk);
-	return copy_from_user(&tsk->thread_info->fpstate, ufp,
+	return copy_from_user(&task_thread_info(tsk)->fpstate, ufp,
 			      sizeof(struct user_fp)) ? -EFAULT : 0;
 }
 
Index: linux-2.6-mm/arch/cris/arch-v10/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/cris/arch-v10/kernel/process.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/cris/arch-v10/kernel/process.c	2005-09-01 21:05:02.580167045 +0200
@@ -79,7 +79,7 @@ void hard_reset_now (void)
  */
 unsigned long thread_saved_pc(struct task_struct *t)
 {
-	return (unsigned long)user_regs(t->thread_info)->irp;
+	return (unsigned long)user_regs(task_thread_info(t))->irp;
 }
 
 static void kernel_thread_helper(void* dummy, int (*fn)(void *), void * arg)
@@ -128,7 +128,7 @@ int copy_thread(int nr, unsigned long cl
 	 * remember that the task_struct doubles as the kernel stack for the task
 	 */
 
-	childregs = user_regs(p->thread_info);        
+	childregs = user_regs(task_thread_info(p));
         
 	*childregs = *regs;  /* struct copy of pt_regs */
         
Index: linux-2.6-mm/arch/cris/arch-v10/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/cris/arch-v10/kernel/ptrace.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/cris/arch-v10/kernel/ptrace.c	2005-09-01 21:05:02.589165499 +0200
@@ -37,7 +37,7 @@ inline long get_reg(struct task_struct *
 	if (regno == PT_USP)
 		return task->thread.usp;
 	else if (regno < PT_MAX)
-		return ((unsigned long *)user_regs(task->thread_info))[regno];
+		return ((unsigned long *)user_regs(task_thread_info(task)))[regno];
 	else
 		return 0;
 }
@@ -51,7 +51,7 @@ inline int put_reg(struct task_struct *t
 	if (regno == PT_USP)
 		task->thread.usp = data;
 	else if (regno < PT_MAX)
-		((unsigned long *)user_regs(task->thread_info))[regno] = data;
+		((unsigned long *)user_regs(task_thread_info(task)))[regno] = data;
 	else
 		return -1;
 	return 0;
Index: linux-2.6-mm/arch/frv/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/frv/kernel/process.c	2005-09-01 21:04:56.398229079 +0200
+++ linux-2.6-mm/arch/frv/kernel/process.c	2005-09-01 21:05:02.598163953 +0200
@@ -216,7 +216,7 @@ int copy_thread(int nr, unsigned long cl
 		*childregs = *regs;
 		childregs->sp = (unsigned long) childregs0;
 		childregs->next_frame = childregs0;
-		childregs->gr15 = (unsigned long) p->thread_info;
+		childregs->gr15 = (unsigned long) task_thread_info(p);
 		childregs->gr29 = (unsigned long) p;
 	}
 
Index: linux-2.6-mm/arch/i386/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/process.c	2005-09-01 21:04:56.524207436 +0200
+++ linux-2.6-mm/arch/i386/kernel/process.c	2005-09-01 21:05:02.598163953 +0200
@@ -619,8 +619,8 @@ static inline void disable_tsc(struct ta
 	 * gcc should eliminate the ->thread_info dereference if
 	 * has_secure_computing returns 0 at compile time (SECCOMP=n).
 	 */
-	prev = prev_p->thread_info;
-	next = next_p->thread_info;
+	prev = task_thread_info(prev_p);
+	next = task_thread_info(next_p);
 
 	if (has_secure_computing(prev) || has_secure_computing(next)) {
 		/* slow path here */
Index: linux-2.6-mm/arch/i386/kernel/vm86.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/vm86.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/i386/kernel/vm86.c	2005-09-01 21:05:02.624159487 +0200
@@ -313,7 +313,7 @@ static void do_sys_vm86(struct kernel_vm
 		"movl %1,%%ebp\n\t"
 		"jmp resume_userspace"
 		: /* no outputs */
-		:"r" (&info->regs), "r" (tsk->thread_info) : "ax");
+		:"r" (&info->regs), "r" (task_thread_info(tsk)) : "ax");
 	/* we never return here */
 }
 
Index: linux-2.6-mm/arch/ia64/kernel/signal.c
===================================================================
--- linux-2.6-mm.orig/arch/ia64/kernel/signal.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/ia64/kernel/signal.c	2005-09-01 21:05:02.677150384 +0200
@@ -656,11 +656,11 @@ set_sigdelayed(pid_t pid, int signo, int
 
 		if (!t)
 			return;
-		t->thread_info->sigdelayed.signo = signo;
-		t->thread_info->sigdelayed.code = code;
-		t->thread_info->sigdelayed.addr = addr;
-		t->thread_info->sigdelayed.start_time = start_time;
-		t->thread_info->sigdelayed.pid = pid;
+		task_thread_info(t)->sigdelayed.signo = signo;
+		task_thread_info(t)->sigdelayed.code = code;
+		task_thread_info(t)->sigdelayed.addr = addr;
+		task_thread_info(t)->sigdelayed.start_time = start_time;
+		task_thread_info(t)->sigdelayed.pid = pid;
 		wmb();
 		set_tsk_thread_flag(t, TIF_SIGDELAYED);
 	}
Index: linux-2.6-mm/arch/m32r/kernel/smpboot.c
===================================================================
--- linux-2.6-mm.orig/arch/m32r/kernel/smpboot.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/m32r/kernel/smpboot.c	2005-09-01 21:05:02.712144372 +0200
@@ -286,7 +286,7 @@ static void __init do_boot_cpu(int phys_
 	/* So we see what's up   */
 	printk("Booting processor %d/%d\n", phys_id, cpu_id);
 	stack_start.spi = (void *)idle->thread.sp;
-	idle->thread_info->cpu = cpu_id;
+	task_thread_info(idle)->cpu = cpu_id;
 
 	/*
 	 * Send Startup IPI
Index: linux-2.6-mm/arch/mips/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/kernel/process.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/mips/kernel/process.c	2005-09-01 21:05:02.741139391 +0200
@@ -94,7 +94,7 @@ void flush_thread(void)
 int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
 	unsigned long unused, struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *ti = p->thread_info;
+	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
 	long childksp;
 
Index: linux-2.6-mm/arch/mips/sibyte/cfe/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/sibyte/cfe/smp.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/mips/sibyte/cfe/smp.c	2005-09-01 21:05:02.792130631 +0200
@@ -60,7 +60,7 @@ void prom_boot_secondary(int cpu, struct
 
 	retval = cfe_cpu_start(cpu_logical_map(cpu), &smp_bootstrap,
 			       __KSTK_TOS(idle),
-			       (unsigned long)idle->thread_info, 0);
+			       (unsigned long)task_thread_info(idle), 0);
 	if (retval != 0)
 		printk("cfe_start_cpu(%i) returned %i\n" , cpu, retval);
 }
Index: linux-2.6-mm/arch/parisc/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/parisc/kernel/process.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/parisc/kernel/process.c	2005-09-01 21:05:02.827124619 +0200
@@ -271,7 +271,7 @@ copy_thread(int nr, unsigned long clone_
 	    struct task_struct * p, struct pt_regs * pregs)
 {
 	struct pt_regs * cregs = &(p->thread.regs);
-	struct thread_info *ti = p->thread_info;
+	struct thread_info *ti = task_thread_info(p);
 	
 	/* We have to use void * instead of a function pointer, because
 	 * function pointers aren't a pointer to the function on 64-bit.
Index: linux-2.6-mm/arch/parisc/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/parisc/kernel/smp.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/parisc/kernel/smp.c	2005-09-01 21:05:02.846121356 +0200
@@ -506,7 +506,7 @@ int __init smp_boot_one_cpu(int cpuid)
 	if (IS_ERR(idle))
 		panic("SMP: fork failed for CPU:%d", cpuid);
 
-	idle->thread_info->cpu = cpuid;
+	task_thread_info(idle)->cpu = cpuid;
 
 	/* Let _start know what logical CPU we're booting
 	** (offset into init_tasks[],cpu_data[])
Index: linux-2.6-mm/arch/ppc/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc/kernel/process.c	2005-09-01 21:04:56.868148347 +0200
+++ linux-2.6-mm/arch/ppc/kernel/process.c	2005-09-01 21:05:02.846121356 +0200
@@ -325,7 +325,7 @@ void show_regs(struct pt_regs * regs)
 	if (trap == 0x300 || trap == 0x600)
 		printk("DAR: %08lX, DSISR: %08lX\n", regs->dar, regs->dsisr);
 	printk("TASK = %p[%d] '%s' THREAD: %p\n",
-	       current, current->pid, current->comm, current->thread_info);
+	       current, current->pid, current->comm, task_thread_info(current));
 	printk("Last syscall: %ld ", current->thread.last_syscall);
 
 #ifdef CONFIG_SMP
Index: linux-2.6-mm/arch/ppc/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc/kernel/smp.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/ppc/kernel/smp.c	2005-09-01 21:05:02.858119295 +0200
@@ -356,8 +356,8 @@ int __cpu_up(unsigned int cpu)
 	p = fork_idle(cpu);
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
-	secondary_ti = p->thread_info;
-	p->thread_info->cpu = cpu;
+	secondary_ti = task_thread_info(p);
+	task_thread_info(p)->cpu = cpu;
 
 	/*
 	 * There was a cache flush loop here to flush the cache
Index: linux-2.6-mm/arch/ppc64/kernel/pSeries_smp.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc64/kernel/pSeries_smp.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/ppc64/kernel/pSeries_smp.c	2005-09-01 21:05:02.871117062 +0200
@@ -280,7 +280,7 @@ static inline int __devinit smp_startup_
 	pcpu = get_hard_smp_processor_id(lcpu);
 
 	/* Fixup atomic count: it exited inside IRQ handler. */
-	paca[lcpu].__current->thread_info->preempt_count	= 0;
+	task_thread_info(paca[lcpu].__current)->preempt_count	= 0;
 
 	status = rtas_call(rtas_token("start-cpu"), 3, 1, NULL,
 			   pcpu, start_here, lcpu);
Index: linux-2.6-mm/arch/ppc64/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc64/kernel/process.c	2005-09-01 21:04:56.905141992 +0200
+++ linux-2.6-mm/arch/ppc64/kernel/process.c	2005-09-01 21:05:02.871117062 +0200
@@ -278,7 +278,7 @@ void show_regs(struct pt_regs * regs)
 	trap = TRAP(regs);
 	printk("DAR: %016lx DSISR: %016lx\n", regs->dar, regs->dsisr);
 	printk("TASK: %p[%d] '%s' THREAD: %p",
-	       current, current->pid, current->comm, current->thread_info);
+	       current, current->pid, current->comm, task_thread_info(current));
 
 #ifdef CONFIG_SMP
 	printk(" CPU: %d", smp_processor_id());
@@ -375,7 +375,7 @@ copy_thread(int nr, unsigned long clone_
 		/* for kernel thread, set stackptr in new task */
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
 		p->thread.regs = NULL;	/* no user register state */
-		clear_ti_thread_flag(p->thread_info, TIF_32BIT);
+		clear_ti_thread_flag(task_thread_info(p), TIF_32BIT);
 	} else {
 		childregs->gpr[1] = usp;
 		p->thread.regs = childregs;
Index: linux-2.6-mm/arch/ppc64/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc64/kernel/smp.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/ppc64/kernel/smp.c	2005-09-01 21:05:02.878115859 +0200
@@ -352,7 +352,7 @@ static void __init smp_create_idle(unsig
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
 	paca[cpu].__current = p;
-	current_set[cpu] = p->thread_info;
+	current_set[cpu] = task_thread_info(p);
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
@@ -399,7 +399,7 @@ void __devinit smp_prepare_boot_cpu(void
 	cpu_set(boot_cpuid, cpu_online_map);
 
 	paca[boot_cpuid].__current = current;
-	current_set[boot_cpuid] = current->thread_info;
+	current_set[boot_cpuid] = task_thread_info(current);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
Index: linux-2.6-mm/arch/s390/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/s390/kernel/process.c	2005-09-01 21:04:56.977129624 +0200
+++ linux-2.6-mm/arch/s390/kernel/process.c	2005-09-01 21:05:02.878115859 +0200
@@ -147,7 +147,7 @@ void show_regs(struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
 
-        printk("CPU:    %d    %s\n", tsk->thread_info->cpu, print_tainted());
+        printk("CPU:    %d    %s\n", task_thread_info(tsk)->cpu, print_tainted());
         printk("Process %s (pid: %d, task: %p, ksp: %p)\n",
 	       current->comm, current->pid, (void *) tsk,
 	       (void *) tsk->thread.ksp);
@@ -373,7 +373,7 @@ unsigned long get_wchan(struct task_stru
 	unsigned long return_address;
 	int count;
 
-	if (!p || p == current || p->state == TASK_RUNNING || !p->thread_info)
+	if (!p || p == current || p->state == TASK_RUNNING || !task_thread_info(p))
 		return 0;
 	low = (struct stack_frame *)p->stack;
 	high = (struct stack_frame *)
Index: linux-2.6-mm/arch/sh/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/sh/kernel/process.c	2005-09-01 21:04:57.041118631 +0200
+++ linux-2.6-mm/arch/sh/kernel/process.c	2005-09-01 21:05:02.893113283 +0200
@@ -396,7 +396,7 @@ struct task_struct *__switch_to(struct t
 	 */
 	asm volatile("ldc	%0, r7_bank"
 		     : /* no output */
-		     : "r" (next->thread_info));
+		     : "r" (task_thread_info(next)));
 
 #ifdef CONFIG_MMU
 	/* If no tasks are using the UBC, we're done */
Index: linux-2.6-mm/arch/sh/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/sh/kernel/smp.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/sh/kernel/smp.c	2005-09-01 21:05:02.908110706 +0200
@@ -100,7 +100,7 @@ int __cpu_up(unsigned int cpu)
 	if (IS_ERR(tsk))
 		panic("Failed forking idle task for cpu %d\n", cpu);
 	
-	tsk->thread_info->cpu = cpu;
+	task_thread_info(tsk)->cpu = cpu;
 
 	cpu_set(cpu, cpu_online_map);
 
Index: linux-2.6-mm/arch/sparc/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/kernel/process.c	2005-09-01 21:04:57.151099737 +0200
+++ linux-2.6-mm/arch/sparc/kernel/process.c	2005-09-01 21:05:02.924107958 +0200
@@ -338,7 +338,7 @@ EXPORT_SYMBOL(dump_stack);
  */
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	return tsk->thread_info->kpc;
+	return task_thread_info(tsk)->kpc;
 }
 
 /*
@@ -460,7 +460,7 @@ int copy_thread(int nr, unsigned long cl
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *ti = p->thread_info;
+	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
 	char *new_stack;
 
@@ -725,7 +725,7 @@ unsigned long get_wchan(struct task_stru
             task->state == TASK_RUNNING)
 		goto out;
 
-	fp = task->thread_info->ksp + bias;
+	fp = task_thread_info(task)->ksp + bias;
 	do {
 		/* Bogus frame pointer? */
 		if (fp < (task_base + sizeof(struct thread_info)) ||
Index: linux-2.6-mm/arch/sparc/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/kernel/ptrace.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/sparc/kernel/ptrace.c	2005-09-01 21:05:02.934106241 +0200
@@ -75,7 +75,7 @@ static inline void read_sunos_user(struc
 				   struct task_struct *tsk, long __user *addr)
 {
 	struct pt_regs *cregs = tsk->thread.kregs;
-	struct thread_info *t = tsk->thread_info;
+	struct thread_info *t = task_thread_info(tsk);
 	int v;
 	
 	if(offset >= 1024)
@@ -170,7 +170,7 @@ static inline void write_sunos_user(stru
 				    struct task_struct *tsk)
 {
 	struct pt_regs *cregs = tsk->thread.kregs;
-	struct thread_info *t = tsk->thread_info;
+	struct thread_info *t = task_thread_info(tsk);
 	unsigned long value = regs->u_regs[UREG_I3];
 
 	if(offset >= 1024)
Index: linux-2.6-mm/arch/sparc/kernel/sun4d_smp.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/kernel/sun4d_smp.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/sparc/kernel/sun4d_smp.c	2005-09-01 21:05:02.939105382 +0200
@@ -200,7 +200,7 @@ void __init smp4d_boot_cpus(void)
 			/* Cook up an idler for this guy. */
 			p = fork_idle(i);
 			cpucount++;
-			current_set[i] = p->thread_info;
+			current_set[i] = task_thread_info(p);
 			for (no = 0; !cpu_find_by_instance(no, NULL, &mid)
 				     && mid != i; no++) ;
 
Index: linux-2.6-mm/arch/sparc/kernel/sun4m_smp.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/kernel/sun4m_smp.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/sparc/kernel/sun4m_smp.c	2005-09-01 21:05:02.940105210 +0200
@@ -173,7 +173,7 @@ void __init smp4m_boot_cpus(void)
 			/* Cook up an idler for this guy. */
 			p = fork_idle(i);
 			cpucount++;
-			current_set[i] = p->thread_info;
+			current_set[i] = task_thread_info(p);
 			/* See trampoline.S for details... */
 			entry += ((i-1) * 3);
 
Index: linux-2.6-mm/arch/sparc/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/kernel/traps.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/sparc/kernel/traps.c	2005-09-01 21:05:02.954102805 +0200
@@ -291,7 +291,7 @@ void do_fpe_trap(struct pt_regs *regs, u
 #ifndef CONFIG_SMP
 	if(!fpt) {
 #else
-        if(!(fpt->thread_info->flags & _TIF_USEDFPU)) {
+        if(!(task_thread_info(fpt)->flags & _TIF_USEDFPU)) {
 #endif
 		fpsave(&fake_regs[0], &fake_fsr, &fake_queue[0], &fake_depth);
 		regs->psr &= ~PSR_EF;
@@ -334,7 +334,7 @@ void do_fpe_trap(struct pt_regs *regs, u
 	/* nope, better SIGFPE the offending process... */
 	       
 #ifdef CONFIG_SMP
-	fpt->thread_info->flags &= ~_TIF_USEDFPU;
+	task_thread_info(fpt)->flags &= ~_TIF_USEDFPU;
 #endif
 	if(psr & PSR_PS) {
 		/* The first fsr store/load we tried trapped,
Index: linux-2.6-mm/arch/sparc64/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc64/kernel/process.c	2005-09-01 21:04:57.208089946 +0200
+++ linux-2.6-mm/arch/sparc64/kernel/process.c	2005-09-01 21:05:02.964101088 +0200
@@ -378,7 +378,7 @@ void show_regs32(struct pt_regs32 *regs)
 
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	struct thread_info *ti = tsk->thread_info;
+	struct thread_info *ti = task_thread_info(tsk);
 	unsigned long ret = 0xdeadbeefUL;
 	
 	if (ti && ti->ksp) {
@@ -604,7 +604,7 @@ int copy_thread(int nr, unsigned long cl
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *t = p->thread_info;
+	struct thread_info *t = task_thread_info(p);
 	char *child_trap_frame;
 
 	/* Calculate offset to stack_frame & pt_regs */
@@ -835,7 +835,7 @@ unsigned long get_wchan(struct task_stru
 
 	thread_info_base = (unsigned long)task->stack;
 	bias = STACK_BIAS;
-	fp = task->thread_info->ksp + bias;
+	fp = task_thread_info(task)->ksp + bias;
 
 	do {
 		/* Bogus frame pointer? */
Index: linux-2.6-mm/arch/sparc64/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc64/kernel/ptrace.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/sparc64/kernel/ptrace.c	2005-09-01 21:05:02.981098168 +0200
@@ -311,7 +311,7 @@ asmlinkage void do_ptrace(struct pt_regs
 	case PTRACE_GETREGS: {
 		struct pt_regs32 __user *pregs =
 			(struct pt_regs32 __user *) addr;
-		struct pt_regs *cregs = child->thread_info->kregs;
+		struct pt_regs *cregs = task_thread_info(child)->kregs;
 		int rval;
 
 		if (__put_user(tstate_to_psr(cregs->tstate), (&pregs->psr)) ||
@@ -335,11 +335,11 @@ asmlinkage void do_ptrace(struct pt_regs
 
 	case PTRACE_GETREGS64: {
 		struct pt_regs __user *pregs = (struct pt_regs __user *) addr;
-		struct pt_regs *cregs = child->thread_info->kregs;
+		struct pt_regs *cregs = task_thread_info(child)->kregs;
 		unsigned long tpc = cregs->tpc;
 		int rval;
 
-		if ((child->thread_info->flags & _TIF_32BIT) != 0)
+		if ((task_thread_info(child)->flags & _TIF_32BIT) != 0)
 			tpc &= 0xffffffff;
 		if (__put_user(cregs->tstate, (&pregs->tstate)) ||
 		    __put_user(tpc, (&pregs->tpc)) ||
@@ -363,7 +363,7 @@ asmlinkage void do_ptrace(struct pt_regs
 	case PTRACE_SETREGS: {
 		struct pt_regs32 __user *pregs =
 			(struct pt_regs32 __user *) addr;
-		struct pt_regs *cregs = child->thread_info->kregs;
+		struct pt_regs *cregs = task_thread_info(child)->kregs;
 		unsigned int psr, pc, npc, y;
 		int i;
 
@@ -396,7 +396,7 @@ asmlinkage void do_ptrace(struct pt_regs
 
 	case PTRACE_SETREGS64: {
 		struct pt_regs __user *pregs = (struct pt_regs __user *) addr;
-		struct pt_regs *cregs = child->thread_info->kregs;
+		struct pt_regs *cregs = task_thread_info(child)->kregs;
 		unsigned long tstate, tpc, tnpc, y;
 		int i;
 
@@ -410,7 +410,7 @@ asmlinkage void do_ptrace(struct pt_regs
 			pt_error_return(regs, EFAULT);
 			goto out_tsk;
 		}
-		if ((child->thread_info->flags & _TIF_32BIT) != 0) {
+		if ((task_thread_info(child)->flags & _TIF_32BIT) != 0) {
 			tpc &= 0xffffffff;
 			tnpc &= 0xffffffff;
 		}
@@ -445,11 +445,11 @@ asmlinkage void do_ptrace(struct pt_regs
 			} fpq[16];
 		};
 		struct fps __user *fps = (struct fps __user *) addr;
-		unsigned long *fpregs = child->thread_info->fpregs;
+		unsigned long *fpregs = task_thread_info(child)->fpregs;
 
 		if (copy_to_user(&fps->regs[0], fpregs,
 				 (32 * sizeof(unsigned int))) ||
-		    __put_user(child->thread_info->xfsr[0], (&fps->fsr)) ||
+		    __put_user(task_thread_info(child)->xfsr[0], (&fps->fsr)) ||
 		    __put_user(0, (&fps->fpqd)) ||
 		    __put_user(0, (&fps->flags)) ||
 		    __put_user(0, (&fps->extra)) ||
@@ -467,11 +467,11 @@ asmlinkage void do_ptrace(struct pt_regs
 			unsigned long fsr;
 		};
 		struct fps __user *fps = (struct fps __user *) addr;
-		unsigned long *fpregs = child->thread_info->fpregs;
+		unsigned long *fpregs = task_thread_info(child)->fpregs;
 
 		if (copy_to_user(&fps->regs[0], fpregs,
 				 (64 * sizeof(unsigned int))) ||
-		    __put_user(child->thread_info->xfsr[0], (&fps->fsr))) {
+		    __put_user(task_thread_info(child)->xfsr[0], (&fps->fsr))) {
 			pt_error_return(regs, EFAULT);
 			goto out_tsk;
 		}
@@ -492,7 +492,7 @@ asmlinkage void do_ptrace(struct pt_regs
 			} fpq[16];
 		};
 		struct fps __user *fps = (struct fps __user *) addr;
-		unsigned long *fpregs = child->thread_info->fpregs;
+		unsigned long *fpregs = task_thread_info(child)->fpregs;
 		unsigned fsr;
 
 		if (copy_from_user(fpregs, &fps->regs[0],
@@ -501,11 +501,11 @@ asmlinkage void do_ptrace(struct pt_regs
 			pt_error_return(regs, EFAULT);
 			goto out_tsk;
 		}
-		child->thread_info->xfsr[0] &= 0xffffffff00000000UL;
-		child->thread_info->xfsr[0] |= fsr;
-		if (!(child->thread_info->fpsaved[0] & FPRS_FEF))
-			child->thread_info->gsr[0] = 0;
-		child->thread_info->fpsaved[0] |= (FPRS_FEF | FPRS_DL);
+		task_thread_info(child)->xfsr[0] &= 0xffffffff00000000UL;
+		task_thread_info(child)->xfsr[0] |= fsr;
+		if (!(task_thread_info(child)->fpsaved[0] & FPRS_FEF))
+			task_thread_info(child)->gsr[0] = 0;
+		task_thread_info(child)->fpsaved[0] |= (FPRS_FEF | FPRS_DL);
 		pt_succ_return(regs, 0);
 		goto out_tsk;
 	}
@@ -516,17 +516,17 @@ asmlinkage void do_ptrace(struct pt_regs
 			unsigned long fsr;
 		};
 		struct fps __user *fps = (struct fps __user *) addr;
-		unsigned long *fpregs = child->thread_info->fpregs;
+		unsigned long *fpregs = task_thread_info(child)->fpregs;
 
 		if (copy_from_user(fpregs, &fps->regs[0],
 				   (64 * sizeof(unsigned int))) ||
-		    __get_user(child->thread_info->xfsr[0], (&fps->fsr))) {
+		    __get_user(task_thread_info(child)->xfsr[0], (&fps->fsr))) {
 			pt_error_return(regs, EFAULT);
 			goto out_tsk;
 		}
-		if (!(child->thread_info->fpsaved[0] & FPRS_FEF))
-			child->thread_info->gsr[0] = 0;
-		child->thread_info->fpsaved[0] |= (FPRS_FEF | FPRS_DL | FPRS_DU);
+		if (!(task_thread_info(child)->fpsaved[0] & FPRS_FEF))
+			task_thread_info(child)->gsr[0] = 0;
+		task_thread_info(child)->fpsaved[0] |= (FPRS_FEF | FPRS_DL | FPRS_DU);
 		pt_succ_return(regs, 0);
 		goto out_tsk;
 	}
@@ -577,8 +577,8 @@ asmlinkage void do_ptrace(struct pt_regs
 #ifdef DEBUG_PTRACE
 		printk("CONT: %s [%d]: set exit_code = %x %lx %lx\n", child->comm,
 			child->pid, child->exit_code,
-			child->thread_info->kregs->tpc,
-			child->thread_info->kregs->tnpc);
+			task_thread_info(child)->kregs->tpc,
+			task_thread_info(child)->kregs->tnpc);
 		       
 #endif
 		wake_up_process(child);
Index: linux-2.6-mm/arch/sparc64/kernel/setup.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc64/kernel/setup.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/sparc64/kernel/setup.c	2005-09-01 21:05:02.994095935 +0200
@@ -573,7 +573,7 @@ void __init setup_arch(char **cmdline_p)
 	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);	
 #endif
 
-	init_task.thread_info->kregs = &fake_swapper_regs;
+	task_thread_info(&init_task)->kregs = &fake_swapper_regs;
 
 #ifdef CONFIG_IP_PNP
 	if (!ic_set_manually) {
Index: linux-2.6-mm/arch/sparc64/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc64/kernel/smp.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/sparc64/kernel/smp.c	2005-09-01 21:05:03.003094389 +0200
@@ -312,7 +312,7 @@ static int __devinit smp_boot_one_cpu(un
 
 	p = fork_idle(cpu);
 	callin_flag = 0;
-	cpu_new_thread = p->thread_info;
+	cpu_new_thread = task_thread_info(p);
 	cpu_set(cpu, cpu_callout_map);
 
 	cpu_find_by_mid(cpu, &cpu_node);
Index: linux-2.6-mm/arch/sparc64/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc64/kernel/traps.c	2005-09-01 21:04:57.240084449 +0200
+++ linux-2.6-mm/arch/sparc64/kernel/traps.c	2005-09-01 21:05:03.004094217 +0200
@@ -1814,7 +1814,7 @@ static void user_instruction_dump (unsig
 void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 {
 	unsigned long pc, fp, thread_base, ksp;
-	struct thread_info *tp = tsk->thread_info;
+	struct thread_info *tp = task_thread_info(tsk);
 	struct reg_window *rw;
 	int count = 0;
 
Index: linux-2.6-mm/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6-mm.orig/arch/um/kernel/process_kern.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/um/kernel/process_kern.c	2005-09-01 21:05:03.049086488 +0200
@@ -107,7 +107,7 @@ void set_current(void *t)
 {
 	struct task_struct *task = t;
 
-	cpu_tasks[task->thread_info->cpu] = ((struct cpu_task) 
+	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task)
 		{ external_pid(task), task });
 }
 
Index: linux-2.6-mm/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6-mm.orig/arch/um/kernel/skas/process_kern.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/um/kernel/skas/process_kern.c	2005-09-01 21:05:03.098078071 +0200
@@ -124,7 +124,7 @@ int copy_thread_skas(int nr, unsigned lo
 		handler = new_thread_handler;
 	}
 
-	new_thread(p->thread_info, &p->thread.mode.skas.switch_buf,
+	new_thread(task_thread_info(p), &p->thread.mode.skas.switch_buf,
 		   &p->thread.mode.skas.fork_buf, handler);
 	return(0);
 }
@@ -186,7 +186,7 @@ int start_uml_skas(void)
 
 	init_task.thread.request.u.thread.proc = start_kernel_proc;
 	init_task.thread.request.u.thread.arg = NULL;
-	return(start_idle_thread(init_task.thread_info,
+	return(start_idle_thread(task_thread_info(&init_task),
 				 &init_task.thread.mode.skas.switch_buf,
 				 &init_task.thread.mode.skas.fork_buf));
 }
Index: linux-2.6-mm/arch/um/kernel/tt/exec_kern.c
===================================================================
--- linux-2.6-mm.orig/arch/um/kernel/tt/exec_kern.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/um/kernel/tt/exec_kern.c	2005-09-01 21:05:03.135071716 +0200
@@ -40,7 +40,7 @@ void flush_thread_tt(void)
 		do_exit(SIGKILL);
 	}
 		
-	new_pid = start_fork_tramp(current->thread_info, stack, 0, exec_tramp);
+	new_pid = start_fork_tramp(task_thread_info(current), stack, 0, exec_tramp);
 	if(new_pid < 0){
 		printk(KERN_ERR 
 		       "flush_thread : new thread failed, errno = %d\n",
Index: linux-2.6-mm/arch/um/kernel/tt/process_kern.c
===================================================================
--- linux-2.6-mm.orig/arch/um/kernel/tt/process_kern.c	2005-09-01 21:04:57.309072597 +0200
+++ linux-2.6-mm/arch/um/kernel/tt/process_kern.c	2005-09-01 21:05:03.144070170 +0200
@@ -38,7 +38,7 @@ void *switch_to_tt(void *prev, void *nex
 
 	to->thread.prev_sched = from;
 
-	cpu = from->thread_info->cpu;
+	cpu = task_thread_info(from)->cpu;
 	if(cpu == 0)
 		forward_interrupts(to->thread.mode.tt.extern_pid);
 #ifdef CONFIG_SMP
@@ -258,7 +258,7 @@ int copy_thread_tt(int nr, unsigned long
 
 	clone_flags &= CLONE_VM;
 	p->thread.temp_stack = stack;
-	new_pid = start_fork_tramp(p->thread_info, stack, clone_flags, tramp);
+	new_pid = start_fork_tramp(task_thread_info(p), stack, clone_flags, tramp);
 	if(new_pid < 0){
 		printk(KERN_ERR "copy_thread : clone failed - errno = %d\n", 
 		       -new_pid);
@@ -348,7 +348,7 @@ int do_proc_op(void *t, int proc_id)
 		pid = thread->request.u.exec.pid;
 		do_exec(thread->mode.tt.extern_pid, pid);
 		thread->mode.tt.extern_pid = pid;
-		cpu_tasks[task->thread_info->cpu].pid = pid;
+		cpu_tasks[task_thread_info(task)->cpu].pid = pid;
 		break;
 	case OP_FORK:
 		attach_process(thread->request.u.fork.pid);
Index: linux-2.6-mm/arch/x86_64/kernel/i387.c
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/kernel/i387.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/i387.c	2005-09-01 21:05:03.168066048 +0200
@@ -95,7 +95,7 @@ int save_i387(struct _fpstate __user *bu
 	if (!used_math())
 		return 0;
 	clear_used_math(); /* trigger finit */
-	if (tsk->thread_info->status & TS_USEDFPU) {
+	if (task_thread_info(tsk)->status & TS_USEDFPU) {
 		err = save_i387_checking((struct i387_fxsave_struct __user *)buf);
 		if (err) return err;
 		stts();
Index: linux-2.6-mm/arch/x86_64/kernel/i8259.c
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/kernel/i8259.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/i8259.c	2005-09-01 21:05:03.175064846 +0200
@@ -137,7 +137,7 @@ static void end_8259A_irq (unsigned int 
 {
 	if (irq > 256) { 
 		char var;
-		printk("return %p stack %p ti %p\n", __builtin_return_address(0), &var, current->thread_info); 
+		printk("return %p stack %p ti %p\n", __builtin_return_address(0), &var, task_thread_info(current));
 
 		BUG(); 
 	}
Index: linux-2.6-mm/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/kernel/process.c	2005-09-01 21:04:57.427052328 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/process.c	2005-09-01 21:05:03.176064674 +0200
@@ -443,7 +443,7 @@ int copy_thread(int nr, unsigned long cl
 	p->thread.rsp0 = (unsigned long) (childregs+1);
 	p->thread.userrsp = me->thread.userrsp; 
 
-	set_ti_thread_flag(p->thread_info, TIF_FORK);
+	set_ti_thread_flag(task_thread_info(p), TIF_FORK);
 
 	p->thread.fs = me->thread.fs;
 	p->thread.gs = me->thread.gs;
@@ -499,8 +499,8 @@ static inline void disable_tsc(struct ta
 	 * gcc should eliminate the ->thread_info dereference if
 	 * has_secure_computing returns 0 at compile time (SECCOMP=n).
 	 */
-	prev = prev_p->thread_info;
-	next = next_p->thread_info;
+	prev = task_thread_info(prev_p);
+	next = task_thread_info(next_p);
 
 	if (has_secure_computing(prev) || has_secure_computing(next)) {
 		/* slow path here */
Index: linux-2.6-mm/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/kernel/smpboot.c	2005-09-01 21:04:57.442049752 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/smpboot.c	2005-09-01 21:05:03.176064674 +0200
@@ -757,7 +757,7 @@ do_rest:
 	init_rsp = c_idle.idle->thread.rsp;
 	per_cpu(init_tss,cpu).rsp0 = init_rsp;
 	initial_code = start_secondary;
-	clear_ti_thread_flag(c_idle.idle->thread_info, TIF_FORK);
+	clear_ti_thread_flag(task_thread_info(c_idle.idle), TIF_FORK);
 
 	printk(KERN_INFO "Booting processor %d/%d APIC 0x%x\n", cpu,
 		cpus_weight(cpu_present_map),
Index: linux-2.6-mm/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/kernel/traps.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/traps.c	2005-09-01 21:05:03.180063987 +0200
@@ -290,7 +290,7 @@ void show_registers(struct pt_regs *regs
 	printk("CPU %d ", cpu);
 	__show_regs(regs);
 	printk("Process %s (pid: %d, threadinfo %p, task %p)\n",
-		cur->comm, cur->pid, cur->thread_info, cur);
+		cur->comm, cur->pid, task_thread_info(cur), cur);
 
 	/*
 	 * When in-kernel, we also print out the stack and code at the
@@ -903,7 +903,7 @@ asmlinkage void math_state_restore(void)
 	if (!used_math())
 		init_fpu(me);
 	restore_fpu_checking(&me->thread.i387.fxsave);
-	me->thread_info->status |= TS_USEDFPU;
+	task_thread_info(me)->status |= TS_USEDFPU;
 }
 
 void do_call_debug(struct pt_regs *regs) 
Index: linux-2.6-mm/include/asm-alpha/mmu_context.h
===================================================================
--- linux-2.6-mm.orig/include/asm-alpha/mmu_context.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-alpha/mmu_context.h	2005-09-01 21:05:03.189062441 +0200
@@ -156,7 +156,7 @@ ev5_switch_mm(struct mm_struct *prev_mm,
 	/* Always update the PCB ASN.  Another thread may have allocated
 	   a new mm->context (via flush_tlb_mm) without the ASN serial
 	   number wrapping.  We have no way to detect when this is needed.  */
-	next->thread_info->pcb.asn = mmc & HARDWARE_ASN_MASK;
+	task_thread_info(next)->pcb.asn = mmc & HARDWARE_ASN_MASK;
 }
 
 __EXTERN_INLINE void
@@ -235,7 +235,7 @@ init_new_context(struct task_struct *tsk
 		if (cpu_online(i))
 			mm->context[i] = 0;
 	if (tsk != current)
-		tsk->thread_info->pcb.ptbr
+		task_thread_info(tsk)->pcb.ptbr
 		  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
 	return 0;
 }
@@ -249,7 +249,7 @@ destroy_context(struct mm_struct *mm)
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
-	tsk->thread_info->pcb.ptbr
+	task_thread_info(tsk)->pcb.ptbr
 	  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
 }
 
Index: linux-2.6-mm/include/asm-alpha/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-alpha/processor.h	2005-09-01 21:04:57.446049065 +0200
+++ linux-2.6-mm/include/asm-alpha/processor.h	2005-09-01 21:05:03.190062269 +0200
@@ -64,7 +64,7 @@ unsigned long get_wchan(struct task_stru
   (*(unsigned long *)(PT_REG(pc) + (unsigned long)((tsk)->stack)))
 
 #define KSTK_ESP(tsk) \
-  ((tsk) == current ? rdusp() : (tsk)->thread_info->pcb.usp)
+  ((tsk) == current ? rdusp() : task_thread_info(tsk)->pcb.usp)
 
 #define cpu_relax()	barrier()
 
Index: linux-2.6-mm/include/asm-alpha/system.h
===================================================================
--- linux-2.6-mm.orig/include/asm-alpha/system.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-alpha/system.h	2005-09-01 21:05:03.212058490 +0200
@@ -132,7 +132,7 @@ extern void halt(void) __attribute__((no
 
 #define switch_to(P,N,L)						\
   do {									\
-    (L) = alpha_switch_to(virt_to_phys(&(N)->thread_info->pcb), (P));	\
+    (L) = alpha_switch_to(virt_to_phys(&task_thread_info(N)->pcb), (P));\
     check_mmu_context();						\
   } while (0)
 
Index: linux-2.6-mm/include/asm-arm/system.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm/system.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-arm/system.h	2005-09-01 21:05:03.225056257 +0200
@@ -168,7 +168,7 @@ extern struct task_struct *__switch_to(s
 
 #define switch_to(prev,next,last)					\
 do {									\
-	last = __switch_to(prev,prev->thread_info,next->thread_info);	\
+	last = __switch_to(prev,task_thread_info(prev),task_thread_info(next));	\
 } while (0)
 
 /*
Index: linux-2.6-mm/include/asm-arm/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm/thread_info.h	2005-09-01 21:04:49.651388197 +0200
+++ linux-2.6-mm/include/asm-arm/thread_info.h	2005-09-01 21:05:03.225056257 +0200
@@ -99,9 +99,9 @@ extern void free_thread_stack(void *);
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 
 #define thread_saved_pc(tsk)	\
-	((unsigned long)(pc_pointer((tsk)->thread_info->cpu_context.pc)))
+	((unsigned long)(pc_pointer(task_thread_info(tsk)->cpu_context.pc)))
 #define thread_saved_fp(tsk)	\
-	((unsigned long)((tsk)->thread_info->cpu_context.fp))
+	((unsigned long)(task_thread_info(tsk)->cpu_context.fp))
 
 extern void iwmmxt_task_disable(struct thread_info *);
 extern void iwmmxt_task_copy(struct thread_info *, void *);
Index: linux-2.6-mm/include/asm-arm26/system.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm26/system.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-arm26/system.h	2005-09-01 21:05:03.251051792 +0200
@@ -111,7 +111,7 @@ extern struct task_struct *__switch_to(s
 
 #define switch_to(prev,next,last)					\
 do {									\
-	last = __switch_to(prev,prev->thread_info,next->thread_info);	\
+	last = __switch_to(prev,task_thread_info(prev),task_thread_info(next));	\
 } while (0)
 
 /*
Index: linux-2.6-mm/include/asm-arm26/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm26/thread_info.h	2005-09-01 21:04:49.684382528 +0200
+++ linux-2.6-mm/include/asm-arm26/thread_info.h	2005-09-01 21:05:03.258050589 +0200
@@ -91,9 +91,9 @@ extern void free_thread_stack(void *);
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 
 #define thread_saved_pc(tsk)	\
-	((unsigned long)(pc_pointer((tsk)->thread_info->cpu_context.pc)))
+	((unsigned long)(pc_pointer(task_thread_info(tsk)->cpu_context.pc)))
 #define thread_saved_fp(tsk)	\
-	((unsigned long)((tsk)->thread_info->cpu_context.fp))
+	((unsigned long)(task_thread_info(tsk)->cpu_context.fp))
 
 #else /* !__ASSEMBLY__ */
 
Index: linux-2.6-mm/include/asm-cris/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-cris/processor.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-cris/processor.h	2005-09-01 21:05:03.273048013 +0200
@@ -43,7 +43,7 @@
  * Dito but for the currently running task
  */
 
-#define current_regs() user_regs(current->thread_info)
+#define current_regs() user_regs(task_thread_info(current))
 
 extern inline void prepare_to_copy(struct task_struct *tsk)
 {
Index: linux-2.6-mm/include/asm-i386/i387.h
===================================================================
--- linux-2.6-mm.orig/include/asm-i386/i387.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-i386/i387.h	2005-09-01 21:05:03.320039940 +0200
@@ -49,19 +49,19 @@ static inline void __save_init_fpu( stru
 		X86_FEATURE_FXSR,
 		"m" (tsk->thread.i387.fxsave)
 		:"memory");
-	tsk->thread_info->status &= ~TS_USEDFPU;
+	task_thread_info(tsk)->status &= ~TS_USEDFPU;
 }
 
 #define __unlazy_fpu( tsk ) do { \
-	if ((tsk)->thread_info->status & TS_USEDFPU) \
+	if (task_thread_info(tsk)->status & TS_USEDFPU) \
 		save_init_fpu( tsk ); \
 } while (0)
 
 #define __clear_fpu( tsk )					\
 do {								\
-	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
+	if (task_thread_info(tsk)->status & TS_USEDFPU) {		\
 		asm volatile("fnclex ; fwait");				\
-		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
+		task_thread_info(tsk)->status &= ~TS_USEDFPU;	\
 		stts();						\
 	}							\
 } while (0)
Index: linux-2.6-mm/include/asm-mips/system.h
===================================================================
--- linux-2.6-mm.orig/include/asm-mips/system.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-mips/system.h	2005-09-01 21:05:03.354034100 +0200
@@ -156,7 +156,7 @@ struct task_struct;
 
 #define switch_to(prev,next,last) \
 do { \
-	(last) = resume(prev, next, next->thread_info); \
+	(last) = resume(prev, next, task_thread_info(next)); \
 } while(0)
 
 /*
Index: linux-2.6-mm/include/asm-ppc64/ptrace-common.h
===================================================================
--- linux-2.6-mm.orig/include/asm-ppc64/ptrace-common.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-ppc64/ptrace-common.h	2005-09-01 21:05:03.368031695 +0200
@@ -58,7 +58,7 @@ static inline void set_single_step(struc
 	struct pt_regs *regs = task->thread.regs;
 	if (regs != NULL)
 		regs->msr |= MSR_SE;
-	set_ti_thread_flag(task->thread_info, TIF_SINGLESTEP);
+	set_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP);
 }
 
 static inline void clear_single_step(struct task_struct *task)
@@ -66,7 +66,7 @@ static inline void clear_single_step(str
 	struct pt_regs *regs = task->thread.regs;
 	if (regs != NULL)
 		regs->msr &= ~MSR_SE;
-	clear_ti_thread_flag(task->thread_info, TIF_SINGLESTEP);
+	clear_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP);
 }
 
 #endif /* _PPC64_PTRACE_COMMON_H */
Index: linux-2.6-mm/include/asm-sparc/system.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sparc/system.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-sparc/system.h	2005-09-01 21:05:03.376030321 +0200
@@ -155,7 +155,7 @@ extern void fpsave(unsigned long *fpregs
 	"here:\n"									\
         : "=&r" (last)									\
         : "r" (&(current_set[hard_smp_processor_id()])),	\
-	  "r" ((next)->thread_info),				\
+	  "r" (task_thread_info(next)),				\
 	  "i" (TI_KPSR),					\
 	  "i" (TI_KSP),						\
 	  "i" (TI_TASK)						\
Index: linux-2.6-mm/include/asm-sparc64/elf.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sparc64/elf.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-sparc64/elf.h	2005-09-01 21:05:03.398026542 +0200
@@ -119,7 +119,7 @@ typedef struct {
 #endif
 
 #define ELF_CORE_COPY_TASK_REGS(__tsk, __elf_regs)	\
-	({ ELF_CORE_COPY_REGS((*(__elf_regs)), (__tsk)->thread_info->kregs); 1; })
+	({ ELF_CORE_COPY_REGS((*(__elf_regs)), task_thread_info(__tsk)->kregs); 1; })
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
Index: linux-2.6-mm/include/asm-sparc64/mmu_context.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sparc64/mmu_context.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-sparc64/mmu_context.h	2005-09-01 21:05:03.407024996 +0200
@@ -60,7 +60,7 @@ do { \
 	register unsigned long pgd_cache asm("o4"); \
 	paddr = __pa((__mm)->pgd); \
 	pgd_cache = 0UL; \
-	if ((__tsk)->thread_info->flags & _TIF_32BIT) \
+	if (task_thread_info(__tsk)->flags & _TIF_32BIT) \
 		pgd_cache = get_pgd_cache((__mm)->pgd); \
 	__asm__ __volatile__("wrpr	%%g0, 0x494, %%pstate\n\t" \
 			     "mov	%3, %%g4\n\t" \
Index: linux-2.6-mm/include/asm-sparc64/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sparc64/processor.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-sparc64/processor.h	2005-09-01 21:05:03.440019328 +0200
@@ -186,8 +186,8 @@ extern pid_t kernel_thread(int (*fn)(voi
 
 extern unsigned long get_wchan(struct task_struct *task);
 
-#define KSTK_EIP(tsk)  ((tsk)->thread_info->kregs->tpc)
-#define KSTK_ESP(tsk)  ((tsk)->thread_info->kregs->u_regs[UREG_FP])
+#define KSTK_EIP(tsk)  (task_thread_info(tsk)->kregs->tpc)
+#define KSTK_ESP(tsk)  (task_thread_info(tsk)->kregs->u_regs[UREG_FP])
 
 #define cpu_relax()	barrier()
 
Index: linux-2.6-mm/include/asm-sparc64/system.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sparc64/system.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-sparc64/system.h	2005-09-01 21:05:03.452017267 +0200
@@ -177,7 +177,7 @@ do {	if (test_thread_flag(TIF_PERFCTR)) 
 	/* If you are tempted to conditionalize the following */	\
 	/* so that ASI is only written if it changes, think again. */	\
 	__asm__ __volatile__("wr %%g0, %0, %%asi"			\
-	: : "r" (__thread_flag_byte_ptr(next->thread_info)[TI_FLAG_BYTE_CURRENT_DS]));\
+	: : "r" (__thread_flag_byte_ptr(task_thread_info(next))[TI_FLAG_BYTE_CURRENT_DS]));\
 	__asm__ __volatile__(						\
 	"mov	%%g4, %%g7\n\t"						\
 	"wrpr	%%g0, 0x95, %%pstate\n\t"				\
@@ -207,7 +207,7 @@ do {	if (test_thread_flag(TIF_PERFCTR)) 
 	"b,a ret_from_syscall\n\t"					\
 	"1:\n\t"							\
 	: "=&r" (last)							\
-	: "0" (next->thread_info),					\
+	: "0" (task_thread_info(next)),					\
 	  "i" (TI_WSTATE), "i" (TI_KSP), "i" (TI_NEW_CHILD),            \
 	  "i" (TI_CWP), "i" (TI_TASK)					\
 	: "cc",								\
Index: linux-2.6-mm/include/asm-x86_64/i387.h
===================================================================
--- linux-2.6-mm.orig/include/asm-x86_64/i387.h	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/include/asm-x86_64/i387.h	2005-09-01 21:05:03.463015378 +0200
@@ -30,7 +30,7 @@ extern int save_i387(struct _fpstate __u
  */
 
 #define unlazy_fpu(tsk) do { \
-	if ((tsk)->thread_info->status & TS_USEDFPU) \
+	if (task_thread_info(tsk)->status & TS_USEDFPU) \
 		save_init_fpu(tsk); \
 } while (0)
 
@@ -46,9 +46,9 @@ static inline void tolerant_fwait(void)
 }
 
 #define clear_fpu(tsk) do { \
-	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
+	if (task_thread_info(tsk)->status & TS_USEDFPU) {	\
 		tolerant_fwait();				\
-		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
+		task_thread_info(tsk)->status &= ~TS_USEDFPU;	\
 		stts();						\
 	}							\
 } while (0)
@@ -135,7 +135,7 @@ static inline void save_init_fpu( struct
 {
 	asm volatile( "rex64 ; fxsave %0 ; fnclex"
 		      : "=m" (tsk->thread.i387.fxsave));
-	tsk->thread_info->status &= ~TS_USEDFPU;
+	task_thread_info(tsk)->status &= ~TS_USEDFPU;
 	stts();
 }
 
Index: linux-2.6-mm/include/linux/sched.h
===================================================================
--- linux-2.6-mm.orig/include/linux/sched.h	2005-09-01 21:04:41.963708999 +0200
+++ linux-2.6-mm/include/linux/sched.h	2005-09-01 21:05:03.464015206 +0200
@@ -1317,7 +1317,7 @@ extern void recalc_sigpending(void);
 extern void signal_wake_up(struct task_struct *t, int resume_stopped);
 
 /*
- * Wrappers for p->thread_info->cpu access. No-op on UP.
+ * Wrappers for task_thread_info(p)->cpu access. No-op on UP.
  */
 #ifdef CONFIG_SMP
 
Index: linux-2.6-mm/arch/cris/arch-v32/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/cris/arch-v32/kernel/process.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/cris/arch-v32/kernel/process.c	2005-09-01 21:05:03.507007820 +0200
@@ -96,7 +96,7 @@ hard_reset_now(void)
  */
 unsigned long thread_saved_pc(struct task_struct *t)
 {
-	return (unsigned long)user_regs(t->thread_info)->erp;
+	return (unsigned long)user_regs(task_thread_info(t))->erp;
 }
 
 static void
@@ -148,7 +148,7 @@ copy_thread(int nr, unsigned long clone_
 	 * fix it up. Note: the task_struct doubles as the kernel stack for the
 	 * task.
 	 */
-	childregs = user_regs(p->thread_info);
+	childregs = user_regs(task_thread_info(p));
 	*childregs = *regs;	/* Struct copy of pt_regs. */
         p->set_child_tid = p->clear_child_tid = NULL;
         childregs->r10 = 0;	/* Child returns 0 after a fork/clone. */
@@ -157,7 +157,7 @@ copy_thread(int nr, unsigned long clone_
 	 * The TLS is in $mof beacuse it is the 5th argument to sys_clone.
 	 */
 	if (p->mm && (clone_flags & CLONE_SETTLS)) {
-		p->thread_info->tls = regs->mof;
+		task_thread_info(p)->tls = regs->mof;
 	}
 
 	/* Put the switch stack right below the pt_regs. */
Index: linux-2.6-mm/arch/cris/arch-v32/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/cris/arch-v32/kernel/ptrace.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/cris/arch-v32/kernel/ptrace.c	2005-09-01 21:05:03.542001808 +0200
@@ -46,7 +46,7 @@ long get_reg(struct task_struct *task, u
 	unsigned long ret;
 
 	if (regno <= PT_EDA)
-		ret = ((unsigned long *)user_regs(task->thread_info))[regno];
+		ret = ((unsigned long *)user_regs(task_thread_info(task)))[regno];
 	else if (regno == PT_USP)
 		ret = task->thread.usp;
 	else if (regno == PT_PPC)
@@ -65,13 +65,13 @@ long get_reg(struct task_struct *task, u
 int put_reg(struct task_struct *task, unsigned int regno, unsigned long data)
 {
 	if (regno <= PT_EDA)
-		((unsigned long *)user_regs(task->thread_info))[regno] = data;
+		((unsigned long *)user_regs(task_thread_info(task)))[regno] = data;
 	else if (regno == PT_USP)
 		task->thread.usp = data;
 	else if (regno == PT_PPC) {
 		/* Write pseudo-PC to ERP only if changed. */
 		if (data != get_pseudo_pc(task))
-			((unsigned long *)user_regs(task->thread_info))[PT_ERP] = data;
+			((unsigned long *)user_regs(task_thread_info(task)))[PT_ERP] = data;
 	} else if (regno <= PT_MAX)
 		return put_debugreg(task->pid, regno, data);
 	else
Index: linux-2.6-mm/arch/cris/arch-v32/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/cris/arch-v32/kernel/smp.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/cris/arch-v32/kernel/smp.c	2005-09-01 21:05:03.543001637 +0200
@@ -111,10 +111,10 @@ smp_boot_one_cpu(int cpuid)
 	if (IS_ERR(idle))
 		panic("SMP: fork failed for CPU:%d", cpuid);
 
-	idle->thread_info->cpu = cpuid;
+	task_thread_info(idle)->cpu = cpuid;
 
 	/* Information to the CPU that is about to boot */
-	smp_init_current_idle_thread = idle->thread_info;
+	smp_init_current_idle_thread = task_thread_info(idle);
 	cpu_now_booting = cpuid;
 
 	/* Wait for CPU to come online */
Index: linux-2.6-mm/arch/cris/arch-v32/mm/tlb.c
===================================================================
--- linux-2.6-mm.orig/arch/cris/arch-v32/mm/tlb.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/cris/arch-v32/mm/tlb.c	2005-09-01 21:05:03.568997171 +0200
@@ -196,9 +196,9 @@ switch_mm(struct mm_struct *prev, struct
 	per_cpu(current_pgd, cpu) = next->pgd;
 
 	/* Switch context in the MMU. */
-        if (tsk && tsk->thread_info)
+        if (tsk && task_thread_info(tsk))
         {
-          SPEC_REG_WR(SPEC_REG_PID, next->context.page_id | tsk->thread_info->tls);
+          SPEC_REG_WR(SPEC_REG_PID, next->context.page_id | task_thread_info(tsk)->tls);
         }
         else
         {
