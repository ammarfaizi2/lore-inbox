Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbUBKOwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUBKOwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:52:10 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:2758 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265378AbUBKOvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:51:06 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kgdb interdiff for x86_64.patch
Date: Wed, 11 Feb 2004 20:20:25 +0530
User-Agent: KMail/1.5
Cc: George Anzinger <george@mvista.com>, Tom Rini <trini@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402112020.26829.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is interdiff for file x86_64.patch

--- archive/2.1.0/linux-2.6.1-kgdb-2.1.0/x86_64.patch	2004-01-21 
22:07:50.000000000 +0530
+++ cvs/kgdb-2/x86_64.patch	2004-02-11 16:01:04.000000000 +0530
@@ -1,66 +1,7 @@
-diff -Naurp linux-2.6.1-1/arch/x86_64/ia32/ia32entry.S 
linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/ia32/ia32entry.S
---- linux-2.6.1-1/arch/x86_64/ia32/ia32entry.S	2004-01-10 11:01:36.000000000 
+0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/ia32/ia32entry.S	2004-01-12 
19:10:30.000000000 +0530
-@@ -4,6 +4,7 @@
-  * Copyright 2000-2002 Andi Kleen, SuSE Labs.
-  */		 
- 
-+#include <asm/dwarf2.h>
- #include <asm/calling.h>
- #include <asm/offset.h>
- #include <asm/current.h>
-@@ -45,6 +46,7 @@
-  * with the int 0x80 path.	
-  */ 	
- ENTRY(ia32_cstar_target)
-+	CFI_STARTPROC
- 	swapgs
- 	movl	%esp,%r8d
- 	movq	%gs:pda_kernelstack,%rsp
-@@ -105,6 +107,7 @@ cstar_tracesys:	
- cstar_badarg:
- 	movq $-EFAULT,%rax
- 	jmp cstar_sysret
-+	CFI_ENDPROC
- 
- /* 
-  * Emulated IA32 system calls via int 0x80. 
-@@ -128,6 +131,7 @@ cstar_badarg:
-  */ 				
- 
- ENTRY(ia32_syscall)
-+	CFI_STARTPROC
- 	swapgs	
- 	sti
- 	movl %eax,%eax
-@@ -168,6 +172,7 @@ ni_syscall:
- quiet_ni_syscall:
- 	movq $-ENOSYS,%rax
- 	ret
-+	CFI_ENDPROC
- 	
- 	.macro PTREGSCALL label, func
- 	.globl \label
-@@ -188,6 +193,7 @@ quiet_ni_syscall:
- 	PTREGSCALL stub32_rt_sigsuspend, sys_rt_sigsuspend
- 
- ENTRY(ia32_ptregs_common)
-+	CFI_STARTPROC
- 	popq %r11
- 	SAVE_REST
- 	movq %r11, %r15
-@@ -198,6 +204,7 @@ ENTRY(ia32_ptregs_common)
- 	je   int_ret_from_sys_call /* misbalances the call/ret stack. sorry */
- 	pushq %r11
- 	ret
-+	CFI_ENDPROC
- 
- 	.data
- 	.align 8
-diff -Naurp linux-2.6.1-1/arch/x86_64/Kconfig 
linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/Kconfig
---- linux-2.6.1-1/arch/x86_64/Kconfig	2004-01-10 11:01:36.000000000 +0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/Kconfig	2004-01-12 
19:10:30.000000000 +0530
-@@ -531,8 +531,36 @@ config IOMMU_LEAK
+diff -Naurp linux-2.6.2/arch/x86_64/Kconfig 
linux-2.6.2-kgdb-x86_64/arch/x86_64/Kconfig
+--- linux-2.6.2/arch/x86_64/Kconfig	2004-02-10 13:01:23.000000000 +0530
++++ linux-2.6.2-kgdb-x86_64/arch/x86_64/Kconfig	2004-02-10 14:50:24.000000000 
+0530
+@@ -465,8 +465,36 @@ config IOMMU_LEAK
           Add a simple leak tracer to the IOMMU code. This is useful when you
  	 are debugging a buggy device driver that leaks IOMMU mappings.
         
@@ -99,96 +40,10 @@
  
  endmenu
  
