Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291261AbSAaUIr>; Thu, 31 Jan 2002 15:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291262AbSAaUIk>; Thu, 31 Jan 2002 15:08:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:31872 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291261AbSAaUIN>;
	Thu, 31 Jan 2002 15:08:13 -0500
Date: Thu, 31 Jan 2002 12:06:33 -0800 (PST)
Message-Id: <20020131.120633.23012675.davem@redhat.com>
To: kernel@Expansa.sns.it
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 does not compile on sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0201311108550.16240-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.44.0201311108550.16240-100000@Expansa.sns.it>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Luigi Genoni <kernel@Expansa.sns.it>
   Date: Thu, 31 Jan 2002 11:14:45 +0100 (CET)

   I cannot compile kernel 2.5.3 on sparc64 platfom.
   My HW are some Ultra II (both dual and mono processor systems),
   with sparc64 II processor, and 1 GB RAM.
   
You'll need, at a minimum, the patch below to use 2.5.3
on sparc64.  I've already sent this to Linus:

diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc/kernel/rtrap.S linux/arch/sparc/kernel/rtrap.S
--- vanilla/linux/arch/sparc/kernel/rtrap.S	Mon Jan 28 15:14:23 2002
+++ linux/arch/sparc/kernel/rtrap.S	Wed Jan 30 19:30:05 2002
@@ -1,4 +1,4 @@
-/* $Id: rtrap.S,v 1.57 2001/07/17 16:17:33 anton Exp $
+/* $Id: rtrap.S,v 1.58 2002/01/31 03:30:05 davem Exp $
  * rtrap.S: Return from Sparc trap low-level code.
  *
  * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc/kernel/systbls.S linux/arch/sparc/kernel/systbls.S
--- vanilla/linux/arch/sparc/kernel/systbls.S	Sun Oct 21 10:36:54 2001
+++ linux/arch/sparc/kernel/systbls.S	Wed Jan 30 19:30:05 2002
@@ -1,4 +1,4 @@
-/* $Id: systbls.S,v 1.101 2001/10/18 08:27:05 davem Exp $
+/* $Id: systbls.S,v 1.102 2002/01/31 03:30:05 davem Exp $
  * systbls.S: System call entry point tables for OS compatibility.
  *            The native Linux system call table lives here also.
  *
@@ -51,11 +51,11 @@
 /*150*/	.long sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
 /*155*/	.long sys_fcntl64, sys_nis_syscall, sys_statfs, sys_fstatfs, sys_oldumount
 /*160*/	.long sys_nis_syscall, sys_nis_syscall, sys_getdomainname, sys_setdomainname, sys_nis_syscall
