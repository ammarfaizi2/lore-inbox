Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268234AbUJHJp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268234AbUJHJp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 05:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUJHJp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 05:45:56 -0400
Received: from [213.146.154.40] ([213.146.154.40]:64672 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S268234AbUJHJpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 05:45:35 -0400
Subject: Re: [PATCH] PPC64 Replace cmp instructions with cmpw/cmpd
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, torvalds@osdl.org, anton@samba.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <16742.10154.523798.177319@cargo.ozlabs.ibm.com>
References: <16742.10154.523798.177319@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1097228724.318.65.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 08 Oct 2004 10:45:24 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 15:37 +1000, Paul Mackerras wrote:
> This patch replaces cmp{,l}{,i} with cmp{,l}[wd]{,i} as appropriate.
> The original patch was from Segher Boessenkool, slightly modified by
> me.  Please apply.

And also for ppc32 and arch/ppc64/kernel/ItLpQueue.c...

--- linux-2.6.8/arch/ppc/kernel/cpu_setup_6xx.S~	2004-10-07 16:50:14.000000000 +0100
+++ linux-2.6.8/arch/ppc/kernel/cpu_setup_6xx.S	2004-10-07 17:45:54.655751312 +0100
@@ -172,9 +172,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NO_DPM)
 setup_750cx:
 	mfspr	r10, SPRN_HID1
 	rlwinm	r10,r10,4,28,31
-	cmpi	cr0,r10,7
-	cmpi	cr1,r10,9
-	cmpi	cr2,r10,11
+	cmpwi	cr0,r10,7
+	cmpwi	cr1,r10,9
+	cmpwi	cr2,r10,11
 	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr2+eq
 	bnelr
@@ -287,12 +287,12 @@ _GLOBAL(__save_cpu_setup)
 	/* Now deal with CPU type dependent registers */
 	mfspr	r3,PVR
 	srwi	r3,r3,16
-	cmpli	cr0,r3,0x8000	/* 7450 */
-	cmpli	cr1,r3,0x000c	/* 7400 */
-	cmpli	cr2,r3,0x800c	/* 7410 */
-	cmpli	cr3,r3,0x8001	/* 7455 */
-	cmpli	cr4,r3,0x8002	/* 7457 */
-	cmpli	cr5,r3,0x7000	/* 750FX */
+	cmplwi	cr0,r3,0x8000	/* 7450 */
+	cmplwi	cr1,r3,0x000c	/* 7400 */
+	cmplwi	cr2,r3,0x800c	/* 7410 */
+	cmplwi	cr3,r3,0x8001	/* 7455 */
+	cmplwi	cr4,r3,0x8002	/* 7457 */
+	cmplwi	cr5,r3,0x7000	/* 750FX */
 	/* cr1 is 7400 || 7410 */
 	cror	4*cr1+eq,4*cr1+eq,4*cr2+eq
 	/* cr0 is 74xx */
@@ -323,7 +323,7 @@ _GLOBAL(__save_cpu_setup)
 	/* If rev 2.x, backup HID2 */
 	mfspr	r3,PVR
 	andi.	r3,r3,0xff00
-	cmpi	cr0,r3,0x0200
+	cmpwi	cr0,r3,0x0200
 	bne	1f
 	mfspr	r4,SPRN_HID2
 	stw	r4,CS_HID2(r5)
@@ -354,12 +354,12 @@ _GLOBAL(__restore_cpu_setup)
 	/* Now deal with CPU type dependent registers */
 	mfspr	r3,PVR
 	srwi	r3,r3,16
-	cmpli	cr0,r3,0x8000	/* 7450 */
-	cmpli	cr1,r3,0x000c	/* 7400 */
-	cmpli	cr2,r3,0x800c	/* 7410 */
-	cmpli	cr3,r3,0x8001	/* 7455 */
-	cmpli	cr4,r3,0x8002	/* 7457 */
-	cmpli	cr5,r3,0x7000	/* 750FX */
+	cmplwi	cr0,r3,0x8000	/* 7450 */
+	cmplwi	cr1,r3,0x000c	/* 7400 */
+	cmplwi	cr2,r3,0x800c	/* 7410 */
+	cmplwi	cr3,r3,0x8001	/* 7455 */
+	cmplwi	cr4,r3,0x8002	/* 7457 */
+	cmplwi	cr5,r3,0x7000	/* 750FX */
 	/* cr1 is 7400 || 7410 */
 	cror	4*cr1+eq,4*cr1+eq,4*cr2+eq
 	/* cr0 is 74xx */
