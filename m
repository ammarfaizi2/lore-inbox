Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUFXMaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUFXMaw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 08:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUFXMaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 08:30:52 -0400
Received: from ozlabs.org ([203.10.76.45]:14477 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264382AbUFXM22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 08:28:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16602.50913.698656.225467@cargo.ozlabs.ibm.com>
Date: Thu, 24 Jun 2004 22:19:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] Clean up head.S whitespace
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The whitespace in arch/ppc64/kernel/head.S is a bit all over the
place.  This patch fixes it up.  This patch changes nothing other than
whitespace.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN prom-cleanup/arch/ppc64/kernel/head.S g5-preempt/arch/ppc64/kernel/head.S
--- prom-cleanup/arch/ppc64/kernel/head.S	2004-06-08 21:31:30.499881320 +1000
+++ g5-preempt/arch/ppc64/kernel/head.S	2004-06-07 13:35:10.000000000 +1000
@@ -43,8 +43,8 @@
 /*
  * hcall interface to pSeries LPAR
  */
-#define HVSC .long 0x44000022
-#define H_SET_ASR		0x30
+#define HVSC		.long 0x44000022
+#define H_SET_ASR	0x30
 
 /*
  * We layout physical memory as follows:
@@ -53,19 +53,19 @@
  * 0x3000 - 0x3fff : Interrupt support
  * 0x4000 - 0x4fff : NACA
  * 0x5000 - 0x5fff : SystemCfg
- * 0x6000          : iSeries and common interrupt prologs
+ * 0x6000	   : iSeries and common interrupt prologs
  * 0x9000 - 0x9fff : Initial segment table
  */
 
 /*
  *   SPRG Usage
  *
- *   Register          Definition
+ *   Register	Definition
  *
- *   SPRG0             reserved for hypervisor
- *   SPRG1             temp - used to save gpr
- *   SPRG2             temp - used to save gpr
- *   SPRG3             virt addr of paca
+ *   SPRG0	reserved for hypervisor
+ *   SPRG1	temp - used to save gpr
+ *   SPRG2	temp - used to save gpr
+ *   SPRG3	virt addr of paca
  */
 
 /*
@@ -106,7 +106,7 @@
 	 * to the pidhash table (also used by the debugger)
 	 */
 	.llong msChunks-KERNELBASE
-	.llong 0 /* pidhash-KERNELBASE SFRXXX */
+	.llong 0	/* pidhash-KERNELBASE SFRXXX */
 
 	/* Offset 0x38 - Pointer to start of embedded System.map */
 	.globl	embedded_sysmap_start
@@ -121,13 +121,13 @@
 	/* Secondary processors spin on this value until it goes to 1. */
 	.globl  __secondary_hold_spinloop
 __secondary_hold_spinloop:
-	.llong  0x0
+	.llong	0x0
 
 	/* Secondary processors write this value with their cpu # */
-	/* after they enter the spin loop immediately below.       */
-	.globl  __secondary_hold_acknowledge
+	/* after they enter the spin loop immediately below.	  */
+	.globl	__secondary_hold_acknowledge
 __secondary_hold_acknowledge:
-	.llong  0x0
+	.llong	0x0
 
 	. = 0x60
 /*
@@ -143,25 +143,25 @@
 	mtmsrd	r24			/* RI on */
 
 	/* Grab our linux cpu number */
-	mr      r24,r3
+	mr	r24,r3
 
 	/* Tell the master cpu we're here */
 	/* Relocation is off & we are located at an address less */
 	/* than 0x100, so only need to grab low order offset.    */
-	std     r24,__secondary_hold_acknowledge@l(0)
+	std	r24,__secondary_hold_acknowledge@l(0)
 	sync
 
 	/* All secondary cpu's wait here until told to start. */
-100:    ld      r4,__secondary_hold_spinloop@l(0)
-	cmpdi   0,r4,1
-	bne     100b
+100:	ld	r4,__secondary_hold_spinloop@l(0)
+	cmpdi	0,r4,1
+	bne	100b
 
 #ifdef CONFIG_HMT
 	b	.hmt_init
 #else
 #ifdef CONFIG_SMP
-	mr      r3,r24
-	b       .pseries_secondary_smp_init
+	mr	r3,r24
+	b	.pseries_secondary_smp_init
 #else
 	BUG_OPCODE
 #endif
@@ -200,7 +200,7 @@
 #define EX_SRR0		40
 #define EX_DAR		48
 #define EX_DSISR	56
-#define EX_CCR   	60
+#define EX_CCR		60
 
 #define EXCEPTION_PROLOG_PSERIES(area, label)				\
 	mfspr	r13,SPRG3;		/* get paca address into r13 */	\
@@ -255,10 +255,10 @@
 #define EXCEPTION_PROLOG_COMMON(n, area)				   \
 	andi.	r10,r12,MSR_PR;		/* See if coming from user	*/ \
 	mr	r10,r1;			/* Save r1			*/ \
-	subi    r1,r1,INT_FRAME_SIZE;   /* alloc frame on kernel stack  */ \
-	beq-    1f;                                                        \
+	subi	r1,r1,INT_FRAME_SIZE;	/* alloc frame on kernel stack	*/ \
+	beq-	1f;							   \
 	ld	r1,PACAKSAVE(r13);	/* kernel stack to use		*/ \
-1:      cmpdi	cr1,r1,0;		/* check if r1 is in userspace  */ \
+1:	cmpdi	cr1,r1,0;		/* check if r1 is in userspace	*/ \
 	bge-	cr1,bad_stack;		/* abort if it is		*/ \
 	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
 	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
@@ -296,7 +296,7 @@
 /*
  * Exception vectors.
  */
-#define STD_EXCEPTION_PSERIES(n, label )		\
+#define STD_EXCEPTION_PSERIES(n, label)			\
 	. = n;						\
 	.globl label##_Pseries;				\
 label##_Pseries:					\
