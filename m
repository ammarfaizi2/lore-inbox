Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUFQSXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUFQSXZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 14:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUFQSXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 14:23:25 -0400
Received: from darwin.snarc.org ([81.56.210.228]:59013 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S261474AbUFQSVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 14:21:44 -0400
Date: Thu, 17 Jun 2004 20:21:36 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] trivial ppc cleanup (2/3) use simplified mnemonics
Message-ID: <20040617182136.GA11876@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040523i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,
	
use simplified mnemonics where it is possible
this is mostly a:  s/rlwimn a,b,0,0,n/clrrwi a,b,31-n/

It applies on top of the 1/3 patch

please apply and/or comment,flame,...

Signed-off-by: Vincent Hanquez <tab@snarc.org>

--- linux-2.6.7/arch/ppc/kernel/~entry.S	2004-06-17 17:16:32.000000000 +0200
+++ linux-2.6.7/arch/ppc/kernel/entry.S	2004-06-17 17:27:15.000000000 +0200
@@ -198,7 +198,7 @@
 #ifdef SHOW_SYSCALLS
 	bl	do_show_syscall
 #endif /* SHOW_SYSCALLS */
-	rlwinm	r10,r1,0,0,18	/* current_thread_info() */
+	clrrwi	r10,r1,13	/* current_thread_info() */
 	lwz	r11,TI_local_flags(r10)
 	rlwinm	r11,r11,0,~_TIFL_FORCE_NOERROR
 	stw	r11,TI_local_flags(r10)
@@ -223,7 +223,7 @@
 	mr	r6,r3
 	li	r11,-_LAST_ERRNO
 	cmpl	0,r3,r11
-	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
+	clrrwi	r12,r1,13	/* current_thread_info() */
 	blt+	30f
 	lwz	r11,TI_local_flags(r12)
 	andi.	r11,r11,_TIFL_FORCE_NOERROR
@@ -310,7 +310,7 @@
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
 	SYNC
 	MTMSRD(r10)		/* disable interrupts again */
-	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
+	clrrwi	r12,r1,13	/* current_thread_info() */
 	lwz	r9,TI_flags(r12)
 5:
 	andi.	r0,r9,_TIF_NEED_RESCHED
@@ -407,7 +407,7 @@
 ppc_sigsuspend:
 	SAVE_NVGPRS(r1)
 	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	clrrwi	r0,r0,1			/* clear LSB to indicate full */
 	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_sigsuspend
 
@@ -415,15 +415,15 @@
 ppc_rt_sigsuspend:
 	SAVE_NVGPRS(r1)
 	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30
-	stw	r0,TRAP(r1)
+	clrrwi	r0,r0,1			/* clear LSB to indicate full */
+	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_rt_sigsuspend
 
 	.globl	ppc_fork
 ppc_fork:
 	SAVE_NVGPRS(r1)
 	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	clrrwi	r0,r0,1			/* clear LSB to indicate full */
 	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_fork
 
@@ -431,7 +431,7 @@
 ppc_vfork:
 	SAVE_NVGPRS(r1)
 	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	clrrwi	r0,r0,1			/* clear LSB to indicate full */
 	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_vfork
 
@@ -439,7 +439,7 @@
 ppc_clone:
 	SAVE_NVGPRS(r1)
 	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	clrrwi	r0,r0,1			/* clear LSB to indicate full */
 	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_clone
 
@@ -447,7 +447,7 @@
 ppc_swapcontext:
 	SAVE_NVGPRS(r1)
 	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	clrrwi	r0,r0,1			/* clear LSB to indicate full */
 	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_swapcontext
 
@@ -557,7 +557,7 @@
 	.globl	sigreturn_exit
 sigreturn_exit:
 	subi	r1,r3,STACK_FRAME_OVERHEAD
-	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
+	clrrwi	r12,r1,13	/* current_thread_info() */
 	lwz	r9,TI_flags(r12)
 	andi.	r0,r9,_TIF_SYSCALL_TRACE
 	bnel-	do_syscall_trace
@@ -583,7 +583,7 @@
 
 user_exc_return:		/* r10 contains MSR_KERNEL here */
 	/* Check current_thread_info()->flags */
-	rlwinm	r9,r1,0,0,18
+	clrrwi	r9,r1,13
 	lwz	r9,TI_flags(r9)
 	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_NEED_RESCHED)
 	bne	do_work