@@ -412,7 +412,7 @@ _GLOBAL(__restore_cpu_setup)
 	/* If rev 2.x, restore HID2 with low voltage bit cleared */
 	mfspr	r3,PVR
 	andi.	r3,r3,0xff00
-	cmpi	cr0,r3,0x0200
+	cmpwi	cr0,r3,0x0200
 	bne	4f
 	lwz	r4,CS_HID2(r5)
 	rlwinm	r4,r4,0,19,17
@@ -426,7 +426,7 @@ _GLOBAL(__restore_cpu_setup)
 	mftbl	r5
 3:	mftbl	r6
 	sub	r6,r6,r5
-	cmpli	cr0,r6,10000
+	cmplwi	cr0,r6,10000
 	ble	3b
 	/* Setup final PLL */
 	mtspr	SPRN_HID1,r4
--- linux-2.6.8/arch/ppc/kernel/entry.S~	2004-08-14 06:37:40.000000000 +0100
+++ linux-2.6.8/arch/ppc/kernel/entry.S	2004-10-07 17:11:33.119152512 +0100
@@ -206,7 +206,7 @@ _GLOBAL(DoSyscall)
 	andi.	r11,r11,_TIF_SYSCALL_TRACE
 	bne-	syscall_dotrace
 syscall_dotrace_cont:
-	cmpli	0,r0,NR_syscalls
+	cmplwi	0,r0,NR_syscalls
 	lis	r10,sys_call_table@h
 	ori	r10,r10,sys_call_table@l
 	slwi	r0,r0,2
@@ -222,7 +222,7 @@ ret_from_syscall:
 #endif
 	mr	r6,r3
 	li	r11,-_LAST_ERRNO
-	cmpl	0,r3,r11
+	cmplw	0,r3,r11
 	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
 	blt+	30f
 	lwz	r11,TI_LOCAL_FLAGS(r12)
--- linux-2.6.8/arch/ppc/kernel/idle_6xx.S~	2004-08-14 06:37:15.000000000 +0100
+++ linux-2.6.8/arch/ppc/kernel/idle_6xx.S	2004-10-07 17:47:04.490134872 +0100
@@ -79,12 +79,12 @@ BEGIN_FTR_SECTION
 	/* Now check if user or arch enabled NAP mode */
 	lis	r4,powersave_nap@ha
 	lwz	r4,powersave_nap@l(r4)
-	cmpi	0,r4,0
+	cmpwi	0,r4,0
 	beq	1f
 	lis	r3,HID0_NAP@h
 1:	
 END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
-	cmpi	0,r3,0
+	cmpwi	0,r3,0
 	beqlr
 
 	/* Clear MSR:EE */
@@ -133,7 +133,7 @@ BEGIN_FTR_SECTION
 	/* Go to low speed mode on some 750FX */
 	lis	r4,powersave_lowspeed@ha
 	lwz	r4,powersave_lowspeed@l(r4)
-	cmpi	0,r4,0
+	cmpwi	0,r4,0
 	beq	1f
 	mfspr	r4,SPRN_HID1
 	oris	r4,r4,0x0001
--- linux-2.6.8/arch/ppc/kernel/misc.S~	2004-10-07 16:50:28.000000000 +0100
+++ linux-2.6.8/arch/ppc/kernel/misc.S	2004-10-07 17:45:17.124456936 +0100
@@ -214,7 +214,7 @@ _GLOBAL(low_choose_750fx_pll)
 	mtmsr	r0
 
 	/* If switching to PLL1, disable HID0:BTIC */
-	cmpli	cr0,r3,0
+	cmplwi	cr0,r3,0
 	beq	1f
 	mfspr	r5,HID0
 	rlwinm	r5,r5,0,27,25
@@ -239,7 +239,7 @@ _GLOBAL(low_choose_750fx_pll)
 	stw	r4,nap_save_hid1@l(r6)
 
 	/* If switching to PLL0, enable HID0:BTIC */