@@ -311,7 +311,7 @@
 	EXCEPTION_PROLOG_ISERIES_2;			\
 	b	label##_common
 
-#define MASKABLE_EXCEPTION_ISERIES( n, label )				\
+#define MASKABLE_EXCEPTION_ISERIES(n, label)				\
 	.globl label##_Iseries;						\
 label##_Iseries:							\
 	mtspr	SPRG1,r13;		/* save r13 */			\
@@ -375,7 +375,7 @@
 
 #endif
 
-#define STD_EXCEPTION_COMMON( trap, label, hdlr )	\
+#define STD_EXCEPTION_COMMON(trap, label, hdlr)		\
 	.align	7;					\
 	.globl label##_common;				\
 label##_common:						\
@@ -383,8 +383,8 @@
 	DISABLE_INTS;					\
 	bl	.save_nvgprs;				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;		\
-	bl      hdlr;					\
-	b       .ret_from_except
+	bl	hdlr;					\
+	b	.ret_from_except
 
 #define STD_EXCEPTION_COMMON_LITE(trap, label, hdlr)	\
 	.align	7;					\
@@ -403,7 +403,7 @@
 	.globl __start_interrupts
 __start_interrupts:
 
-	STD_EXCEPTION_PSERIES( 0x100, SystemReset )
+	STD_EXCEPTION_PSERIES(0x100, SystemReset)
 
 	. = 0x200
 	.globl MachineCheck_Pseries
@@ -443,15 +443,15 @@
 	mfspr	r12,SPRG2
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, DataAccessSLB_common)
 
-	STD_EXCEPTION_PSERIES( 0x400, InstructionAccess )
-	STD_EXCEPTION_PSERIES( 0x480, InstructionAccessSLB )
-	STD_EXCEPTION_PSERIES( 0x500, HardwareInterrupt )
-	STD_EXCEPTION_PSERIES( 0x600, Alignment )
-	STD_EXCEPTION_PSERIES( 0x700, ProgramCheck )
-	STD_EXCEPTION_PSERIES( 0x800, FPUnavailable )
-	STD_EXCEPTION_PSERIES( 0x900, Decrementer )
-	STD_EXCEPTION_PSERIES( 0xa00, Trap_0a )
-	STD_EXCEPTION_PSERIES( 0xb00, Trap_0b )
+	STD_EXCEPTION_PSERIES(0x400, InstructionAccess)
+	STD_EXCEPTION_PSERIES(0x480, InstructionAccessSLB)
+	STD_EXCEPTION_PSERIES(0x500, HardwareInterrupt)
+	STD_EXCEPTION_PSERIES(0x600, Alignment)
+	STD_EXCEPTION_PSERIES(0x700, ProgramCheck)
+	STD_EXCEPTION_PSERIES(0x800, FPUnavailable)
+	STD_EXCEPTION_PSERIES(0x900, Decrementer)
+	STD_EXCEPTION_PSERIES(0xa00, Trap_0a)
+	STD_EXCEPTION_PSERIES(0xb00, Trap_0b)
 
 	. = 0xc00
 	.globl	SystemCall_Pseries
@@ -469,8 +469,8 @@
 	mtspr	SRR1,r10
 	rfid
 
-	STD_EXCEPTION_PSERIES( 0xd00, SingleStep )
-	STD_EXCEPTION_PSERIES( 0xe00, Trap_0e )
+	STD_EXCEPTION_PSERIES(0xd00, SingleStep)
+	STD_EXCEPTION_PSERIES(0xe00, Trap_0e)
 
 	/* We need to deal with the Altivec unavailable exception
 	 * here which is at 0xf20, thus in the middle of the
@@ -482,12 +482,12 @@
 
 	STD_EXCEPTION_PSERIES(0xf20, AltivecUnavailable)
 
-	STD_EXCEPTION_PSERIES( 0x1300, InstructionBreakpoint )
-	STD_EXCEPTION_PSERIES( 0x1700, AltivecAssist )
+	STD_EXCEPTION_PSERIES(0x1300, InstructionBreakpoint)
+	STD_EXCEPTION_PSERIES(0x1700, AltivecAssist)
 
 	/* moved from 0xf00 */
 	STD_EXCEPTION_PSERIES(0x3000, PerformanceMonitor)
-	
+
 	. = 0x3100
 _GLOBAL(do_stab_bolted_Pseries)
 	mtcrf	0x80,r12
@@ -498,8 +498,8 @@
 	mtcrf	0x80,r12
 	mfspr	r12,SPRG2
 	EXCEPTION_PROLOG_PSERIES(PACA_EXSLB, .do_slb_bolted)
+
 	
-		
 	/* Space for the naca.  Architected to be located at real address
 	 * NACA_PHYS_ADDR.  Various tools rely on this location being fixed.
 	 * The first dword of the naca is required by iSeries LPAR to
@@ -538,16 +538,16 @@
 	 * VSID generation algorithm.  See include/asm/mmu_context.h.
 	 */
 
-	.llong	1		/* # ESIDs to be mapped by hypervisor         */
+	.llong	1		/* # ESIDs to be mapped by hypervisor	 */
 	.llong	1		/* # memory ranges to be mapped by hypervisor */
-	.llong	STAB0_PAGE	/* Page # of segment table within load area   */
+	.llong	STAB0_PAGE	/* Page # of segment table within load area	*/
+	.llong	0		/* Reserved */
+	.llong	0		/* Reserved */
 	.llong	0		/* Reserved */
-	.llong  0		/* Reserved */
-	.llong  0		/* Reserved */
 	.llong	0		/* Reserved */
 	.llong	0		/* Reserved */
 	.llong	0x0c00000000	/* ESID to map (Kernel at EA = 0xC000000000000000) */