-diff -Naurp linux-2.6.1-1/arch/x86_64/kernel/entry.S 
linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/kernel/entry.S
---- linux-2.6.1-1/arch/x86_64/kernel/entry.S	2003-11-24 07:01:45.000000000 
+0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/kernel/entry.S	2004-01-12 
19:10:30.000000000 +0530
-@@ -34,6 +34,7 @@
- #include <asm/smp.h>
- #include <asm/cache.h>
- #include <asm/errno.h>
-+#include <asm/dwarf2.h>
- #include <asm/calling.h>
- #include <asm/offset.h>
- #include <asm/msr.h>
-@@ -41,7 +42,6 @@
- #include <asm/thread_info.h>
- #include <asm/hw_irq.h>
- #include <asm/errno.h>
--#include <asm/dwarf2.h>
- 
- 	.code64
- 
-@@ -82,22 +82,53 @@
- 	/* push in order ss, rsp, eflags, cs, rip */
- 	xorq %rax, %rax
- 	pushq %rax /* ss */
-+	CFI_ADJUST_CFA_OFFSET	8
- 	pushq %rax /* rsp */
-+	CFI_ADJUST_CFA_OFFSET	8
-+	CFI_OFFSET	rip,0
- 	pushq $(1<<9) /* eflags - interrupts on */
-+	CFI_ADJUST_CFA_OFFSET	8
- 	pushq $__KERNEL_CS /* cs */
-+	CFI_ADJUST_CFA_OFFSET	8
- 	pushq \child_rip /* rip */
-+	CFI_ADJUST_CFA_OFFSET	8
-+	CFI_OFFSET	rip,0
- 	pushq	%rax /* orig rax */
-+	CFI_ADJUST_CFA_OFFSET	8
- 	.endm
- 
- 	.macro UNFAKE_STACK_FRAME
- 	addq $8*6, %rsp
-+	CFI_ADJUST_CFA_OFFSET	-(6*8)
- 	.endm
- 
-+	.macro	CFI_DEFAULT_STACK
-+	CFI_ADJUST_CFA_OFFSET  (SS)
-+	CFI_OFFSET	r15,R15-SS
-+	CFI_OFFSET	r14,R14-SS
-+	CFI_OFFSET	r13,R13-SS
-+	CFI_OFFSET	r12,R12-SS
-+	CFI_OFFSET	rbp,RBP-SS
-+	CFI_OFFSET	rbx,RBX-SS
-+	CFI_OFFSET	r11,R11-SS
-+	CFI_OFFSET	r10,R10-SS
-+	CFI_OFFSET	r9,R9-SS
-+	CFI_OFFSET	r8,R8-SS
-+	CFI_OFFSET	rax,RAX-SS
-+	CFI_OFFSET	rcx,RCX-SS
-+	CFI_OFFSET	rdx,RDX-SS
-+	CFI_OFFSET	rsi,RSI-SS
-+	CFI_OFFSET	rdi,RDI-SS
-+	CFI_OFFSET	rsp,RSP-SS
-+	CFI_OFFSET	rip,RIP-SS
-+	.endm
- /*
-  * A newly forked process directly context switches into this.
-  */ 	
- /* rdi:	prev */	
- ENTRY(ret_from_fork)
-+	CFI_STARTPROC
-+	CFI_DEFAULT_STACK
- 	call schedule_tail
- 	GET_THREAD_INFO(%rcx)
- 	bt $TIF_SYSCALL_TRACE,threadinfo_flags(%rcx)
-@@ -115,6 +146,7 @@ rff_trace:
- 	call syscall_trace
- 	GET_THREAD_INFO(%rcx)	
- 	jmp rff_action
-+	CFI_ENDPROC
- 
- /*
-  * System call entry. Upto 6 arguments in registers are supported.
-@@ -144,6 +176,7 @@ rff_trace:
-  */ 			 		
- 
- ENTRY(system_call)
-+	CFI_STARTPROC
- 	swapgs
- 	movq	%rsp,%gs:pda_oldrsp 
- 	movq	%gs:pda_kernelstack,%rsp
-@@ -186,7 +219,7 @@ sysret_careful:
+diff -Naurp linux-2.6.2/arch/x86_64/kernel/entry.S 
linux-2.6.2-kgdb-x86_64/arch/x86_64/kernel/entry.S
+--- linux-2.6.2/arch/x86_64/kernel/entry.S	2004-02-10 13:01:23.000000000 
+0530
++++ linux-2.6.2-kgdb-x86_64/arch/x86_64/kernel/entry.S	2004-02-10 
14:50:26.000000000 +0530
+@@ -219,7 +219,7 @@ sysret_careful:
  	jnc sysret_signal
  	sti
  	pushq %rdi
@@ -197,7 +52,7 @@
  	popq  %rdi
  	jmp sysret_check
  
-@@ -255,7 +288,7 @@ int_careful:
+@@ -288,7 +288,7 @@ int_careful:
  	jnc  int_very_careful
  	sti
  	pushq %rdi
@@ -206,99 +61,7 @@
  	popq %rdi
  	jmp int_with_check
  
-@@ -283,6 +316,7 @@ int_signal:
- int_restore_rest:
- 	RESTORE_REST
- 	jmp int_with_check
-+	CFI_ENDPROC
- 		
- /* 
-  * Certain special system calls that need to save a complete full stack 
frame.
-@@ -303,7 +337,9 @@ int_restore_rest:
- 	PTREGSCALL stub_iopl, sys_iopl
- 
- ENTRY(ptregscall_common)
-+	CFI_STARTPROC
- 	popq %r11
-+	CFI_ADJUST_CFA_OFFSET	-8
- 	SAVE_REST
- 	movq %r11, %r15
- 	FIXUP_TOP_OF_STACK %r11
-@@ -312,10 +348,14 @@ ENTRY(ptregscall_common)
- 	movq %r15, %r11
- 	RESTORE_REST
- 	pushq %r11
-+	CFI_ADJUST_CFA_OFFSET	8
- 	ret
-+	CFI_ENDPROC
- 	
- ENTRY(stub_execve)
-+	CFI_STARTPROC
- 	popq %r11
-+	CFI_ADJUST_CFA_OFFSET	-8
- 	SAVE_REST
- 	movq %r11, %r15
- 	FIXUP_TOP_OF_STACK %r11
-@@ -330,15 +370,18 @@ ENTRY(stub_execve)
- 	ret
- 
- exec_32bit:
-+	CFI_ADJUST_CFA_OFFSET	REST_SKIP
- 	movq %rax,RAX(%rsp)
- 	RESTORE_REST
- 	jmp int_ret_from_sys_call
-+	CFI_ENDPROC
- 	
- /*
-  * sigreturn is special because it needs to restore all registers on return.
-  * This cannot be done with SYSRET, so use the IRET return path instead.
-  */                
- ENTRY(stub_rt_sigreturn)
-+	CFI_STARTPROC
- 	addq $8, %rsp		
- 	SAVE_REST
- 	FIXUP_TOP_OF_STACK %r11
-@@ -346,6 +389,7 @@ ENTRY(stub_rt_sigreturn)
- 	movq %rax,RAX(%rsp) # fixme, this could be done at the higher layer
- 	RESTORE_REST
- 	jmp int_ret_from_sys_call
-+	CFI_ENDPROC
- 
- /* 
-  * Interrupt entry/exit.
-@@ -357,10 +401,20 @@ ENTRY(stub_rt_sigreturn)
- 
- /* 0(%rsp): interrupt number */ 
- 	.macro interrupt func
-+	CFI_STARTPROC	simple
-+	CFI_DEF_CFA	rsp,(SS-ORIG_RAX)
-+	CFI_OFFSET	rsp,(RSP-SS)
-+	CFI_OFFSET	rip,(RIP-SS)
- 	cld
--#ifdef CONFIG_X86_REMOTE_DEBUG
-+#ifdef CONFIG_KGDB
- 	SAVE_ALL	
- 	movq %rsp,%rdi
-+	/*
-+	 * Setup a stack frame pointer.  This allows gdb to trace
-+	 * back to the original stack.
-+	 */
-+	movq %rsp,%rbp
-+	CFI_DEF_CFA_REGISTER	rbp
- #else		
- 	SAVE_ARGS
- 	leaq -ARGOFFSET(%rsp),%rdi	# arg1 for handler
-@@ -382,6 +436,9 @@ ret_from_intr:		
- 	popq  %rdi
- 	cli	
- 	subl $1,%gs:pda_irqcount
-+#ifdef CONFIG_KGDB
-+	movq RBP(%rdi),%rbp
-+#endif
- 	leaq ARGOFFSET(%rdi),%rsp
- exit_intr:	 	
- 	GET_THREAD_INFO(%rcx)
-@@ -425,7 +482,7 @@ retint_careful:
+@@ -482,7 +482,7 @@ retint_careful:
  	jnc   retint_signal
  	sti
  	pushq %rdi