-	cmpli	cr0,r3,0
+	cmplwi	cr0,r3,0
 	bne	1f
 	mfspr	r5,HID0
 	ori	r5,r5,HID0_BTIC
@@ -470,7 +470,7 @@ _GLOBAL(_tlbia)
 	ori	r9,r9,mmu_hash_lock@l
 	tophys(r9,r9)
 10:	lwarx	r7,0,r9
-	cmpi	0,r7,0
+	cmpwi	0,r7,0
 	bne-	10b
 	stwcx.	r8,0,r9
 	bne-	10b
@@ -551,7 +551,7 @@ _GLOBAL(_tlbie)
 	ori	r9,r9,mmu_hash_lock@l
 	tophys(r9,r9)
 10:	lwarx	r7,0,r9
-	cmpi	0,r7,0
+	cmpwi	0,r7,0
 	bne-	10b
 	stwcx.	r8,0,r9
 	bne-	10b
@@ -599,7 +599,7 @@ _GLOBAL(flush_instruction_cache)
 #else
 	mfspr	r3,PVR
 	rlwinm	r3,r3,16,16,31
-	cmpi	0,r3,1
+	cmpwi	0,r3,1
 	beqlr			/* for 601, do nothing */
 	/* 603/604 processor - use invalidate-all bit in HID0 */
 	mfspr	r3,HID0
@@ -1141,7 +1141,7 @@ _GLOBAL(kernel_thread)
 	li	r4,0		/* new sp (unused) */
 	li	r0,__NR_clone
 	sc
-	cmpi	0,r3,0		/* parent or child? */
+	cmpwi	0,r3,0		/* parent or child? */
 	bne	1f		/* return if parent */
 	li	r0,0		/* make top-level stack frame */
 	stwu	r0,-16(r1)
--- linux-2.6.8/arch/ppc/kernel/idle_power4.S~	2004-08-14 06:36:16.000000000 +0100
+++ linux-2.6.8/arch/ppc/kernel/idle_power4.S	2004-10-07 17:47:12.953848192 +0100
@@ -56,7 +56,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	/* Now check if user or arch enabled NAP mode */
 	lis	r4,powersave_nap@ha
 	lwz	r4,powersave_nap@l(r4)
-	cmpi	0,r4,0
+	cmpwi	0,r4,0
 	beqlr
 
 	/* Clear MSR:EE */
--- linux-2.6.8/arch/ppc/kernel/head.S~	2004-08-14 06:37:14.000000000 +0100
+++ linux-2.6.8/arch/ppc/kernel/head.S	2004-10-07 17:46:47.457724192 +0100
@@ -800,7 +800,7 @@ load_up_fpu:
 	tophys(r6,0)			/* get __pa constant */
 	addis	r3,r6,last_task_used_math@ha
 	lwz	r4,last_task_used_math@l(r3)
-	cmpi	0,r4,0
+	cmpwi	0,r4,0
 	beq	1f
 	add	r4,r4,r6
 	addi	r4,r4,THREAD		/* want last_task_used_math->thread */
@@ -927,7 +927,7 @@ load_up_altivec:
 	tophys(r6,0)
 	addis	r3,r6,last_task_used_altivec@ha
 	lwz	r4,last_task_used_altivec@l(r3)
-	cmpi	0,r4,0
+	cmpwi	0,r4,0
 	beq	1f
 	add	r4,r4,r6
 	addi	r4,r4,THREAD	/* want THREAD of last_task_used_altivec */
@@ -992,11 +992,11 @@ giveup_altivec:
 	SYNC
 	MTMSRD(r5)			/* enable use of AltiVec now */
 	isync
-	cmpi	0,r3,0
+	cmpwi	0,r3,0
 	beqlr-				/* if no previous owner, done */
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	lwz	r5,PT_REGS(r3)
-	cmpi	0,r5,0
+	cmpwi	0,r5,0
 	SAVE_32VR(0, r4, r3)
 	mfvscr	vr0
 	li	r4,THREAD_VSCR
@@ -1030,11 +1030,11 @@ giveup_fpu:
 	MTMSRD(r5)			/* enable use of fpu now */
 	SYNC_601
 	isync
-	cmpi	0,r3,0
+	cmpwi	0,r3,0
 	beqlr-				/* if no previous owner, done */
 	addi	r3,r3,THREAD	        /* want THREAD of task */
 	lwz	r5,PT_REGS(r3)