-	.llong	0x06a99b4b14    /* VSID to map (Kernel at VA = 0x6a99b4b140000000) */
+	.llong	0x06a99b4b14	/* VSID to map (Kernel at VA = 0x6a99b4b140000000) */
 	.llong	8192		/* # pages to map (32 MB) */
 	.llong	0		/* Offset from start of loadarea to start of map */
 	.llong	0x0006a99b4b140000	/* VPN of first page to map */
@@ -662,7 +662,7 @@
 	rldicr	r3,r3,32,15		/* r0 = (r3 << 32) & 0xffff000000000000 */
 #else /* CONFIG_SMP */
 	/* Yield the processor.  This is required for non-SMP kernels
-	   which are running on multi-threaded machines. */
+		which are running on multi-threaded machines. */
 	lis	r3,0x8000
 	rldicr	r3,r3,32,15		/* r3 = (r3 << 32) & 0xffff000000000000 */
 	addi	r3,r3,18		/* r3 = 0x8000000000000012 which is "yield" */
@@ -701,7 +701,7 @@
 /*
  * Data area reserved for FWNMI option.
  */
-        .= 0x7000
+	.= 0x7000
 	.globl fwnmi_data_area
 fwnmi_data_area:
 
@@ -734,7 +734,7 @@
 
 /*** Common interrupt handlers ***/
 
-	STD_EXCEPTION_COMMON( 0x100, SystemReset, .SystemResetException )
+	STD_EXCEPTION_COMMON(0x100, SystemReset, .SystemResetException)
 
 	/*
 	 * Machine check is different because we use a different
@@ -751,16 +751,16 @@
 	b	.ret_from_except
 
 	STD_EXCEPTION_COMMON_LITE(0x900, Decrementer, .timer_interrupt)
-	STD_EXCEPTION_COMMON( 0xa00, Trap_0a, .UnknownException )
-	STD_EXCEPTION_COMMON( 0xb00, Trap_0b, .UnknownException )
-	STD_EXCEPTION_COMMON( 0xd00, SingleStep, .SingleStepException )
-	STD_EXCEPTION_COMMON( 0xe00, Trap_0e, .UnknownException )
-	STD_EXCEPTION_COMMON( 0xf00, PerformanceMonitor, .PerformanceMonitorException )
-	STD_EXCEPTION_COMMON(0x1300, InstructionBreakpoint, .InstructionBreakpointException )
+	STD_EXCEPTION_COMMON(0xa00, Trap_0a, .UnknownException)
+	STD_EXCEPTION_COMMON(0xb00, Trap_0b, .UnknownException)
+	STD_EXCEPTION_COMMON(0xd00, SingleStep, .SingleStepException)
+	STD_EXCEPTION_COMMON(0xe00, Trap_0e, .UnknownException)
+	STD_EXCEPTION_COMMON(0xf00, PerformanceMonitor, .PerformanceMonitorException)
+	STD_EXCEPTION_COMMON(0x1300, InstructionBreakpoint, .InstructionBreakpointException)
 #ifdef CONFIG_ALTIVEC
-	STD_EXCEPTION_COMMON(0x1700, AltivecAssist, .AltivecAssistException )
+	STD_EXCEPTION_COMMON(0x1700, AltivecAssist, .AltivecAssistException)
 #else
-	STD_EXCEPTION_COMMON(0x1700, AltivecAssist, .UnknownException )
+	STD_EXCEPTION_COMMON(0x1700, AltivecAssist, .UnknownException)
 #endif
 
 /*
@@ -787,7 +787,7 @@
 	std	r10,_LINK(r1)
 	std	r11,_CTR(r1)
 	std	r12,_XER(r1)
-	SAVE_GPR(0, r1)
+	SAVE_GPR(0,r1)
 	SAVE_GPR(2,r1)
 	SAVE_4GPRS(3,r1)
 	SAVE_2GPRS(7,r1)
@@ -815,13 +815,13 @@
 	ld	r11,_NIP(r1)
 	andi.	r3,r12,MSR_RI		/* check if RI is set */
 	beq-	unrecov_fer
-	ld      r3,_CCR(r1)
-	ld      r4,_LINK(r1)
-	ld      r5,_CTR(r1)
-	ld      r6,_XER(r1)
-	mtcr    r3
-	mtlr    r4
-	mtctr   r5
+	ld	r3,_CCR(r1)
+	ld	r4,_LINK(r1)
+	ld	r5,_CTR(r1)
+	ld	r6,_XER(r1)
+	mtcr	r3
+	mtlr	r4
+	mtctr	r5
 	mtxer	r6
 	REST_GPR(0, r1)
 	REST_8GPRS(2, r1)
@@ -833,7 +833,7 @@
 	mtspr	SRR1,r12
 	mtspr	SRR0,r11
 	REST_4GPRS(10, r1)
-	ld      r1,GPR1(r1)
+	ld	r1,GPR1(r1)
 	rfid
 
 unrecov_fer:
@@ -870,7 +870,7 @@
 	std	r3,_DAR(r1)
 	bl	.slb_allocate
 	cmpdi	r3,0			/* Check return code */
-	beq     fast_exception_return   /* Return if we succeeded */
+	beq	fast_exception_return	/* Return if we succeeded */
 	li	r5,0
 	std	r5,_DSISR(r1)
 	b	.handle_page_fault
@@ -891,7 +891,7 @@
 	ld	r3,_NIP(r1)		/* SRR0 = NIA	*/
 	bl	.slb_allocate
 	or.	r3,r3,r3		/* Check return code */
-	beq+	fast_exception_return   /* Return if we succeeded */
+	beq+	fast_exception_return	/* Return if we succeeded */
 
 	ld	r4,_NIP(r1)
 	li	r5,0