-/*165*/	.long sys_quotactl, sys_nis_syscall, sys_mount, sys_ustat, sys_nis_syscall
-/*170*/	.long sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_getdents
-/*175*/	.long sys_setsid, sys_fchdir, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
-/*180*/	.long sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_sigpending, sys_query_module
-/*185*/	.long sys_setpgid, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_newuname
+/*165*/	.long sys_quotactl, sys_nis_syscall, sys_mount, sys_ustat, sys_setxattr
+/*170*/	.long sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys_getdents
+/*175*/	.long sys_setsid, sys_fchdir, sys_fgetxattr, sys_listxattr, sys_llistxattr
+/*180*/	.long sys_flistxattr, sys_removexattr, sys_lremovexattr, sys_sigpending, sys_query_module
+/*185*/	.long sys_setpgid, sys_fremovexattr, sys_nis_syscall, sys_nis_syscall, sys_newuname
 /*190*/	.long sys_init_module, sys_personality, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
 /*195*/	.long sys_nis_syscall, sys_nis_syscall, sys_getppid, sparc_sigaction, sys_sgetmask
 /*200*/	.long sys_ssetmask, sys_sigsuspend, sys_newlstat, sys_uselib, old_readdir
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/kernel/entry.S linux/arch/sparc64/kernel/entry.S
--- vanilla/linux/arch/sparc64/kernel/entry.S	Mon Jan 14 10:10:44 2002
+++ linux/arch/sparc64/kernel/entry.S	Wed Jan 30 19:30:06 2002
@@ -1,4 +1,4 @@
-/* $Id: entry.S,v 1.141 2001/12/05 23:56:32 davem Exp $
+/* $Id: entry.S,v 1.142 2002/01/31 03:30:06 davem Exp $
  * arch/sparc64/kernel/entry.S:  Sparc64 trap low-level entry points.
  *
  * Copyright (C) 1995,1997 David S. Miller (davem@caip.rutgers.edu)
@@ -1384,8 +1384,8 @@
 		 add		%o7, 1f-.-4, %o7
 		nop
 		.align		32
-1:		ldx		[%curptr + AOFF_task_ptrace], %l5
-		andcc		%l5, 0x02, %g0
+1:		ldub		[%curptr + AOFF_task_work + 1], %l5
+		andcc		%l5, 0xff, %g0
 		be,pt		%icc, rtrap
 		 clr		%l6
 		call		syscall_trace
@@ -1510,11 +1510,11 @@
 	mov		%i4, %o4				! IEU1
 	lduw		[%l7 + %l4], %l7			! Load
 	srl		%i1, 0, %o1				! IEU0	Group
-	ldx		[%curptr + AOFF_task_ptrace], %l0	! Load
+	ldub		[%curptr + AOFF_task_work + 1], %l0	! Load
 
 	mov		%i5, %o5				! IEU1
 	srl		%i2, 0, %o2				! IEU0	Group
-	andcc		%l0, 0x02, %g0				! IEU0	Group
+	andcc		%l0, 0xff, %g0				! IEU0	Group
 	bne,pn		%icc, linux_syscall_trace32		! CTI
 	 mov		%i0, %l5				! IEU1
 	call		%l7					! CTI	Group brk forced
@@ -1538,11 +1538,11 @@
 	mov		%i1, %o1				! IEU1
 	lduw		[%l7 + %l4], %l7			! Load
 4:	mov		%i2, %o2				! IEU0	Group
-	ldx		[%curptr + AOFF_task_ptrace], %l0	! Load
+	ldub		[%curptr + AOFF_task_work + 1], %l0	! Load
 
 	mov		%i3, %o3				! IEU1
 	mov		%i4, %o4				! IEU0	Group
-	andcc		%l0, 0x02, %g0				! IEU1	Group+1 bubble
+	andcc		%l0, 0xff, %g0				! IEU1	Group+1 bubble
 	bne,pn		%icc, linux_syscall_trace		! CTI	Group
 	 mov		%i0, %l5				! IEU0
 2:	call		%l7					! CTI	Group brk forced
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/kernel/process.c linux/arch/sparc64/kernel/process.c
--- vanilla/linux/arch/sparc64/kernel/process.c	Mon Jan 28 15:14:23 2002
+++ linux/arch/sparc64/kernel/process.c	Wed Jan 30 19:30:06 2002
@@ -1,4 +1,4 @@
-/*  $Id: process.c,v 1.129 2002/01/23 11:27:32 davem Exp $
+/*  $Id: process.c,v 1.130 2002/01/31 03:30:06 davem Exp $
  *  arch/sparc64/kernel/process.c
  *
  *  Copyright (C) 1995, 1996 David S. Miller (davem@caip.rutgers.edu)
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/kernel/ptrace.c linux/arch/sparc64/kernel/ptrace.c
--- vanilla/linux/arch/sparc64/kernel/ptrace.c	Mon Oct  1 09:19:56 2001
+++ linux/arch/sparc64/kernel/ptrace.c	Wed Jan 30 14:27:32 2002
@@ -538,10 +538,13 @@
 			child->thread.kregs->tnpc = ((addr + 4) & pc_mask);
 		}
 
-		if (request == PTRACE_SYSCALL)
-			child->ptrace |= PT_TRACESYS;
-		else
-			child->ptrace &= ~PT_TRACESYS;
+		if (request == PTRACE_SYSCALL) {
+			child->ptrace |= PT_SYSCALLTRACE;
+			child->work.syscall_trace++;
+		} else {
+			child->ptrace &= ~PT_SYSCALLTRACE;
+			child->work.syscall_trace--;
+		}
 
 		child->exit_code = data;
 #ifdef DEBUG_PTRACE
@@ -621,8 +624,8 @@
 #ifdef DEBUG_PTRACE
 	printk("%s [%d]: syscall_trace\n", current->comm, current->pid);
 #endif
-	if ((current->ptrace & (PT_PTRACED|PT_TRACESYS))
-	    != (PT_PTRACED|PT_TRACESYS))
+	if ((current->ptrace & (PT_PTRACED|PT_SYSCALLTRACE))
+	    != (PT_PTRACED|PT_SYSCALLTRACE))
 		return;
 	current->exit_code = SIGTRAP;
 	current->state = TASK_STOPPED;
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/kernel/rtrap.S linux/arch/sparc64/kernel/rtrap.S
--- vanilla/linux/arch/sparc64/kernel/rtrap.S	Mon Jan 28 15:14:23 2002
+++ linux/arch/sparc64/kernel/rtrap.S	Wed Jan 30 19:30:06 2002
@@ -1,4 +1,4 @@
-/* $Id: rtrap.S,v 1.59 2002/01/11 08:45:38 davem Exp $
+/* $Id: rtrap.S,v 1.60 2002/01/31 03:30:06 davem Exp $
  * rtrap.S: Preparing for return from trap on Sparc V9.
  *
  * Copyright (C) 1997,1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
@@ -20,8 +20,8 @@
 
 		/* Register %l6 keeps track of whether we are returning
 		 * from a system call or not.  It is cleared if we call
-		 * do_signal, and it must not be otherwise modified until
-		 * we fully commit to returning to userspace.
+		 * do_notify_resume, and it must not be otherwise modified
+		 * until we fully commit to returning to userspace.
 		 */
 
 		.text
@@ -42,22 +42,26 @@
 		 wrpr			%g0, RTRAP_PSTATE, %pstate
 		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
 		/* Redo sched+sig checks */
-#error		ldx			[%g6 + AOFF_task_need_resched], %l0
-		brz,pt			%l0, 1f
+		lduw			[%g6 + AOFF_task_work], %l0
+		srlx			%l0, 24, %o0
+
+		brz,pt			%o0, 1f
 		 nop
 		call			schedule
-
 		 wrpr			%g0, RTRAP_PSTATE, %pstate
 		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
