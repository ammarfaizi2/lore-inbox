Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVAEFk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVAEFk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 00:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVAEFk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 00:40:27 -0500
Received: from ozlabs.org ([203.10.76.45]:34759 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262251AbVAEFfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 00:35:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16859.31868.528367.951243@cargo.ozlabs.ibm.com>
Date: Wed, 5 Jan 2005 16:34:52 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Jake Moilanen <moilanen@austin.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 (2/3) Clean up trap handling in head.S
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Jake Moilanen <moilanen@austin.ibm.com>.

Changed the naming conventions for head.S to more closely follow
the Linux naming conventions.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN base-2.6/arch/ppc64/kernel/LparData.c test/arch/ppc64/kernel/LparData.c
--- base-2.6/arch/ppc64/kernel/LparData.c	2005-01-05 15:02:44.225477712 +1100
+++ test/arch/ppc64/kernel/LparData.c	2005-01-05 16:01:40.725518624 +1100
@@ -59,23 +59,23 @@
 		0xf4, 0x4b, 0xf6, 0xf4 },
 };
 
-extern void SystemReset_Iseries(void);
-extern void MachineCheck_Iseries(void);
-extern void DataAccess_Iseries(void);
-extern void InstructionAccess_Iseries(void);
-extern void HardwareInterrupt_Iseries(void);
-extern void Alignment_Iseries(void);
-extern void ProgramCheck_Iseries(void);
-extern void FPUnavailable_Iseries(void);
-extern void Decrementer_Iseries(void);
-extern void Trap_0a_Iseries(void);
-extern void Trap_0b_Iseries(void);
-extern void SystemCall_Iseries(void);
-extern void SingleStep_Iseries(void);
-extern void Trap_0e_Iseries(void);
-extern void PerformanceMonitor_Iseries(void);
-extern void DataAccessSLB_Iseries(void);
-extern void InstructionAccessSLB_Iseries(void);
+extern void system_reset_iSeries(void);
+extern void machine_check_iSeries(void);
+extern void data_access_iSeries(void);
+extern void instruction_access_iSeries(void);
+extern void hardware_interrupt_iSeries(void);
+extern void alignment_iSeries(void);
+extern void program_check_iSeries(void);
+extern void fp_unavailable_iSeries(void);
+extern void decrementer_iSeries(void);
+extern void trap_0a_iSeries(void);
+extern void trap_0b_iSeries(void);
+extern void system_call_iSeries(void);
+extern void single_step_iSeries(void);
+extern void trap_0e_iSeries(void);
+extern void performance_monitor_iSeries(void);
+extern void data_access_slb_iSeries(void);
+extern void instruction_access_slb_iSeries(void);
 	
 struct ItLpNaca itLpNaca = {
 	.xDesc = 0xd397d581,		/* "LpNa" ebcdic */
@@ -105,27 +105,27 @@
 	.xSlicSegmentTablePtr = 0,	/* seg table */
 	.xOldLpQueue = { 0 }, 		/* Old LP Queue */
 	.xInterruptHdlr = {
-		(u64)SystemReset_Iseries,	/* 0x100 System Reset */
-		(u64)MachineCheck_Iseries,	/* 0x200 Machine Check */
-		(u64)DataAccess_Iseries,	/* 0x300 Data Access */
-		(u64)InstructionAccess_Iseries,	/* 0x400 Instruction Access */
-		(u64)HardwareInterrupt_Iseries,	/* 0x500 External */
-		(u64)Alignment_Iseries,		/* 0x600 Alignment */
-		(u64)ProgramCheck_Iseries,	/* 0x700 Program Check */
-		(u64)FPUnavailable_Iseries,	/* 0x800 FP Unavailable */
-		(u64)Decrementer_Iseries,	/* 0x900 Decrementer */
-		(u64)Trap_0a_Iseries,		/* 0xa00 Trap 0A */
-		(u64)Trap_0b_Iseries,		/* 0xb00 Trap 0B */
-		(u64)SystemCall_Iseries,	/* 0xc00 System Call */
-		(u64)SingleStep_Iseries,	/* 0xd00 Single Step */
-		(u64)Trap_0e_Iseries,		/* 0xe00 Trap 0E */
-		(u64)PerformanceMonitor_Iseries,/* 0xf00 Performance Monitor */
+		(u64)system_reset_iSeries,	/* 0x100 System Reset */
+		(u64)machine_check_iSeries,	/* 0x200 Machine Check */
+		(u64)data_access_iSeries,	/* 0x300 Data Access */
+		(u64)instruction_access_iSeries, /* 0x400 Instruction Access */
+		(u64)hardware_interrupt_iSeries, /* 0x500 External */
+		(u64)alignment_iSeries,		/* 0x600 Alignment */
+		(u64)program_check_iSeries,	/* 0x700 Program Check */
+		(u64)fp_unavailable_iSeries,	/* 0x800 FP Unavailable */
+		(u64)decrementer_iSeries,	/* 0x900 Decrementer */
+		(u64)trap_0a_iSeries,		/* 0xa00 Trap 0A */
+		(u64)trap_0b_iSeries,		/* 0xb00 Trap 0B */
+		(u64)system_call_iSeries,	/* 0xc00 System Call */
+		(u64)single_step_iSeries,	/* 0xd00 Single Step */
+		(u64)trap_0e_iSeries,		/* 0xe00 Trap 0E */
+		(u64)performance_monitor_iSeries,/* 0xf00 Performance Monitor */
 		0,				/* int 0x1000 */
 		0,				/* int 0x1010 */
 		0,				/* int 0x1020 CPU ctls */
-		(u64)HardwareInterrupt_Iseries, /* SC Ret Hdlr */
-		(u64)DataAccessSLB_Iseries,	/* 0x380 D-SLB */
-		(u64)InstructionAccessSLB_Iseries /* 0x480 I-SLB */
+		(u64)hardware_interrupt_iSeries, /* SC Ret Hdlr */
+		(u64)data_access_slb_iSeries,	/* 0x380 D-SLB */
+		(u64)instruction_access_slb_iSeries /* 0x480 I-SLB */
 	}
 };
 EXPORT_SYMBOL(itLpNaca);
