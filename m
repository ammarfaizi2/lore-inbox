Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265266AbUFVTWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbUFVTWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUFVTTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:19:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:51113 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265226AbUFVTOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:14:03 -0400
Subject: [PATCH] ppc32: Cleanups & warning fixes of traps.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1087931251.1861.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 14:07:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch cleans up arch/ppc/kernel/traps.c and vecemu.c to use the same
formatting style for all functions, and fixes 2 warnings in the altivec
floating point emulation code. No functional change.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff -Nru a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c	2004-06-22 14:04:49 -05:00
+++ b/arch/ppc/kernel/traps.c	2004-06-22 14:04:49 -05:00
@@ -103,8 +103,7 @@
 	do_exit(err);
 }
 
-void
-_exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
+void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
 	siginfo_t info;
 
@@ -200,8 +199,7 @@
 #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
 #endif
 
-void
-MachineCheckException(struct pt_regs *regs)
+void MachineCheckException(struct pt_regs *regs)
 {
 	unsigned long reason = get_mc_reason(regs);
 
@@ -329,8 +327,7 @@
 	die("machine check", regs, SIGBUS);
 }
 
-void
-SMIException(struct pt_regs *regs)
+void SMIException(struct pt_regs *regs)
 {
 	debugger(regs);
 #if !(defined(CONFIG_XMON) || defined(CONFIG_KGDB))
@@ -339,24 +336,21 @@
 #endif
 }
 
-void
-UnknownException(struct pt_regs *regs)
+void UnknownException(struct pt_regs *regs)
 {
 	printk("Bad trap at PC: %lx, MSR: %lx, vector=%lx    %s\n",
 	       regs->nip, regs->msr, regs->trap, print_tainted());
 	_exception(SIGTRAP, regs, 0, 0);
 }
 
-void
-InstructionBreakpoint(struct pt_regs *regs)
+void InstructionBreakpoint(struct pt_regs *regs)
 {
 	if (debugger_iabr_match(regs))
 		return;
 	_exception(SIGTRAP, regs, TRAP_BRKPT, 0);
 }
 
-void
-RunModeException(struct pt_regs *regs)
+void RunModeException(struct pt_regs *regs)
 {
 	_exception(SIGTRAP, regs, 0, 0);
 }
@@ -374,8 +368,7 @@
 #define INST_MFSPR_PVR		0x7c1f42a6
 #define INST_MFSPR_PVR_MASK	0xfc1fffff
 
-static int
-emulate_instruction(struct pt_regs *regs)
+static int emulate_instruction(struct pt_regs *regs)
 {
 	u32 instword;
 	u32 rd;
@@ -438,8 +431,7 @@
 	return module_find_bug(bugaddr);
 }
 
-int
-check_bug_trap(struct pt_regs *regs)
+int check_bug_trap(struct pt_regs *regs)
 {
 	struct bug_entry *bug;
 	unsigned long addr;
@@ -476,8 +468,7 @@
 	return 0;
 }
 
-void
-ProgramCheckException(struct pt_regs *regs)
+void ProgramCheckException(struct pt_regs *regs)
 {
 	unsigned int reason = get_reason(regs);
 	extern int do_mathemu(struct pt_regs *regs);
@@ -550,8 +541,7 @@
 	_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 }
 
-void
-SingleStepException(struct pt_regs *regs)
+void SingleStepException(struct pt_regs *regs)
 {
 	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
 	if (debugger_sstep(regs))
@@ -559,8 +549,7 @@
 	_exception(SIGTRAP, regs, TRAP_TRACE, 0);
 }
 
-void
-AlignmentException(struct pt_regs *regs)
+void AlignmentException(struct pt_regs *regs)
 {
 	int fixed;
 
@@ -580,8 +569,7 @@
 	_exception(SIGBUS, regs, BUS_ADRALN, regs->dar);
 }
 
-void
-StackOverflow(struct pt_regs *regs)
+void StackOverflow(struct pt_regs *regs)
 {
 	printk(KERN_CRIT "Kernel stack overflow in process %p, r1=%lx\n",
 	       current, regs->gpr[1]);
@@ -598,8 +586,7 @@
 	die("nonrecoverable exception", regs, SIGKILL);
 }
 
-void
-trace_syscall(struct pt_regs *regs)
+void trace_syscall(struct pt_regs *regs)
 {
 	printk("Task: %p(%d), PC: %08lX/%08lX, Syscall: %3ld, Result: %s%ld    %s\n",
 	       current, current->pid, regs->nip, regs->link, regs->gpr[0],
@@ -607,8 +594,7 @@
 }
 
 #ifdef CONFIG_8xx
-void
-SoftwareEmulation(struct pt_regs *regs)
+void SoftwareEmulation(struct pt_regs *regs)
 {
 	extern int do_mathemu(struct pt_regs *);
 	extern int Soft_emulate_8xx(struct pt_regs *);
@@ -660,8 +646,7 @@
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
 
 #if !defined(CONFIG_TAU_INT)
-void
-TAUException(struct pt_regs *regs)
+void TAUException(struct pt_regs *regs)
 {
 	printk("TAU trap at PC: %lx, MSR: %lx, vector=%lx    %s\n",
 	       regs->nip, regs->msr, regs->trap, print_tainted());
@@ -683,14 +668,13 @@
 	/* The kernel has executed an altivec instruction without
 	   first enabling altivec.  Whinge but let it do it. */
 	if (++kernel_altivec_count < 10)
-		printk(KERN_ERR "AltiVec used in kernel (task=%p, pc=%x)\n",
+		printk(KERN_ERR "AltiVec used in kernel (task=%p, pc=%lx)\n",
 		       current, regs->nip);
 	regs->msr |= MSR_VEC;
 }
 
 #ifdef CONFIG_ALTIVEC
-void
-AltivecAssistException(struct pt_regs *regs)
+void AltivecAssistException(struct pt_regs *regs)
 {
 	int err;
 
@@ -734,8 +718,7 @@
 #endif /* CONFIG_FSL_BOOKE */
 
 #ifdef CONFIG_SPE
-void
-SPEFloatingPointException(struct pt_regs *regs)
+void SPEFloatingPointException(struct pt_regs *regs)
 {
 	unsigned long spefscr;
 	int fpexc_mode;
diff -Nru a/arch/ppc/kernel/vecemu.c b/arch/ppc/kernel/vecemu.c
--- a/arch/ppc/kernel/vecemu.c	2004-06-22 14:04:49 -05:00
+++ b/arch/ppc/kernel/vecemu.c	2004-06-22 14:04:49 -05:00
@@ -256,8 +256,7 @@
 	return (x + half) & ~(0x7fffff >> exp);
 }
 
-int
-emulate_altivec(struct pt_regs *regs)
+int emulate_altivec(struct pt_regs *regs)
 {
 	unsigned int instr, i;
 	unsigned int va, vb, vc, vd;
diff -Nru a/include/asm-ppc/processor.h b/include/asm-ppc/processor.h
--- a/include/asm-ppc/processor.h	2004-06-22 14:04:49 -05:00
+++ b/include/asm-ppc/processor.h	2004-06-22 14:04:49 -05:00
@@ -197,6 +197,8 @@
 
 #define spin_lock_prefetch(x)	prefetchw(x)
 
+extern int emulate_altivec(struct pt_regs *regs);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PPC_PROCESSOR_H */