@@ -907,7 +907,7 @@
 HardwareInterrupt_entry:
 	DISABLE_INTS
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl      .do_IRQ
+	bl	.do_IRQ
 	b	.ret_from_except_lite
 
 	.align	7
@@ -925,8 +925,8 @@
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ENABLE_INTS
-	bl      .AlignmentException
-	b       .ret_from_except
+	bl	.AlignmentException
+	b	.ret_from_except
 
 	.align	7
 	.globl ProgramCheck_common
@@ -935,8 +935,8 @@
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ENABLE_INTS
-	bl      .ProgramCheckException
-	b       .ret_from_except
+	bl	.ProgramCheckException
+	b	.ret_from_except
 
 	.align	7
 	.globl FPUnavailable_common
@@ -946,7 +946,7 @@
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ENABLE_INTS
-	bl      .KernelFPUnavailableException
+	bl	.KernelFPUnavailableException
 	BUG_OPCODE
 
 	.align	7
@@ -961,7 +961,7 @@
 	ENABLE_INTS
 	bl	.AltivecUnavailableException
 	b	.ret_from_except
-		
+
 /*
  * Hash table stuff
  */
@@ -1091,19 +1091,19 @@
 	andi.	r11,r10,0x70
 	bne	1b
 
-	/* Stick for only searching the primary group for now.          */
+	/* Stick for only searching the primary group for now.		*/
 	/* At least for now, we use a very simple random castout scheme */
-	/* Use the TB as a random number ;  OR in 1 to avoid entry 0    */
+	/* Use the TB as a random number ;  OR in 1 to avoid entry 0	*/
 	mftb	r11
 	rldic	r11,r11,4,57	/* r11 = (r11 << 4) & 0x70 */
 	ori	r11,r11,0x10
 
 	/* r10 currently points to an ste one past the group of interest */
-	/* make it point to the randomly selected entry                   */
+	/* make it point to the randomly selected entry			*/
 	subi	r10,r10,128
 	or 	r10,r10,r11	/* r10 is the entry to invalidate	*/
 
-	isync                    /* mark the entry invalid                */
+	isync			/* mark the entry invalid		*/
 	ld	r11,0(r10)
 	rldicl	r11,r11,56,1	/* clear the valid bit */
 	rotldi	r11,r11,8
@@ -1301,24 +1301,24 @@
 	isync
 
 	/* Set up a paca value for this processor. */
-	LOADADDR(r24, paca) 		 /* Get base vaddr of paca array  */
-	mulli	r13,r3,PACA_SIZE	 /* Calculate vaddr of right paca */
-	add	r13,r13,r24              /* for this processor.           */
+	LOADADDR(r24, paca) 		/* Get base vaddr of paca array	 */
+	mulli	r13,r3,PACA_SIZE	/* Calculate vaddr of right paca */
+	add	r13,r13,r24		/* for this processor.		 */
 
-	mtspr	SPRG3,r13		 /* Save vaddr of paca in SPRG3   */
-	mr	r24,r3			 /* __secondary_start needs cpu#  */
+	mtspr	SPRG3,r13		/* Save vaddr of paca in SPRG3	 */
+	mr	r24,r3			/* __secondary_start needs cpu#	 */
 
 1:
 	HMT_LOW
-	lbz	r23,PACAPROCSTART(r13)	 /* Test if this processor should */
-					 /* start.                        */
+	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor should */
+					/* start.			 */
 	sync
 
-        /* Create a temp kernel stack for use before relocation is on.    */
-        mr      r1,r13
-        addi    r1,r1,PACAGUARD
-        addi    r1,r1,0x1000
-        subi    r1,r1,STACK_FRAME_OVERHEAD
+	/* Create a temp kernel stack for use before relocation is on.	*/
+	mr	r1,r13
+	addi	r1,r1,PACAGUARD
+	addi	r1,r1,0x1000
+	subi	r1,r1,STACK_FRAME_OVERHEAD
 
 	cmpwi	0,r23,0
 #ifdef CONFIG_SMP
@@ -1326,7 +1326,7 @@
 	bne	.__secondary_start
 #endif
 #endif
-	b 	1b			 /* Loop until told to go         */
+	b 	1b			/* Loop until told to go	 */
 #ifdef CONFIG_PPC_ISERIES
 _GLOBAL(__start_initialization_iSeries)
 	/* Clear out the BSS */
@@ -1334,13 +1334,13 @@
 
 	LOADADDR(r8,__bss_start)
 
-	sub	r11,r11,r8        /* bss size                        */
-	addi	r11,r11,7         /* round up to an even double word */
-	rldicl. r11,r11,61,3      /* shift right by 3                */
+	sub	r11,r11,r8		/* bss size			*/
+	addi	r11,r11,7		/* round up to an even double word */
+	rldicl. r11,r11,61,3		/* shift right by 3		*/
 	beq	4f
 	addi	r8,r8,-8
 	li	r0,0
-	mtctr	r11		  /* zero this many doublewords      */
+	mtctr	r11			/* zero this many doublewords	*/
 3:	stdu	r0,8(r8)
 	bdnz	3b
 4:
@@ -1367,10 +1367,10 @@
 	std	r4,0(r9)		/* set the naca pointer */
 
 	/* Get the pointer to the segment table */
-	ld	r6,PACA(r4)             /* Get the base paca pointer       */
+	ld	r6,PACA(r4)		/* Get the base paca pointer	*/
 	ld	r4,PACASTABVIRT(r6)
 
-	bl      .iSeries_fixup_klimit
+	bl	.iSeries_fixup_klimit
 
 	/* relocation is on at this point */
 
@@ -1401,8 +1401,8 @@
 	bl	.reloc_offset
 
 	LOADADDR(r2,__toc_start)