diff -urN base-2.6/arch/ppc64/kernel/entry.S test/arch/ppc64/kernel/entry.S
--- base-2.6/arch/ppc64/kernel/entry.S	2004-12-14 16:34:17.000000000 +1100
+++ test/arch/ppc64/kernel/entry.S	2005-01-05 15:59:33.871500992 +1100
@@ -54,8 +54,8 @@
 
 #undef SHOW_SYSCALLS
 
-	.globl SystemCall_common
-SystemCall_common:
+	.globl system_call_common
+system_call_common:
 	andi.	r10,r12,MSR_PR
 	mr	r10,r1
 	addi	r1,r1,-INT_FRAME_SIZE
@@ -100,7 +100,7 @@
 	cmpdi	cr1,r0,0x5555		/* syscall 0x5555 */
 	andi.	r10,r12,MSR_PR		/* from kernel */
 	crand	4*cr0+eq,4*cr1+eq,4*cr0+eq
-	beq	HardwareInterrupt_entry
+	beq	hardware_interrupt_entry
 	lbz	r10,PACAPROCENABLED(r13)
 	std	r10,SOFTE(r1)
 #endif
diff -urN base-2.6/arch/ppc64/kernel/head.S test/arch/ppc64/kernel/head.S
--- base-2.6/arch/ppc64/kernel/head.S	2005-01-05 15:59:23.536474848 +1100
+++ test/arch/ppc64/kernel/head.S	2005-01-05 15:59:33.817509200 +1100
@@ -78,7 +78,7 @@
  *
  *  For iSeries:
  *   1. The MMU is on (as it always is for iSeries)
- *   2. The kernel is entered at SystemReset_Iseries
+ *   2. The kernel is entered at system_reset_iSeries
  */
 
 	.text
@@ -165,7 +165,7 @@
 #else
 #ifdef CONFIG_SMP
 	mr	r3,r24
-	b	.pseries_secondary_smp_init
+	b	.pSeries_secondary_smp_init
 #else
 	BUG_OPCODE
 #endif
@@ -305,15 +305,15 @@
  */
 #define STD_EXCEPTION_PSERIES(n, label)			\
 	. = n;						\
-	.globl label##_Pseries;				\
-label##_Pseries:					\
+	.globl label##_pSeries;				\
+label##_pSeries:					\
 	HMT_MEDIUM;					\
 	mtspr	SPRG1,r13;		/* save r13 */	\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
 
 #define STD_EXCEPTION_ISERIES(n, label, area)		\