@@ -307,138 +70,7 @@
  	popq %rdi		
  	GET_THREAD_INFO(%rcx)
  	cli
-@@ -465,6 +522,7 @@ retint_kernel:	
- 	movl $0,threadinfo_preempt_count(%rcx) 
- 	jmp exit_intr
- #endif	
-+	CFI_ENDPROC
- 	
- /*
-  * APIC interrupts.
-@@ -473,6 +531,7 @@ retint_kernel:	
- 	pushq $\num-256
- 	interrupt \func
- 	jmp ret_from_intr
-+	CFI_ENDPROC
- 	.endm
- 
- #ifdef CONFIG_SMP	
-@@ -518,24 +577,43 @@ ENTRY(spurious_interrupt)
-  * and the exception handler in %rax.	
-  */ 		  				
- ENTRY(error_entry)
-+	CFI_STARTPROC	simple
-+	CFI_DEF_CFA	rsp,(SS-RDI)
-+	CFI_REL_OFFSET	rsp,(RSP-RDI)
-+	CFI_REL_OFFSET	rip,(RIP-RDI)
- 	/* rdi slot contains rax, oldrax contains error code */
- 	cld	
- 	subq  $14*8,%rsp
-+	CFI_ADJUST_CFA_OFFSET	(14*8)
- 	movq %rsi,13*8(%rsp)
-+	CFI_REL_OFFSET	rsi,RSI
- 	movq 14*8(%rsp),%rsi	/* load rax from rdi slot */
- 	movq %rdx,12*8(%rsp)
-+	CFI_REL_OFFSET	rdx,RDX
- 	movq %rcx,11*8(%rsp)
-+	CFI_REL_OFFSET	rcx,RCX
- 	movq %rsi,10*8(%rsp)	/* store rax */ 
-+	CFI_REL_OFFSET	rax,RAX
- 	movq %r8, 9*8(%rsp)
-+	CFI_REL_OFFSET	r8,R8
- 	movq %r9, 8*8(%rsp)
-+	CFI_REL_OFFSET	r9,R9
- 	movq %r10,7*8(%rsp)
-+	CFI_REL_OFFSET	r10,R10
- 	movq %r11,6*8(%rsp)
-+	CFI_REL_OFFSET	r11,R11
- 	movq %rbx,5*8(%rsp) 
-+	CFI_REL_OFFSET	rbx,RBX
- 	movq %rbp,4*8(%rsp) 
-+	CFI_REL_OFFSET	rbp,RBP
- 	movq %r12,3*8(%rsp) 
-+	CFI_REL_OFFSET	r12,R12
- 	movq %r13,2*8(%rsp) 
-+	CFI_REL_OFFSET	r13,R13
- 	movq %r14,1*8(%rsp) 
-+	CFI_REL_OFFSET	r14,R14
- 	movq %r15,(%rsp) 
-+	CFI_REL_OFFSET	r15,R15
- 	xorl %ebx,%ebx	
- 	testl $3,CS(%rsp)
- 	je  error_kernelspace
-@@ -561,6 +639,7 @@ error_exit:		
- 	swapgs 
- 	RESTORE_ARGS 0,8,0						
- 	iretq
-+	CFI_ENDPROC
- 
- error_kernelspace:
- 	incl %ebx
-@@ -615,6 +694,7 @@ bad_gs: 
-  *	rdi: fn, rsi: arg, rdx: flags
-  */
- ENTRY(kernel_thread)
-+	CFI_STARTPROC
- 	FAKE_STACK_FRAME $child_rip
- 	SAVE_ALL
- 
-@@ -642,6 +722,8 @@ ENTRY(kernel_thread)
- 	RESTORE_ALL
- 	UNFAKE_STACK_FRAME
- 	ret
-+	CFI_ENDPROC
-+	
- 	
- child_rip:
- 	/*
-@@ -671,6 +753,7 @@ child_rip:
-  *	rdi: name, rsi: argv, rdx: envp, fake frame on the stack
-  */
- ENTRY(execve)
-+	CFI_STARTPROC
- 	FAKE_STACK_FRAME $0
- 	SAVE_ALL	
- 	call sys_execve
-@@ -681,6 +764,7 @@ ENTRY(execve)
- 	RESTORE_ARGS
- 	UNFAKE_STACK_FRAME
- 	ret
-+	CFI_ENDPROC
- 
- ENTRY(page_fault)
- 	errorentry do_page_fault
-@@ -692,6 +776,7 @@ ENTRY(simd_coprocessor_error)
- 	zeroentry do_simd_coprocessor_error	
- 
- ENTRY(device_not_available)
-+	CFI_STARTPROC
- 	pushq $-1	#error code
- 	SAVE_ALL
- 	movl  $1,%ebx
-@@ -706,11 +791,13 @@ ENTRY(device_not_available)
- 	cmoveq %rcx,%rdx
- 	call  *%rdx
- 	jmp  error_exit
-+	CFI_ENDPROC
- 
- ENTRY(debug)
- 	zeroentry do_debug
- 
- ENTRY(nmi)
-+	CFI_STARTPROC
- 	pushq $-1
- 	SAVE_ALL
-         /* NMI could happen inside the critical section of a swapgs,
-@@ -731,6 +818,7 @@ ENTRY(nmi)
- 	swapgs
- 2:	RESTORE_ALL 8
- 	iretq
-+	CFI_ENDPROC
- 	
- ENTRY(int3)
- 	zeroentry do_int3	
-@@ -780,3 +868,38 @@ ENTRY(machine_check)
+@@ -868,3 +868,38 @@ ENTRY(machine_check)
  ENTRY(call_debug)
         zeroentry do_call_debug
  
@@ -477,9 +109,9 @@
 +	addq $21*8,%rsp
 +	ret
 +#endif
-diff -Naurp linux-2.6.1-1/arch/x86_64/kernel/Makefile 
linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/kernel/Makefile
---- linux-2.6.1-1/arch/x86_64/kernel/Makefile	2004-01-10 11:01:36.000000000 
+0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/kernel/Makefile	2004-01-12 
19:10:30.000000000 +0530
+diff -Naurp linux-2.6.2/arch/x86_64/kernel/Makefile 
linux-2.6.2-kgdb-x86_64/arch/x86_64/kernel/Makefile
+--- linux-2.6.2/arch/x86_64/kernel/Makefile	2004-01-10 11:01:36.000000000 
+0530
++++ linux-2.6.2-kgdb-x86_64/arch/x86_64/kernel/Makefile	2004-02-10 
14:50:26.000000000 +0530
 @@ -24,6 +24,7 @@ obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o a
  obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
  
@@ -488,9 +120,9 @@
  
  obj-y				+= topology.o
  
-diff -Naurp linux-2.6.1-1/arch/x86_64/kernel/nmi.c 
linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/kernel/nmi.c
---- linux-2.6.1-1/arch/x86_64/kernel/nmi.c	2003-11-24 07:01:53.000000000 
+0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/kernel/nmi.c	2004-01-12 
19:10:30.000000000 +0530
+diff -Naurp linux-2.6.2/arch/x86_64/kernel/nmi.c 
linux-2.6.2-kgdb-x86_64/arch/x86_64/kernel/nmi.c
+--- linux-2.6.2/arch/x86_64/kernel/nmi.c	2003-11-24 07:01:53.000000000 +0530
++++ linux-2.6.2-kgdb-x86_64/arch/x86_64/kernel/nmi.c	2004-02-10 
14:50:26.000000000 +0530
 @@ -24,6 +24,7 @@
  #include <linux/module.h>
  #include <linux/sysdev.h>
@@ -527,9 +159,9 @@
  			if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_BAD) { 
  				alert_counter[cpu] = 0; 
  				return;
-diff -Naurp linux-2.6.1-1/arch/x86_64/kernel/traps.c 
linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/kernel/traps.c
---- linux-2.6.1-1/arch/x86_64/kernel/traps.c	2004-01-10 11:01:36.000000000 
+0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/kernel/traps.c	2004-01-12 
19:10:30.000000000 +0530
+diff -Naurp linux-2.6.2/arch/x86_64/kernel/traps.c 
linux-2.6.2-kgdb-x86_64/arch/x86_64/kernel/traps.c
+--- linux-2.6.2/arch/x86_64/kernel/traps.c	2004-02-10 13:01:23.000000000 
+0530
++++ linux-2.6.2-kgdb-x86_64/arch/x86_64/kernel/traps.c	2004-02-10 
14:50:26.000000000 +0530
 @@ -28,6 +28,7 @@
  #include <linux/interrupt.h>
  #include <linux/module.h>
@@ -546,7 +178,7 @@
  	oops_begin();
  	handle_BUG(regs);
  	__die(str, regs, err);
-@@ -438,6 +440,7 @@ static void do_trap(int trapnr, int sign
+@@ -436,6 +438,7 @@ static void do_trap(int trapnr, int sign
  #define DO_ERROR(trapnr, signr, str, name) \
  asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
  { \
@@ -554,7 +186,7 @@
  	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) == 
NOTIFY_BAD) \
  		return; \
  	do_trap(trapnr, signr, str, regs, error_code, NULL); \
-@@ -616,7 +619,7 @@ asmlinkage void do_debug(struct pt_regs 
+@@ -614,7 +617,7 @@ asmlinkage void do_debug(struct pt_regs 
  	tsk->thread.debugreg6 = condition;
  
  	/* Mask out spurious TF errors due to lazy TF clearing */