@@ -602,7 +602,7 @@
 /* N.B. the only way to get here is from the beq following ret_from_except. */
 resume_kernel:
 	/* check current_thread_info->preempt_count */
-	rlwinm	r9,r1,0,0,18
+	clrrwi	r9,r1,13
 	lwz	r0,TI_preempt_count(r9)
 	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
 	bne	restore
@@ -620,7 +620,7 @@
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
-	rlwinm	r9,r1,0,0,18
+	clrrwi	r9,r1,13
 	li	r0,0
 	stw	r0,TI_preempt_count(r9)
 	lwz	r3,TI_flags(r9)
@@ -900,7 +900,7 @@
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
-	rlwinm	r9,r1,0,0,18
+	clrrwi	r9,r1,13
 	lwz	r9,TI_flags(r9)
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	bne-	do_resched
@@ -915,7 +915,7 @@
 	andi.	r0,r3,1
 	beq	2f
 	SAVE_NVGPRS(r1)
-	rlwinm	r3,r3,0,0,30
+	clrrwi	r3,r3,1
 	stw	r3,TRAP(r1)
 2:	li	r3,0
 	addi	r4,r1,STACK_FRAME_OVERHEAD
@@ -952,7 +952,7 @@
 	andi.	r0,r3,1
 	beq	4f
 	SAVE_NVGPRS(r1)
-	rlwinm	r3,r3,0,0,30
+	clrrwi	r3,r3,1
 	stw	r3,TRAP(r1)
 4:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	nonrecoverable_exception
--- linux-2.6.7/arch/ppc/kernel/~misc.S	2004-06-17 18:00:20.000000000 +0200
+++ linux-2.6.7/arch/ppc/kernel/misc.S	2004-06-17 17:31:01.000000000 +0200
@@ -232,7 +232,7 @@
 	mtspr	SPRN_HID1,r4
 
 	/* Store new HID1 image */
-	rlwinm	r6,r1,0,0,18
+	clrrwi	r6,r1,13
 	lwz	r6,TI_cpu(r6)
 	slwi	r6,r6,2
 	addis	r6,r6,nap_save_hid1@ha
@@ -421,7 +421,7 @@
 	isync
 #else /* !(CONFIG_40x || CONFIG_44x) */
 #if defined(CONFIG_SMP)
-	rlwinm	r8,r1,0,0,18
+	clrrwi	r8,r1,13
 	lwz	r8,TI_cpu(r8)
 	oris	r8,r8,10
 	mfmsr	r10
@@ -489,7 +489,7 @@
 10:
 #else /* !(CONFIG_40x || CONFIG_44x) */
 #if defined(CONFIG_SMP)
-	rlwinm	r8,r1,0,0,18
+	clrrwi	r8,r1,13
 	lwz	r8,TI_cpu(r8)
 	oris	r8,r8,11
 	mfmsr	r10
@@ -687,7 +687,7 @@
 	rlwinm	r5,r5,16,16,31
 	cmpi	0,r5,1
 	beqlr					/* for 601, do nothing */
-	rlwinm	r3,r3,0,0,19			/* Get page base address */
+	clrrwi	r3,r3,12			/* Get page base address */
 	li	r4,4096/L1_CACHE_LINE_SIZE	/* Number of lines in a page */
 	mtctr	r4
 	mr	r6,r3
@@ -720,7 +720,7 @@
 	rlwinm	r0,r10,0,28,26			/* clear DR */
 	mtmsr	r0
 	isync
-	rlwinm	r3,r3,0,0,19			/* Get page base address */
+	clrrwi	r3,r3,12			/* Get page base address */
 	li	r4,4096/L1_CACHE_LINE_SIZE	/* Number of lines in a page */
 	mtctr	r4
 	mr	r6,r3