-	addi    r2,r2,0x4000
-	addi    r2,r2,0x4000
+	addi	r2,r2,0x4000
+	addi	r2,r2,0x4000
 
 	/* Relocate the TOC from a virt addr to a real addr */
 	sub	r2,r2,r3
@@ -1443,33 +1443,33 @@
  * unknown exception placeholders.
  *
  * Note: This process overwrites the OF exception vectors.
- *       r26 == relocation offset
- *       r27 == KERNELBASE
+ *	r26 == relocation offset
+ *	r27 == KERNELBASE
  */
 	bl	.reloc_offset
 	mr	r26,r3
 	SET_REG_TO_CONST(r27,KERNELBASE)
 
-	li	r3,0                    /* target addr */
+	li	r3,0			/* target addr */
 
 	// XXX FIXME: Use phys returned by OF (r23)
-	sub	r4,r27,r26 		/* source addr */
-					/* current address of _start   */
-			                /*   i.e. where we are running */
-			                /*        the source addr      */
+	sub	r4,r27,r26 		/* source addr			 */
+					/* current address of _start	 */
+					/*   i.e. where we are running	 */
+					/*	the source addr		 */
 
-	LOADADDR(r5,copy_to_here)	/* # bytes of memory to copy      */
+	LOADADDR(r5,copy_to_here)	/* # bytes of memory to copy	 */
 	sub	r5,r5,r27
 
-	li	r6,0x100		/* Start offset, the first 0x100  */
-					/* bytes were copied earlier.	  */
+	li	r6,0x100		/* Start offset, the first 0x100 */
+					/* bytes were copied earlier.	 */
 
-	bl	.copy_and_flush		/* copy the first n bytes         */
-					/* this includes the code being   */
-					/* executed here.                 */
+	bl	.copy_and_flush		/* copy the first n bytes	 */
+					/* this includes the code being	 */
+					/* executed here.		 */
 
-        LOADADDR(r0, 4f)                /* Jump to the copy of this code  */
-	mtctr	r0			/* that we just made/relocated    */
+	LOADADDR(r0, 4f)		/* Jump to the copy of this code */
+	mtctr	r0			/* that we just made/relocated	 */
 	bctr
 
 4:	LOADADDR(r5,klimit)
@@ -1491,23 +1491,23 @@
 _GLOBAL(copy_and_flush)
 	addi	r5,r5,-8
 	addi	r6,r6,-8
-4:	li	r0,16                   /* Use the least common      */
-					/* denominator cache line    */
-			                /* size.  This results in    */
-					/* extra cache line flushes  */
-					/* but operation is correct. */
-					/* Can't get cache line size */
-					/* from NACA as it is being  */
-					/* moved too.                */
+4:	li	r0,16			/* Use the least common		*/
+					/* denominator cache line	*/
+					/* size.  This results in	*/
+					/* extra cache line flushes	*/
+					/* but operation is correct.	*/
+					/* Can't get cache line size	*/
+					/* from NACA as it is being	*/
+					/* moved too.			*/
 
-	mtctr	r0			/* put # words/line in ctr */
-3:	addi	r6,r6,8			/* copy a cache line */
+	mtctr	r0			/* put # words/line in ctr	*/
+3:	addi	r6,r6,8			/* copy a cache line		*/
 	ldx	r0,r6,r4
 	stdx	r0,r6,r3
 	bdnz	3b
-	dcbst	r6,r3			/* write it to memory */
+	dcbst	r6,r3			/* write it to memory		*/
 	sync
-	icbi	r6,r3			/* flush the icache line */
+	icbi	r6,r3			/* flush the icache line	*/
 	cmpld	0,r6,r5
 	blt	4b
 	sync
@@ -1528,9 +1528,9 @@
  * On entry: r13 == 'current' && last_task_used_math != 'current'
  */
 _STATIC(load_up_fpu)
-	mfmsr	r5                      /* grab the current MSR */
+	mfmsr	r5			/* grab the current MSR */
 	ori	r5,r5,MSR_FP
-	mtmsrd  r5			/* enable use of fpu now */
+	mtmsrd	r5			/* enable use of fpu now */
 	isync
 /*
  * For SMP, we don't do lazy FPU switching because it just gets too
@@ -1579,10 +1579,10 @@
  * Disable the FPU.
  */
 _GLOBAL(disable_kernel_fp)
-	mfmsr   r3
-	rldicl  r0,r3,(63-MSR_FP_LG),1
-	rldicl  r3,r0,(MSR_FP_LG+1),0
-	mtmsrd  r3			/* disable use of fpu now */
+	mfmsr	r3
+	rldicl	r0,r3,(63-MSR_FP_LG),1
+	rldicl	r3,r0,(MSR_FP_LG+1),0
+	mtmsrd	r3			/* disable use of fpu now */
 	isync
 	blr
 
@@ -1631,9 +1631,9 @@
  * On entry: r13 == 'current' && last_task_used_altivec != 'current'
  */
 _STATIC(load_up_altivec)
-	mfmsr	r5                      /* grab the current MSR */
+	mfmsr	r5			/* grab the current MSR */
 	oris	r5,r5,MSR_VEC@h
-	mtmsrd  r5			/* enable use of VMX now */
+	mtmsrd	r5			/* enable use of VMX now */
 	isync
 	
 /*
@@ -1697,10 +1697,10 @@
  * Disable the VMX.
  */
 _GLOBAL(disable_kernel_altivec)
-	mfmsr   r3
-	rldicl  r0,r3,(63-MSR_VEC_LG),1
-	rldicl  r3,r0,(MSR_VEC_LG+1),0
-	mtmsrd  r3			/* disable use of VMX now */
+	mfmsr	r3
+	rldicl	r0,r3,(63-MSR_VEC_LG),1
+	rldicl	r3,r0,(MSR_VEC_LG+1),0
+	mtmsrd	r3			/* disable use of VMX now */
 	isync
 	blr
 
