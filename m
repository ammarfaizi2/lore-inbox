Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUGTTmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUGTTmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUGTSir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:38:47 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:58156
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S266128AbUGTSiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:03 -0400
Date: Tue, 20 Jul 2004 20:38:00 +0200
Message-Id: <200407201838.i6KIc0BI015384@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 463] m68k sparse #if vs. #ifdef
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Use #ifdef instead of #if (found by sparse)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/arch/m68k/kernel/signal.c	2004-06-21 20:20:00.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/kernel/signal.c	2004-07-10 21:07:33.000000000 +0200
@@ -349,7 +349,7 @@
 		/*
 		 * user process trying to return with weird frame format
 		 */
-#if DEBUG
+#ifdef DEBUG
 		printk("user process returning with weird frame format\n");
 #endif
 		goto badframe;
@@ -450,7 +450,7 @@
 		/*
 		 * user process trying to return with weird frame format
 		 */
-#if DEBUG
+#ifdef DEBUG
 		printk("user process returning with weird frame format\n");
 #endif
 		goto badframe;
@@ -829,7 +829,7 @@
 	if (regs->stkadj) {
 		struct pt_regs *tregs =
 			(struct pt_regs *)((ulong)regs + regs->stkadj);
-#if DEBUG
+#ifdef DEBUG
 		printk("Performing stackadjust=%04x\n", regs->stkadj);
 #endif
 		/* This must be copied with decreasing addresses to
@@ -912,7 +912,7 @@
 	if (regs->stkadj) {
 		struct pt_regs *tregs =
 			(struct pt_regs *)((ulong)regs + regs->stkadj);
-#if DEBUG
+#ifdef DEBUG
 		printk("Performing stackadjust=%04x\n", regs->stkadj);
 #endif
 		/* This must be copied with decreasing addresses to
--- linux-2.6.8-rc2/arch/m68k/kernel/traps.c	2004-06-20 17:14:30.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/kernel/traps.c	2004-07-10 21:07:34.000000000 +0200
@@ -541,7 +541,7 @@
 	unsigned short ssw = fp->un.fmtb.ssw;
 	extern unsigned long _sun3_map_test_start, _sun3_map_test_end;
 
-#if DEBUG
+#ifdef DEBUG
 	if (ssw & (FC | FB))
 		printk ("Instruction fault at %#010lx\n",
 			ssw & FC ?
@@ -670,7 +670,7 @@
 	unsigned short mmusr;
 	unsigned long addr, errorcode;
 	unsigned short ssw = fp->un.fmtb.ssw;
-#if DEBUG
+#ifdef DEBUG
 	unsigned long desc;
 
 	printk ("pid = %x  ", current->pid);
@@ -696,7 +696,7 @@
 	if (ssw & DF) {
 		addr = fp->un.fmtb.daddr;
 
-#if DEBUG
+#ifdef DEBUG
 		asm volatile ("ptestr %3,%2@,#7,%0\n\t"
 			      "pmove %%psr,%1@"
 			      : "=a&" (desc)
@@ -708,7 +708,7 @@
 #endif
 		mmusr = temp;
 
-#if DEBUG
+#ifdef DEBUG
 		printk("mmusr is %#x for addr %#lx in task %p\n",
 		       mmusr, addr, current);
 		printk("descriptor address is %#lx, contents %#lx\n",
@@ -767,7 +767,7 @@
 				      : "a" (&tlong));
 			printk("tt1 is %#lx\n", tlong);
 #endif
-#if DEBUG
+#ifdef DEBUG
 			printk("Unknown SIGSEGV - 1\n");
 #endif
 			die_if_kernel("Oops",&fp->ptregs,mmusr);
@@ -812,7 +812,7 @@
 		   should still create the ATC entry.  */
 		goto create_atc_entry;
 
-#if DEBUG
+#ifdef DEBUG
 	asm volatile ("ptestr #1,%2@,#7,%0\n\t"
 		      "pmove %%psr,%1@"
 		      : "=a&" (desc)
@@ -836,7 +836,7 @@
 	else if (mmusr & (MMU_B|MMU_L|MMU_S)) {
 		printk ("invalid insn access at %#lx from pc %#lx\n",
 			addr, fp->ptregs.pc);
-#if DEBUG
+#ifdef DEBUG
 		printk("Unknown SIGSEGV - 2\n");
 #endif
 		die_if_kernel("Oops",&fp->ptregs,mmusr);
@@ -858,7 +858,7 @@
 	if (user_mode(&fp->ptregs))
 		current->thread.esp0 = (unsigned long) fp;
 
-#if DEBUG
+#ifdef DEBUG
 	printk ("*** Bus Error *** Format is %x\n", fp->ptregs.format);
 #endif
 
@@ -881,7 +881,7 @@
 #endif
 	default:
 	  die_if_kernel("bad frame format",&fp->ptregs,0);
-#if DEBUG
+#ifdef DEBUG
 	  printk("Unknown SIGSEGV - 4\n");
 #endif
 	  force_sig(SIGSEGV, current);
--- linux-2.6.8-rc2/arch/m68k/mm/memory.c	2004-06-21 20:20:00.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/mm/memory.c	2004-07-10 21:06:54.000000000 +0200
@@ -129,7 +129,7 @@
 	return 0;
 }
 
-#if DEBUG_INVALID_PTOV
+#ifdef DEBUG_INVALID_PTOV
 int mm_inv_cnt = 5;
 #endif
 
@@ -179,7 +179,7 @@
 		voff += m68k_memory[i].size;
 	} while (++i < m68k_num_memory);
 
-#if DEBUG_INVALID_PTOV
+#ifdef DEBUG_INVALID_PTOV
 	if (mm_inv_cnt > 0) {
 		mm_inv_cnt--;
 		printk("Invalid use of phys_to_virt(0x%lx) at 0x%p!\n",
--- linux-2.6.8-rc2/include/asm-m68k/math-emu.h	1999-08-15 20:47:29.000000000 +0200
+++ linux-m68k-2.6.8-rc2/include/asm-m68k/math-emu.h	2004-07-10 21:06:55.000000000 +0200
@@ -102,7 +102,7 @@
 	struct fp_ext temp[2];
 };
 
-#if FPU_EMU_DEBUG
+#ifdef FPU_EMU_DEBUG
 extern unsigned int fp_debugprint;
 
 #define dprint(bit, fmt, args...) ({			\
--- linux-2.6.8-rc2/include/asm-m68k/semaphore.h	2004-04-28 15:47:30.000000000 +0200
+++ linux-m68k-2.6.8-rc2/include/asm-m68k/semaphore.h	2004-07-10 21:06:55.000000000 +0200
@@ -27,12 +27,12 @@
 	atomic_t count;
 	atomic_t waking;
 	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	long __magic;
 #endif
 };
 
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 # define __SEM_DEBUG_INIT(name) \
 		, (long)&(name).__magic
 #else
@@ -86,7 +86,7 @@
 {
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
 	might_sleep();
@@ -109,7 +109,7 @@
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 	register int result __asm__ ("%d0");
 
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
 	might_sleep();
@@ -134,7 +134,7 @@
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 	register int result __asm__ ("%d0");
 
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
 
@@ -164,7 +164,7 @@
 {
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