--- linux-2.6.7/arch/ppc/kernel/~ppc_htab.c	2004-06-17 17:32:46.000000000 +0200
+++ linux-2.6.7/arch/ppc/kernel/ppc_htab.c	2004-06-17 17:33:43.000000000 +0200
@@ -286,7 +286,7 @@
 		/* setup mmcr0 and clear the correct pmc */
 	       asm volatile(
 		       "mfspr %0,%1\n\t"     /* get current mccr0 */
-		       "rlwinm %0,%0,0,0,31-6\n\t"  /* clear bits [26-31] */
+		       "clrrwi %0,%0,6\n\t"  /* clear bits [26-31] */
 		       "ori   %0,%0,%2 \n\t" /* or in mmcr0 settings */
 		       "mtspr %1,%0 \n\t"    /* set new mccr0 */
 		       "mtspr %3,%4 \n\t"    /* reset the pmc */
@@ -301,7 +301,7 @@
 		/* setup mmcr0 and clear the correct pmc */
 	       asm volatile(
 		       "mfspr %0,%1\n\t"     /* get current mccr0 */
-		       "rlwinm %0,%0,0,0,31-6\n\t"  /* clear bits [26-31] */
+		       "clrrwi %0,%0,6\n\t"  /* clear bits [26-31] */
 		       "ori   %0,%0,%2 \n\t" /* or in mmcr0 settings */
 		       "mtspr %1,%0 \n\t"    /* set new mccr0 */
 		       "mtspr %3,%4 \n\t"    /* reset the pmc */
@@ -315,7 +315,7 @@
 		/* setup mmcr0 and clear the correct pmc */
 	       asm volatile(
 		       "mfspr %0,%1\n\t"     /* get current mccr0 */
-		       "rlwinm %0,%0,0,0,31-6\n\t"  /* clear bits [26-31] */
+		       "clrrwi %0,%0,6\n\t"  /* clear bits [26-31] */
 		       "ori   %0,%0,%2 \n\t" /* or in mmcr0 settings */
 		       "mtspr %1,%0 \n\t"    /* set new mccr0 */
 		       "mtspr %3,%4 \n\t"    /* reset the pmc */
--- linux-2.6.7/arch/ppc/kernel/~head_44x.S	2004-06-17 17:47:06.000000000 +0200
+++ linux-2.6.7/arch/ppc/kernel/head_44x.S	2004-06-17 17:52:18.000000000 +0200
@@ -579,7 +579,7 @@
 	ori	r11, r11, swapper_pg_dir@l
 
 	mfspr   r12,SPRN_MMUCR
-	rlwinm	r12,r12,0,0,23		/* Clear TID */
+	clrrwi	r12,r12,8		/* Clear TID */
 
 	b	4f
 
@@ -598,7 +598,7 @@
 
 	rlwinm  r12, r10, 13, 19, 29    /* Compute pgdir/pmd offset */
 	lwzx    r11, r12, r11           /* Get pgd/pmd entry */
-	rlwinm. r12, r11, 0, 0, 20      /* Extract pt base address */
+	clrrwi. r12, r11, 11		/* Extract pt base address */
 	beq     2f                      /* Bail if no table */
 
 	rlwimi  r12, r10, 23, 20, 28    /* Compute pte address */
@@ -728,7 +728,7 @@
 	ori	r11, r11, swapper_pg_dir@l
 
 	mfspr	r12,SPRN_MMUCR
-	rlwinm	r12,r12,0,0,23		/* Clear TID */
+	clrrwi	r12,r12,8		/* Clear TID */
 
 	b	4f
 
@@ -747,7 +747,7 @@
 
 	rlwinm 	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
 	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
-	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
+	clrrwi. r12, r11, 11		/* Extract pt base address */
 	beq	2f			/* Bail if no table */
 
 	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
@@ -797,7 +797,7 @@
 	ori	r11, r11, swapper_pg_dir@l
 
 	mfspr	r12,SPRN_MMUCR
-	rlwinm	r12,r12,0,0,23		/* Clear TID */
+	clrrwi	r12,r12,8		/* Clear TID */
 
 	b	4f
 
@@ -816,7 +816,7 @@
 
 	rlwinm	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
 	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
-	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
+	clrrwi. r12, r11, 11		/* Extract pt base address */
 	beq	2f			/* Bail if no table */
 
 	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
--- linux-2.6.7/arch/ppc/kernel/~head_4xx.S	2004-06-17 17:52:31.000000000 +0200
+++ linux-2.6.7/arch/ppc/kernel/head_4xx.S	2004-06-17 17:55:05.000000000 +0200
@@ -347,7 +347,7 @@
 	tophys(r11, r11)
 	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
 	lwz	r11, 0(r11)		/* Get L1 entry */
-	rlwinm.	r12, r11, 0, 0, 19	/* Extract L2 (pte) base address */
+	clrrwi.	r12, r11, 12		/* Extract L2 (pte) base address */
 	beq	2f			/* Bail if no table */
 
 	rlwimi	r12, r10, 22, 20, 29	/* Compute PTE address */