-#error1:		lduw			[%g6 + AOFF_task_sigpending], %l0
-		brz,pt			%l0, __handle_user_windows_continue
+		lduw			[%g6 + AOFF_task_work], %l0
+
+1:		sllx			%l0, 48, %o0
+		brz,pt			%o0, __handle_user_windows_continue
 		 nop
 		clr			%o0
 		mov			%l5, %o2
 		mov			%l6, %o3
-
 		add			%sp, STACK_BIAS + REGWIN_SZ, %o1
-		call			do_signal
+		mov			%l0, %o4
+
+		call			do_notify_resume
 		 wrpr			%g0, RTRAP_PSTATE, %pstate
 		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
 		clr			%l6
@@ -67,8 +71,8 @@
 		ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
 		sethi			%hi(0xf << 20), %l4
 		and			%l1, %l4, %l4
-
 		ba,pt			%xcc, __handle_user_windows_continue
+
 		 andn			%l1, %l4, %l1
 __handle_perfctrs:
 		call			update_perfctrs
@@ -77,27 +81,31 @@
 		ldub			[%g6 + AOFF_task_thread + AOFF_thread_w_saved], %o2
 		brz,pt			%o2, 1f
 		 nop
-
 		/* Redo userwin+sched+sig checks */
 		call			fault_in_user_windows
+
 		 wrpr			%g0, RTRAP_PSTATE, %pstate
 		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
-#error 1:		ldx			[%g6 + AOFF_task_need_resched], %l0
-		brz,pt			%l0, 1f
+		lduw			[%g6 + AOFF_task_work], %l0
+		srlx			%l0, 24, %o0
+		brz,pt			%o0, 1f
+
 		 nop
 		call			schedule
 		 wrpr			%g0, RTRAP_PSTATE, %pstate
-
 		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
-#error 1:		lduw			[%g6 + AOFF_task_sigpending], %l0
-		brz,pt			%l0, __handle_perfctrs_continue
+		lduw			[%g6 + AOFF_task_work], %l0
+1:		sllx			%l0, 48, %o0
+
+		brz,pt			%o0, __handle_perfctrs_continue
 		 sethi			%hi(TSTATE_PEF), %o0
 		clr			%o0
 		mov			%l5, %o2
 		mov			%l6, %o3
 		add			%sp, STACK_BIAS + REGWIN_SZ, %o1
+		mov			%l0, %o4
+		call			do_notify_resume
 
-		call			do_signal
 		 wrpr			%g0, RTRAP_PSTATE, %pstate
 		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
 		clr			%l6
@@ -108,8 +116,8 @@
 		sethi			%hi(0xf << 20), %l4
 		and			%l1, %l4, %l4
 		andn			%l1, %l4, %l1
-
 		ba,pt			%xcc, __handle_perfctrs_continue
+
 		 sethi			%hi(TSTATE_PEF), %o0
 __handle_userfpu:
 		rd			%fprs, %l5
@@ -124,7 +132,8 @@
 		mov			%l5, %o2
 		mov			%l6, %o3
 		add			%sp, STACK_BIAS + REGWIN_SZ, %o1
-		call			do_signal
+		mov			%l0, %o4
+		call			do_notify_resume
 		 wrpr			%g0, RTRAP_PSTATE, %pstate
 		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
 		clr			%l6
@@ -173,13 +182,13 @@
 		 */
 to_user:	wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
 __handle_preemption_continue:
-#error		ldx			[%g6 + AOFF_task_need_resched], %l0
-		brnz,pn			%l0, __handle_preemption
-#error		 lduw			[%g6 + AOFF_task_sigpending], %l0
-		brnz,pn			%l0, __handle_signal
-		 nop
+		lduw			[%g6 + AOFF_task_work], %l0
+		srlx			%l0, 24, %o0
+		brnz,pn			%o0, __handle_preemption
+		 sllx			%l0, 48, %o0
+		brnz,pn			%o0, __handle_signal
 __handle_signal_continue:
-		ldub			[%g6 + AOFF_task_thread + AOFF_thread_w_saved], %o2
+		 ldub			[%g6 + AOFF_task_thread + AOFF_thread_w_saved], %o2
 		brnz,pn			%o2, __handle_user_windows
 		 nop
 __handle_user_windows_continue:
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/kernel/signal.c linux/arch/sparc64/kernel/signal.c
--- vanilla/linux/arch/sparc64/kernel/signal.c	Mon Jan 14 10:10:44 2002
+++ linux/arch/sparc64/kernel/signal.c	Wed Jan 30 19:30:06 2002
@@ -1,4 +1,4 @@
-/*  $Id: signal.c,v 1.57 2001/12/11 04:55:51 davem Exp $
+/*  $Id: signal.c,v 1.58 2002/01/31 03:30:06 davem Exp $
  *  arch/sparc64/kernel/signal.c
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
@@ -32,8 +32,8 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-asmlinkage int do_signal(sigset_t *oldset, struct pt_regs * regs,
-			 unsigned long orig_o0, int ret_from_syscall);
+static int do_signal(sigset_t *oldset, struct pt_regs * regs,
+		     unsigned long orig_o0, int ret_from_syscall);
 
 /* This turned off for production... */
 /* #define DEBUG_SIGNALS 1 */