@@ -563,7 +195,7 @@
  		/*
  		 * The TF error should be masked out only if the current
  		 * process is not traced and if the TRAP flag has been set
-@@ -645,6 +648,7 @@ asmlinkage void do_debug(struct pt_regs 
+@@ -643,6 +646,7 @@ asmlinkage void do_debug(struct pt_regs 
  	force_sig_info(SIGTRAP, &info, tsk);	
  clear_dr7:
  	asm volatile("movq %0,%%db7"::"r"(0UL));
@@ -571,32 +203,10 @@
  	notify_die(DIE_DEBUG, "debug", regs, error_code, 1, SIGTRAP);
  	return;
  
-diff -Naurp linux-2.6.1-1/arch/x86_64/kernel/vmlinux.lds.S 
linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/kernel/vmlinux.lds.S
---- linux-2.6.1-1/arch/x86_64/kernel/vmlinux.lds.S	2003-11-24 
07:01:07.000000000 +0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/kernel/vmlinux.lds.S	
2004-01-12 19:10:30.000000000 +0530
-@@ -3,6 +3,7 @@
-  */
- 
- #include <asm-generic/vmlinux.lds.h>
-+#include <linux/config.h>
- 
- OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
- OUTPUT_ARCH(i386:x86-64)
-@@ -137,7 +138,9 @@ SECTIONS
-   /* Sections to be discarded */
-   /DISCARD/ : {
- 	*(.exitcall.exit)
--	*(.eh_frame)
-+#ifndef CONFIG_KGDB
-+	*(.eh_frame) 
-+#endif
- 	}
- 
-   /* DWARF 2 */
-diff -Naurp linux-2.6.1-1/arch/x86_64/kernel/x86_64-stub.c 
linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/kernel/x86_64-stub.c
---- linux-2.6.1-1/arch/x86_64/kernel/x86_64-stub.c	1970-01-01 
05:30:00.000000000 +0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/kernel/x86_64-stub.c	
2004-01-12 19:10:30.000000000 +0530
-@@ -0,0 +1,541 @@
+diff -Naurp linux-2.6.2/arch/x86_64/kernel/x86_64-stub.c 
linux-2.6.2-kgdb-x86_64/arch/x86_64/kernel/x86_64-stub.c
+--- linux-2.6.2/arch/x86_64/kernel/x86_64-stub.c	1970-01-01 
05:30:00.000000000 +0530
++++ linux-2.6.2-kgdb-x86_64/arch/x86_64/kernel/x86_64-stub.c	2004-02-11 
13:55:25.000000000 +0530
+@@ -0,0 +1,454 @@
 +/*
 + *
 + * This program is free software; you can redistribute it and/or modify it
@@ -617,83 +227,14 @@
 + * Copyright (C) 2002 Andi Kleen, SuSE Labs
 + */
 