-	cmpi	0,r5,0
+	cmpwi	0,r5,0
 	SAVE_32FPRS(0, r3)
 	mffs	fr0
 	stfd	fr0,THREAD_FPSCR-4(r3)
@@ -1539,7 +1539,7 @@ initial_bats:
 #ifndef CONFIG_PPC64BRIDGE
 	mfspr	r9,PVR
 	rlwinm	r9,r9,16,16,31		/* r9 = 1 for 601, 4 for 604 */
-	cmpi	0,r9,1
+	cmpwi	0,r9,1
 	bne	4f
 	ori	r11,r11,4		/* set up BAT registers for 601 */
 	li	r8,0x7f			/* valid, block length = 8MB */
@@ -1591,7 +1591,7 @@ setup_disp_bat:
 	lwz	r8,4(r8)
 	mfspr	r9,PVR
 	rlwinm	r9,r9,16,16,31		/* r9 = 1 for 601, 4 for 604 */
-	cmpi	0,r9,1
+	cmpwi	0,r9,1
 	beq	1f
 	mtspr	DBAT3L,r8
 	mtspr	DBAT3U,r11
--- linux-2.6.8/arch/ppc/lib/checksum.S~	2004-08-14 06:36:33.000000000 +0100
+++ linux-2.6.8/arch/ppc/lib/checksum.S	2004-10-07 17:13:15.771546976 +0100
@@ -80,13 +80,13 @@ _GLOBAL(csum_partial)
 	adde	r0,r0,r5	/* be unnecessary to unroll this loop */
 	bdnz	2b
 	andi.	r4,r4,3
-3:	cmpi	0,r4,2
+3:	cmpwi	0,r4,2
 	blt+	4f
 	lhz	r5,4(r3)
 	addi	r3,r3,2
 	subi	r4,r4,2
 	adde	r0,r0,r5
-4:	cmpi	0,r4,1
+4:	cmpwi	0,r4,1
 	bne+	5f
 	lbz	r5,4(r3)
 	slwi	r5,r5,8		/* Upper byte of word */
@@ -143,7 +143,7 @@ _GLOBAL(csum_partial_copy_generic)
 	adde	r0,r0,r9
 	bdnz	82b
 13:	andi.	r5,r5,3
-3:	cmpi	0,r5,2
+3:	cmpwi	0,r5,2
 	blt+	4f
 83:	lhz	r6,4(r3)
 	addi	r3,r3,2
@@ -151,7 +151,7 @@ _GLOBAL(csum_partial_copy_generic)
 93:	sth	r6,4(r4)
 	addi	r4,r4,2
 	adde	r0,r0,r6
-4:	cmpi	0,r5,1
+4:	cmpwi	0,r5,1
 	bne+	5f
 84:	lbz	r6,4(r3)
 94:	stb	r6,4(r4)
@@ -188,7 +188,7 @@ src_error_3:
 97:	stbu	r6,1(r4)
 	bdnz	97b
 src_error:
-	cmpi	0,r7,0
+	cmpwi	0,r7,0
 	beq	1f
 	li	r6,-EFAULT
 	stw	r6,0(r7)
@@ -196,7 +196,7 @@ src_error:
 	blr
 
 dst_error:
-	cmpi	0,r8,0
+	cmpwi	0,r8,0
 	beq	1f
 	li	r6,-EFAULT
 	stw	r6,0(r8)

--- linux-2.6.8/arch/ppc/boot/common/util.S~	2004-10-07 14:13:39.251891048 -0400
+++ linux-2.6.8/arch/ppc/boot/common/util.S	2004-10-07 14:15:16.354129264 -0400
@@ -41,7 +41,7 @@ disable_6xx_mmu:
 	/* Test for a 601 */
 	mfpvr	r10
 	srwi	r10,r10,16
-	cmpi	0,r10,1		/* 601 ? */
+	cmpwi	0,r10,1		/* 601 ? */
 	beq	.clearbats_601
 
 	/* Clear BATs */
@@ -117,9 +117,9 @@ _setup_L2CR:
 	/* Wait for the invalidation to complete */
 	mfspr   r8,PVR
 	srwi    r8,r8,16