@@ -1777,16 +1777,16 @@
 	mtmsrd	r3			/* RI on */
 
 	/* Set up a paca value for this processor. */
-	LOADADDR(r4, paca) 		 /* Get base vaddr of paca array  */
+	LOADADDR(r4, paca) 		 /* Get base vaddr of paca array	*/
 	mulli	r13,r24,PACA_SIZE	 /* Calculate vaddr of right paca */
-	add	r13,r13,r4               /* for this processor.           */
-	mtspr	SPRG3,r13		 /* Save vaddr of paca in SPRG3   */
+	add	r13,r13,r4		/* for this processor.		*/
+	mtspr	SPRG3,r13		 /* Save vaddr of paca in SPRG3	*/
 
-        /* Create a temp kernel stack for use before relocation is on.    */
-        mr      r1,r13
-        addi    r1,r1,PACAGUARD
-        addi    r1,r1,0x1000
-        subi    r1,r1,STACK_FRAME_OVERHEAD
+	/* Create a temp kernel stack for use before relocation is on.	*/
+	mr	r1,r13
+	addi	r1,r1,PACAGUARD
+	addi	r1,r1,0x1000
+	subi	r1,r1,STACK_FRAME_OVERHEAD
 
 	b	.__secondary_start
 
@@ -1800,7 +1800,7 @@
  *   1. Processor number
  *   2. Segment table pointer (virtual address)
  * On entry the following are set:
- *   r1    = stack pointer.  vaddr for iSeries, raddr (temp stack) for pSeries
+ *   r1	= stack pointer.  vaddr for iSeries, raddr (temp stack) for pSeries
  *   r24   = cpu# (in Linux terms)
  *   r13   = paca virtual address
  *   SPRG3 = paca virtual address
@@ -1811,8 +1811,8 @@
 
 	/* set up the TOC (virtual address) */
 	LOADADDR(r2,__toc_start)
-	addi    r2,r2,0x4000
-	addi    r2,r2,0x4000
+	addi	r2,r2,0x4000
+	addi	r2,r2,0x4000
 
 	std	r2,PACATOC(r13)
 	li	r6,0
@@ -1821,24 +1821,24 @@
 #ifndef CONFIG_PPC_ISERIES
 	/* Initialize the page table pointer register. */
 	LOADADDR(r6,_SDR1)
-	ld	r6,0(r6)		/* get the value of _SDR1 */
-	mtspr	SDR1,r6			/* set the htab location  */
+	ld	r6,0(r6)		/* get the value of _SDR1	 */
+	mtspr	SDR1,r6			/* set the htab location	 */
 #endif
-	/* Initialize the first segment table (or SLB) entry                */
-	ld	r3,PACASTABVIRT(r13)    /* get addr of segment table        */
+	/* Initialize the first segment table (or SLB) entry		 */
+	ld	r3,PACASTABVIRT(r13)	/* get addr of segment table	 */
 	bl	.stab_initialize
 
-	/* Initialize the kernel stack.  Just a repeat for iSeries.         */
+	/* Initialize the kernel stack.  Just a repeat for iSeries.	 */
 	LOADADDR(r3,current_set)
-	sldi	r28,r24,3		/* get current_set[cpu#] */
+	sldi	r28,r24,3		/* get current_set[cpu#]	 */
 	ldx	r1,r3,r28
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
 	li	r0,0
 	std	r0,0(r1)
 	std	r1,PACAKSAVE(r13)
 
-	ld	r3,PACASTABREAL(r13)    /* get raddr of segment table       */
-	ori	r4,r3,1			/* turn on valid bit                */
+	ld	r3,PACASTABREAL(r13)	/* get raddr of segment table	 */
+	ori	r4,r3,1			/* turn on valid bit		 */
 
 #ifdef CONFIG_PPC_ISERIES
 	li	r0,-1			/* hypervisor call */
@@ -1848,23 +1848,23 @@
 	sc				/* HvCall_setASR */
 #else
 	/* set the ASR */
-	li	r3,SYSTEMCFG_PHYS_ADDR	/* r3 = ptr to systemcfg  */
-	lwz   	r3,PLATFORM(r3)		/* r3 = platform flags */
+	li	r3,SYSTEMCFG_PHYS_ADDR	/* r3 = ptr to systemcfg	 */
+	lwz	r3,PLATFORM(r3)		/* r3 = platform flags		 */
 	cmpldi 	r3,PLATFORM_PSERIES_LPAR
-	bne   	98f
+	bne	98f
 	mfspr	r3,PVR
 	srwi	r3,r3,16
-	cmpwi	r3,0x37         /* SStar  */
+	cmpwi	r3,0x37			/* SStar  */
 	beq	97f
-	cmpwi	r3,0x36         /* IStar  */
+	cmpwi	r3,0x36			/* IStar  */
 	beq	97f
-	cmpwi	r3,0x34         /* Pulsar */
+	cmpwi	r3,0x34			/* Pulsar */
 	bne	98f
-97:	li	r3,H_SET_ASR    /* hcall = H_SET_ASR */
-	HVSC     		/* Invoking hcall */
+97:	li	r3,H_SET_ASR		/* hcall = H_SET_ASR */
+	HVSC				/* Invoking hcall */
 	b	99f
-98:                             /* !(rpa hypervisor) || !(star)  */
-	mtasr	r4	        /* set the stab location         */
+98:					/* !(rpa hypervisor) || !(star)  */
+	mtasr	r4			/* set the stab location	 */
 99:
 #endif
 	li	r7,0
@@ -1886,7 +1886,7 @@
  */
 _GLOBAL(start_secondary_prolog)
 	li	r3,0
