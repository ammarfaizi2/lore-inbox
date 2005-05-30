Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVEaADP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVEaADP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVEaADO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:03:14 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:44938 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261829AbVE3Xv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:51:27 -0400
Date: Tue, 31 May 2005 01:51:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: more thread_info patches
In-Reply-To: <Pine.LNX.4.61.0505310113370.10977@scrub.home>
Message-ID: <Pine.LNX.4.61.0505310136050.10977@scrub.home>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
 <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be>
 <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
 <20050421173908.GZ13052@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.61.0505310113370.10977@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This globally replaces the access to the thread_info field in task_struct 
with either:
- direct access of the stack field, where it's obvious it wants the stack
- the same for end_of_stack()
- everything else with task_thread_info()

To simplify merging anything anything that creates conflicts can simply be 
dropped and can be dealt with latter.

bye, Roman

---

 arch/alpha/kernel/process.c         |   12 ++++-----
 arch/alpha/kernel/ptrace.c          |   40 +++++++++++++++----------------
 arch/alpha/kernel/smp.c             |    2 -
 arch/arm/kernel/process.c           |   10 +++----
 arch/arm/kernel/ptrace.c            |   12 ++++-----
 arch/arm/kernel/traps.c             |    6 ++--
 arch/arm26/kernel/process.c         |    2 -
 arch/arm26/kernel/ptrace.c          |    6 ++--
 arch/arm26/kernel/traps.c           |    8 +++---
 arch/cris/arch-v10/kernel/process.c |    4 +--
 arch/cris/arch-v10/kernel/ptrace.c  |    4 +--
 arch/cris/kernel/ptrace.c           |    4 +--
 arch/frv/kernel/process.c           |    4 +--
 arch/h8300/kernel/process.c         |    2 -
 arch/i386/kernel/kgdb_stub.c        |    2 -
 arch/i386/kernel/process.c          |    8 +++---
 arch/i386/kernel/smpboot.c          |    2 -
 arch/i386/kernel/vm86.c             |    2 -
 arch/ia64/kernel/signal.c           |   10 +++----
 arch/m32r/kernel/process.c          |    2 -
 arch/m32r/kernel/ptrace.c           |    2 -
 arch/m32r/kernel/smpboot.c          |    2 -
 arch/m68k/kernel/process.c          |    4 +--
 arch/m68knommu/kernel/process.c     |    2 -
 arch/mips/kernel/process.c          |    2 -
 arch/mips/kernel/ptrace.c           |    4 +--
 arch/mips/kernel/ptrace32.c         |    4 +--
 arch/mips/pmc-sierra/yosemite/smp.c |    2 -
 arch/mips/sgi-ip27/ip27-smp.c       |    2 -
 arch/mips/sibyte/cfe/smp.c          |    2 -
 arch/parisc/kernel/process.c        |    2 -
 arch/parisc/kernel/smp.c            |    2 -
 arch/ppc/kernel/process.c           |   10 +++----
 arch/ppc/kernel/smp.c               |    4 +--
 arch/ppc64/kernel/pSeries_smp.c     |    2 -
 arch/ppc64/kernel/process.c         |   12 ++++-----
 arch/ppc64/kernel/smp.c             |    4 +--
 arch/ppc64/kernel/sys_ppc32.c       |    2 -
 arch/s390/kernel/process.c          |   10 +++----
 arch/s390/kernel/smp.c              |    2 -
 arch/s390/kernel/traps.c            |    4 +--
 arch/sh/kernel/process.c            |   16 ++++++------
 arch/sh/kernel/ptrace.c             |    4 +--
 arch/sh/kernel/smp.c                |    2 -
 arch/sh64/kernel/process.c          |    4 +--
 arch/sh64/lib/dbg.c                 |    2 -
 arch/sparc/kernel/process.c         |   10 +++----
 arch/sparc/kernel/ptrace.c          |    4 +--
 arch/sparc/kernel/sun4d_smp.c       |    2 -
 arch/sparc/kernel/sun4m_smp.c       |    2 -
 arch/sparc/kernel/traps.c           |    4 +--
 arch/sparc64/kernel/process.c       |    8 +++---
 arch/sparc64/kernel/ptrace.c        |   46 ++++++++++++++++++------------------
 arch/sparc64/kernel/setup.c         |    2 -
 arch/sparc64/kernel/smp.c           |    2 -
 arch/sparc64/kernel/traps.c         |    4 +--
 arch/um/kernel/process_kern.c       |    4 +--
 arch/um/kernel/skas/process_kern.c  |    4 +--
 arch/um/kernel/tt/exec_kern.c       |    2 -
 arch/um/kernel/tt/process_kern.c    |    8 +++---
 arch/v850/kernel/process.c          |    2 -
 arch/x86_64/kernel/i387.c           |    2 -
 arch/x86_64/kernel/i8259.c          |    2 -
 arch/x86_64/kernel/kgdb_stub.c      |    2 -
 arch/x86_64/kernel/process.c        |   10 +++----
 arch/x86_64/kernel/smpboot.c        |    2 -
 arch/x86_64/kernel/traps.c          |    4 +--
 arch/x86_64/mm/fault.c              |    2 -
 arch/xtensa/kernel/process.c        |    4 +--
 include/asm-alpha/mmu_context.h     |    6 ++--
 include/asm-alpha/processor.h       |    4 +--
 include/asm-alpha/ptrace.h          |    2 -
 include/asm-alpha/system.h          |    2 -
 include/asm-arm/processor.h         |    2 -
 include/asm-arm/system.h            |    2 -
 include/asm-arm/thread_info.h       |    4 +--
 include/asm-arm26/system.h          |    2 -
 include/asm-arm26/thread_info.h     |    4 +--
 include/asm-cris/processor.h        |    2 -
 include/asm-i386/i387.h             |    8 +++---
 include/asm-i386/processor.h        |    2 -
 include/asm-m68k/thread_info.h      |    2 -
 include/asm-mips/processor.h        |    2 -
 include/asm-mips/system.h           |    2 -
 include/asm-ppc64/ptrace-common.h   |    4 +--
 include/asm-s390/processor.h        |    2 -
 include/asm-sparc/system.h          |    2 -
 include/asm-sparc64/elf.h           |    2 -
 include/asm-sparc64/mmu_context.h   |    2 -
 include/asm-sparc64/processor.h     |    4 +--
 include/asm-sparc64/system.h        |    4 +--
 include/asm-v850/processor.h        |    2 -
 include/asm-x86_64/i387.h           |    8 +++---
 include/asm-xtensa/ptrace.h         |    2 -
 include/linux/sched.h               |    6 ++--
 95 files changed, 233 insertions(+), 233 deletions(-)