@@ -688,8 +688,8 @@
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-asmlinkage int do_signal(sigset_t *oldset, struct pt_regs * regs,
-			 unsigned long orig_i0, int restart_syscall)
+static int do_signal(sigset_t *oldset, struct pt_regs * regs,
+		     unsigned long orig_i0, int restart_syscall)
 {
 	unsigned long signr;
 	siginfo_t info;
@@ -700,8 +700,8 @@
 
 #ifdef CONFIG_SPARC32_COMPAT
 	if (current->thread.flags & SPARC_FLAG_32BIT) {
-		extern asmlinkage int do_signal32(sigset_t *, struct pt_regs *,
-						  unsigned long, int);
+		extern int do_signal32(sigset_t *, struct pt_regs *,
+				       unsigned long, int);
 		return do_signal32(oldset, regs, orig_i0, restart_syscall);
 	}
 #endif	
@@ -829,4 +829,16 @@
 		regs->tnpc -= 4;
 	}
 	return 0;
+}
+
+void do_notify_resume(sigset_t *oldset, struct pt_regs *regs,
+		      unsigned long orig_i0, int restart_syscall,
+		      unsigned int work_pending)
+{
+	/* We don't pass in the task_work struct as a struct because
+	 * GCC always bounces that onto the stack due to the
+	 * ABI calling conventions.
+	 */
+	if (work_pending & 0x0000ff00)
+		do_signal(oldset, regs, orig_i0, restart_syscall);
 }
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/kernel/signal32.c linux/arch/sparc64/kernel/signal32.c
--- vanilla/linux/arch/sparc64/kernel/signal32.c	Mon Jan 14 10:10:44 2002
+++ linux/arch/sparc64/kernel/signal32.c	Wed Jan 30 19:30:06 2002
@@ -1,4 +1,4 @@
-/*  $Id: signal32.c,v 1.71 2001/12/11 04:55:51 davem Exp $
+/*  $Id: signal32.c,v 1.72 2002/01/31 03:30:06 davem Exp $
  *  arch/sparc64/kernel/signal32.c
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
@@ -30,8 +30,8 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-asmlinkage int do_signal32(sigset_t *oldset, struct pt_regs *regs,
-			 unsigned long orig_o0, int ret_from_syscall);
+int do_signal32(sigset_t *oldset, struct pt_regs *regs,
+		unsigned long orig_o0, int ret_from_syscall);
 
 /* This turned off for production... */
 /* #define DEBUG_SIGNALS 1 */
@@ -1357,8 +1357,8 @@
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-asmlinkage int do_signal32(sigset_t *oldset, struct pt_regs * regs,
-			   unsigned long orig_i0, int restart_syscall)
+int do_signal32(sigset_t *oldset, struct pt_regs * regs,
+		unsigned long orig_i0, int restart_syscall)
 {
 	unsigned long signr;
 	struct k_sigaction *ka;
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/kernel/smp.c linux/arch/sparc64/kernel/smp.c
--- vanilla/linux/arch/sparc64/kernel/smp.c	Wed Jan 23 15:28:40 2002
+++ linux/arch/sparc64/kernel/smp.c	Wed Jan 30 19:37:41 2002
@@ -218,12 +218,8 @@
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 
-	init_idle();
-
 	while (!smp_threads_ready)
 		membar("#LoadLoad");
-
-	idle_startup_done();
 }
 
 void cpu_panic(void)
@@ -242,6 +238,8 @@
  */
 static struct task_struct *cpu_new_task = NULL;
 
+static void smp_tune_scheduling(void);
+
 void __init smp_boot_cpus(void)
 {
 	int cpucount = 0, i;
@@ -250,15 +248,17 @@
 	__sti();
 	smp_store_cpu_info(boot_cpu_id);
 
-	if (linux_num_cpus == 1)
+	if (linux_num_cpus == 1) {
+		smp_tune_scheduling();
 		return;
+	}
 
 	for (i = 0; i < NR_CPUS; i++) {
 		if (i == boot_cpu_id)
 			continue;
 
 		if ((cpucount + 1) == max_cpus)
-			break;
+			goto ignorecpu;
 		if (cpu_present_map & (1UL << i)) {
 			unsigned long entry = (unsigned long)(&sparc64_cpu_startup);
 			unsigned long cookie = (unsigned long)(&cpu_new_task);
@@ -272,7 +272,7 @@
 
 			p = init_task.prev_task;
 
-			p->cpu = i;
+			init_idle(p, i);
 
 			unhash_process(p);
 
@@ -300,13 +300,15 @@
 			}
 		}
 		if (!callin_flag) {
+ignorecpu:
 			cpu_present_map &= ~(1UL << i);
 			__cpu_number_map[i] = -1;
 		}
 	}
 	cpu_new_task = NULL;
 	if (cpucount == 0) {
-		printk("Error: only one processor found.\n");
+		if (max_cpus != 1)
+			printk("Error: only one processor found.\n");
 		cpu_present_map = (1UL << smp_processor_id());
 	} else {
 		unsigned long bogosum = 0;
@@ -322,6 +324,12 @@
 		smp_activated = 1;
 		smp_num_cpus = cpucount + 1;
 	}
+
+	/* We want to run this with all the other cpus spinning
+	 * in the kernel.
+	 */
+	smp_tune_scheduling();
+
 	smp_processors_ready = 1;
 	membar("#StoreStore | #StoreLoad");
 }