-	.globl label##_Iseries;				\
-label##_Iseries:					\
+	.globl label##_iSeries;				\
+label##_iSeries:					\
 	HMT_MEDIUM;					\
 	mtspr	SPRG1,r13;		/* save r13 */	\
 	EXCEPTION_PROLOG_ISERIES_1(area);		\
@@ -321,14 +321,14 @@
 	b	label##_common
 
 #define MASKABLE_EXCEPTION_ISERIES(n, label)				\
-	.globl label##_Iseries;						\
-label##_Iseries:							\
+	.globl label##_iSeries;						\
+label##_iSeries:							\
 	HMT_MEDIUM;							\
 	mtspr	SPRG1,r13;		/* save r13 */			\
 	EXCEPTION_PROLOG_ISERIES_1(PACA_EXGEN);				\
 	lbz	r10,PACAPROCENABLED(r13);				\
 	cmpwi	0,r10,0;						\
-	beq-	label##_Iseries_masked;					\
+	beq-	label##_iSeries_masked;					\
 	EXCEPTION_PROLOG_ISERIES_2;					\
 	b	label##_common;						\
 
@@ -388,17 +388,17 @@
 	.globl __start_interrupts
 __start_interrupts:
 
-	STD_EXCEPTION_PSERIES(0x100, SystemReset)
+	STD_EXCEPTION_PSERIES(0x100, system_reset)
 
 	. = 0x200
-_MachineCheckPseries:
+_machine_check_pSeries:
 	HMT_MEDIUM
 	mtspr	SPRG1,r13		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, MachineCheck_common)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common)
 
 	. = 0x300
-	.globl DataAccess_Pseries
-DataAccess_Pseries:
+	.globl data_access_pSeries
+data_access_pSeries:
 	HMT_MEDIUM
 	mtspr	SPRG1,r13
 BEGIN_FTR_SECTION
@@ -409,15 +409,15 @@
 	rlwimi	r13,r12,16,0x20
 	mfcr	r12
 	cmpwi	r13,0x2c
-	beq	.do_stab_bolted_Pseries
+	beq	.do_stab_bolted_pSeries
 	mtcrf	0x80,r12
 	mfspr	r12,SPRG2
 END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, DataAccess_common)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common)
 
 	. = 0x380
-	.globl DataAccessSLB_Pseries
-DataAccessSLB_Pseries:
+	.globl data_access_slb_pSeries
+data_access_slb_pSeries:
 	HMT_MEDIUM
 	mtspr	SPRG1,r13
 	mfspr	r13,SPRG3		/* get paca address into r13 */
@@ -433,11 +433,11 @@
 	mfspr	r3,DAR
 	b	.do_slb_miss		/* Rel. branch works in real mode */
 
-	STD_EXCEPTION_PSERIES(0x400, InstructionAccess)
+	STD_EXCEPTION_PSERIES(0x400, instruction_access)
 
 	. = 0x480
-	.globl InstructionAccessSLB_Pseries
-InstructionAccessSLB_Pseries:
+	.globl instruction_access_slb_pSeries
+instruction_access_slb_pSeries:
 	HMT_MEDIUM
 	mtspr	SPRG1,r13
 	mfspr	r13,SPRG3		/* get paca address into r13 */
@@ -453,25 +453,25 @@
 	mfspr	r3,SRR0			/* SRR0 is faulting address */
 	b	.do_slb_miss		/* Rel. branch works in real mode */
 
-	STD_EXCEPTION_PSERIES(0x500, HardwareInterrupt)
-	STD_EXCEPTION_PSERIES(0x600, Alignment)
-	STD_EXCEPTION_PSERIES(0x700, ProgramCheck)
-	STD_EXCEPTION_PSERIES(0x800, FPUnavailable)
-	STD_EXCEPTION_PSERIES(0x900, Decrementer)
-	STD_EXCEPTION_PSERIES(0xa00, Trap_0a)
-	STD_EXCEPTION_PSERIES(0xb00, Trap_0b)
+	STD_EXCEPTION_PSERIES(0x500, hardware_interrupt)
+	STD_EXCEPTION_PSERIES(0x600, alignment)
+	STD_EXCEPTION_PSERIES(0x700, program_check)
+	STD_EXCEPTION_PSERIES(0x800, fp_unavailable)
+	STD_EXCEPTION_PSERIES(0x900, decrementer)
+	STD_EXCEPTION_PSERIES(0xa00, trap_0a)
+	STD_EXCEPTION_PSERIES(0xb00, trap_0b)
 
 	. = 0xc00