-	cmpli	cr0,r8,0x8000			/* 7450 */
-	cmpli	cr1,r8,0x8001			/* 7455 */
-	cmpli	cr2,r8,0x8002			/* 7457 */
+	cmplwi	cr0,r8,0x8000			/* 7450 */
+	cmplwi	cr1,r8,0x8001			/* 7455 */
+	cmplwi	cr2,r8,0x8002			/* 7457 */
 	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq	/* Now test if any are true. */
 	cror	4*cr0+eq,4*cr0+eq,4*cr2+eq
 	bne     2f
@@ -190,7 +190,7 @@ timebase_period_ns:
 udelay:
 	mfspr	r4,PVR
 	srwi	r4,r4,16
-	cmpi	0,r4,1		/* 601 ? */
+	cmpwi	0,r4,1		/* 601 ? */
 	bne	.udelay_not_601
 00:	li	r0,86	/* Instructions / microsecond? */
 	mtctr	r0
@@ -213,16 +213,16 @@ udelay:
 1:	mftbu	r5
 	mftb	r6
 	mftbu	r7
-	cmp	0,r5,r7
+	cmpw	0,r5,r7
 	bne	1b		/* Get [synced] base time */
 	addc	r9,r6,r4	/* Compute end time */
 	addze	r8,r5
 2:	mftbu	r5
-	cmp	0,r5,r8
+	cmpw	0,r5,r8
 	blt	2b
 	bgt	3f
 	mftb	r6
-	cmp	0,r6,r9
+	cmpw	0,r6,r9
 	blt	2b
 3:	blr
 
--- linux-2.6.8/arch/ppc64/kernel/ItLpQueue.c~	2004-10-07 14:48:37.043978176 -0400
+++ linux-2.6.8/arch/ppc64/kernel/ItLpQueue.c	2004-10-07 14:48:51.495781168 -0400
@@ -25,7 +25,7 @@ static __inline__ int set_inUse( struct 
 
 	__asm__ __volatile__("\n\
 1:	lwarx	%0,0,%2		\n\
-	cmpi	0,%0,0		\n\
+	cmpwi	0,%0,0		\n\
 	li	%0,0		\n\
 	bne-	2f		\n\
 	addi	%0,%0,1		\n\
--- linux-2.6.8/arch/ppc/boot/simple/relocate.S~	2004-10-07 15:17:04.737369320 -0400
+++ linux-2.6.8/arch/ppc/boot/simple/relocate.S	2004-10-07 15:17:13.064103464 -0400
@@ -50,7 +50,7 @@ relocate:
 	 * Check if we need to relocate ourselves to the link addr or were
 	 * we loaded there to begin with.
 	 */
-	cmp	cr0,r3,r4
+	cmpw	cr0,r3,r4
 	beq	start_ldr	/* If 0, we don't need to relocate */
 
 	/* Move this code somewhere safe.  This is max(load + size, end)
@@ -122,7 +122,7 @@ do_relocate:
 	GETSYM(r4, start)
 	mr	r3,r8		/* Get the load addr */
 
-	cmp	cr0,r4,r3	/* If we need to copy from the end, do so */
+	cmpw	cr0,r4,r3	/* If we need to copy from the end, do so */
 	bgt	do_relocate_from_end
 
 do_relocate_from_start:
@@ -165,7 +165,7 @@ start_ldr:
 	subi	r4,r4,4
 	li	r0,0
 50:	stwu	r0,4(r3)
-	cmp	cr0,r3,r4
+	cmpw	cr0,r3,r4
 	bne	50b
 90:	mr	r9,r1		/* Save old stack pointer (in case it matters) */
 	lis	r1,.stack@h
--- linux-2.6.8/arch/ppc/boot/openfirmware/misc.S~	2004-10-07 15:17:29.325631336 -0400
+++ linux-2.6.8/arch/ppc/boot/openfirmware/misc.S	2004-10-07 15:17:53.479959320 -0400
@@ -16,7 +16,7 @@
 setup_bats:
 	mfpvr	5
 	rlwinm	5,5,16,16,31		/* r3 = 1 for 601, 4 for 604 */
-	cmpi	0,5,1
+	cmpwi	0,5,1
 	li	0,0
 	bne	4f
 	mtibatl	3,0			/* invalidate BAT first */


-- 
dwmw2