+/****************************************************************************
-+ *  Header: remcom.c,v 1.34 91/03/09 12:29:49 glenne Exp $
-+ *
-+ *  Module name: remcom.c $
-+ *  Revision: 1.34 $
-+ *  Date: 91/03/09 12:29:49 $
 + *  Contributor:     Lake Stevens Instrument Division$
-+ *
-+ *  Description:     low level support for gdb debugger. $
-+ *
-+ *  Considerations:  only works on target hardware $
-+ *
 + *  Written by:      Glenn Engel $
 + *  Updated by:	     Amit Kale<akale@veritas.com>
-+ *  ModuleState:     Experimental $
-+ *
-+ *  NOTES:           See Below $
-+ *
 + *  Modified for 386 by Jim Kingdon, Cygnus Support.
 + *  Origianl kgdb, compatibility with 2.1.xx kernel by David Grothe 
<dave@gcom.com>
 + *  Integrated into 2.2.5 kernel by Tigran Aivazian <tigran@sco.com>
-+ *      thread support,
-+ *      support for multiple processors,
-+ *  	support for ia-32(x86) hardware debugging,
-+ *  	Console support,
-+ *  	handling nmi watchdog
-+ *  	Amit S. Kale ( amitkale@emsyssoft.com )
-+ *
 + *  X86_64 changes from Andi Kleen's patch merged by Jim Houston
-+ *
-+ *
-+ *  To enable debugger support, two things need to happen.  One, a
-+ *  call to set_debug_traps() is necessary in order to allow any breakpoints
-+ *  or error conditions to be properly intercepted and reported to gdb.
-+ *  Two, a breakpoint needs to be generated to begin communication.  This
-+ *  is most easily accomplished by a call to breakpoint().  Breakpoint()
-+ *  simulates a breakpoint by executing an int 3.
-+ *
-+ *************
-+ *
-+ *    The following gdb commands are supported:
-+ *
-+ * command          function                               Return value
-+ *
-+ *    g             return the value of the CPU registers  hex data or ENN
-+ *    G             set the value of the CPU registers     OK or ENN
-+ *
-+ *    mAA..AA,LLLL  Read LLLL bytes at address AA..AA      hex data or ENN
-+ *    MAA..AA,LLLL: Write LLLL bytes at address AA.AA      OK or ENN
-+ *
-+ *    c             Resume at current address              SNN   ( signal 
NN)
-+ *    cAA..AA       Continue at address AA..AA             SNN
-+ *
-+ *    s             Step one instruction                   SNN
-+ *    sAA..AA       Step one instruction from AA..AA       SNN
-+ *
-+ *    k             kill
-+ *
-+ *    ?             What was the last sigval ?             SNN   (signal NN)
-+ *
-+ * All commands and responses are sent with a packet which includes a
-+ * checksum.  A packet consists of
-+ *
-+ * $<packet info>#<checksum>.
-+ *
-+ * where
-+ * <packet info> :: <characters representing the command or response>
-+ * <checksum>    :: < two hex digits computed as modulo 256 sum of 
<packetinfo>>
-+ *
-+ * When a packet is received, it is first acknowledged with either '+' or 
'-'.
-+ * '+' indicates a successful transfer.  '-' indicates a failed transfer.
-+ *
-+ * Example:
-+ *
-+ * Host:                  Reply:
-+ * $m0,10#2a               +$00010203040506070809101112131415#42
-+ *
-+ 
****************************************************************************/
++ */
 +
 +#include <linux/string.h>
 +#include <linux/kernel.h>
@@ -720,8 +261,7 @@
 +#error change the definition of slavecpulocks
 +#endif
 +
-+static void x86_64_regs_to_gdb_regs(unsigned long *gdb_regs,
-+				    struct pt_regs *regs)
++void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 +{
 +	gdb_regs[_RAX] =  regs->rax;
 +	gdb_regs[_RBX] =  regs->rbx;
@@ -745,8 +285,7 @@
 +
 +struct task_struct *__switch_to(struct task_struct *prev_p,
 +				struct task_struct *next_p);
-+static void x86_64_sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,
-+					       struct task_struct *p)
++void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct 
*p)
 +{
 +	gdb_regs[_RAX] = 0;
 +	gdb_regs[_RBX] = 0;
@@ -768,8 +307,7 @@
 +	gdb_regs[_RSP] = p->thread.rsp;
 +}
 +
-+static void x86_64_gdb_regs_to_regs(unsigned long *gdb_regs,
-+				    struct pt_regs *regs)
++void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 +{
 +	regs->rax	=     gdb_regs[_RAX] ;
 +	regs->rbx	=     gdb_regs[_RBX] ;
@@ -809,7 +347,7 @@
 +enabled:0}, {
 +enabled:0}};
 +
-+void x86_64_correct_hw_break(void)
++void kgdb_correct_hw_break(void)
 +{
 +	int breakno;
 +	int correctit;
@@ -867,7 +405,7 @@
 +	}
 +}
 +