-	.globl	SystemCall_Pseries
-SystemCall_Pseries:
+	.globl	system_call_pSeries
+system_call_pSeries:
 	HMT_MEDIUM
 	mr	r9,r13
 	mfmsr	r10
 	mfspr	r13,SPRG3
 	mfspr	r11,SRR0
 	clrrdi	r12,r13,32
-	oris	r12,r12,SystemCall_common@h
-	ori	r12,r12,SystemCall_common@l
+	oris	r12,r12,system_call_common@h
+	ori	r12,r12,system_call_common@l
 	mtspr	SRR0,r12
 	ori	r10,r10,MSR_IR|MSR_DR|MSR_RI
 	mfspr	r12,SRR1
@@ -479,8 +479,8 @@
 	rfid
 	b	.	/* prevent speculative execution */
 
-	STD_EXCEPTION_PSERIES(0xd00, SingleStep)
-	STD_EXCEPTION_PSERIES(0xe00, Trap_0e)
+	STD_EXCEPTION_PSERIES(0xd00, single_step)
+	STD_EXCEPTION_PSERIES(0xe00, trap_0e)
 
 	/* We need to deal with the Altivec unavailable exception
 	 * here which is at 0xf20, thus in the middle of the
@@ -488,18 +488,18 @@
 	 * trickery is thus necessary
 	 */
 	. = 0xf00
-	b	PerformanceMonitor_Pseries
+	b	performance_monitor_pSeries
 
-	STD_EXCEPTION_PSERIES(0xf20, AltivecUnavailable)
+	STD_EXCEPTION_PSERIES(0xf20, altivec_unavailable)
 
-	STD_EXCEPTION_PSERIES(0x1300, InstructionBreakpoint)
-	STD_EXCEPTION_PSERIES(0x1700, AltivecAssist)
+	STD_EXCEPTION_PSERIES(0x1300, instruction_breakpoint)
+	STD_EXCEPTION_PSERIES(0x1700, altivec_assist)
 
 	/* moved from 0xf00 */
-	STD_EXCEPTION_PSERIES(0x3000, PerformanceMonitor)
+	STD_EXCEPTION_PSERIES(0x3000, performance_monitor)
 
 	. = 0x3100
-_GLOBAL(do_stab_bolted_Pseries)
+_GLOBAL(do_stab_bolted_pSeries)
 	mtcrf	0x80,r12
 	mfspr	r12,SPRG2
 	EXCEPTION_PROLOG_PSERIES(PACA_EXSLB, .do_stab_bolted)
@@ -558,10 +558,10 @@
 
 /***  ISeries-LPAR interrupt handlers ***/
 
-	STD_EXCEPTION_ISERIES(0x200, MachineCheck, PACA_EXMC)
+	STD_EXCEPTION_ISERIES(0x200, machine_check, PACA_EXMC)
 
-	.globl DataAccess_Iseries
-DataAccess_Iseries:
+	.globl data_access_iSeries
+data_access_iSeries:
 	mtspr	SPRG1,r13
 BEGIN_FTR_SECTION
 	mtspr	SPRG2,r12
@@ -571,23 +571,23 @@
 	rlwimi	r13,r12,16,0x20
 	mfcr	r12
 	cmpwi	r13,0x2c
-	beq	.do_stab_bolted_Iseries
+	beq	.do_stab_bolted_iSeries
 	mtcrf	0x80,r12
 	mfspr	r12,SPRG2
 END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 	EXCEPTION_PROLOG_ISERIES_1(PACA_EXGEN)
 	EXCEPTION_PROLOG_ISERIES_2
-	b	DataAccess_common
+	b	data_access_common
 
-.do_stab_bolted_Iseries:
+.do_stab_bolted_iSeries:
 	mtcrf	0x80,r12
 	mfspr	r12,SPRG2
 	EXCEPTION_PROLOG_ISERIES_1(PACA_EXSLB)
 	EXCEPTION_PROLOG_ISERIES_2
 	b	.do_stab_bolted
 
-	.globl	DataAccessSLB_Iseries
-DataAccessSLB_Iseries:
+	.globl	data_access_slb_iSeries
+data_access_slb_iSeries:
 	mtspr	SPRG1,r13		/* save r13 */
 	EXCEPTION_PROLOG_ISERIES_1(PACA_EXSLB)
 	std	r3,PACA_EXSLB+EX_R3(r13)