Index: linux-2.6-mm/arch/alpha/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/alpha/kernel/process.c	2005-05-31 01:18:59.124022794 +0200
+++ linux-2.6-mm/arch/alpha/kernel/process.c	2005-05-31 01:20:37.338151703 +0200
@@ -274,7 +274,7 @@ copy_thread(int nr, unsigned long clone_
 {
 	extern void ret_from_fork(void);
 
-	struct thread_info *childti = p->thread_info;
+	struct thread_info *childti = task_thread_info(p);
 	struct pt_regs * childregs;
 	struct switch_stack * childstack, *stack;
 	unsigned long stack_offset, settls;
@@ -429,7 +429,7 @@ dump_elf_task(elf_greg_t *dest, struct t
 	struct thread_info *ti;
 	struct pt_regs *pt;
 
-	ti = task->thread_info;
+	ti = task_thread_info(task);
 	pt = (struct pt_regs *)((unsigned long)ti + 2*PAGE_SIZE) - 1;
 
 	dump_elf_thread(dest, pt, ti);
@@ -444,7 +444,7 @@ dump_elf_task_fp(elf_fpreg_t *dest, stru
 	struct pt_regs *pt;
 	struct switch_stack *sw;
 
-	ti = task->thread_info;
+	ti = task_thread_info(task);
 	pt = (struct pt_regs *)((unsigned long)ti + 2*PAGE_SIZE) - 1;
 	sw = (struct switch_stack *)pt - 1;
 
@@ -490,8 +490,8 @@ out:
 unsigned long
 thread_saved_pc(task_t *t)
 {
-	unsigned long base = (unsigned long)t->thread_info;
-	unsigned long fp, sp = t->thread_info->pcb.ksp;
+	unsigned long base = (unsigned long)t->stack;
+	unsigned long fp, sp = task_thread_info(t)->pcb.ksp;
 
 	if (sp > base && sp+6*8 < base + 16*1024) {
 		fp = ((unsigned long*)sp)[6];
@@ -521,7 +521,7 @@ get_wchan(struct task_struct *p)
 
 	pc = thread_saved_pc(p);
 	if (in_sched_functions(pc)) {
-		schedule_frame = ((unsigned long *)p->thread_info->pcb.ksp)[6];
+		schedule_frame = ((unsigned long *)task_thread_info(p)->pcb.ksp)[6];
 		return ((unsigned long *)schedule_frame)[12];
 	}
 	return pc;
Index: linux-2.6-mm/arch/alpha/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/alpha/kernel/ptrace.c	2005-05-31 01:18:59.124022794 +0200
+++ linux-2.6-mm/arch/alpha/kernel/ptrace.c	2005-05-31 01:20:37.338151703 +0200
@@ -103,14 +103,14 @@ get_reg_addr(struct task_struct * task, 
 	unsigned long *addr;
 
 	if (regno == 30) {
-		addr = &task->thread_info->pcb.usp;
+		addr = &task_thread_info(task)->pcb.usp;
 	} else if (regno == 65) {
-		addr = &task->thread_info->pcb.unique;
+		addr = &task_thread_infotask)->pcb.unique;
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
--- linux-2.6-mm.orig/arch/alpha/kernel/smp.c	2005-05-31 01:18:59.124022794 +0200
+++ linux-2.6-mm/arch/alpha/kernel/smp.c	2005-05-31 01:20:37.342151016 +0200
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
--- linux-2.6-mm.orig/arch/arm/kernel/process.c	2005-05-31 01:19:43.463406256 +0200
+++ linux-2.6-mm/arch/arm/kernel/process.c	2005-05-31 01:20:37.342151016 +0200
@@ -331,10 +331,10 @@ void flush_thread(void)
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
 
@@ -344,7 +344,7 @@ int
 copy_thread(int nr, unsigned long clone_flags, unsigned long stack_start,
 	    unsigned long stk_sz, struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *thread = p->thread_info;
+	struct thread_info *thread = task_thread_info(p);
 	struct pt_regs *childregs;
 
 	childregs = ((struct pt_regs *)((unsigned long)thread + THREAD_START_SP)) - 1;
@@ -449,8 +449,8 @@ unsigned long get_wchan(struct task_stru
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	stack_start = (unsigned long)(p->thread_info + 1);
-	stack_end = ((unsigned long)p->thread_info) + THREAD_SIZE;
+	stack_start = (unsigned long)end_of_stack(p);
+	stack_end = (unsigned long)p->stack + THREAD_SIZE;
 
 	fp = thread_saved_fp(p);
 	do {
Index: linux-2.6-mm/arch/arm/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/arm/kernel/ptrace.c	2005-05-31 01:18:59.125022622 +0200
+++ linux-2.6-mm/arch/arm/kernel/ptrace.c	2005-05-31 01:20:37.343150844 +0200
@@ -67,7 +67,7 @@ static inline struct pt_regs *
 get_user_regs(struct task_struct *task)
 {
 	return (struct pt_regs *)
-		((unsigned long)task->thread_info + THREAD_SIZE -
+		((unsigned long)task->stack + THREAD_SIZE -
 				 8 - sizeof(struct pt_regs));
 }
 
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
 
Index: linux-2.6-mm/arch/arm/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/arm/kernel/traps.c	2005-05-31 01:18:59.125022622 +0200
+++ linux-2.6-mm/arch/arm/kernel/traps.c	2005-05-31 01:20:37.343150844 +0200
@@ -164,7 +164,7 @@ static void dump_backtrace(struct pt_reg
 	} else if (verify_stack(fp)) {
 		printk("invalid frame pointer 0x%08x", fp);
 		ok = 0;
-	} else if (fp < (unsigned long)(tsk->thread_info + 1))
+	} else if (fp < (unsigned long)end_of_stack(tsk))
 		printk("frame pointer underflow");
 	printk("\n");
 
@@ -215,11 +215,11 @@ NORET_TYPE void die(const char *str, str
 	print_modules();
 	__show_regs(regs);
 	printk("Process %s (pid: %d, stack limit = 0x%p)\n",
-		tsk->comm, tsk->pid, tsk->thread_info + 1);
+		tsk->comm, tsk->pid, end_of_stack(tsk));
 
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem("Stack: ", regs->ARM_sp,
-			 THREAD_SIZE + (unsigned long)tsk->thread_info);
+			 THREAD_SIZE + (unsigned long)tsk->stack);
 		dump_backtrace(regs, tsk);
 		dump_instr(regs);
 	}
Index: linux-2.6-mm/arch/arm26/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/arm26/kernel/process.c	2005-05-31 01:19:43.466405741 +0200
+++ linux-2.6-mm/arch/arm26/kernel/process.c	2005-05-31 01:20:37.343150844 +0200
@@ -284,7 +284,7 @@ int
 copy_thread(int nr, unsigned long clone_flags, unsigned long stack_start,
 	    unsigned long unused, struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *thread = p->thread_info;
+	struct thread_info *thread = task_thread_info(p);
 	struct pt_regs *childregs;
 
 	childregs = __get_user_regs(thread);
Index: linux-2.6-mm/arch/arm26/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/arm26/kernel/ptrace.c	2005-05-31 01:18:59.125022622 +0200
+++ linux-2.6-mm/arch/arm26/kernel/ptrace.c	2005-05-31 01:20:37.344150672 +0200
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
 
Index: linux-2.6-mm/arch/arm26/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/arm26/kernel/traps.c	2005-05-31 01:18:59.125022622 +0200
+++ linux-2.6-mm/arch/arm26/kernel/traps.c	2005-05-31 01:20:37.345150500 +0200
@@ -132,7 +132,7 @@ static void dump_instr(struct pt_regs *r
 
 /*static*/ void __dump_stack(struct task_struct *tsk, unsigned long sp)
 {
-	dump_mem("Stack: ", sp, 8192+(unsigned long)tsk->thread_info);
+	dump_mem("Stack: ", sp, 8192+(unsigned long)tsk->stack);
 }
 
 void dump_stack(void)
@@ -158,7 +158,7 @@ void dump_backtrace(struct pt_regs *regs
 	} else if (verify_stack(fp)) {
 		printk("invalid frame pointer 0x%08x", fp);
 		ok = 0;
-	} else if (fp < (unsigned long)(tsk->thread_info + 1))
+	} else if (fp < (unsigned long)end_of_stack(tsk))
 		printk("frame pointer underflow");
 	printk("\n");
 
@@ -168,7 +168,7 @@ void dump_backtrace(struct pt_regs *regs
 
 /* FIXME - this is probably wrong.. */
 void show_stack(struct task_struct *task, unsigned long *sp) {
-	dump_mem("Stack: ", (unsigned long)sp, 8192+(unsigned long)task->thread_info);
+	dump_mem("Stack: ", (unsigned long)sp, 8192+(unsigned long)task->stack);
 }
 
 DEFINE_SPINLOCK(die_lock);
@@ -187,7 +187,7 @@ NORET_TYPE void die(const char *str, str
 	printk("CPU: %d\n", smp_processor_id());
 	show_regs(regs);
 	printk("Process %s (pid: %d, stack limit = 0x%p)\n",
-		current->comm, current->pid, tsk->thread_info + 1);
+		current->comm, current->pid, end_of_stack(tsk));
 
 	if (!user_mode(regs) || in_interrupt()) {
 		__dump_stack(tsk, (unsigned long)(regs + 1));
Index: linux-2.6-mm/arch/cris/arch-v10/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/cris/arch-v10/kernel/process.c	2005-05-31 01:18:59.125022622 +0200
+++ linux-2.6-mm/arch/cris/arch-v10/kernel/process.c	2005-05-31 01:20:37.345150500 +0200
@@ -79,7 +79,7 @@ void hard_reset_now (void)
  */
 unsigned long thread_saved_pc(struct task_struct *t)
 {
-	return (unsigned long)user_regs(t->thread_info)->irp;
+	return (unsigned long)user_regs(task_thread_info(t))->irp;
 }
 
 static void kernel_thread_helper(void* dummy, int (*fn)(void *), void * arg)
@@ -127,7 +127,7 @@ int copy_thread(int nr, unsigned long cl
 	 * remember that the task_struct doubles as the kernel stack for the task
 	 */
 
-	childregs = user_regs(p->thread_info);        
+	childregs = user_regs(task_thread_info(p));        
         
 	*childregs = *regs;  /* struct copy of pt_regs */
         
Index: linux-2.6-mm/arch/cris/arch-v10/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/cris/arch-v10/kernel/ptrace.c	2005-05-31 01:18:59.125022622 +0200
+++ linux-2.6-mm/arch/cris/arch-v10/kernel/ptrace.c	2005-05-31 01:20:37.345150500 +0200
@@ -36,7 +36,7 @@ inline long get_reg(struct task_struct *
 	if (regno == PT_USP)
 		return task->thread.usp;
 	else if (regno < PT_MAX)
-		return ((unsigned long *)user_regs(task->thread_info))[regno];
+		return ((unsigned long *)user_regs(task_thread_info(task)))[regno];
 	else
 		return 0;
 }
@@ -50,7 +50,7 @@ inline int put_reg(struct task_struct *t
 	if (regno == PT_USP)
 		task->thread.usp = data;
 	else if (regno < PT_MAX)
-		((unsigned long *)user_regs(task->thread_info))[regno] = data;
+		((unsigned long *)user_regs(task_thread_info(task)))[regno] = data;
 	else
 		return -1;
 	return 0;
Index: linux-2.6-mm/arch/cris/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/cris/kernel/ptrace.c	2005-05-31 01:18:59.125022622 +0200
+++ linux-2.6-mm/arch/cris/kernel/ptrace.c	2005-05-31 01:20:37.345150500 +0200
@@ -84,7 +84,7 @@ inline long get_reg(struct task_struct *
 	if (regno == PT_USP)
 		return task->thread.usp;
 	else if (regno < PT_MAX)
-		return ((unsigned long *)user_regs(task->thread_info))[regno];
+		return ((unsigned long *)user_regs(task_thread_info(task)))[regno];
 	else
 		return 0;
 }
@@ -98,7 +98,7 @@ inline int put_reg(struct task_struct *t
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
--- linux-2.6-mm.orig/arch/frv/kernel/process.c	2005-05-31 01:18:59.125022622 +0200
+++ linux-2.6-mm/arch/frv/kernel/process.c	2005-05-31 01:20:37.346150329 +0200
@@ -200,7 +200,7 @@ int copy_thread(int nr, unsigned long cl
 
 	regs0 = __kernel_frame0_ptr;
 	childregs0 = (struct pt_regs *)
-		((unsigned long) p->thread_info + THREAD_SIZE - USER_CONTEXT_SIZE);
+		((unsigned long)p->stack + THREAD_SIZE - USER_CONTEXT_SIZE);
 	childregs = childregs0;
 
 	/* set up the userspace frame (the only place that the USP is stored) */
@@ -216,7 +216,7 @@ int copy_thread(int nr, unsigned long cl
 		*childregs = *regs;
 		childregs->sp = (unsigned long) childregs0;
 		childregs->next_frame = childregs0;
-		childregs->gr15 = (unsigned long) p->thread_info;
+		childregs->gr15 = (unsigned long) task_thread_info(p);
 		childregs->gr29 = (unsigned long) p;
 	}
 
Index: linux-2.6-mm/arch/h8300/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/h8300/kernel/process.c	2005-05-31 01:18:59.125022622 +0200
+++ linux-2.6-mm/arch/h8300/kernel/process.c	2005-05-31 01:20:37.346150329 +0200
@@ -199,7 +199,7 @@ int copy_thread(int nr, unsigned long cl
 {
 	struct pt_regs * childregs;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long)p->stack)) - 1;
 
 	*childregs = *regs;
 	childregs->retpc = (unsigned long) ret_from_fork;
Index: linux-2.6-mm/arch/i386/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/process.c	2005-05-31 01:18:59.126022450 +0200
+++ linux-2.6-mm/arch/i386/kernel/process.c	2005-05-31 01:20:37.347150157 +0200
@@ -457,7 +457,7 @@ int copy_thread(int nr, unsigned long cl
 	struct task_struct *tsk;
 	int err;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long)p->stack)) - 1;
 	/*
 	 * The below -8 is to reserve 8 bytes on top of the ring0 stack.
 	 * This is necessary to guarantee that the entire "struct pt_regs"
@@ -578,7 +578,7 @@ int dump_task_regs(struct task_struct *t
 	struct pt_regs ptregs;
 	
 	ptregs = *(struct pt_regs *)
-		((unsigned long)tsk->thread_info+THREAD_SIZE - sizeof(ptregs));
+		((unsigned long)tsk->stack+THREAD_SIZE - sizeof(ptregs));
 	ptregs.xcs &= 0xffff;
 	ptregs.xds &= 0xffff;
 	ptregs.xes &= 0xffff;
@@ -719,7 +719,7 @@ struct task_struct fastcall * __switch_t
 	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
 		handle_io_bitmap(next, tss);
 
-	disable_tsc(prev_p->thread_info, next_p->thread_info);
+	disable_tsc(task_thread_info(prev_p), task_thread_info(next_p));
 
 	perfctr_resume_thread(next);
 	return prev_p;
@@ -798,7 +798,7 @@ unsigned long get_wchan(struct task_stru
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
-	stack_page = (unsigned long)p->thread_info;
+	stack_page = (unsigned long)p->stack;
 	esp = p->thread.esp;
 	if (!stack_page || esp < stack_page || esp > top_esp+stack_page)
 		return 0;
Index: linux-2.6-mm/arch/i386/kernel/vm86.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/vm86.c	2005-05-31 01:18:59.126022450 +0200
+++ linux-2.6-mm/arch/i386/kernel/vm86.c	2005-05-31 01:20:37.347150157 +0200
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
--- linux-2.6-mm.orig/arch/ia64/kernel/signal.c	2005-05-31 01:18:59.126022450 +0200
+++ linux-2.6-mm/arch/ia64/kernel/signal.c	2005-05-31 01:20:37.347150157 +0200
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
Index: linux-2.6-mm/arch/m32r/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/m32r/kernel/process.c	2005-05-31 01:18:59.126022450 +0200
+++ linux-2.6-mm/arch/m32r/kernel/process.c	2005-05-31 01:20:37.348149985 +0200
@@ -243,7 +243,7 @@ int copy_thread(int nr, unsigned long cl
 	unsigned long unused, struct task_struct *tsk, struct pt_regs *regs)
 {
 	struct pt_regs *childregs;
-	unsigned long sp = (unsigned long)tsk->thread_info + THREAD_SIZE;
+	unsigned long sp = (unsigned long)tsk->stack + THREAD_SIZE;
 	extern void ret_from_fork(void);
 
 	/* Copy registers */
Index: linux-2.6-mm/arch/m32r/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/m32r/kernel/ptrace.c	2005-05-31 01:18:59.126022450 +0200
+++ linux-2.6-mm/arch/m32r/kernel/ptrace.c	2005-05-31 01:20:37.348149985 +0200
@@ -47,7 +47,7 @@ static inline struct pt_regs *
 get_user_regs(struct task_struct *task)
 {
         return (struct pt_regs *)
-                ((unsigned long)task->thread_info + THREAD_SIZE
+                ((unsigned long)task->stack + THREAD_SIZE
                  - sizeof(struct pt_regs));
 }
 
Index: linux-2.6-mm/arch/m32r/kernel/smpboot.c
===================================================================
--- linux-2.6-mm.orig/arch/m32r/kernel/smpboot.c	2005-05-31 01:18:59.126022450 +0200
+++ linux-2.6-mm/arch/m32r/kernel/smpboot.c	2005-05-31 01:20:37.349149813 +0200
@@ -285,7 +285,7 @@ static void __init do_boot_cpu(int phys_
 	/* So we see what's up   */
 	printk("Booting processor %d/%d\n", phys_id, cpu_id);
 	stack_start.spi = (void *)idle->thread.sp;
-	idle->thread_info->cpu = cpu_id;
+	task_thread_info(idle)->cpu = cpu_id;
 
 	/*
 	 * Send Startup IPI
Index: linux-2.6-mm/arch/m68k/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/m68k/kernel/process.c	2005-05-31 01:18:59.126022450 +0200
+++ linux-2.6-mm/arch/m68k/kernel/process.c	2005-05-31 01:20:37.349149813 +0200
@@ -245,7 +245,7 @@ int copy_thread(int nr, unsigned long cl
 	unsigned long stack_offset, *retp;
 
 	stack_offset = THREAD_SIZE - sizeof(struct pt_regs);
-	childregs = (struct pt_regs *) ((unsigned long) (p->thread_info) + stack_offset);
+	childregs = (struct pt_regs *) ((unsigned long)p->stack + stack_offset);
 
 	*childregs = *regs;
 	childregs->d0 = 0;
@@ -390,7 +390,7 @@ unsigned long get_wchan(struct task_stru
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	stack_page = (unsigned long)(p->thread_info);
+	stack_page = (unsigned long)p->stack;
 	fp = ((struct switch_stack *)p->thread.ksp)->a6;
 	do {
 		if (fp < stack_page+sizeof(struct thread_info) ||
Index: linux-2.6-mm/arch/m68knommu/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/m68knommu/kernel/process.c	2005-05-31 01:18:59.126022450 +0200
+++ linux-2.6-mm/arch/m68knommu/kernel/process.c	2005-05-31 01:20:37.349149813 +0200
@@ -200,7 +200,7 @@ int copy_thread(int nr, unsigned long cl
 	unsigned long stack_offset, *retp;
 
 	stack_offset = THREAD_SIZE - sizeof(struct pt_regs);
-	childregs = (struct pt_regs *) ((unsigned long) p->thread_info + stack_offset);
+	childregs = (struct pt_regs *) ((unsigned long)p->stack + stack_offset);
 
 	*childregs = *regs;
 	childregs->d0 = 0;
Index: linux-2.6-mm/arch/mips/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/kernel/process.c	2005-05-31 01:18:59.126022450 +0200
+++ linux-2.6-mm/arch/mips/kernel/process.c	2005-05-31 01:20:37.350149642 +0200
@@ -94,7 +94,7 @@ void flush_thread(void)
 int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
 	unsigned long unused, struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *ti = p->thread_info;
+	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
 	long childksp;
 
Index: linux-2.6-mm/arch/mips/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/kernel/ptrace.c	2005-05-31 01:18:59.127022278 +0200
+++ linux-2.6-mm/arch/mips/kernel/ptrace.c	2005-05-31 01:20:37.350149642 +0200
@@ -112,7 +112,7 @@ asmlinkage int sys_ptrace(long request, 
 		struct pt_regs *regs;
 		unsigned long tmp = 0;
 
-		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
+		regs = (struct pt_regs *) ((unsigned long)child->stack +
 		       THREAD_SIZE - 32 - sizeof(struct pt_regs));
 		ret = 0;  /* Default return value. */
 
@@ -197,7 +197,7 @@ asmlinkage int sys_ptrace(long request, 
 	case PTRACE_POKEUSR: {
 		struct pt_regs *regs;
 		ret = 0;
-		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
+		regs = (struct pt_regs *) ((unsigned long)child->stack +
 		       THREAD_SIZE - 32 - sizeof(struct pt_regs));
 
 		switch (addr) {
Index: linux-2.6-mm/arch/mips/kernel/ptrace32.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/kernel/ptrace32.c	2005-05-31 01:18:59.127022278 +0200
+++ linux-2.6-mm/arch/mips/kernel/ptrace32.c	2005-05-31 01:20:37.350149642 +0200
@@ -104,7 +104,7 @@ asmlinkage int sys32_ptrace(int request,
 		struct pt_regs *regs;
 		unsigned int tmp;
 
-		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
+		regs = (struct pt_regs *) ((unsigned long)child->stack +
 		       THREAD_SIZE - 32 - sizeof(struct pt_regs));
 		ret = 0;  /* Default return value. */
 
@@ -184,7 +184,7 @@ asmlinkage int sys32_ptrace(int request,
 	case PTRACE_POKEUSR: {
 		struct pt_regs *regs;
 		ret = 0;
-		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
+		regs = (struct pt_regs *) ((unsigned long)child->stack +
 		       THREAD_SIZE - 32 - sizeof(struct pt_regs));
 
 		switch (addr) {
Index: linux-2.6-mm/arch/mips/pmc-sierra/yosemite/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/pmc-sierra/yosemite/smp.c	2005-05-31 01:18:59.127022278 +0200
+++ linux-2.6-mm/arch/mips/pmc-sierra/yosemite/smp.c	2005-05-31 01:20:37.350149642 +0200
@@ -93,7 +93,7 @@ void __init prom_prepare_cpus(unsigned i
  */
 void prom_boot_secondary(int cpu, struct task_struct *idle)
 {
-	unsigned long gp = (unsigned long) idle->thread_info;
+	unsigned long gp = (unsigned long)idle->stack;
 	unsigned long sp = gp + THREAD_SIZE - 32;
 
 	secondary_sp = sp;
Index: linux-2.6-mm/arch/mips/sgi-ip27/ip27-smp.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/sgi-ip27/ip27-smp.c	2005-05-31 01:18:59.127022278 +0200
+++ linux-2.6-mm/arch/mips/sgi-ip27/ip27-smp.c	2005-05-31 01:20:37.351149470 +0200
@@ -177,7 +177,7 @@ void __init prom_prepare_cpus(unsigned i
  */
 void __init prom_boot_secondary(int cpu, struct task_struct *idle)
 {
-	unsigned long gp = (unsigned long) idle->thread_info;
+	unsigned long gp = (unsigned long)idle->stack;
 	unsigned long sp = gp + THREAD_SIZE - 32;
 
 	LAUNCH_SLAVE(cputonasid(cpu),cputoslice(cpu),
Index: linux-2.6-mm/arch/mips/sibyte/cfe/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/sibyte/cfe/smp.c	2005-05-31 01:18:59.127022278 +0200
+++ linux-2.6-mm/arch/mips/sibyte/cfe/smp.c	2005-05-31 01:20:37.351149470 +0200
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
--- linux-2.6-mm.orig/arch/parisc/kernel/process.c	2005-05-31 01:18:59.127022278 +0200
+++ linux-2.6-mm/arch/parisc/kernel/process.c	2005-05-31 01:20:37.351149470 +0200
@@ -277,7 +277,7 @@ copy_thread(int nr, unsigned long clone_
 	    struct task_struct * p, struct pt_regs * pregs)
 {
 	struct pt_regs * cregs = &(p->thread.regs);
-	struct thread_info *ti = p->thread_info;
+	struct thread_info *ti = task_thread_info(p);
 	
 	/* We have to use void * instead of a function pointer, because
 	 * function pointers aren't a pointer to the function on 64-bit.
Index: linux-2.6-mm/arch/parisc/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/parisc/kernel/smp.c	2005-05-31 01:18:59.127022278 +0200
+++ linux-2.6-mm/arch/parisc/kernel/smp.c	2005-05-31 01:20:37.352149298 +0200
@@ -506,7 +506,7 @@ int __init smp_boot_one_cpu(int cpuid)
 	if (IS_ERR(idle))
 		panic("SMP: fork failed for CPU:%d", cpuid);
 
-	idle->thread_info->cpu = cpuid;
+	task_thread_info(idle)->cpu = cpuid;
 
 	/* Let _start know what logical CPU we're booting
 	** (offset into init_tasks[],cpu_data[])
Index: linux-2.6-mm/arch/ppc/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc/kernel/process.c	2005-05-31 01:18:59.127022278 +0200
+++ linux-2.6-mm/arch/ppc/kernel/process.c	2005-05-31 01:20:37.352149298 +0200
@@ -325,7 +325,7 @@ void show_regs(struct pt_regs * regs)
 	if (trap == 0x300 || trap == 0x600)
 		printk("DAR: %08lX, DSISR: %08lX\n", regs->dar, regs->dsisr);
 	printk("TASK = %p[%d] '%s' THREAD: %p\n",
-	       current, current->pid, current->comm, current->thread_info);
+	       current, current->pid, current->comm, task_thread_info(current));
 	printk("Last syscall: %ld ", current->thread.last_syscall);
 
 #ifdef CONFIG_SMP
@@ -420,7 +420,7 @@ copy_thread(int nr, unsigned long clone_
 {
 	struct pt_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
-	unsigned long sp = (unsigned long)p->thread_info + THREAD_SIZE;
+	unsigned long sp = (unsigned long)p->stack + THREAD_SIZE;
 	unsigned long childframe;
 
 	CHECK_FULL_REGS(regs);
@@ -638,8 +638,8 @@ void show_stack(struct task_struct *tsk,
 			sp = tsk->thread.ksp;
 	}
 
-	prev_sp = (unsigned long) (tsk->thread_info + 1);
-	stack_top = (unsigned long) tsk->thread_info + THREAD_SIZE;
+	prev_sp = (unsigned long)end_of_stack(tsk);
+	stack_top = (unsigned long)tsk->stack + THREAD_SIZE;
 	while (count < 16 && sp > prev_sp && sp < stack_top && (sp & 3) == 0) {
 		if (count == 0) {
 			printk("Call trace:");
@@ -768,7 +768,7 @@ void __init ll_puts(const char *s)
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
-	unsigned long stack_page = (unsigned long) p->thread_info;
+	unsigned long stack_page = (unsigned long)p->stack;
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
Index: linux-2.6-mm/arch/ppc/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc/kernel/smp.c	2005-05-31 01:18:59.127022278 +0200
+++ linux-2.6-mm/arch/ppc/kernel/smp.c	2005-05-31 01:20:37.352149298 +0200
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
--- linux-2.6-mm.orig/arch/ppc64/kernel/pSeries_smp.c	2005-05-31 01:18:59.127022278 +0200
+++ linux-2.6-mm/arch/ppc64/kernel/pSeries_smp.c	2005-05-31 01:20:37.353149126 +0200
@@ -278,7 +278,7 @@ static inline int __devinit smp_startup_
 	pcpu = get_hard_smp_processor_id(lcpu);
 
 	/* Fixup atomic count: it exited inside IRQ handler. */
-	paca[lcpu].__current->thread_info->preempt_count	= 0;
+	task_thread_info(paca[lcpu].__current)->preempt_count	= 0;
 
 	status = rtas_call(rtas_token("start-cpu"), 3, 1, NULL,
 			   pcpu, start_here, lcpu);
Index: linux-2.6-mm/arch/ppc64/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc64/kernel/process.c	2005-05-31 01:18:59.127022278 +0200
+++ linux-2.6-mm/arch/ppc64/kernel/process.c	2005-05-31 01:20:37.353149126 +0200
@@ -279,7 +279,7 @@ void show_regs(struct pt_regs * regs)
 	trap = TRAP(regs);
 	printk("DAR: %016lx DSISR: %016lx\n", regs->dar, regs->dsisr);
 	printk("TASK: %p[%d] '%s' THREAD: %p",
-	       current, current->pid, current->comm, current->thread_info);
+	       current, current->pid, current->comm, task_thread_info(current));
 
 #ifdef CONFIG_SMP
 	printk(" CPU: %d", smp_processor_id());
@@ -363,7 +363,7 @@ copy_thread(int nr, unsigned long clone_
 {
 	struct pt_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
-	unsigned long sp = (unsigned long)p->thread_info + THREAD_SIZE;
+	unsigned long sp = (unsigned long)p->stack + THREAD_SIZE;
 
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
@@ -373,9 +373,9 @@ copy_thread(int nr, unsigned long clone_
 		/* for kernel thread, set stackptr in new task */
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
 		p->thread.regs = NULL;	/* no user register state */
-		clear_ti_thread_flag(p->thread_info, TIF_32BIT);
+		clear_ti_thread_flag(task_thread_info(p), TIF_32BIT);
 #ifdef CONFIG_PPC_ISERIES
-		set_ti_thread_flag(p->thread_info, TIF_RUN_LIGHT);
+		set_ti_thread_flag(task_thread_info(p), TIF_RUN_LIGHT);
 #endif
 	} else {
 		childregs->gpr[1] = usp;
@@ -455,7 +455,7 @@ void start_thread(struct pt_regs *regs, 
 	 * set. Do it now.
 	 */
 	if (!current->thread.regs) {
-		unsigned long childregs = (unsigned long)current->thread_info +
+		unsigned long childregs = (unsigned long)current->stack +
 						THREAD_SIZE;
 		childregs -= sizeof(struct pt_regs);
 		current->thread.regs = (struct pt_regs *)childregs;
@@ -579,7 +579,7 @@ static int kstack_depth_to_print = 64;
 static int validate_sp(unsigned long sp, struct task_struct *p,
 		       unsigned long nbytes)
 {
-	unsigned long stack_page = (unsigned long)p->thread_info;
+	unsigned long stack_page = (unsigned long)p->stack;
 
 	if (sp >= stack_page + sizeof(struct thread_struct)
 	    && sp <= stack_page + THREAD_SIZE - nbytes)
Index: linux-2.6-mm/arch/ppc64/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc64/kernel/smp.c	2005-05-31 01:18:59.127022278 +0200
+++ linux-2.6-mm/arch/ppc64/kernel/smp.c	2005-05-31 01:20:37.354148955 +0200
@@ -355,7 +355,7 @@ static void __init smp_create_idle(unsig
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
 	paca[cpu].__current = p;
-	current_set[cpu] = p->thread_info;
+	current_set[cpu] = task_thread_info(p);
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
@@ -402,7 +402,7 @@ void __devinit smp_prepare_boot_cpu(void
 	cpu_set(boot_cpuid, cpu_online_map);
 
 	paca[boot_cpuid].__current = current;
-	current_set[boot_cpuid] = current->thread_info;
+	current_set[boot_cpuid] = task_thread_info(current);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
Index: linux-2.6-mm/arch/ppc64/kernel/sys_ppc32.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc64/kernel/sys_ppc32.c	2005-05-31 01:18:59.128022107 +0200
+++ linux-2.6-mm/arch/ppc64/kernel/sys_ppc32.c	2005-05-31 01:20:37.354148955 +0200
@@ -645,7 +645,7 @@ void start_thread32(struct pt_regs* regs
 	 * set. Do it now.
 	 */
 	if (!current->thread.regs) {
-		unsigned long childregs = (unsigned long)current->thread_info +
+		unsigned long childregs = (unsigned long)current->stack +
 						THREAD_SIZE;
 		childregs -= sizeof(struct pt_regs);
 		current->thread.regs = (struct pt_regs *)childregs;
Index: linux-2.6-mm/arch/s390/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/s390/kernel/process.c	2005-05-31 01:18:59.128022107 +0200
+++ linux-2.6-mm/arch/s390/kernel/process.c	2005-05-31 01:20:37.355148783 +0200
@@ -169,7 +169,7 @@ void show_regs(struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
 
-        printk("CPU:    %d    %s\n", tsk->thread_info->cpu, print_tainted());
+        printk("CPU:    %d    %s\n", task_thread_info(tsk)->cpu, print_tainted());
         printk("Process %s (pid: %d, task: %p, ksp: %p)\n",
 	       current->comm, current->pid, (void *) tsk,
 	       (void *) tsk->thread.ksp);
@@ -234,7 +234,7 @@ int copy_thread(int nr, unsigned long cl
           } *frame;
 
         frame = ((struct fake_frame *)
-		 (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+		 (THREAD_SIZE + (unsigned long)p->stack)) - 1;
         p->thread.ksp = (unsigned long) frame;
 	/* Store access registers to kernel stack of new process. */
         frame->childregs = *regs;
@@ -395,11 +395,11 @@ unsigned long get_wchan(struct task_stru
 	unsigned long return_address;
 	int count;
 
-	if (!p || p == current || p->state == TASK_RUNNING || !p->thread_info)
+	if (!p || p == current || p->state == TASK_RUNNING || !task_thread_info(p))
 		return 0;
-	low = (struct stack_frame *) p->thread_info;
+	low = (struct stack_frame *)p->stack;
 	high = (struct stack_frame *)
-		((unsigned long) p->thread_info + THREAD_SIZE) - 1;
+		((unsigned long)p->stack + THREAD_SIZE) - 1;
 	sf = (struct stack_frame *) (p->thread.ksp & PSW_ADDR_INSN);
 	if (sf <= low || sf > high)
 		return 0;
Index: linux-2.6-mm/arch/s390/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/s390/kernel/smp.c	2005-05-31 01:18:59.128022107 +0200
+++ linux-2.6-mm/arch/s390/kernel/smp.c	2005-05-31 01:20:37.355148783 +0200
@@ -652,7 +652,7 @@ __cpu_up(unsigned int cpu)
 	idle = current_set[cpu];
         cpu_lowcore = lowcore_ptr[cpu];
 	cpu_lowcore->kernel_stack = (unsigned long)
-		idle->thread_info + (THREAD_SIZE);
+		idle->stack + THREAD_SIZE;
 	sf = (struct stack_frame *) (cpu_lowcore->kernel_stack
 				     - sizeof(struct pt_regs)
 				     - sizeof(struct stack_frame));
Index: linux-2.6-mm/arch/s390/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/s390/kernel/traps.c	2005-05-31 01:18:59.128022107 +0200
+++ linux-2.6-mm/arch/s390/kernel/traps.c	2005-05-31 01:20:37.356148611 +0200
@@ -136,8 +136,8 @@ void show_trace(struct task_struct *task
 	sp = __show_trace(sp, S390_lowcore.async_stack - ASYNC_SIZE,
 			  S390_lowcore.async_stack);
 	if (task)
-		__show_trace(sp, (unsigned long) task->thread_info,
-			     (unsigned long) task->thread_info + THREAD_SIZE);
+		__show_trace(sp, (unsigned long)task->stack,
+			     (unsigned long)task->stack + THREAD_SIZE);
 	else
 		__show_trace(sp, S390_lowcore.thread_info,
 			     S390_lowcore.thread_info + THREAD_SIZE);
Index: linux-2.6-mm/arch/sh/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/sh/kernel/process.c	2005-05-31 01:18:59.128022107 +0200
+++ linux-2.6-mm/arch/sh/kernel/process.c	2005-05-31 01:20:37.356148611 +0200
@@ -202,7 +202,7 @@ void flush_thread(void)
 #if defined(CONFIG_SH_FPU)
 	struct task_struct *tsk = current;
 	struct pt_regs *regs = (struct pt_regs *)
-				((unsigned long)tsk->thread_info
+				((unsigned long)tsk->stack
 				 + THREAD_SIZE - sizeof(struct pt_regs)
 				 - sizeof(unsigned long));
 
@@ -243,7 +243,7 @@ int dump_task_regs(struct task_struct *t
 	struct pt_regs ptregs;
 	
 	ptregs = *(struct pt_regs *)
-		((unsigned long)tsk->thread_info + THREAD_SIZE
+		((unsigned long)tsk->stack + THREAD_SIZE
 		 - sizeof(struct pt_regs)
 #ifdef CONFIG_SH_DSP
 		 - sizeof(struct pt_dspregs)
@@ -263,7 +263,7 @@ dump_task_fpu (struct task_struct *tsk, 
 	fpvalid = !!tsk_used_math(tsk);
 	if (fpvalid) {
 		struct pt_regs *regs = (struct pt_regs *)
-					((unsigned long)tsk->thread_info
+					((unsigned long)tsk->stack
 					 + THREAD_SIZE - sizeof(struct pt_regs)
 					 - sizeof(unsigned long));
 		unlazy_fpu(tsk, regs);
@@ -290,7 +290,7 @@ int copy_thread(int nr, unsigned long cl
 #endif
 
 	childregs = ((struct pt_regs *)
-		(THREAD_SIZE + (unsigned long) p->thread_info)
+		(THREAD_SIZE + (unsigned long)p->stack)
 #ifdef CONFIG_SH_DSP
 		- sizeof(struct pt_dspregs)
 #endif
@@ -300,7 +300,7 @@ int copy_thread(int nr, unsigned long cl
 	if (user_mode(regs)) {
 		childregs->regs[15] = usp;
 	} else {
-		childregs->regs[15] = (unsigned long)p->thread_info + THREAD_SIZE;
+		childregs->regs[15] = (unsigned long)p->stack + THREAD_SIZE;
 	}
         if (clone_flags & CLONE_SETTLS) {
 		childregs->gbr = childregs->regs[0];
@@ -364,7 +364,7 @@ struct task_struct *__switch_to(struct t
 {
 #if defined(CONFIG_SH_FPU)
 	struct pt_regs *regs = (struct pt_regs *)
-				((unsigned long)prev->thread_info
+				((unsigned long)prev->stack
 				 + THREAD_SIZE - sizeof(struct pt_regs)
 				 - sizeof(unsigned long));
 	unlazy_fpu(prev, regs);
@@ -377,7 +377,7 @@ struct task_struct *__switch_to(struct t
 
 		local_irq_save(flags);
 		regs = (struct pt_regs *)
-			((unsigned long)prev->thread_info
+			((unsigned long)prev->stack
 			 + THREAD_SIZE - sizeof(struct pt_regs)
 #ifdef CONFIG_SH_DSP
 			 - sizeof(struct pt_dspregs)
@@ -402,7 +402,7 @@ struct task_struct *__switch_to(struct t
 	 */
 	asm volatile("ldc	%0, r7_bank"
 		     : /* no output */
-		     : "r" (next->thread_info));
+		     : "r" (task_thread_info(next)));
 
 #ifdef CONFIG_MMU
 	/* If no tasks are using the UBC, we're done */
Index: linux-2.6-mm/arch/sh/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/sh/kernel/ptrace.c	2005-05-31 01:18:59.128022107 +0200
+++ linux-2.6-mm/arch/sh/kernel/ptrace.c	2005-05-31 01:20:37.356148611 +0200
@@ -42,7 +42,7 @@ static inline int get_stack_long(struct 
 	unsigned char *stack;
 
 	stack = (unsigned char *)
-		task->thread_info + THREAD_SIZE	- sizeof(struct pt_regs)
+		task->stack + THREAD_SIZE - sizeof(struct pt_regs)
 #ifdef CONFIG_SH_DSP
 		- sizeof(struct pt_dspregs)
 #endif
@@ -60,7 +60,7 @@ static inline int put_stack_long(struct 
 	unsigned char *stack;
 
 	stack = (unsigned char *)
-		task->thread_info + THREAD_SIZE - sizeof(struct pt_regs)
+		task->stack + THREAD_SIZE - sizeof(struct pt_regs)
 #ifdef CONFIG_SH_DSP
 		- sizeof(struct pt_dspregs)
 #endif
Index: linux-2.6-mm/arch/sh/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/sh/kernel/smp.c	2005-05-31 01:18:59.128022107 +0200
+++ linux-2.6-mm/arch/sh/kernel/smp.c	2005-05-31 01:20:37.357148439 +0200
@@ -100,7 +100,7 @@ int __cpu_up(unsigned int cpu)
 	if (IS_ERR(tsk))
 		panic("Failed forking idle task for cpu %d\n", cpu);
 	
-	tsk->thread_info->cpu = cpu;
+	task_thread_info(tsk)->cpu = cpu;
 
 	cpu_set(cpu, cpu_online_map);
 
Index: linux-2.6-mm/arch/sh64/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/sh64/kernel/process.c	2005-05-31 01:18:59.128022107 +0200
+++ linux-2.6-mm/arch/sh64/kernel/process.c	2005-05-31 01:20:37.357148439 +0200
@@ -750,7 +750,7 @@ int copy_thread(int nr, unsigned long cl
 	}
 #endif
 	/* Copy from sh version */
-	childregs = ((struct pt_regs *)(THREAD_SIZE + (unsigned long) p->thread_info )) - 1;
+	childregs = ((struct pt_regs *)(THREAD_SIZE + (unsigned long)p->stack)) - 1;
 
 	*childregs = *regs;
 
@@ -758,7 +758,7 @@ int copy_thread(int nr, unsigned long cl
 		childregs->regs[15] = usp;
 		p->thread.uregs = childregs;
 	} else {
-		childregs->regs[15] = (unsigned long)p->thread_info + THREAD_SIZE;
+		childregs->regs[15] = (unsigned long)p->stack + THREAD_SIZE;
 	}
 
 	childregs->regs[9] = 0; /* Set return value for child */
Index: linux-2.6-mm/arch/sh64/lib/dbg.c
===================================================================
--- linux-2.6-mm.orig/arch/sh64/lib/dbg.c	2005-05-31 01:18:59.128022107 +0200
+++ linux-2.6-mm/arch/sh64/lib/dbg.c	2005-05-31 01:20:37.357148439 +0200
@@ -174,7 +174,7 @@ void evt_debug(int evt, int ret_addr, in
 	struct ring_node *rr;
 
 	pid = current->pid;
-	stack_bottom = (unsigned long) current->thread_info;
+	stack_bottom = (unsigned long)current->stack;
 	asm volatile("ori r15, 0, %0" : "=r" (sp));
 	rr = event_ring + event_ptr;
 	rr->evt = evt;
Index: linux-2.6-mm/arch/sparc/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/kernel/process.c	2005-05-31 01:18:59.128022107 +0200
+++ linux-2.6-mm/arch/sparc/kernel/process.c	2005-05-31 01:20:37.358148268 +0200
@@ -309,7 +309,7 @@ void show_stack(struct task_struct *tsk,
 	int count = 0;
 
 	if (tsk != NULL)
-		task_base = (unsigned long) tsk->thread_info;
+		task_base = (unsigned long)tsk->stack;
 	else
 		task_base = (unsigned long) current_thread_info();
 
@@ -344,7 +344,7 @@ EXPORT_SYMBOL(dump_stack);
  */
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	return tsk->thread_info->kpc;
+	return task_thread_info(tsk)->kpc;
 }
 
 /*
@@ -399,7 +399,7 @@ void flush_thread(void)
 		/* We must fixup kregs as well. */
 		/* XXX This was not fixed for ti for a while, worked. Unused? */
 		current->thread.kregs = (struct pt_regs *)
-		    ((char *)current->thread_info + (THREAD_SIZE - TRACEREG_SZ));
+		    ((char *)current->stack + (THREAD_SIZE - TRACEREG_SZ));
 	}
 }
 
@@ -466,7 +466,7 @@ int copy_thread(int nr, unsigned long cl
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *ti = p->thread_info;
+	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
 	char *new_stack;
 
@@ -731,7 +731,7 @@ unsigned long get_wchan(struct task_stru
             task->state == TASK_RUNNING)
 		goto out;
 
-	fp = task->thread_info->ksp + bias;
+	fp = task_thread_info(task)->ksp + bias;
 	do {
 		/* Bogus frame pointer? */
 		if (fp < (task_base + sizeof(struct thread_info)) ||
Index: linux-2.6-mm/arch/sparc/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/kernel/ptrace.c	2005-05-31 01:18:59.128022107 +0200
+++ linux-2.6-mm/arch/sparc/kernel/ptrace.c	2005-05-31 01:20:37.358148268 +0200
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
--- linux-2.6-mm.orig/arch/sparc/kernel/sun4d_smp.c	2005-05-31 01:18:59.128022107 +0200
+++ linux-2.6-mm/arch/sparc/kernel/sun4d_smp.c	2005-05-31 01:20:37.359148096 +0200
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
--- linux-2.6-mm.orig/arch/sparc/kernel/sun4m_smp.c	2005-05-31 01:18:59.129021935 +0200
+++ linux-2.6-mm/arch/sparc/kernel/sun4m_smp.c	2005-05-31 01:20:37.359148096 +0200
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
--- linux-2.6-mm.orig/arch/sparc/kernel/traps.c	2005-05-31 01:18:59.129021935 +0200
+++ linux-2.6-mm/arch/sparc/kernel/traps.c	2005-05-31 01:20:37.359148096 +0200
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
--- linux-2.6-mm.orig/arch/sparc64/kernel/process.c	2005-05-31 01:18:59.129021935 +0200
+++ linux-2.6-mm/arch/sparc64/kernel/process.c	2005-05-31 01:20:37.360147924 +0200
@@ -382,7 +382,7 @@ void show_regs32(struct pt_regs32 *regs)
 
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	struct thread_info *ti = tsk->thread_info;
+	struct thread_info *ti = task_thread_info(tsk);
 	unsigned long ret = 0xdeadbeefUL;
 	
 	if (ti && ti->ksp) {
@@ -608,7 +608,7 @@ int copy_thread(int nr, unsigned long cl
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *t = p->thread_info;
+	struct thread_info *t = task_thread_info(p);
 	char *child_trap_frame;
 
 #ifdef CONFIG_DEBUG_SPINLOCK
@@ -842,9 +842,9 @@ unsigned long get_wchan(struct task_stru
             task->state == TASK_RUNNING)
 		goto out;
 
-	thread_info_base = (unsigned long) task->thread_info;
+	thread_info_base = (unsigned long)task->stack;
 	bias = STACK_BIAS;
-	fp = task->thread_info->ksp + bias;
+	fp = task_thread_info(task)->ksp + bias;
 
 	do {
 		/* Bogus frame pointer? */
Index: linux-2.6-mm/arch/sparc64/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc64/kernel/ptrace.c	2005-05-31 01:18:59.129021935 +0200
+++ linux-2.6-mm/arch/sparc64/kernel/ptrace.c	2005-05-31 01:20:37.361147752 +0200
@@ -309,7 +309,7 @@ asmlinkage void do_ptrace(struct pt_regs
 	case PTRACE_GETREGS: {
 		struct pt_regs32 __user *pregs =
 			(struct pt_regs32 __user *) addr;
-		struct pt_regs *cregs = child->thread_info->kregs;
+		struct pt_regs *cregs = task_thread_info(child)->kregs;
 		int rval;
 
 		if (__put_user(tstate_to_psr(cregs->tstate), (&pregs->psr)) ||
@@ -333,11 +333,11 @@ asmlinkage void do_ptrace(struct pt_regs
 
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
@@ -361,7 +361,7 @@ asmlinkage void do_ptrace(struct pt_regs
 	case PTRACE_SETREGS: {
 		struct pt_regs32 __user *pregs =
 			(struct pt_regs32 __user *) addr;
-		struct pt_regs *cregs = child->thread_info->kregs;
+		struct pt_regs *cregs = task_thread_info(child)->kregs;
 		unsigned int psr, pc, npc, y;
 		int i;
 
@@ -394,7 +394,7 @@ asmlinkage void do_ptrace(struct pt_regs
 
 	case PTRACE_SETREGS64: {
 		struct pt_regs __user *pregs = (struct pt_regs __user *) addr;
-		struct pt_regs *cregs = child->thread_info->kregs;
+		struct pt_regs *cregs = task_thread_info(child)->kregs;
 		unsigned long tstate, tpc, tnpc, y;
 		int i;
 
@@ -408,7 +408,7 @@ asmlinkage void do_ptrace(struct pt_regs
 			pt_error_return(regs, EFAULT);
 			goto out_tsk;
 		}
-		if ((child->thread_info->flags & _TIF_32BIT) != 0) {
+		if ((task_thread_info(child)->flags & _TIF_32BIT) != 0) {
 			tpc &= 0xffffffff;
 			tnpc &= 0xffffffff;
 		}
@@ -443,11 +443,11 @@ asmlinkage void do_ptrace(struct pt_regs
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
@@ -465,11 +465,11 @@ asmlinkage void do_ptrace(struct pt_regs
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
@@ -490,7 +490,7 @@ asmlinkage void do_ptrace(struct pt_regs
 			} fpq[16];
 		};
 		struct fps __user *fps = (struct fps __user *) addr;
-		unsigned long *fpregs = child->thread_info->fpregs;
+		unsigned long *fpregs = task_thread_info(child)->fpregs;
 		unsigned fsr;
 
 		if (copy_from_user(fpregs, &fps->regs[0],
@@ -499,11 +499,11 @@ asmlinkage void do_ptrace(struct pt_regs
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
@@ -514,17 +514,17 @@ asmlinkage void do_ptrace(struct pt_regs
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
@@ -575,8 +575,8 @@ asmlinkage void do_ptrace(struct pt_regs
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
--- linux-2.6-mm.orig/arch/sparc64/kernel/setup.c	2005-05-31 01:18:59.129021935 +0200
+++ linux-2.6-mm/arch/sparc64/kernel/setup.c	2005-05-31 01:20:37.361147752 +0200
@@ -563,7 +563,7 @@ void __init setup_arch(char **cmdline_p)
 	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);	
 #endif
 
-	init_task.thread_info->kregs = &fake_swapper_regs;
+	task_thread_info(&init_task)->kregs = &fake_swapper_regs;
 
 #ifdef CONFIG_IP_PNP
 	if (!ic_set_manually) {
Index: linux-2.6-mm/arch/sparc64/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc64/kernel/smp.c	2005-05-31 01:18:59.129021935 +0200
+++ linux-2.6-mm/arch/sparc64/kernel/smp.c	2005-05-31 01:20:37.361147752 +0200
@@ -309,7 +309,7 @@ static int __devinit smp_boot_one_cpu(un
 
 	p = fork_idle(cpu);
 	callin_flag = 0;
-	cpu_new_thread = p->thread_info;
+	cpu_new_thread = task_thread_info(p);
 	cpu_set(cpu, cpu_callout_map);
 
 	cpu_find_by_mid(cpu, &cpu_node);
Index: linux-2.6-mm/arch/sparc64/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc64/kernel/traps.c	2005-05-31 01:18:59.129021935 +0200
+++ linux-2.6-mm/arch/sparc64/kernel/traps.c	2005-05-31 01:20:37.362147581 +0200
@@ -1758,7 +1758,7 @@ static void user_instruction_dump (unsig
 void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 {
 	unsigned long pc, fp, thread_base, ksp;
-	struct thread_info *tp = tsk->thread_info;
+	struct thread_info *tp = task_thread_info(tsk);
 	struct reg_window *rw;
 	int count = 0;
 
@@ -1812,7 +1812,7 @@ static inline int is_kernel_stack(struct
 			return 0;
 	}
 
-	thread_base = (unsigned long) task->thread_info;
+	thread_base = (unsigned long)task->stack;
 	thread_end = thread_base + sizeof(union thread_union);
 	if (rw_addr >= thread_base &&
 	    rw_addr < thread_end &&
Index: linux-2.6-mm/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6-mm.orig/arch/um/kernel/process_kern.c	2005-05-31 01:18:59.129021935 +0200
+++ linux-2.6-mm/arch/um/kernel/process_kern.c	2005-05-31 01:20:37.363147409 +0200
@@ -120,7 +120,7 @@ void set_current(void *t)
 {
 	struct task_struct *task = t;
 
-	cpu_tasks[task->thread_info->cpu] = ((struct cpu_task) 
+	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task) 
 		{ external_pid(task), task });
 }
 
@@ -347,7 +347,7 @@ char *uml_strdup(char *string)
 
 void *get_init_task(void)
 {
-	return(&init_thread_union.thread_info.task);
+	return(&task_thread_info(&init_thread_union)->task);
 }
 
 int copy_to_user_proc(void __user *to, void *from, int size)
Index: linux-2.6-mm/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6-mm.orig/arch/um/kernel/skas/process_kern.c	2005-05-31 01:18:59.129021935 +0200
+++ linux-2.6-mm/arch/um/kernel/skas/process_kern.c	2005-05-31 01:20:37.363147409 +0200
@@ -120,7 +120,7 @@ int copy_thread_skas(int nr, unsigned lo
 		handler = new_thread_handler;
 	}
 
-	new_thread(p->thread_info, &p->thread.mode.skas.switch_buf,
+	new_thread(task_thread_info(p), &p->thread.mode.skas.switch_buf,
 		   &p->thread.mode.skas.fork_buf, handler);
 	return(0);
 }
@@ -180,7 +180,7 @@ int start_uml_skas(void)
 
 	init_task.thread.request.u.thread.proc = start_kernel_proc;
 	init_task.thread.request.u.thread.arg = NULL;
-	return(start_idle_thread(init_task.thread_info,
+	return(start_idle_thread(task_thread_info(&init_task),
 				 &init_task.thread.mode.skas.switch_buf,
 				 &init_task.thread.mode.skas.fork_buf));
 }
Index: linux-2.6-mm/arch/um/kernel/tt/exec_kern.c
===================================================================
--- linux-2.6-mm.orig/arch/um/kernel/tt/exec_kern.c	2005-05-31 01:18:59.129021935 +0200
+++ linux-2.6-mm/arch/um/kernel/tt/exec_kern.c	2005-05-31 01:20:37.363147409 +0200
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
--- linux-2.6-mm.orig/arch/um/kernel/tt/process_kern.c	2005-05-31 01:18:59.129021935 +0200
+++ linux-2.6-mm/arch/um/kernel/tt/process_kern.c	2005-05-31 01:20:37.364147237 +0200
@@ -42,7 +42,7 @@ void *switch_to_tt(void *prev, void *nex
 
 	to->thread.prev_sched = from;
 
-	cpu = from->thread_info->cpu;
+	cpu = task_thread_info(from)->cpu;
 	if(cpu == 0)
 		forward_interrupts(to->thread.mode.tt.extern_pid);
 #ifdef CONFIG_SMP
@@ -264,7 +264,7 @@ int copy_thread_tt(int nr, unsigned long
 
 	clone_flags &= CLONE_VM;
 	p->thread.temp_stack = stack;
-	new_pid = start_fork_tramp(p->thread_info, stack, clone_flags, tramp);
+	new_pid = start_fork_tramp(task_thread_info(p), stack, clone_flags, tramp);
 	if(new_pid < 0){
 		printk(KERN_ERR "copy_thread : clone failed - errno = %d\n", 
 		       -new_pid);
@@ -354,7 +354,7 @@ int do_proc_op(void *t, int proc_id)
 		pid = thread->request.u.exec.pid;
 		do_exec(thread->mode.tt.extern_pid, pid);
 		thread->mode.tt.extern_pid = pid;
-		cpu_tasks[task->thread_info->cpu].pid = pid;
+		cpu_tasks[task_thread_info(task)->cpu].pid = pid;
 		break;
 	case OP_FORK:
 		attach_process(thread->request.u.fork.pid);
@@ -436,7 +436,7 @@ int start_uml_tt(void)
 	int pages;
 
 	pages = (1 << CONFIG_KERNEL_STACK_ORDER);
-	sp = (void *) ((unsigned long) init_task.thread_info) +
+	sp = (void *) ((unsigned long) init_task.stack) +
 		pages * PAGE_SIZE - sizeof(unsigned long);
 	return(tracer(start_kernel_proc, sp));
 }
Index: linux-2.6-mm/arch/v850/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/v850/kernel/process.c	2005-05-31 01:18:59.129021935 +0200
+++ linux-2.6-mm/arch/v850/kernel/process.c	2005-05-31 01:20:37.364147237 +0200
@@ -110,7 +110,7 @@ int copy_thread (int nr, unsigned long c
 		 struct task_struct *p, struct pt_regs *regs)
 {
 	/* Start pushing stuff from the top of the child's kernel stack.  */
-	unsigned long orig_ksp = (unsigned long)p->thread_info + THREAD_SIZE;
+	unsigned long orig_ksp = (unsigned long)p->stack + THREAD_SIZE;
 	unsigned long ksp = orig_ksp;
 	/* We push two `state save' stack fames (see entry.S) on the new
 	   kernel stack:
Index: linux-2.6-mm/arch/x86_64/kernel/i387.c
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/kernel/i387.c	2005-05-31 01:18:59.130021763 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/i387.c	2005-05-31 01:20:37.364147237 +0200
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
--- linux-2.6-mm.orig/arch/x86_64/kernel/i8259.c	2005-05-31 01:18:59.130021763 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/i8259.c	2005-05-31 01:20:37.365147065 +0200
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
--- linux-2.6-mm.orig/arch/x86_64/kernel/process.c	2005-05-31 01:18:59.130021763 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/process.c	2005-05-31 01:20:37.365147065 +0200
@@ -387,7 +387,7 @@ int copy_thread(int nr, unsigned long cl
 	struct pt_regs * childregs;
 	struct task_struct *me = current;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long)p->stack)) - 1;
 
 	*childregs = *regs;
 
@@ -401,7 +401,7 @@ int copy_thread(int nr, unsigned long cl
 	p->thread.rsp0 = (unsigned long) (childregs+1);
 	p->thread.userrsp = me->thread.userrsp; 
 
-	set_ti_thread_flag(p->thread_info, TIF_FORK);
+	set_ti_thread_flag(task_thread_info(p), TIF_FORK);
 
 	p->thread.fs = me->thread.fs;
 	p->thread.gs = me->thread.gs;
@@ -546,7 +546,7 @@ struct task_struct *__switch_to(struct t
 	prev->userrsp = read_pda(oldrsp); 
 	write_pda(oldrsp, next->userrsp); 
 	write_pda(pcurrent, next_p); 
-	write_pda(kernelstack, (unsigned long)next_p->thread_info + THREAD_SIZE - PDA_STACKOFFSET);
+	write_pda(kernelstack, (unsigned long)next_p->stack + THREAD_SIZE - PDA_STACKOFFSET);
 
 	/*
 	 * Now maybe reload the debug registers
@@ -581,7 +581,7 @@ struct task_struct *__switch_to(struct t
 		}
 	}
 
-	disable_tsc(prev_p->thread_info, next_p->thread_info);
+	disable_tsc(task_thread_info(prev_p), task_thread_info(next_p));
 
 	perfctr_resume_thread(next);
 
@@ -662,7 +662,7 @@ unsigned long get_wchan(struct task_stru
 
 	if (!p || p == current || p->state==TASK_RUNNING)
 		return 0; 
-	stack = (unsigned long)p->thread_info; 
+	stack = (unsigned long)p->stack; 
 	if (p->thread.rsp < stack || p->thread.rsp > stack+THREAD_SIZE)
 		return 0;
 	fp = *(u64 *)(p->thread.rsp);
Index: linux-2.6-mm/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/kernel/smpboot.c	2005-05-31 01:18:59.130021763 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/smpboot.c	2005-05-31 01:20:37.366146894 +0200
@@ -654,7 +654,7 @@ static int __cpuinit do_boot_cpu(int cpu
 	init_rsp = idle->thread.rsp;
 	per_cpu(init_tss,cpu).rsp0 = init_rsp;
 	initial_code = start_secondary;
-	clear_ti_thread_flag(idle->thread_info, TIF_FORK);
+	clear_ti_thread_flag(task_thread_info(idle), TIF_FORK);
 
 	printk(KERN_INFO "Booting processor %d/%d rip %lx rsp %lx\n", cpu, apicid,
 	       start_rip, init_rsp);
Index: linux-2.6-mm/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/kernel/traps.c	2005-05-31 01:18:59.130021763 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/traps.c	2005-05-31 01:20:37.366146894 +0200
@@ -287,7 +287,7 @@ void show_registers(struct pt_regs *regs
 	printk("CPU %d ", cpu);
 	__show_regs(regs);
 	printk("Process %s (pid: %d, threadinfo %p, task %p)\n",
-		cur->comm, cur->pid, cur->thread_info, cur);
+		cur->comm, cur->pid, task_thread_info(cur), cur);
 
 	/*
 	 * When in-kernel, we also print out the stack and code at the
@@ -894,7 +894,7 @@ asmlinkage void math_state_restore(void)
 	if (!used_math())
 		init_fpu(me);
 	restore_fpu_checking(&me->thread.i387.fxsave);
-	me->thread_info->status |= TS_USEDFPU;
+	task_thread_info(me)->status |= TS_USEDFPU;
 }
 
 void do_call_debug(struct pt_regs *regs) 
Index: linux-2.6-mm/arch/x86_64/mm/fault.c
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/mm/fault.c	2005-05-31 01:18:59.130021763 +0200
+++ linux-2.6-mm/arch/x86_64/mm/fault.c	2005-05-31 01:20:37.367146722 +0200
@@ -213,7 +213,7 @@ int unhandled_signal(struct task_struct 
 	if (tsk->pid == 1)
 		return 1;
 	/* Warn for strace, but not for gdb */
-	if (!test_ti_thread_flag(tsk->thread_info, TIF_SYSCALL_TRACE) &&
+	if (!test_ti_thread_flag(task_thread_info(tsk), TIF_SYSCALL_TRACE) &&
 	    (tsk->ptrace & PT_PTRACED))
 		return 0;
 	return (tsk->sighand->action[sig-1].sa.sa_handler == SIG_IGN) ||
Index: linux-2.6-mm/include/asm-alpha/mmu_context.h
===================================================================
--- linux-2.6-mm.orig/include/asm-alpha/mmu_context.h	2005-05-31 01:18:59.130021763 +0200
+++ linux-2.6-mm/include/asm-alpha/mmu_context.h	2005-05-31 01:20:37.367146722 +0200
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
--- linux-2.6-mm.orig/include/asm-alpha/processor.h	2005-05-31 01:18:59.130021763 +0200
+++ linux-2.6-mm/include/asm-alpha/processor.h	2005-05-31 01:20:37.367146722 +0200
@@ -61,10 +61,10 @@ unsigned long get_wchan(struct task_stru
   + offsetof(struct switch_stack, reg))
 
 #define KSTK_EIP(tsk) \
-  (*(unsigned long *)(PT_REG(pc) + (unsigned long) ((tsk)->thread_info)))
+  (*(unsigned long *)(PT_REG(pc) + (unsigned long)((tsk)->stack)))
 
 #define KSTK_ESP(tsk) \
-  ((tsk) == current ? rdusp() : (tsk)->thread_info->pcb.usp)
+  ((tsk) == current ? rdusp() : task_thread_info(tsk)->pcb.usp)
 
 #define cpu_relax()	barrier()
 
Index: linux-2.6-mm/include/asm-alpha/ptrace.h
===================================================================
--- linux-2.6-mm.orig/include/asm-alpha/ptrace.h	2005-05-31 01:18:59.130021763 +0200
+++ linux-2.6-mm/include/asm-alpha/ptrace.h	2005-05-31 01:20:37.367146722 +0200
@@ -73,7 +73,7 @@ struct switch_stack {
 extern void show_regs(struct pt_regs *);
 
 #define alpha_task_regs(task) \
-  ((struct pt_regs *) ((long) (task)->thread_info + 2*PAGE_SIZE) - 1)
+  ((struct pt_regs *) ((long) (task)->stack + 2*PAGE_SIZE) - 1)
 
 #define force_successful_syscall_return() (alpha_task_regs(current)->r0 = 0)
 
Index: linux-2.6-mm/include/asm-alpha/system.h
===================================================================
--- linux-2.6-mm.orig/include/asm-alpha/system.h	2005-05-31 01:18:59.130021763 +0200
+++ linux-2.6-mm/include/asm-alpha/system.h	2005-05-31 01:20:37.368146550 +0200
@@ -132,7 +132,7 @@ extern void halt(void) __attribute__((no
 
 #define switch_to(P,N,L)						\
   do {									\
-    (L) = alpha_switch_to(virt_to_phys(&(N)->thread_info->pcb), (P));	\
+    (L) = alpha_switch_to(virt_to_phys(&task_thread_info(N)->pcb), (P));\
     check_mmu_context();						\
   } while (0)
 
Index: linux-2.6-mm/include/asm-arm/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm/processor.h	2005-05-31 01:18:59.131021591 +0200
+++ linux-2.6-mm/include/asm-arm/processor.h	2005-05-31 01:20:37.368146550 +0200
@@ -85,7 +85,7 @@ unsigned long get_wchan(struct task_stru
  */
 extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
-#define KSTK_REGS(tsk)	(((struct pt_regs *)(THREAD_START_SP + (unsigned long)(tsk)->thread_info)) - 1)
+#define KSTK_REGS(tsk)	(((struct pt_regs *)(THREAD_START_SP + (unsigned long)(tsk)->stack)) - 1)
 #define KSTK_EIP(tsk)	KSTK_REGS(tsk)->ARM_pc
 #define KSTK_ESP(tsk)	KSTK_REGS(tsk)->ARM_sp
 
Index: linux-2.6-mm/include/asm-arm/system.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm/system.h	2005-05-31 01:18:59.131021591 +0200
+++ linux-2.6-mm/include/asm-arm/system.h	2005-05-31 01:20:37.368146550 +0200
@@ -160,7 +160,7 @@ extern struct task_struct *__switch_to(s
 
 #define switch_to(prev,next,last)					\
 do {									\
-	last = __switch_to(prev,prev->thread_info,next->thread_info);	\
+	last = __switch_to(prev,task_thread_info(prev),task_thread_info(next));	\
 } while (0)
 
 /*
Index: linux-2.6-mm/include/asm-arm/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm/thread_info.h	2005-05-31 01:19:43.461406599 +0200
+++ linux-2.6-mm/include/asm-arm/thread_info.h	2005-05-31 01:20:37.368146550 +0200
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
--- linux-2.6-mm.orig/include/asm-arm26/system.h	2005-05-31 01:18:59.131021591 +0200
+++ linux-2.6-mm/include/asm-arm26/system.h	2005-05-31 01:20:37.369146378 +0200
@@ -111,7 +111,7 @@ extern struct task_struct *__switch_to(s
 
 #define switch_to(prev,next,last)					\
 do {									\
-	last = __switch_to(prev,prev->thread_info,next->thread_info);	\
+	last = __switch_to(prev,task_thread_info(prev),task_thread_info(next));	\
 } while (0)
 
 /*
Index: linux-2.6-mm/include/asm-arm26/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm26/thread_info.h	2005-05-31 01:19:43.462406428 +0200
+++ linux-2.6-mm/include/asm-arm26/thread_info.h	2005-05-31 01:20:37.369146378 +0200
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
--- linux-2.6-mm.orig/include/asm-cris/processor.h	2005-05-31 01:18:59.131021591 +0200
+++ linux-2.6-mm/include/asm-cris/processor.h	2005-05-31 01:20:37.369146378 +0200
@@ -43,7 +43,7 @@
  * Dito but for the currently running task
  */
 
-#define current_regs() user_regs(current->thread_info)
+#define current_regs() user_regs(task_thread_info(current))
 
 extern inline void prepare_to_copy(struct task_struct *tsk)
 {
Index: linux-2.6-mm/include/asm-i386/i387.h
===================================================================
--- linux-2.6-mm.orig/include/asm-i386/i387.h	2005-05-31 01:18:59.131021591 +0200
+++ linux-2.6-mm/include/asm-i386/i387.h	2005-05-31 01:20:37.369146378 +0200
@@ -39,19 +39,19 @@ static inline void __save_init_fpu( stru
 		asm volatile( "fnsave %0 ; fwait"
 			      : "=m" (tsk->thread.i387.fsave) );
 	}
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
Index: linux-2.6-mm/include/asm-i386/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-i386/processor.h	2005-05-31 01:18:59.131021591 +0200
+++ linux-2.6-mm/include/asm-i386/processor.h	2005-05-31 01:20:37.370146207 +0200
@@ -544,7 +544,7 @@ unsigned long get_wchan(struct task_stru
 #define task_pt_regs(task)                                             \
 ({                                                                     \
        struct pt_regs *__regs__;                                       \
-       __regs__ = (struct pt_regs *)KSTK_TOP((task)->thread_info);     \
+       __regs__ = (struct pt_regs *)KSTK_TOP((task)->stack);           \
        __regs__ - 1;                                                   \
 })
 
Index: linux-2.6-mm/include/asm-m68k/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m68k/thread_info.h	2005-05-31 01:19:43.461406599 +0200
+++ linux-2.6-mm/include/asm-m68k/thread_info.h	2005-05-31 01:20:37.370146207 +0200
@@ -54,7 +54,7 @@ extern int thread_flag_fixme(void);
 
 #define setup_thread_info(p, ti) do (ti)->task = p; while(0)
 
-#define end_of_stack(p) ((unsigned long *)(p)->thread_info + 1)
+#define end_of_stack(p) ((unsigned long *)(p)->stack + 1)
 
 /*
  * flag set/clear/test wrappers
Index: linux-2.6-mm/include/asm-mips/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-mips/processor.h	2005-05-31 01:18:59.131021591 +0200
+++ linux-2.6-mm/include/asm-mips/processor.h	2005-05-31 01:20:37.370146207 +0200
@@ -180,7 +180,7 @@ extern void start_thread(struct pt_regs 
 unsigned long get_wchan(struct task_struct *p);
 
 #define __PT_REG(reg) ((long)&((struct pt_regs *)0)->reg - sizeof(struct pt_regs))
-#define __KSTK_TOS(tsk) ((unsigned long)(tsk->thread_info) + THREAD_SIZE - 32)
+#define __KSTK_TOS(tsk) ((unsigned long)(tsk)->stack + THREAD_SIZE - 32)
 #define KSTK_EIP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_epc)))
 #define KSTK_ESP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(regs[29])))
 #define KSTK_STATUS(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_status)))
Index: linux-2.6-mm/include/asm-mips/system.h
===================================================================
--- linux-2.6-mm.orig/include/asm-mips/system.h	2005-05-31 01:18:59.131021591 +0200
+++ linux-2.6-mm/include/asm-mips/system.h	2005-05-31 01:20:37.371146035 +0200
@@ -156,7 +156,7 @@ struct task_struct;
 
 #define switch_to(prev,next,last) \
 do { \
-	(last) = resume(prev, next, next->thread_info); \
+	(last) = resume(prev, next, task_thread_info(next)); \
 } while(0)
 
 #define ROT_IN_PIECES							\
Index: linux-2.6-mm/include/asm-ppc64/ptrace-common.h
===================================================================
--- linux-2.6-mm.orig/include/asm-ppc64/ptrace-common.h	2005-05-31 01:18:59.131021591 +0200
+++ linux-2.6-mm/include/asm-ppc64/ptrace-common.h	2005-05-31 01:20:37.371146035 +0200
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
Index: linux-2.6-mm/include/asm-s390/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-s390/processor.h	2005-05-31 01:18:59.131021591 +0200
+++ linux-2.6-mm/include/asm-s390/processor.h	2005-05-31 01:20:37.371146035 +0200
@@ -192,7 +192,7 @@ extern void show_trace(struct task_struc
 
 unsigned long get_wchan(struct task_struct *p);
 #define __KSTK_PTREGS(tsk) ((struct pt_regs *) \
-        ((unsigned long) tsk->thread_info + THREAD_SIZE - sizeof(struct pt_regs)))
+        ((unsigned long)(tsk)->stack + THREAD_SIZE - sizeof(struct pt_regs)))
 #define KSTK_EIP(tsk)	(__KSTK_PTREGS(tsk)->psw.addr)
 #define KSTK_ESP(tsk)	(__KSTK_PTREGS(tsk)->gprs[15])
 
Index: linux-2.6-mm/include/asm-sparc/system.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sparc/system.h	2005-05-31 01:18:59.132021420 +0200
+++ linux-2.6-mm/include/asm-sparc/system.h	2005-05-31 01:20:37.371146035 +0200
@@ -156,7 +156,7 @@ extern void fpsave(unsigned long *fpregs
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
--- linux-2.6-mm.orig/include/asm-sparc64/elf.h	2005-05-31 01:18:59.132021420 +0200
+++ linux-2.6-mm/include/asm-sparc64/elf.h	2005-05-31 01:20:37.372145863 +0200
@@ -119,7 +119,7 @@ typedef struct {
 #endif
 
 #define ELF_CORE_COPY_TASK_REGS(__tsk, __elf_regs)	\
-	({ ELF_CORE_COPY_REGS((*(__elf_regs)), (__tsk)->thread_info->kregs); 1; })
+	({ ELF_CORE_COPY_REGS((*(__elf_regs)), task_thread_info(__tsk)->kregs); 1; })
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
Index: linux-2.6-mm/include/asm-sparc64/mmu_context.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sparc64/mmu_context.h	2005-05-31 01:18:59.132021420 +0200
+++ linux-2.6-mm/include/asm-sparc64/mmu_context.h	2005-05-31 01:20:37.372145863 +0200
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
--- linux-2.6-mm.orig/include/asm-sparc64/processor.h	2005-05-31 01:18:59.132021420 +0200
+++ linux-2.6-mm/include/asm-sparc64/processor.h	2005-05-31 01:20:37.372145863 +0200
@@ -187,8 +187,8 @@ extern pid_t kernel_thread(int (*fn)(voi
 
 extern unsigned long get_wchan(struct task_struct *task);
 
-#define KSTK_EIP(tsk)  ((tsk)->thread_info->kregs->tpc)
-#define KSTK_ESP(tsk)  ((tsk)->thread_info->kregs->u_regs[UREG_FP])
+#define KSTK_EIP(tsk)  (task_thread_info(tsk)->kregs->tpc)
+#define KSTK_ESP(tsk)  (task_thread_info(tsk)->kregs->u_regs[UREG_FP])
 
 #define cpu_relax()	barrier()
 
Index: linux-2.6-mm/include/asm-sparc64/system.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sparc64/system.h	2005-05-31 01:18:59.132021420 +0200
+++ linux-2.6-mm/include/asm-sparc64/system.h	2005-05-31 01:20:37.373145691 +0200
@@ -174,7 +174,7 @@ do {	if (test_thread_flag(TIF_PERFCTR)) 
 	/* If you are tempted to conditionalize the following */	\
 	/* so that ASI is only written if it changes, think again. */	\
 	__asm__ __volatile__("wr %%g0, %0, %%asi"			\
-	: : "r" (__thread_flag_byte_ptr(next->thread_info)[TI_FLAG_BYTE_CURRENT_DS]));\
+	: : "r" (__thread_flag_byte_ptr(task_thread_info(next))[TI_FLAG_BYTE_CURRENT_DS]));\
 	__asm__ __volatile__(						\
 	"mov	%%g4, %%g7\n\t"						\
 	"wrpr	%%g0, 0x95, %%pstate\n\t"				\
@@ -205,7 +205,7 @@ do {	if (test_thread_flag(TIF_PERFCTR)) 
 	"b,a ret_from_syscall\n\t"					\
 	"1:\n\t"							\
 	: "=&r" (last)							\
-	: "0" (next->thread_info),					\
+	: "0" (task_thread_info(next)),					\
 	  "i" (TI_WSTATE), "i" (TI_KSP), "i" (TI_FLAGS), "i" (TI_CWP),	\
 	  "i" (_TIF_NEWCHILD), "i" (TI_TASK)				\
 	: "cc",								\
Index: linux-2.6-mm/include/asm-v850/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-v850/processor.h	2005-05-31 01:18:59.132021420 +0200
+++ linux-2.6-mm/include/asm-v850/processor.h	2005-05-31 01:20:37.373145691 +0200
@@ -98,7 +98,7 @@ unsigned long get_wchan (struct task_str
 
 
 /* Return some info about the user process TASK.  */
-#define task_tos(task)	((unsigned long)(task)->thread_info + THREAD_SIZE)
+#define task_tos(task)	((unsigned long)(task)->stack + THREAD_SIZE)
 #define task_regs(task) ((struct pt_regs *)task_tos (task) - 1)
 #define task_sp(task)	(task_regs (task)->gpr[GPR_SP])
 #define task_pc(task)	(task_regs (task)->pc)
Index: linux-2.6-mm/include/asm-x86_64/i387.h
===================================================================
--- linux-2.6-mm.orig/include/asm-x86_64/i387.h	2005-05-31 01:18:59.132021420 +0200
+++ linux-2.6-mm/include/asm-x86_64/i387.h	2005-05-31 01:20:37.373145691 +0200
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
--- linux-2.6-mm.orig/include/linux/sched.h	2005-05-31 01:19:43.467405569 +0200
+++ linux-2.6-mm/include/linux/sched.h	2005-05-31 01:20:37.374145520 +0200
@@ -1160,7 +1160,7 @@ static inline void task_unlock(struct ta
 
 #ifndef __HAVE_THREAD_FUNCTIONS
 
-#define task_thread_info(task) (task)->thread_info
+#define task_thread_info(task) ((struct thread_info *)(task)->stack)
 
 static inline void setup_thread_stack(struct task_struct *p, struct task_struct *org)
 {
@@ -1170,7 +1170,7 @@ static inline void setup_thread_stack(st
 
 static inline unsigned long *end_of_stack(struct task_struct *p)
 {
-	return (unsigned long *)(p->thread_info + 1);
+	return (unsigned long *)(task_thread_info(p) + 1);
 }
 
 /* set thread flags in other task's structures
@@ -1265,7 +1265,7 @@ extern void recalc_sigpending(void);
 extern void signal_wake_up(struct task_struct *t, int resume_stopped);
 
 /*
- * Wrappers for p->thread_info->cpu access. No-op on UP.
+ * Wrappers for task_thread_info(p)->cpu access. No-op on UP.
  */
 #ifdef CONFIG_SMP
 
Index: linux-2.6-mm/arch/i386/kernel/kgdb_stub.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/kgdb_stub.c	2005-05-31 01:18:59.126022450 +0200
+++ linux-2.6-mm/arch/i386/kernel/kgdb_stub.c	2005-05-31 01:20:37.375145348 +0200
@@ -702,7 +702,7 @@ get_gdb_regs(struct task_struct *p, stru
 
 	if (p->state == TASK_RUNNING)
 		return;
-	stack_page = (unsigned long) p->thread_info;
+	stack_page = (unsigned long)p->stack;
 	if (gdb_regs[_ESP] < stack_page || gdb_regs[_ESP] >
 	    THREAD_SIZE - sizeof(long) + stack_page)
 		return;
Index: linux-2.6-mm/arch/xtensa/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/xtensa/kernel/process.c	2005-05-31 01:18:59.130021763 +0200
+++ linux-2.6-mm/arch/xtensa/kernel/process.c	2005-05-31 01:20:37.376145176 +0200
@@ -144,7 +144,7 @@ int copy_thread(int nr, unsigned long cl
 	int user_mode = user_mode(regs);
 
 	/* Set up new TSS. */
-	tos = (unsigned long)p->thread_info + THREAD_SIZE;
+	tos = (unsigned long)p->stack + THREAD_SIZE;
 	if (user_mode)
 		childregs = (struct pt_regs*)(tos - PT_USER_SIZE);
 	else
@@ -216,7 +216,7 @@ int kernel_thread(int (*fn)(void *), voi
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long sp, pc;
-	unsigned long stack_page = (unsigned long) p->thread_info;
+	unsigned long stack_page = (unsigned long)p->stack;
 	int count = 0;
 
 	if (!p || p == current || p->state == TASK_RUNNING)
Index: linux-2.6-mm/include/asm-xtensa/ptrace.h
===================================================================
--- linux-2.6-mm.orig/include/asm-xtensa/ptrace.h	2005-05-31 01:18:59.132021420 +0200
+++ linux-2.6-mm/include/asm-xtensa/ptrace.h	2005-05-31 01:20:37.376145176 +0200
@@ -114,7 +114,7 @@ struct pt_regs {
 
 #ifdef __KERNEL__
 # define xtensa_pt_regs(tsk) ((struct pt_regs*) \
-  (((long)(tsk)->thread_info + KERNEL_STACK_SIZE - (XCHAL_NUM_AREGS-16)*4)) - 1)
+  (((long)(tsk)->stack + KERNEL_STACK_SIZE - (XCHAL_NUM_AREGS-16)*4)) - 1)
 # define user_mode(regs) (((regs)->ps & 0x00000020)!=0)
 # define instruction_pointer(regs) ((regs)->pc)
 extern void show_regs(struct pt_regs *);
Index: linux-2.6-mm/arch/x86_64/kernel/kgdb_stub.c
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/kernel/kgdb_stub.c	2005-05-31 01:18:59.130021763 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/kgdb_stub.c	2005-05-31 01:20:37.377145004 +0200
@@ -717,7 +717,7 @@ get_gdb_regs(struct task_struct *p, stru
 	if (p->state == TASK_RUNNING)
 		return;
 	rsp0 = (unsigned long *)p->thread.rsp0;
-	if (rsp < (unsigned long *) p->thread_info || rsp > rsp0)
+	if (rsp < (unsigned long *)p->stack || rsp > rsp0)
 		return;
 	/* include/asm-i386/system.h:switch_to() pushes ebp last. */
 	do {
Index: linux-2.6-mm/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/smpboot.c	2005-05-31 01:18:59.126022450 +0200
+++ linux-2.6-mm/arch/i386/kernel/smpboot.c	2005-05-31 01:20:37.377145004 +0200
@@ -836,7 +836,7 @@ static inline struct task_struct * alloc
 		 * idle tread
 		 */
 		idle->thread.esp = (unsigned long)(((struct pt_regs *)
-			(THREAD_SIZE + (unsigned long) idle->thread_info)) - 1);
+			(THREAD_SIZE + (unsigned long)idle->stack)) - 1);
 		init_idle(idle, cpu);
 		return idle;
 	}