-	std	r3,0(r1)                /* Zero the stack frame pointer     */
+	std	r3,0(r1)		/* Zero the stack frame pointer	*/
 	bl	.start_secondary
 #endif
 
@@ -1894,14 +1894,14 @@
  * This subroutine clobbers r11 and r12
  */
 _GLOBAL(enable_64b_mode)
-	mfmsr   r11                      /* grab the current MSR */
-	li      r12,1
-	rldicr  r12,r12,MSR_SF_LG,(63-MSR_SF_LG)
-	or      r11,r11,r12
-	li      r12,1
-	rldicr  r12,r12,MSR_ISF_LG,(63-MSR_ISF_LG)
-	or      r11,r11,r12
-	mtmsrd  r11
+	mfmsr	r11			/* grab the current MSR */
+	li	r12,1
+	rldicr	r12,r12,MSR_SF_LG,(63-MSR_SF_LG)
+	or	r11,r11,r12
+	li	r12,1
+	rldicr	r12,r12,MSR_ISF_LG,(63-MSR_ISF_LG)
+	or	r11,r11,r12
+	mtmsrd	r11
 	isync
 	blr
 
@@ -1918,30 +1918,30 @@
 	ori	r6,r6,MSR_RI
 	mtmsrd	r6			/* RI on */
 
-	/* setup the systemcfg pointer which is needed by *tab_initialize  */
+	/* setup the systemcfg pointer which is needed by *tab_initialize	*/
 	LOADADDR(r6,systemcfg)
-	sub	r6,r6,r26                /* addr of the variable systemcfg */
+	sub	r6,r6,r26		/* addr of the variable systemcfg */
 	li	r27,SYSTEMCFG_PHYS_ADDR
-	std	r27,0(r6)	 	 /* set the value of systemcfg     */
+	std	r27,0(r6)	 	/* set the value of systemcfg	*/
 
-	/* setup the naca pointer which is needed by *tab_initialize       */
+	/* setup the naca pointer which is needed by *tab_initialize	*/
 	LOADADDR(r6,naca)
-	sub	r6,r6,r26                /* addr of the variable naca      */
+	sub	r6,r6,r26		/* addr of the variable naca	*/
 	li	r27,NACA_PHYS_ADDR
-	std	r27,0(r6)	 	 /* set the value of naca          */
+	std	r27,0(r6)	 	/* set the value of naca	*/
 
 #ifdef CONFIG_HMT
 	/* Start up the second thread on cpu 0 */
 	mfspr	r3,PVR
 	srwi	r3,r3,16
-	cmpwi	r3,0x34                 /* Pulsar  */
+	cmpwi	r3,0x34			/* Pulsar  */
 	beq	90f
-	cmpwi	r3,0x36                 /* Icestar */
+	cmpwi	r3,0x36			/* Icestar */
 	beq	90f
-	cmpwi	r3,0x37                 /* SStar   */
+	cmpwi	r3,0x37			/* SStar   */
 	beq	90f
-	b	91f                     /* HMT not supported */
-90:	li      r3,0
+	b	91f			/* HMT not supported */
+90:	li	r3,0
 	bl	.hmt_start_secondary
 91:
 #endif
@@ -1956,7 +1956,7 @@
 	li	r3,1
 	LOADADDR(r5,__secondary_hold_spinloop)
 	tophys(r4,r5)
-	std     r3,0(r4)
+	std	r3,0(r4)
 #endif
 
 	/* The following gets the stack and TOC set up with the regs */
@@ -1975,8 +1975,8 @@
 
 		/* set up the TOC (physical address) */
 	LOADADDR(r2,__toc_start)
-	addi    r2,r2,0x4000
-	addi    r2,r2,0x4000
+	addi	r2,r2,0x4000
+	addi	r2,r2,0x4000
 	sub	r2,r2,r26
 
 	LOADADDR(r3,cpu_specs)
@@ -1986,44 +1986,44 @@
 	mr	r5,r26
 	bl	.identify_cpu
 
-	/* Get the pointer to the segment table which is used by           */
-	/* stab_initialize                                                 */
+	/* Get the pointer to the segment table which is used by		*/
+	/* stab_initialize						 */
 	LOADADDR(r27, boot_cpuid)
 	sub	r27,r27,r26
 	lwz	r27,0(r27)
 
-	LOADADDR(r24, paca) 		 /* Get base vaddr of paca array  */
-	mulli	r13,r27,PACA_SIZE	 /* Calculate vaddr of right paca */
-	add	r13,r13,r24              /* for this processor.           */
-	sub	r13,r13,r26		/* convert to physical addr         */
+	LOADADDR(r24, paca) 		/* Get base vaddr of paca array	 */
+	mulli	r13,r27,PACA_SIZE	/* Calculate vaddr of right paca */
+	add	r13,r13,r24		/* for this processor.		 */
+	sub	r13,r13,r26		/* convert to physical addr	 */
 
 	mtspr	SPRG3,r13		/* PPPBBB: Temp... -Peter */
 	ld	r3,PACASTABREAL(r13)
-	ori	r4,r3,1			/* turn on valid bit                */
+	ori	r4,r3,1			/* turn on valid bit		 */
 	
 	/* set the ASR */
 	li	r3,SYSTEMCFG_PHYS_ADDR	/* r3 = ptr to systemcfg */
-	lwz   	r3,PLATFORM(r3)		/* r3 = platform flags */
+	lwz	r3,PLATFORM(r3)		/* r3 = platform flags */
 	cmpldi 	r3,PLATFORM_PSERIES_LPAR
-	bne   	98f
+	bne	98f
 	mfspr	r3,PVR
 	srwi	r3,r3,16
-	cmpwi	r3,0x37         /* SStar */
+	cmpwi	r3,0x37			/* SStar */
 	beq	97f
-	cmpwi	r3,0x36         /* IStar  */
+	cmpwi	r3,0x36			/* IStar  */
 	beq	97f