@@ -595,10 +595,10 @@
 	mfspr	r3,DAR
 	b	.do_slb_miss
 
-	STD_EXCEPTION_ISERIES(0x400, InstructionAccess, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(0x400, instruction_access, PACA_EXGEN)
 
-	.globl	InstructionAccessSLB_Iseries
-InstructionAccessSLB_Iseries:
+	.globl	instruction_access_slb_iSeries
+instruction_access_slb_iSeries:
 	mtspr	SPRG1,r13		/* save r13 */
 	EXCEPTION_PROLOG_ISERIES_1(PACA_EXSLB)
 	std	r3,PACA_EXSLB+EX_R3(r13)
@@ -606,27 +606,27 @@
 	ld	r3,PACALPPACA+LPPACASRR0(r13)
 	b	.do_slb_miss
 
-	MASKABLE_EXCEPTION_ISERIES(0x500, HardwareInterrupt)
-	STD_EXCEPTION_ISERIES(0x600, Alignment, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES(0x700, ProgramCheck, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES(0x800, FPUnavailable, PACA_EXGEN)
-	MASKABLE_EXCEPTION_ISERIES(0x900, Decrementer)
-	STD_EXCEPTION_ISERIES(0xa00, Trap_0a, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES(0xb00, Trap_0b, PACA_EXGEN)
+	MASKABLE_EXCEPTION_ISERIES(0x500, hardware_interrupt)
+	STD_EXCEPTION_ISERIES(0x600, alignment, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(0x700, program_check, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(0x800, fp_unavailable, PACA_EXGEN)
+	MASKABLE_EXCEPTION_ISERIES(0x900, decrementer)
+	STD_EXCEPTION_ISERIES(0xa00, trap_0a, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(0xb00, trap_0b, PACA_EXGEN)
 
-	.globl	SystemCall_Iseries
-SystemCall_Iseries:
+	.globl	system_call_iSeries
+system_call_iSeries:
 	mr	r9,r13
 	mfspr	r13,SPRG3
 	EXCEPTION_PROLOG_ISERIES_2
-	b	SystemCall_common
+	b	system_call_common
 
-	STD_EXCEPTION_ISERIES( 0xd00, SingleStep, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES( 0xe00, Trap_0e, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES( 0xf00, PerformanceMonitor, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES( 0xd00, single_step, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES( 0xe00, trap_0e, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES( 0xf00, performance_monitor, PACA_EXGEN)
 
-	.globl SystemReset_Iseries
-SystemReset_Iseries:
+	.globl system_reset_iSeries
+system_reset_iSeries:
 	mfspr	r13,SPRG3		/* Get paca address */
 	mfmsr	r24
 	ori	r24,r24,MSR_RI
@@ -652,11 +652,11 @@
 	subi	r1,r1,STACK_FRAME_OVERHEAD
 
 	cmpwi	0,r23,0
-	beq	iseries_secondary_smp_loop	/* Loop until told to go */
+	beq	iSeries_secondary_smp_loop	/* Loop until told to go */
 #ifdef SECONDARY_PROCESSORS
 	bne	.__secondary_start		/* Loop until told to go */
 #endif
-iseries_secondary_smp_loop:
+iSeries_secondary_smp_loop:
 	/* Let the Hypervisor know we are alive */
 	/* 8002 is a call to HvCallCfg::getLps, a harmless Hypervisor function */
 	lis	r3,0x8002
@@ -676,16 +676,16 @@
 	b	1b			/* If SMP not configured, secondaries
 					 * loop forever */
 
-	.globl Decrementer_Iseries_masked
-Decrementer_Iseries_masked:
+	.globl decrementer_iSeries_masked
+decrementer_iSeries_masked:
 	li	r11,1
 	stb	r11,PACALPPACA+LPPACADECRINT(r13)
 	lwz	r12,PACADEFAULTDECR(r13)
 	mtspr	SPRN_DEC,r12
 	/* fall through */
 
-	.globl HardwareInterrupt_Iseries_masked
-HardwareInterrupt_Iseries_masked:
+	.globl hardware_interrupt_iSeries_masked
+hardware_interrupt_iSeries_masked:
 	mtcrf	0x80,r9		/* Restore regs */
 	ld	r11,PACALPPACA+LPPACASRR0(r13)
 	ld	r12,PACALPPACA+LPPACASRR1(r13)
@@ -711,16 +711,16 @@
  * Vectors for the FWNMI option.  Share common code.
  */
 	. = 0x8000
-	.globl SystemReset_FWNMI
-SystemReset_FWNMI:
+	.globl system_reset_fwnmi
+system_reset_fwnmi:
 	HMT_MEDIUM
 	mtspr	SPRG1,r13		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, SystemReset_common)
-	.globl MachineCheck_FWNMI
-MachineCheck_FWNMI:
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common)
+	.globl machine_check_fwnmi
+machine_check_fwnmi:
 	HMT_MEDIUM
 	mtspr	SPRG1,r13		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, MachineCheck_common)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common)
 
 	/*
 	 * Space for the initial segment table
@@ -738,15 +738,15 @@
 
 /*** Common interrupt handlers ***/
 
-	STD_EXCEPTION_COMMON(0x100, SystemReset, .system_reset_exception)
+	STD_EXCEPTION_COMMON(0x100, system_reset, .system_reset_exception)
 
 	/*
 	 * Machine check is different because we use a different
 	 * save area: PACA_EXMC instead of PACA_EXGEN.
 	 */
 	.align	7
-	.globl MachineCheck_common
-MachineCheck_common:
+	.globl machine_check_common
+machine_check_common:
 	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
 	DISABLE_INTS
 	bl	.save_nvgprs
@@ -754,17 +754,17 @@
 	bl	.machine_check_exception
 	b	.ret_from_except
 
-	STD_EXCEPTION_COMMON_LITE(0x900, Decrementer, .timer_interrupt)
-	STD_EXCEPTION_COMMON(0xa00, Trap_0a, .unknown_exception)
-	STD_EXCEPTION_COMMON(0xb00, Trap_0b, .unknown_exception)
-	STD_EXCEPTION_COMMON(0xd00, SingleStep, .single_step_exception)
-	STD_EXCEPTION_COMMON(0xe00, Trap_0e, .unknown_exception)
-	STD_EXCEPTION_COMMON(0xf00, PerformanceMonitor, .performance_monitor_exception)
-	STD_EXCEPTION_COMMON(0x1300, InstructionBreakpoint, .instruction_breakpoint_exception)
+	STD_EXCEPTION_COMMON_LITE(0x900, decrementer, .timer_interrupt)
+	STD_EXCEPTION_COMMON(0xa00, trap_0a, .unknown_exception)
+	STD_EXCEPTION_COMMON(0xb00, trap_0b, .unknown_exception)
+	STD_EXCEPTION_COMMON(0xd00, single_step, .single_step_exception)
+	STD_EXCEPTION_COMMON(0xe00, trap_0e, .unknown_exception)
+	STD_EXCEPTION_COMMON(0xf00, performance_monitor, .performance_monitor_exception)
+	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, .instruction_breakpoint_exception)
 #ifdef CONFIG_ALTIVEC
-	STD_EXCEPTION_COMMON(0x1700, AltivecAssist, .altivec_assist_exception)
+	STD_EXCEPTION_COMMON(0x1700, altivec_assist, .altivec_assist_exception)
 #else
-	STD_EXCEPTION_COMMON(0x1700, AltivecAssist, .unknown_exception)
+	STD_EXCEPTION_COMMON(0x1700, altivec_assist, .unknown_exception)
 #endif
 
 /*
@@ -854,8 +854,8 @@
  * r9 - r13 are saved in paca->exgen.
  */
 	.align	7
-	.globl DataAccess_common
-DataAccess_common:
+	.globl data_access_common
+data_access_common:
 	mfspr	r10,DAR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
 	mfspr	r10,DSISR
@@ -867,8 +867,8 @@
 	b	.do_hash_page	 	/* Try to handle as hpte fault */
 
 	.align	7
-	.globl InstructionAccess_common
-InstructionAccess_common:
+	.globl instruction_access_common
+instruction_access_common:
 	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
 	ld	r3,_NIP(r1)
 	andis.	r4,r12,0x5820
@@ -876,19 +876,19 @@
 	b	.do_hash_page		/* Try to handle as hpte fault */
 
 	.align	7
-	.globl HardwareInterrupt_common
-	.globl HardwareInterrupt_entry
-HardwareInterrupt_common:
+	.globl hardware_interrupt_common
+	.globl hardware_interrupt_entry
+hardware_interrupt_common:
 	EXCEPTION_PROLOG_COMMON(0x500, PACA_EXGEN)
-HardwareInterrupt_entry:
+hardware_interrupt_entry:
 	DISABLE_INTS
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_IRQ
 	b	.ret_from_except_lite
 
 	.align	7
-	.globl Alignment_common
-Alignment_common:
+	.globl alignment_common
+alignment_common:
 	mfspr	r10,DAR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
 	mfspr	r10,DSISR
@@ -905,8 +905,8 @@
 	b	.ret_from_except
 
 	.align	7
-	.globl ProgramCheck_common
-ProgramCheck_common:
+	.globl program_check_common
+program_check_common:
 	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -915,8 +915,8 @@
 	b	.ret_from_except
 
 	.align	7
-	.globl FPUnavailable_common
-FPUnavailable_common:
+	.globl fp_unavailable_common
+fp_unavailable_common:
 	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
 	bne	.load_up_fpu		/* if from user, just load it up */
 	bl	.save_nvgprs
@@ -926,8 +926,8 @@
 	BUG_OPCODE
 
 	.align	7
-	.globl AltivecUnavailable_common
-AltivecUnavailable_common:
+	.globl altivec_unavailable_common
+altivec_unavailable_common:
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
 	bne	.load_up_altivec	/* if from user, just load it up */
@@ -1188,7 +1188,7 @@
  * On pSeries, secondary processors spin in the following code.
  * At entry, r3 = this processor's number (physical cpu id)
  */
-_GLOBAL(pseries_secondary_smp_init)
+_GLOBAL(pSeries_secondary_smp_init)
 	mr	r24,r3
 	
 	/* turn on 64-bit mode */
@@ -2083,7 +2083,7 @@
 101:
 #endif
 	mr	r3,r24
-	b	.pseries_secondary_smp_init
+	b	.pSeries_secondary_smp_init
 
 #ifdef CONFIG_HMT
 _GLOBAL(hmt_start_secondary)
diff -urN base-2.6/arch/ppc64/kernel/pSeries_smp.c test/arch/ppc64/kernel/pSeries_smp.c
--- base-2.6/arch/ppc64/kernel/pSeries_smp.c	2005-01-05 14:30:19.458583136 +1100
+++ test/arch/ppc64/kernel/pSeries_smp.c	2005-01-05 16:02:22.100485944 +1100
@@ -56,7 +56,7 @@
 #define DBG(fmt...)
 #endif
 
-extern void pseries_secondary_smp_init(unsigned long); 
+extern void pSeries_secondary_smp_init(unsigned long);
 
 /* Get state of physical CPU.
  * Return codes:
@@ -192,7 +192,7 @@
 {
 	int status;
 	unsigned long start_here = __pa((u32)*((unsigned long *)
-					       pseries_secondary_smp_init));
+					       pSeries_secondary_smp_init));
 	unsigned int pcpu;
 
 	/* At boot time the cpus are already spinning in hold
@@ -362,7 +362,7 @@
 			rtas_call(rtas_token("start-cpu"), 3, 1, &ret,
 				  get_hard_smp_processor_id(i),
 				  __pa((u32)*((unsigned long *)
-					      pseries_secondary_smp_init)),
+					      pSeries_secondary_smp_init)),
 				  i);
 		}
 	}
diff -urN base-2.6/arch/ppc64/lib/sstep.c test/arch/ppc64/lib/sstep.c
--- base-2.6/arch/ppc64/lib/sstep.c	2004-11-19 18:03:12.000000000 +1100
+++ test/arch/ppc64/lib/sstep.c	2005-01-05 15:59:33.896497192 +1100
@@ -13,7 +13,7 @@
 #include <asm/sstep.h>
 #include <asm/processor.h>
 
-extern char SystemCall_common[];
+extern char system_call_common[];
 
 /* Bits in SRR1 that are copied from MSR */
 #define MSR_MASK	0xffffffff87c0ffff
@@ -76,7 +76,7 @@
 		regs->gpr[11] = regs->nip + 4;
 		regs->gpr[12] = regs->msr & MSR_MASK;
 		regs->gpr[13] = (unsigned long) get_paca();
-		regs->nip = (unsigned long) &SystemCall_common;
+		regs->nip = (unsigned long) &system_call_common;
 		regs->msr = MSR_KERNEL;
 		return 1;
 	case 18:	/* b */