-+int x86_64_remove_hw_break(unsigned long addr, int type)
++int kgdb_remove_hw_break(unsigned long addr, int type)
 +{
 +	int i, idx = -1;
 +	for (i = 0; i < 4; i ++) {
@@ -883,7 +421,7 @@
 +	return 0;
 +}
 +
-+int x86_64_set_hw_break(unsigned long addr, int type)
++int kgdb_set_hw_break(unsigned long addr, int type)
 +{
 +	int i, idx = -1;
 +	for (i = 0; i < 4; i ++) {
@@ -924,7 +462,7 @@
 +	return 0;
 +}
 +
-+static void x86_64_printexceptioninfo(int exceptionNo, int errorcode, char 
*buffer)
++void kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
 +{
 +	unsigned long	dr6;
 +	int		i;
@@ -954,19 +492,20 @@
 +	return;
 +}
 +
-+static void x86_64_disable_hw_debug(struct pt_regs *regs) 
++void kgdb_disable_hw_debug(struct pt_regs *regs) 
 +{
 +	/* Disable hardware debugging while we are in kgdb */
 +	asm volatile("movq %0,%%db7": /* no output */ : "r"(0UL));
 +}
 +
-+static void x86_64_post_master_code(struct pt_regs *regs, int eVector, int 
err_code)
++void kgdb_post_master_code(struct pt_regs *regs, int eVector, int err_code)
 +{
 +	/* Master processor is completely in the debugger */
 +	gdb_x86_64vector = eVector;
 +	gdb_x86_64errcode = err_code;
 +}
-+static int x86_64_handle_exception(int exceptionVector, int signo, int 
err_code,
++
++int kgdb_arch_handle_exception(int exceptionVector, int signo, int err_code,
 +                                 char *remcomInBuffer, char 
*remcomOutBuffer,
 +                                 struct pt_regs *linux_regs)
 +{
@@ -1014,7 +553,7 @@
 +				}
 +			}
 +		}
-+		x86_64_correct_hw_break();
++		kgdb_correct_hw_break();
 +		asm volatile ("movq %0, %%db6\n"::"r" (0UL));
 +
 +		return (0);
@@ -1051,11 +590,6 @@
 +	return -1; /* this means that we do not want to exit from the handler */
 +}
 +
-+static int x86_64_kgdb_init(void)
-+{
-+	return 0;
-+}
-+
 +static struct pt_regs *in_interrupt_stack(unsigned long rsp, int cpu) 
 +{ 
 +	struct pt_regs *regs;
@@ -1080,7 +614,8 @@
 +	return NULL;
 +} 
 +
-+static void x86_64_shadowinfo(struct pt_regs *regs, char *buffer, unsigned 
threadid)
++void kgdb_shadowinfo(struct pt_regs *regs, char *buffer,
++		unsigned threadid)
 +{
 +	static char intr_desc[] = "Stack at interrupt entrypoint";
 +	static char exc_desc[] = "Stack at exception entrypoint";
@@ -1088,13 +623,14 @@
 +	int cpu = hard_smp_processor_id();
 +
 +	if ((stregs = in_interrupt_stack(regs->rsp, cpu))) {
-+		kgdb_mem2hex(intr_desc, buffer, strlen(intr_desc), 0);
++		kgdb_mem2hex(intr_desc, buffer, strlen(intr_desc));
 +	} else if ((stregs = in_exception_stack(regs->rsp, cpu))) {
-+		kgdb_mem2hex(exc_desc, buffer, strlen(exc_desc), 0);
++		kgdb_mem2hex(exc_desc, buffer, strlen(exc_desc));
 +	}
 +}
 +
-+static struct task_struct *x86_64_get_shadow_thread(struct pt_regs *regs, 
int threadid)
++struct task_struct *kgdb_get_shadow_thread(struct pt_regs *regs,
++		int threadid)
 +{
 +	struct pt_regs *stregs;
 +	int cpu = hard_smp_processor_id();
@@ -1107,7 +643,7 @@
 +	return NULL;
 +}
 +
-+static struct pt_regs *x86_64_shadow_regs(struct pt_regs *regs, int 
threadid)
++struct pt_regs *kgdb_shadow_regs(struct pt_regs *regs, int threadid)
 +{
 +	struct pt_regs *stregs;
 +	int cpu = hard_smp_processor_id();
@@ -1119,83 +655,15 @@
 +	}
 +	return NULL;
 +}
++
 +struct kgdb_arch arch_kgdb_ops =  {
 +	.gdb_bpt_instr = {0xcc},
 +	.flags = KGDB_HW_BREAKPOINT,
 +	.shadowth = 1,
-+	.kgdb_init = x86_64_kgdb_init,
-+	.regs_to_gdb_regs = x86_64_regs_to_gdb_regs,
-+	.sleeping_thread_to_gdb_regs = x86_64_sleeping_thread_to_gdb_regs,
-+	.gdb_regs_to_regs = x86_64_gdb_regs_to_regs,
-+	.printexceptioninfo = x86_64_printexceptioninfo,
-+	.disable_hw_debug = x86_64_disable_hw_debug,
-+	.post_master_code = x86_64_post_master_code,
-+	.handle_exception = x86_64_handle_exception,
-+	.set_break = x86_64_set_hw_break,
-+	.remove_break = x86_64_remove_hw_break,
-+	.correct_hw_break = x86_64_correct_hw_break,
-+	.shadowinfo = x86_64_shadowinfo,
-+	.get_shadow_thread = x86_64_get_shadow_thread,
-+	.shadow_regs = x86_64_shadow_regs,
 +};
-diff -Naurp linux-2.6.1-1/arch/x86_64/lib/thunk.S 
linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/lib/thunk.S
---- linux-2.6.1-1/arch/x86_64/lib/thunk.S	2003-11-24 07:01:53.000000000 +0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/lib/thunk.S	2004-01-12 
19:10:30.000000000 +0530
-@@ -8,6 +8,7 @@
- 
- 	#include <linux/config.h>
- 	#include <linux/linkage.h>
-+	#include <asm/dwarf2.h>
- 	#include <asm/calling.h>			
- 	#include <asm/rwlock.h>
- 		
-@@ -15,18 +16,22 @@
- 	.macro thunk name,func
- 	.globl \name
- \name:	
-+	CFI_STARTPROC
- 	SAVE_ARGS
- 	call \func
- 	jmp  restore
-+	CFI_ENDPROC
- 	.endm
- 
- 	/* rdi:	arg1 ... normal C conventions. rax is passed from C. */ 	
- 	.macro thunk_retrax name,func
- 	.globl \name
- \name:	
-+	CFI_STARTPROC
- 	SAVE_ARGS
- 	call \func
- 	jmp  restore_norax
-+	CFI_ENDPROC
- 	.endm
- 	
- 
-@@ -43,13 +48,20 @@
- 	thunk_retrax __down_failed_trylock,__down_trylock
- 	thunk __up_wakeup,__up
- 	
-+	/* SAVE_ARGS below is used only for the .cfi directives it contains. */
-+	CFI_STARTPROC
-+	SAVE_ARGS
- restore:
- 	RESTORE_ARGS
- 	ret	
-+	CFI_ENDPROC
- 	
-+	CFI_STARTPROC
-+	SAVE_ARGS
- restore_norax:	
- 	RESTORE_ARGS 1
- 	ret
-+	CFI_ENDPROC
- 
- #ifdef CONFIG_SMP
- /* Support for read/write spinlocks. */
-diff -Naurp linux-2.6.1-1/arch/x86_64/mm/fault.c 
linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/mm/fault.c
---- linux-2.6.1-1/arch/x86_64/mm/fault.c	2004-01-10 11:01:36.000000000 +0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/arch/x86_64/mm/fault.c	2004-01-12 
19:10:30.000000000 +0530
+diff -Naurp linux-2.6.2/arch/x86_64/mm/fault.c 
linux-2.6.2-kgdb-x86_64/arch/x86_64/mm/fault.c
+--- linux-2.6.2/arch/x86_64/mm/fault.c	2004-02-10 13:01:23.000000000 +0530
++++ linux-2.6.2-kgdb-x86_64/arch/x86_64/mm/fault.c	2004-02-10 
16:06:23.000000000 +0530
 @@ -23,6 +23,7 @@
  #include <linux/vt_kern.h>		/* For unblank_screen() */
  #include <linux/compiler.h>