@@ -1170,27 +1178,94 @@
 	prof_counter(boot_cpu_id) = prof_multiplier(boot_cpu_id) = 1;
 }
 
-static inline unsigned long find_flush_base(unsigned long size)
+cycles_t cacheflush_time;
+unsigned long cache_decay_ticks;
+
+extern unsigned long cheetah_tune_scheduling(void);
+extern unsigned long timer_ticks_per_usec_quotient;
+
+static void __init smp_tune_scheduling(void)
 {
-	struct page *p = mem_map;
-	unsigned long found, base;
+	unsigned long orig_flush_base, flush_base, flags, *p;
+	unsigned int ecache_size, order;
+	cycles_t tick1, tick2, raw;
 
-	size = PAGE_ALIGN(size);
-	found = size;
-	base = (unsigned long) page_address(p);
-	while (found != 0) {
-		/* Failure. */
-		if (p >= (mem_map + max_mapnr))
-			return 0UL;
-		if (PageReserved(p)) {
-			found = size;
-			base = (unsigned long) page_address(p);
-		} else {
-			found -= PAGE_SIZE;
-		}
-		p++;
+	/* Approximate heuristic for SMP scheduling.  It is an
+	 * estimation of the time it takes to flush the L2 cache
+	 * on the local processor.
+	 *
+	 * The ia32 chooses to use the L1 cache flush time instead,
+	 * and I consider this complete nonsense.  The Ultra can service
+	 * a miss to the L1 with a hit to the L2 in 7 or 8 cycles, and
+	 * L2 misses are what create extra bus traffic (ie. the "cost"
+	 * of moving a process from one cpu to another).
+	 */
+	printk("SMP: Calibrating ecache flush... ");
+	if (tlb_type == cheetah) {
+		cacheflush_time = cheetah_tune_scheduling();
+		goto report;
+	}
+
+	ecache_size = prom_getintdefault(linux_cpus[0].prom_node,
+					 "ecache-size", (512 * 1024));
+	if (ecache_size > (4 * 1024 * 1024))
+		ecache_size = (4 * 1024 * 1024);
+	orig_flush_base = flush_base =
+		__get_free_pages(GFP_KERNEL, order = get_order(ecache_size));
+
+	if (flush_base != 0UL) {
+		__save_and_cli(flags);
+
+		/* Scan twice the size once just to get the TLB entries
+		 * loaded and make sure the second scan measures pure misses.
+		 */
+		for (p = (unsigned long *)flush_base;
+		     ((unsigned long)p) < (flush_base + (ecache_size<<1));
+		     p += (64 / sizeof(unsigned long)))
+			*((volatile unsigned long *)p);
+
+		/* Now the real measurement. */
+		__asm__ __volatile__("
+		b,pt	%%xcc, 1f
+		 rd	%%tick, %0
+
+		.align	64
+1:		ldx	[%2 + 0x000], %%g1
+		ldx	[%2 + 0x040], %%g2
+		ldx	[%2 + 0x080], %%g3
+		ldx	[%2 + 0x0c0], %%g5
+		add	%2, 0x100, %2
+		cmp	%2, %4
+		bne,pt	%%xcc, 1b
+		 nop
+	
+		rd	%%tick, %1"
+		: "=&r" (tick1), "=&r" (tick2), "=&r" (flush_base)
+		: "2" (flush_base), "r" (flush_base + ecache_size)
+		: "g1", "g2", "g3", "g5");
+
+		__restore_flags(flags);
+
+		raw = (tick2 - tick1);
+
+		/* Dampen it a little, considering two processes
+		 * sharing the cache and fitting.
+		 */
+		cacheflush_time = (raw - (raw >> 2));
+
+		free_pages(orig_flush_base, order);
+	} else {
+		cacheflush_time = ((ecache_size << 2) +
+				   (ecache_size << 1));
 	}
-	return base;
+report:
+	/* Convert cpu ticks to jiffie ticks. */
+	cache_decay_ticks = ((long)cacheflush_time * timer_ticks_per_usec_quotient);
+	cache_decay_ticks >>= 32UL;
+	cache_decay_ticks = (cache_decay_ticks * HZ) / 1000;
+
+	printk("Using heuristic of %ld cycles, %ld ticks.\n",
+	       cacheflush_time, cache_decay_ticks);
 }
 
 /* /proc/profile writes can call this, don't __init it please. */
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/kernel/systbls.S linux/arch/sparc64/kernel/systbls.S
--- vanilla/linux/arch/sparc64/kernel/systbls.S	Sun Oct 21 10:36:54 2001
+++ linux/arch/sparc64/kernel/systbls.S	Wed Jan 30 19:30:06 2002
@@ -1,4 +1,4 @@
-/* $Id: systbls.S,v 1.79 2001/10/18 08:27:05 davem Exp $
+/* $Id: systbls.S,v 1.80 2002/01/31 03:30:06 davem Exp $
  * systbls.S: System call entry point tables for OS compatibility.
  *            The native Linux system call table lives here also.
  *
@@ -52,11 +52,11 @@
 /*150*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
 	.word sys32_fcntl64, sys_nis_syscall, sys32_statfs, sys32_fstatfs, sys_oldumount
 /*160*/	.word sys_nis_syscall, sys_nis_syscall, sys_getdomainname, sys_setdomainname, sys_nis_syscall
-	.word sys32_quotactl, sys_nis_syscall, sys32_mount, sys_ustat, sys_nis_syscall
-/*170*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys32_getdents
-	.word sys_setsid, sys_fchdir, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
-/*180*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys32_sigpending, sys32_query_module
-	.word sys_setpgid, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sparc64_newuname
+	.word sys32_quotactl, sys_nis_syscall, sys32_mount, sys_ustat, sys_setxattr
+/*170*/	.word sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys32_getdents
+	.word sys_setsid, sys_fchdir, sys_fgetxattr, sys_listxattr, sys_llistxattr
+/*180*/	.word sys_flistxattr, sys_removexattr, sys_lremovexattr, sys32_sigpending, sys32_query_module
+	.word sys_setpgid, sys_fremovexattr, sys_nis_syscall, sys_nis_syscall, sparc64_newuname
 /*190*/	.word sys32_init_module, sparc64_personality, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
 	.word sys_nis_syscall, sys_nis_syscall, sys_getppid, sys32_sigaction, sys_sgetmask
 /*200*/	.word sys_ssetmask, sys_sigsuspend, sys32_newlstat, sys_uselib, old32_readdir
@@ -111,11 +111,11 @@
 /*150*/	.word sys_getsockname, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
 	.word sys_nis_syscall, sys_nis_syscall, sys_statfs, sys_fstatfs, sys_oldumount
 /*160*/	.word sys_nis_syscall, sys_nis_syscall, sys_getdomainname, sys_setdomainname, sys_utrap_install
-	.word sys_quotactl, sys_nis_syscall, sys_mount, sys_ustat, sys_nis_syscall
-/*170*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_getdents
-	.word sys_setsid, sys_fchdir, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
-/*180*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_query_module
-	.word sys_setpgid, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sparc64_newuname
+	.word sys_quotactl, sys_nis_syscall, sys_mount, sys_ustat, sys_setxattr
+/*170*/	.word sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys_getdents
+	.word sys_setsid, sys_fchdir, sys_fgetxattr, sys_listxattr, sys_llistxattr
+/*180*/	.word sys_flistxattr, sys_removexattr, sys_lremovexattr, sys_nis_syscall, sys_query_module
+	.word sys_setpgid, sys_fremovexattr, sys_nis_syscall, sys_nis_syscall, sparc64_newuname
 /*190*/	.word sys_init_module, sparc64_personality, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
 	.word sys_nis_syscall, sys_nis_syscall, sys_getppid, sys_nis_syscall, sys_sgetmask
 /*200*/	.word sys_ssetmask, sys_nis_syscall, sys_newlstat, sys_uselib, sys_nis_syscall
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/kernel/traps.c linux/arch/sparc64/kernel/traps.c
--- vanilla/linux/arch/sparc64/kernel/traps.c	Mon Jan 14 10:10:44 2002
+++ linux/arch/sparc64/kernel/traps.c	Tue Jan 29 17:39:56 2002
@@ -1,4 +1,4 @@
-/* $Id: traps.c,v 1.83 2002/01/11 08:45:38 davem Exp $
+/* $Id: traps.c,v 1.84 2002/01/30 01:39:56 davem Exp $
  * arch/sparc64/kernel/traps.c
  *
  * Copyright (C) 1995,1997 David S. Miller (davem@caip.rutgers.edu)
@@ -526,6 +526,21 @@
 			     : "r" (physaddr), "r" (alias),
 			       "i" (ASI_PHYS_USE_EC));
 }
+
+#ifdef CONFIG_SMP
+unsigned long cheetah_tune_scheduling(void)
+{
+	unsigned long tick1, tick2, raw;
+
+	__asm__ __volatile__("rd %%tick, %0" : "=r" (tick1));
+	cheetah_flush_ecache();
+	__asm__ __volatile__("rd %%tick, %0" : "=r" (tick2));
+
+	raw = (tick2 - tick1);
+
+	return (raw - (raw >> 2));
+}
+#endif
 
 /* Unfortunately, the diagnostic access to the I-cache tags we need to
  * use to clear the thing interferes with I-cache coherency transactions.
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/include/asm-sparc/unistd.h linux/include/asm-sparc/unistd.h
--- vanilla/linux/include/asm-sparc/unistd.h	Sun Oct 21 10:36:54 2001
+++ linux/include/asm-sparc/unistd.h	Wed Jan 30 19:30:13 2002
@@ -1,4 +1,4 @@
-/* $Id: unistd.h,v 1.72 2001/10/18 08:27:05 davem Exp $ */
+/* $Id: unistd.h,v 1.73 2002/01/31 03:30:13 davem Exp $ */
 #ifndef _SPARC_UNISTD_H
 #define _SPARC_UNISTD_H
 
@@ -184,24 +184,24 @@
 /* #define __NR_exportfs        166    SunOS Specific                              */
 #define __NR_mount              167 /* Common                                      */
 #define __NR_ustat              168 /* Common                                      */
-/* #define __NR_semsys          169    SunOS Specific                              */
-/* #define __NR_msgsys          170    SunOS Specific                              */
-/* #define __NR_shmsys          171    SunOS Specific                              */
-/* #define __NR_auditsys        172    SunOS Specific                              */
-/* #define __NR_rfssys          173    SunOS Specific                              */
+#define __NR_setxattr           169 /* SunOS: semsys                               */
+#define __NR_lsetxattr          170 /* SunOS: msgsys                               */
+#define __NR_fsetxattr          171 /* SunOS: shmsys                               */
+#define __NR_getxattr           172 /* SunOS: auditsys                             */
+#define __NR_lgetxattr          173 /* SunOS: rfssys                               */
 #define __NR_getdents           174 /* Common                                      */
 #define __NR_setsid             175 /* Common                                      */
 #define __NR_fchdir             176 /* Common                                      */
-/* #define __NR_fchroot         177    SunOS Specific                              */
-/* #define __NR_vpixsys         178    SunOS Specific                              */
-/* #define __NR_aioread         179    SunOS Specific                              */
-/* #define __NR_aiowrite        180    SunOS Specific                              */
-/* #define __NR_aiowait         181    SunOS Specific                              */
-/* #define __NR_aiocancel       182    SunOS Specific                              */
+#define __NR_fgetxattr          177 /* SunOS: fchroot                              */
+#define __NR_listxattr          178 /* SunOS: vpixsys                              */
+#define __NR_llistxattr         179 /* SunOS: aioread                              */
+#define __NR_flistxattr         180 /* SunOS: aiowrite                             */
+#define __NR_removexattr        181 /* SunOS: aiowait                              */
+#define __NR_lremovexattr       182 /* SunOS: aiocancel                            */
 #define __NR_sigpending         183 /* Common                                      */
 #define __NR_query_module	184 /* Linux Specific				   */
 #define __NR_setpgid            185 /* Common                                      */
-/* #define __NR_pathconf        186    SunOS Specific                              */
+#define __NR_fremovexattr       186 /* SunOS: pathconf                             */
 /* #define __NR_fpathconf       187    SunOS Specific                              */
 /* #define __NR_sysconf         188    SunOS Specific                              */
 #define __NR_uname              189 /* Linux Specific                              */
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/include/asm-sparc64/bitops.h linux/include/asm-sparc64/bitops.h
--- vanilla/linux/include/asm-sparc64/bitops.h	Mon Jan 14 10:10:44 2002
+++ linux/include/asm-sparc64/bitops.h	Tue Jan 29 17:40:00 2002
@@ -1,4 +1,4 @@
-/* $Id: bitops.h,v 1.38 2001/11/19 18:36:34 davem Exp $
+/* $Id: bitops.h,v 1.39 2002/01/30 01:40:00 davem Exp $
  * bitops.h: Bit string operations on the V9.
  *
  * Copyright 1996, 1997 David S. Miller (davem@caip.rutgers.edu)
@@ -64,54 +64,38 @@
 #define smp_mb__before_clear_bit()	do { } while(0)
 #define smp_mb__after_clear_bit()	do { } while(0)
 
-extern __inline__ int test_bit(int nr, __const__ void *addr)
+static __inline__ int test_bit(int nr, __const__ void *addr)
 {
 	return (1UL & (((__const__ long *) addr)[nr >> 6] >> (nr & 63))) != 0UL;
 }
 
 /* The easy/cheese version for now. */
-extern __inline__ unsigned long ffz(unsigned long word)
+static __inline__ unsigned long ffz(unsigned long word)
 {
 	unsigned long result;
 
-#ifdef ULTRA_HAS_POPULATION_COUNT	/* Thanks for nothing Sun... */
-	__asm__ __volatile__(
-"	brz,pn	%0, 1f\n"
-"	 neg	%0, %%g1\n"
-"	xnor	%0, %%g1, %%g2\n"
-"	popc	%%g2, %0\n"
-"1:	" : "=&r" (result)
-	  : "0" (word)
-	  : "g1", "g2");
-#else
-#if 1 /* def EASY_CHEESE_VERSION */
 	result = 0;
 	while(word & 1) {
 		result++;
 		word >>= 1;
 	}
-#else
-	unsigned long tmp;
+	return result;
+}
 
-	result = 0;	
-	tmp = ~word & -~word;
-	if (!(unsigned)tmp) {
-		tmp >>= 32;
-		result = 32;
-	}
-	if (!(unsigned short)tmp) {
-		tmp >>= 16;
-		result += 16;
-	}
-	if (!(unsigned char)tmp) {
-		tmp >>= 8;
-		result += 8;
-	}
-	if (tmp & 0xf0) result += 4;
-	if (tmp & 0xcc) result += 2;
-	if (tmp & 0xaa) result ++;
-#endif
-#endif
+/**
+ * __ffs - find first bit in word.
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+static __inline__ unsigned long __ffs(unsigned long word)
+{
+	unsigned long result = 0;
+
+	while (!(word & 1UL)) {
+		result++;
+		word >>= 1;
+	}
 	return result;
 }
 
@@ -122,8 +106,12 @@
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-
-#define ffs(x) generic_ffs(x)
+static __inline__ int ffs(int x)
+{
+	if (!x)
+		return 0;
+	return __ffs((unsigned long)x);
+}
 
 /*
  * hweightN: returns the hamming weight (i.e. the number
@@ -132,7 +120,7 @@
 
 #ifdef ULTRA_HAS_POPULATION_COUNT
 
-extern __inline__ unsigned int hweight32(unsigned int w)
+static __inline__ unsigned int hweight32(unsigned int w)
 {
 	unsigned int res;
 
@@ -140,7 +128,7 @@
 	return res;
 }
 
-extern __inline__ unsigned int hweight16(unsigned int w)
+static __inline__ unsigned int hweight16(unsigned int w)
 {
 	unsigned int res;
 
@@ -148,7 +136,7 @@
 	return res;
 }
 
-extern __inline__ unsigned int hweight8(unsigned int w)
+static __inline__ unsigned int hweight8(unsigned int w)
 {
 	unsigned int res;
 
@@ -165,12 +153,67 @@
 #endif
 #endif /* __KERNEL__ */
 
+/**
+ * find_next_bit - find the next set bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The maximum size to search
+ */
+static __inline__ unsigned long find_next_bit(void *addr, unsigned long size, unsigned long offset)
+{
+	unsigned long *p = ((unsigned long *) addr) + (offset >> 6);
+	unsigned long result = offset & ~63UL;
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset &= 63UL;
+	if (offset) {
+		tmp = *(p++);
+		tmp &= (~0UL << offset);
+		if (size < 64)
+			goto found_first;
+		if (tmp)
+			goto found_middle;
+		size -= 64;
+		result += 64;
+	}
+	while (size & ~63UL) {
+		if ((tmp = *(p++)))
+			goto found_middle;
+		result += 64;
+		size -= 64;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp &= (~0UL >> (64 - size));
+	if (tmp == 0UL)        /* Are any bits set? */
+		return result + size; /* Nope. */
+found_middle:
+	return result + __ffs(tmp);
+}
+
+/**
+ * find_first_bit - find the first set bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum size to search
+ *
+ * Returns the bit-number of the first set bit, not the number of the byte
+ * containing a bit.
+ */
+#define find_first_bit(addr, size) \
+	find_next_bit((addr), (size), 0)
+
 /* find_next_zero_bit() finds the first zero bit in a bit string of length
  * 'size' bits, starting the search at bit 'offset'. This is largely based
  * on Linus's ALPHA routines, which are pretty portable BTW.
  */
 
-extern __inline__ unsigned long find_next_zero_bit(void *addr, unsigned long size, unsigned long offset)
+static __inline__ unsigned long find_next_zero_bit(void *addr, unsigned long size, unsigned long offset)
 {
 	unsigned long *p = ((unsigned long *) addr) + (offset >> 6);
 	unsigned long result = offset & ~63UL;
@@ -219,7 +262,7 @@
 #define set_le_bit(nr,addr)		((void)___test_and_set_le_bit(nr,addr))
 #define clear_le_bit(nr,addr)		((void)___test_and_clear_le_bit(nr,addr))
 
-extern __inline__ int test_le_bit(int nr, __const__ void * addr)
+static __inline__ int test_le_bit(int nr, __const__ void * addr)
 {
 	int			mask;
 	__const__ unsigned char	*ADDR = (__const__ unsigned char *) addr;
@@ -232,7 +275,7 @@
 #define find_first_zero_le_bit(addr, size) \
         find_next_zero_le_bit((addr), (size), 0)
 
-extern __inline__ unsigned long find_next_zero_le_bit(void *addr, unsigned long size, unsigned long offset)
+static __inline__ unsigned long find_next_zero_le_bit(void *addr, unsigned long size, unsigned long offset)
 {
 	unsigned long *p = ((unsigned long *) addr) + (offset >> 6);
 	unsigned long result = offset & ~63UL;
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/include/asm-sparc64/mmu_context.h linux/include/asm-sparc64/mmu_context.h
--- vanilla/linux/include/asm-sparc64/mmu_context.h	Mon Jan 14 10:10:44 2002
+++ linux/include/asm-sparc64/mmu_context.h	Wed Jan 30 15:14:50 2002
@@ -1,4 +1,4 @@
-/* $Id: mmu_context.h,v 1.52 2002/01/11 08:45:38 davem Exp $ */
+/* $Id: mmu_context.h,v 1.53 2002/01/30 01:40:00 davem Exp $ */
 #ifndef __SPARC64_MMU_CONTEXT_H
 #define __SPARC64_MMU_CONTEXT_H
 
@@ -30,22 +30,20 @@
 /*
  * Every architecture must define this function. It's the fastest
  * way of searching a 168-bit bitmap where the first 128 bits are
- * unlikely to be clear. It's guaranteed that at least one of the 168
+ * unlikely to be set. It's guaranteed that at least one of the 168
  * bits is cleared.
  */
 #if MAX_RT_PRIO != 128 || MAX_PRIO != 168
 # error update this function.
 #endif
 
-static inline int sched_find_first_zero_bit(unsigned long *b)
+static inline int sched_find_first_bit(unsigned long *b)
 {
-	unsigned long rt;
-
-	rt = b[0] & b[1];
-	if (unlikely(rt != 0xffffffffffffffff))
-		return find_first_zero_bit(b, MAX_RT_PRIO);
-
-	return ffz(b[2]) + MAX_RT_PRIO;
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(b[1]))
+		return __ffs(b[1]) + 64;
+	return __ffs(b[2]) + 128;
 }
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