-	cmpwi	r3,0x34         /* Pulsar */
+	cmpwi	r3,0x34			/* Pulsar */
 	bne	98f
-97:	li	r3,H_SET_ASR    /* hcall = H_SET_ASR */
-	HVSC     	        /* Invoking hcall */
-	b     	99f
-98:                             /* !(rpa hypervisor) || !(star) */
-	mtasr	r4	        /* set the stab location         */
+97:	li	r3,H_SET_ASR		/* hcall = H_SET_ASR */
+	HVSC				/* Invoking hcall */
+	b	99f
+98:					/* !(rpa hypervisor) || !(star) */
+	mtasr	r4			/* set the stab location	*/
 99:
 	mfspr	r6,SPRG3
-	ld	r3,PACASTABREAL(r6)     /* restore r3 for stab_initialize */
+	ld	r3,PACASTABREAL(r6)	/* restore r3 for stab_initialize */
 
-	/* Initialize an initial memory mapping and turn on relocation.   */
+	/* Initialize an initial memory mapping and turn on relocation.	*/
 	bl	.stab_initialize
 	bl	.htab_initialize
 
@@ -2031,7 +2031,7 @@
 	lwz	r3,PLATFORM(r3)		/* r3 = platform flags */
 	/* Test if bit 0 is set (LPAR bit) */
 	andi.	r3,r3,0x1
-	bne    98f
+	bne	98f
 	LOADADDR(r6,_SDR1)		/* Only if NOT LPAR */
 	sub	r6,r6,r26
 	ld	r6,0(r6)		/* get the value of _SDR1 */
@@ -2060,8 +2060,8 @@
 
 	/* set up the TOC */
 	LOADADDR(r2,__toc_start)
-	addi    r2,r2,0x4000
-	addi    r2,r2,0x4000
+	addi	r2,r2,0x4000
+	addi	r2,r2,0x4000
 
 	/* Apply the CPUs-specific fixups (nop out sections not relevant
 	 * to this CPU
@@ -2077,14 +2077,14 @@
 	/* setup the naca pointer */
 	LOADADDR(r9,naca)
 	SET_REG_TO_CONST(r8, NACA_VIRT_ADDR)
-	std	r8,0(r9)		/* set the value of the naca ptr  */
+	std	r8,0(r9)		/* set the value of the naca ptr */
 
 	LOADADDR(r26, boot_cpuid)
 	lwz	r26,0(r26)
 
-	LOADADDR(r24, paca) 		 /* Get base vaddr of paca array  */
-	mulli	r13,r26,PACA_SIZE	 /* Calculate vaddr of right paca */
-	add	r13,r13,r24              /* for this processor.           */
+	LOADADDR(r24, paca) 		/* Get base vaddr of paca array  */
+	mulli	r13,r26,PACA_SIZE	/* Calculate vaddr of right paca */
+	add	r13,r13,r24		/* for this processor.		 */
 	mtspr	SPRG3,r13
 
 	/* ptr to current */
@@ -2123,11 +2123,11 @@
 	LOADADDR(r5, hmt_thread_data)
 	mfspr	r7,PVR
 	srwi	r7,r7,16
-	cmpwi	r7,0x34                 /* Pulsar  */
+	cmpwi	r7,0x34			/* Pulsar  */
 	beq	90f
-	cmpwi	r7,0x36                 /* Icestar */
+	cmpwi	r7,0x36			/* Icestar */
 	beq	91f
-	cmpwi	r7,0x37                 /* SStar   */
+	cmpwi	r7,0x37			/* SStar   */
 	beq	91f
 	b	101f
 90:	mfspr	r6,PIR
@@ -2161,32 +2161,32 @@
 
 104:	addi	r7,r7,4
 	lwzx	r9,r5,r7
-	mr      r24,r9
+	mr	r24,r9
 101:
 #endif
-	mr      r3,r24
-	b       .pseries_secondary_smp_init
+	mr	r3,r24
+	b	.pseries_secondary_smp_init
 
 #ifdef CONFIG_HMT
 _GLOBAL(hmt_start_secondary)
 	LOADADDR(r4,__hmt_secondary_hold)
 	clrldi	r4,r4,4
-	mtspr   NIADORM, r4
-	mfspr   r4, MSRDORM
-	li      r5, -65
-	and     r4, r4, r5
-	mtspr   MSRDORM, r4
+	mtspr	NIADORM, r4
+	mfspr	r4, MSRDORM
+	li	r5, -65
+	and	r4, r4, r5
+	mtspr	MSRDORM, r4
 	lis	r4,0xffef
 	ori	r4,r4,0x7403
 	mtspr	TSC, r4
 	li	r4,0x1f4
 	mtspr	TST, r4
-	mfspr   r4, HID0
-	ori     r4, r4, 0x1
-	mtspr   HID0, r4
-	mfspr   r4, CTRLF
-	oris    r4, r4, 0x40
-	mtspr   CTRLT, r4
+	mfspr	r4, HID0
+	ori	r4, r4, 0x1
+	mtspr	HID0, r4
+	mfspr	r4, CTRLF
+	oris	r4, r4, 0x40
+	mtspr	CTRLT, r4
 	blr
 #endif
 
@@ -2196,7 +2196,7 @@
  * which is page-aligned.
  */
 	.data
-	.align  12
+	.align	12
 	.globl	sdata
 sdata:
 	.globl	empty_zero_page
@@ -2214,7 +2214,7 @@
 /* 1 page segment table per cpu (max 48, cpu0 allocated at STAB0_PHYS_ADDR) */
 	.globl	stab_array
 stab_array:
-        .space	4096 * 48
+	.space	4096 * 48
 	
 /*
  * This space gets a copy of optional info passed to us by the bootstrap