@@ -1204,29 +672,17 @@
  
  #include <asm/system.h>
  #include <asm/uaccess.h>
-@@ -248,6 +249,11 @@ asmlinkage void do_page_fault(struct pt_
- 		return;
- 
-  again:
-+	if (debugger_memerr_expected) {
-+		/* This fault was caused by memory access through a debugger.
-+		 * Don't handle it like user accesses */
-+		goto no_context;
-+	}
- 	down_read(&mm->mmap_sem);
- 
- 	vma = find_vma(mm, address);
-@@ -362,6 +368,7 @@ no_context:
+@@ -403,6 +404,7 @@ no_context:
  
   	if (is_prefetch(regs, address))
   		return;
 +	CHK_DEBUGGER(14, SIGSEGV,error_code, regs,)
  
- /*
-  * Oops. The kernel tried to access some bad page. We'll have to
-diff -Naurp linux-2.6.1-1/include/asm-x86_64/calling.h 
linux-2.6.1-1-kgdb-2.1.0-x86_64/include/asm-x86_64/calling.h
---- linux-2.6.1-1/include/asm-x86_64/calling.h	2004-01-10 11:01:47.000000000 
+0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/include/asm-x86_64/calling.h	2004-01-12 
19:10:30.000000000 +0530
+ 	if (is_errata93(regs, address))
+ 		return; 
+diff -Naurp linux-2.6.2/include/asm-x86_64/calling.h 
linux-2.6.2-kgdb-x86_64/include/asm-x86_64/calling.h
+--- linux-2.6.2/include/asm-x86_64/calling.h	2004-02-10 13:01:29.000000000 
+0530
++++ linux-2.6.2-kgdb-x86_64/include/asm-x86_64/calling.h	2004-02-10 
14:50:29.000000000 +0530
 @@ -12,7 +12,7 @@
  #define RBX 40
  /* arguments: interrupts/non tracing syscalls only save upto here*/
@@ -1236,129 +692,9 @@
  #define R9 64
  #define R8 72
  #define RAX 80
-@@ -31,20 +31,34 @@
- #define ARGOFFSET R11
- #define SWFRAME ORIG_RAX
- 
-+	
-+
-+
- 	.macro SAVE_ARGS addskip=0,norcx=0 	
-+
- 	subq  $9*8+\addskip,%rsp
-+	CFI_ADJUST_CFA_OFFSET	9*8+\addskip
- 	movq  %rdi,8*8(%rsp) 
-+	CFI_OFFSET	rdi,8*8-(9*8+\addskip)
- 	movq  %rsi,7*8(%rsp) 
-+	CFI_OFFSET	rsi,7*8-(9*8+\addskip)
- 	movq  %rdx,6*8(%rsp)
-+	CFI_OFFSET	rdx,6*8-(9*8+\addskip)
- 	.if \norcx
- 	.else
- 	movq  %rcx,5*8(%rsp)
-+	CFI_OFFSET	rcx,5*8-(9*8+\addskip)
- 	.endif
- 	movq  %rax,4*8(%rsp) 
-+	CFI_OFFSET	rax,4*8-(9*8+\addskip)
- 	movq  %r8,3*8(%rsp) 
-+	CFI_OFFSET	r8,3*8-(9*8+\addskip)
- 	movq  %r9,2*8(%rsp) 
-+	CFI_OFFSET	r9,2*8-(9*8+\addskip)
- 	movq  %r10,1*8(%rsp) 
-+	CFI_OFFSET	r10,1*8-(9*8+\addskip)
- 	movq  %r11,(%rsp) 
-+	CFI_OFFSET	r11,-(9*8+\addskip)
- 	.endm
- 
- #define ARG_SKIP 9*8
-@@ -69,6 +83,7 @@
- 	movq 8*8(%rsp),%rdi
- 	.if ARG_SKIP+\addskip > 0
- 	addq $ARG_SKIP+\addskip,%rsp
-+	CFI_ADJUST_CFA_OFFSET	-(ARG_SKIP+\addskip)
- 	.endif
- 	.endm	
- 
-@@ -87,12 +102,19 @@
- #define REST_SKIP 6*8			
- 	.macro SAVE_REST
- 	subq $REST_SKIP,%rsp
-+	CFI_ADJUST_CFA_OFFSET	REST_SKIP
- 	movq %rbx,5*8(%rsp) 
-+	CFI_OFFSET	rbx,5*8-(REST_SKIP)
- 	movq %rbp,4*8(%rsp) 
-+	CFI_OFFSET	rbp,4*8-(REST_SKIP)
- 	movq %r12,3*8(%rsp) 
-+	CFI_OFFSET	r12,3*8-(REST_SKIP)
- 	movq %r13,2*8(%rsp) 
-+	CFI_OFFSET	r13,2*8-(REST_SKIP)
- 	movq %r14,1*8(%rsp) 
-+	CFI_OFFSET	r14,1*8-(REST_SKIP)
- 	movq %r15,(%rsp) 
-+	CFI_OFFSET	r15,0*8-(REST_SKIP)
- 	.endm		
- 
- 	.macro RESTORE_REST
-@@ -103,6 +125,7 @@
- 	movq 4*8(%rsp),%rbp
- 	movq 5*8(%rsp),%rbx
- 	addq $REST_SKIP,%rsp
-+	CFI_ADJUST_CFA_OFFSET	-(REST_SKIP)
- 	.endm
- 		
- 	.macro SAVE_ALL
-diff -Naurp linux-2.6.1-1/include/asm-x86_64/dwarf2.h 
linux-2.6.1-1-kgdb-2.1.0-x86_64/include/asm-x86_64/dwarf2.h
---- linux-2.6.1-1/include/asm-x86_64/dwarf2.h	2003-11-24 07:00:56.000000000 
+0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/include/asm-x86_64/dwarf2.h	2004-01-12 
19:10:30.000000000 +0530
-@@ -12,9 +12,11 @@
-    See "as.info" for details on these pseudo ops. Unfortunately 
-    they are only supported in very new binutils, so define them 
-    away for older version. 
-+
-+   If you want to build a KGDB kernel install the new assembler.
-  */
- 
--#ifdef CONFIG_CFI_BINUTILS
-+#ifdef CONFIG_KGDB
- 
- #define CFI_STARTPROC .cfi_startproc
- #define CFI_ENDPROC .cfi_endproc
-@@ -27,23 +29,15 @@
- 
- #else
- 
--#ifdef __ASSEMBLY__
--	.macro nothing
--	.endm
--	.macro nothing1 a
--	.endm
--	.macro nothing2 a,b
--	.endm      
--#endif
--
--#define CFI_STARTPROC nothing
--#define CFI_ENDPROC nothing
--#define CFI_DEF_CFA nothing2
--#define CFI_DEF_CFA_REGISTER nothing1
--#define CFI_DEF_CFA_OFFSET nothing1
--#define CFI_ADJUST_CFA_OFFSET nothing1
--#define CFI_OFFSET nothing2
--#define CFI_REL_OFFSET nothing2
-+/* use assembler line comment character # to ignore the arguments. */
-+#define CFI_STARTPROC	#
-+#define CFI_ENDPROC	#
-+#define CFI_DEF_CFA	#
-+#define CFI_DEF_CFA_REGISTER	#
-+#define CFI_DEF_CFA_OFFSET	#
-+#define CFI_ADJUST_CFA_OFFSET	#
-+#define CFI_OFFSET	#
-+#define CFI_REL_OFFSET	#
- 
- #endif
- 
-diff -Naurp linux-2.6.1-1/include/asm-x86_64/kgdb.h 
linux-2.6.1-1-kgdb-2.1.0-x86_64/include/asm-x86_64/kgdb.h
---- linux-2.6.1-1/include/asm-x86_64/kgdb.h	1970-01-01 05:30:00.000000000 
+0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/include/asm-x86_64/kgdb.h	2004-01-12 
19:10:30.000000000 +0530
+diff -Naurp linux-2.6.2/include/asm-x86_64/kgdb.h 
linux-2.6.2-kgdb-x86_64/include/asm-x86_64/kgdb.h
+--- linux-2.6.2/include/asm-x86_64/kgdb.h	1970-01-01 05:30:00.000000000 +0530
++++ linux-2.6.2-kgdb-x86_64/include/asm-x86_64/kgdb.h	2004-02-11 
13:37:55.000000000 +0530
 @@ -0,0 +1,53 @@
 +#ifndef _ASM_KGDB_H_
 +#define _ASM_KGDB_H_
@@ -1413,9 +749,9 @@
 +#define BREAK_INSTR_SIZE       1
 +
 +#endif /* _ASM_KGDB_H_ */
-diff -Naurp linux-2.6.1-1/include/asm-x86_64/processor.h 
linux-2.6.1-1-kgdb-2.1.0-x86_64/include/asm-x86_64/processor.h
---- linux-2.6.1-1/include/asm-x86_64/processor.h	2003-11-24 
07:03:22.000000000 +0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/include/asm-x86_64/processor.h	2004-01-12 
19:10:30.000000000 +0530
+diff -Naurp linux-2.6.2/include/asm-x86_64/processor.h 
linux-2.6.2-kgdb-x86_64/include/asm-x86_64/processor.h
+--- linux-2.6.2/include/asm-x86_64/processor.h	2004-02-10 13:01:29.000000000 
+0530
++++ linux-2.6.2-kgdb-x86_64/include/asm-x86_64/processor.h	2004-02-10 
14:50:29.000000000 +0530
 @@ -252,6 +252,7 @@ struct thread_struct {
  	unsigned long	*io_bitmap_ptr;
  /* cached TLS descriptors. */
@@ -1424,23 +760,3 @@
  };
  
  #define INIT_THREAD  {}
-diff -Naurp linux-2.6.1-1/include/asm-x86_64/system.h 
linux-2.6.1-1-kgdb-2.1.0-x86_64/include/asm-x86_64/system.h
---- linux-2.6.1-1/include/asm-x86_64/system.h	2004-01-10 11:01:50.000000000 
+0530
-+++ linux-2.6.1-1-kgdb-2.1.0-x86_64/include/asm-x86_64/system.h	2004-01-12 
19:10:30.000000000 +0530
-@@ -19,7 +19,7 @@
- #define __SAVE(reg,offset) "movq %%" #reg ",(14-" #offset ")*8(%%rsp)\n\t"
- #define __RESTORE(reg,offset) "movq (14-" #offset ")*8(%%rsp),%%" #reg 
"\n\t"
- 
--#ifdef CONFIG_X86_REMOTE_DEBUG
-+/* #ifdef CONFIG_KGDB */
- 
- /* full frame for the debug stub */
- /* Should be replaced with a dwarf2 cie/fde description, then gdb could
-@@ -42,6 +42,7 @@ struct save_context_frame { 
- 	unsigned long flags;
- }; 
- 
-+#if 0
- #define SAVE_CONTEXT \
- 	"pushfq\n\t"							\
- 	"subq $14*8,%%rsp\n\t" 						\

