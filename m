Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314679AbSD1ETZ>; Sun, 28 Apr 2002 00:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314681AbSD1ETY>; Sun, 28 Apr 2002 00:19:24 -0400
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:29105 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S314679AbSD1ETN>; Sun, 28 Apr 2002 00:19:13 -0400
Message-ID: <3CCB77A3.6080402@didntduck.org>
Date: Sun, 28 Apr 2002 00:16:35 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Jones <davej@suse.de>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Removing SYMBOL_NAME part 4
Content-Type: multipart/mixed;
 boundary="------------040203010407000104070707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040203010407000104070707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

m68k arch

-- 

						Brian Gerst

--------------040203010407000104070707
Content-Type: text/plain;
 name="symbol_name-4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="symbol_name-4"

diff -urN linux-sn3/arch/m68k/atari/ataints.c linux/arch/m68k/atari/ataints.c
--- linux-sn3/arch/m68k/atari/ataints.c	Thu Mar  7 21:18:15 2002
+++ linux/arch/m68k/atari/ataints.c	Sat Apr 27 23:19:54 2002
@@ -168,8 +168,8 @@
 /* Dummy function to allow asm with operands.  */			   \
 void atari_slow_irq_##n##_dummy (void) {				   \
 __asm__ (__ALIGN_STR "\n"						   \
-SYMBOL_NAME_STR(atari_slow_irq_) #n "_handler:\t"			   \
-"	addql	#1,"SYMBOL_NAME_STR(irq_stat)"+8\n" /* local_irq_count */  \
+"atari_slow_irq_" #n "_handler:\t"					   \
+"	addql	#1,irq_stat+8\n" /* local_irq_count */			   \
 	SAVE_ALL_INT "\n"						   \
 	GET_CURRENT(%%d0) "\n"						   \
 "	andb	#~(1<<(%c3&7)),%a4:w\n"	/* mask this interrupt */	   \
@@ -190,7 +190,7 @@
 "	orw	#0x0600,%%sr\n"						   \
 "	andw	#0xfeff,%%sr\n"		/* set IPL = 6 again */		   \
 "	orb 	#(1<<(%c3&7)),%a4:w\n"	/* now unmask the int again */	   \
-"	jbra	"SYMBOL_NAME_STR(ret_from_interrupt)"\n"		   \
+"	jbra	ret_from_interrupt\n"					   \
 	 : : "i" (&kstat.irqs[0][n+8]), "i" (&irq_handler[n+8]),	   \
 	     "n" (PT_OFF_SR), "n" (n),					   \
 	     "i" (n & 8 ? (n & 16 ? &tt_mfp.int_mk_a : &mfp.int_mk_a)	   \
@@ -272,10 +272,10 @@
 /* Dummy function to allow asm with operands.  */
 void atari_fast_prio_irq_dummy (void) {
 __asm__ (__ALIGN_STR "\n"
-SYMBOL_NAME_STR(atari_fast_irq_handler) ":
+"atari_fast_irq_handler:
 	orw 	#0x700,%%sr		/* disable all interrupts */
-"SYMBOL_NAME_STR(atari_prio_irq_handler) ":\t
-	addql	#1,"SYMBOL_NAME_STR(irq_stat)"+8\n" /* local_irq_count */
+atari_prio_irq_handler:\t
+	addql	#1,irq_stat+8\n" /* local_irq_count */
 	SAVE_ALL_INT "\n"
 	GET_CURRENT(%%d0) "
 	/* get vector number from stack frame and convert to source */
@@ -285,7 +285,7 @@
 	addw	#(0x40-8-0x18),%%d0
 1:	lea	%a0,%%a0
 	addql	#1,%%a0@(%%d0:l:4)
-	lea	"SYMBOL_NAME_STR(irq_handler)",%%a0
+	lea	irq_handler,%%a0
 	lea	%%a0@(%%d0:l:8),%%a0
 	pea 	%%sp@			/* push frame address */
 	movel	%%a0@(4),%%sp@-		/* push handler data */
@@ -294,7 +294,7 @@
 	jsr	%%a0@			/* and call the handler */
 	addql	#8,%%sp
 	addql	#4,%%sp
-	jbra	"SYMBOL_NAME_STR(ret_from_interrupt)
+	jbra	ret_from_interrupt"
 	 : : "i" (&kstat.irqs[0]), "n" (PT_OFF_FORMATVEC)
 );
 }
@@ -306,7 +306,7 @@
 asmlinkage void falcon_hblhandler(void);
 asm(".text\n"
 __ALIGN_STR "\n"
-SYMBOL_NAME_STR(falcon_hblhandler) ":
+"falcon_hblhandler:
 	orw	#0x200,%sp@	/* set saved ipl to 2 */
 	rte");
 
diff -urN linux-sn3/arch/m68k/fpsp040/skeleton.S linux/arch/m68k/fpsp040/skeleton.S
--- linux-sn3/arch/m68k/fpsp040/skeleton.S	Thu Mar  7 21:18:18 2002
+++ linux/arch/m68k/fpsp040/skeleton.S	Sat Apr 27 23:19:54 2002
@@ -73,9 +73,9 @@
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	movel	%sp,%sp@- 		| stack frame pointer argument
-	bsrl	SYMBOL_NAME(trap_c)
+	bsrl	trap_c
 	addql	#4,%sp
-	bral	SYMBOL_NAME(ret_from_exception)
+	bral	ret_from_exception
 
 |
 |	Inexact exception
@@ -164,9 +164,9 @@
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	movel	%sp,%sp@- 		| stack frame pointer argument
-	bsrl	SYMBOL_NAME(trap_c)
+	bsrl	trap_c
 	addql	#4,%sp
-	bral	SYMBOL_NAME(ret_from_exception)
+	bral	ret_from_exception
 	
 |
 |	Overflow exception
@@ -190,9 +190,9 @@
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	movel	%sp,%sp@- 		| stack frame pointer argument
-	bsrl	SYMBOL_NAME(trap_c)
+	bsrl	trap_c
 	addql	#4,%sp
-	bral	SYMBOL_NAME(ret_from_exception)
+	bral	ret_from_exception
 	
 |
 |	Underflow exception
@@ -216,9 +216,9 @@
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	movel	%sp,%sp@- 		| stack frame pointer argument
-	bsrl	SYMBOL_NAME(trap_c)
+	bsrl	trap_c
 	addql	#4,%sp
-	bral	SYMBOL_NAME(ret_from_exception)
+	bral	ret_from_exception
 	
 |
 |	Signalling NAN exception
@@ -238,9 +238,9 @@
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	movel	%sp,%sp@- 		| stack frame pointer argument
-	bsrl	SYMBOL_NAME(trap_c)
+	bsrl	trap_c
 	addql	#4,%sp
-	bral	SYMBOL_NAME(ret_from_exception)
+	bral	ret_from_exception
 	
 |
 |	Operand Error exception
@@ -260,9 +260,9 @@
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	movel	%sp,%sp@- 		| stack frame pointer argument
-	bsrl	SYMBOL_NAME(trap_c)
+	bsrl	trap_c
 	addql	#4,%sp
-	bral	SYMBOL_NAME(ret_from_exception)
+	bral	ret_from_exception
 
 	
 |
@@ -288,9 +288,9 @@
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	movel	%sp,%sp@- 		| stack frame pointer argument
-	bsrl	SYMBOL_NAME(trap_c)
+	bsrl	trap_c
 	addql	#4,%sp
-	bral	SYMBOL_NAME(ret_from_exception)
+	bral	ret_from_exception
 
 |
 |	F-line exception
@@ -309,9 +309,9 @@
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	movel	%sp,%sp@- 		| stack frame pointer argument
-	bsrl	SYMBOL_NAME(trap_c)
+	bsrl	trap_c
 	addql	#4,%sp
-	bral	SYMBOL_NAME(ret_from_exception)
+	bral	ret_from_exception
 
 |
 |	Unsupported data type exception
@@ -331,9 +331,9 @@
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	movel	%sp,%sp@- 		| stack frame pointer argument
-	bsrl	SYMBOL_NAME(trap_c)
+	bsrl	trap_c
 	addql	#4,%sp
-	bral	SYMBOL_NAME(ret_from_exception)
+	bral	ret_from_exception
 
 |
 |	Trace exception
@@ -341,7 +341,7 @@
 	.global	real_trace
 real_trace:
 	|
-	bral	SYMBOL_NAME(trap)
+	bral	trap
 
 |
 |	fpsp_fmt_error --- exit point for frame format error
@@ -382,7 +382,7 @@
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	tstl	%curptr@(TASK_NEEDRESCHED)
-	jne	SYMBOL_NAME(ret_from_exception)	| deliver signals,
+	jne	ret_from_exception	| deliver signals,
 						| reschedule etc..
 	RESTORE_ALL
 
@@ -505,7 +505,7 @@
 	.section .fixup,#alloc,#execinstr
 	.even
 1:
-	jbra	SYMBOL_NAME(fpsp040_die)
+	jbra	fpsp040_die
 
 	.section __ex_table,#alloc
 	.align	4
diff -urN linux-sn3/arch/m68k/ifpsp060/fskeleton.S linux/arch/m68k/ifpsp060/fskeleton.S
--- linux-sn3/arch/m68k/ifpsp060/fskeleton.S	Thu Mar  7 21:18:24 2002
+++ linux/arch/m68k/ifpsp060/fskeleton.S	Sat Apr 27 23:19:54 2002
@@ -80,7 +80,7 @@
 	fsave		-(%sp)
 	move.w		#0x6000,0x2(%sp)
 	frestore	(%sp)+
-	bral		SYMBOL_NAME(trap)	| jump to trap handler
+	bral		trap	| jump to trap handler
 
 
 |
@@ -99,7 +99,7 @@
 	fsave		-(%sp)
 	move.w		#0x6000,0x2(%sp)
 	frestore	(%sp)+
-	bral		SYMBOL_NAME(trap)	| jump to trap handler
+	bral		trap	| jump to trap handler
 
 |
 | _060_real_operr():
@@ -118,7 +118,7 @@
 	fsave		-(%sp)
 	move.w		#0x6000,0x2(%sp)
 	frestore	(%sp)+
-	bral		SYMBOL_NAME(trap)	| jump to trap handler
+	bral		trap	| jump to trap handler
 
 |
 | _060_real_snan():
@@ -137,7 +137,7 @@
 	fsave		-(%sp)
 	move.w		#0x6000,0x2(%sp)
 	frestore	(%sp)+
-	bral		SYMBOL_NAME(trap)	| jump to trap handler
+	bral		trap	| jump to trap handler
 
 |
 | _060_real_dz():
@@ -156,7 +156,7 @@
 	fsave		-(%sp)
 	move.w		#0x6000,0x2(%sp)
 	frestore	(%sp)+
-	bral		SYMBOL_NAME(trap)	| jump to trap handler
+	bral		trap	| jump to trap handler
 
 |
 | _060_real_inex():
@@ -175,7 +175,7 @@
 	fsave		-(%sp)
 	move.w		#0x6000,0x2(%sp)
 	frestore	(%sp)+
-	bral		SYMBOL_NAME(trap)	| jump to trap handler
+	bral		trap	| jump to trap handler
 
 |
 | _060_real_bsun():
@@ -197,7 +197,7 @@
 	andi.b		#0xfe,(%sp)
 	fmove.l		(%sp)+,%fpsr
 
-	bral		SYMBOL_NAME(trap)	| jump to trap handler
+	bral		trap	| jump to trap handler
 
 |
 | _060_real_fline():
@@ -211,7 +211,7 @@
 | 
 	.global		_060_real_fline
 _060_real_fline:
-	bral		SYMBOL_NAME(trap)	| jump to trap handler
+	bral		trap	| jump to trap handler
 
 |
 | _060_real_fpu_disabled():
@@ -250,7 +250,7 @@
 |
 	.global		_060_real_trap
 _060_real_trap:
-	bral		SYMBOL_NAME(trap)	| jump to trap handler
+	bral		trap	| jump to trap handler
 
 |############################################################################
 
diff -urN linux-sn3/arch/m68k/ifpsp060/iskeleton.S linux/arch/m68k/ifpsp060/iskeleton.S
--- linux-sn3/arch/m68k/ifpsp060/iskeleton.S	Thu Mar  7 21:18:12 2002
+++ linux/arch/m68k/ifpsp060/iskeleton.S	Sat Apr 27 23:19:54 2002
@@ -76,8 +76,8 @@
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	tstl	%curptr@(TASK_NEEDRESCHED)
-	jne	SYMBOL_NAME(ret_from_exception)	| deliver signals,
-						| reschedule etc..
+	jne	ret_from_exception	| deliver signals,
+					| reschedule etc..
 	RESTORE_ALL
 
 |
@@ -113,7 +113,7 @@
 |	bral		_060_real_trace
 
 real_chk_end:
-	bral		SYMBOL_NAME(trap)	| jump to trap handler
+	bral		trap			| jump to trap handler
 
 |
 | _060_real_divbyzero:
@@ -153,7 +153,7 @@
 |	bral		_060_real_trace
 
 real_divbyzero_end:
-	bral		SYMBOL_NAME(trap)	| jump to trap handler
+	bral		trap			| jump to trap handler
 
 |##########################
 
diff -urN linux-sn3/arch/m68k/ifpsp060/os.S linux/arch/m68k/ifpsp060/os.S
--- linux-sn3/arch/m68k/ifpsp060/os.S	Thu Mar  7 21:18:05 2002
+++ linux/arch/m68k/ifpsp060/os.S	Sat Apr 27 23:19:54 2002
@@ -358,7 +358,7 @@
 |
 	.global		_060_real_trace
 _060_real_trace:
-	bral	SYMBOL_NAME(trap)
+	bral	trap
 
 |
 | _060_real_access():
@@ -374,7 +374,7 @@
 |
 	.global		_060_real_access
 _060_real_access:
-	bral	SYMBOL_NAME(buserr)
+	bral	buserr
 
 
 
diff -urN linux-sn3/arch/m68k/kernel/entry.S linux/arch/m68k/kernel/entry.S
--- linux-sn3/arch/m68k/kernel/entry.S	Thu Mar  7 21:18:05 2002
+++ linux/arch/m68k/kernel/entry.S	Sat Apr 27 23:19:54 2002
@@ -44,36 +44,36 @@
 
 #include "m68k_defs.h"
 
-.globl SYMBOL_NAME(system_call), SYMBOL_NAME(buserr), SYMBOL_NAME(trap)
-.globl SYMBOL_NAME(resume), SYMBOL_NAME(ret_from_exception)
-.globl SYMBOL_NAME(ret_from_signal)
-.globl SYMBOL_NAME(inthandler), SYMBOL_NAME(sys_call_table)
-.globl SYMBOL_NAME(sys_fork), SYMBOL_NAME(sys_clone), SYMBOL_NAME(sys_vfork)
-.globl SYMBOL_NAME(ret_from_interrupt), SYMBOL_NAME(bad_interrupt)
+.globl system_call, buserr, trap
+.globl resume, ret_from_exception
+.globl ret_from_signal
+.globl inthandler, sys_call_table
+.globl sys_fork, sys_clone, sys_vfork
+.globl ret_from_interrupt, bad_interrupt
 
 .text
 ENTRY(buserr)
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	movel	%sp,%sp@- 		| stack frame pointer argument
-	bsrl	SYMBOL_NAME(buserr_c)
+	bsrl	buserr_c
 	addql	#4,%sp
-	jra	SYMBOL_NAME(ret_from_exception)
+	jra	ret_from_exception
 
 ENTRY(trap)
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	movel	%sp,%sp@- 		| stack frame pointer argument
-	bsrl	SYMBOL_NAME(trap_c)
+	bsrl	trap_c
 	addql	#4,%sp
-	jra	SYMBOL_NAME(ret_from_exception)
+	jra	ret_from_exception
 
 ENTRY(reschedule)
 	| save top of frame
 	movel	%sp,%curptr@(TASK_THREAD+THREAD_ESP0)
 
-	pea	SYMBOL_NAME(ret_from_exception)
-	jmp	SYMBOL_NAME(schedule)
+	pea	ret_from_exception
+	jmp	schedule
 
 	| After a fork we jump here directly from resume,
 	| so that %d1 contains the previous task
@@ -81,32 +81,32 @@
 	| what happens in schedule_tail() in future...
 ENTRY(ret_from_fork)
 	movel	%d1,%sp@-
-	jsr	SYMBOL_NAME(schedule_tail)
+	jsr	schedule_tail
 	addql	#4,%sp
-	jra	SYMBOL_NAME(ret_from_exception)
+	jra	ret_from_exception
 
 badsys:
 	movel	#-ENOSYS,%sp@(PT_D0)
-	jra	SYMBOL_NAME(ret_from_exception)
+	jra	ret_from_exception
 
 do_trace:
 	movel	#-ENOSYS,%sp@(PT_D0)	| needed for strace
 	subql	#4,%sp
 	SAVE_SWITCH_STACK
-	jbsr	SYMBOL_NAME(syscall_trace)
+	jbsr	syscall_trace
 	RESTORE_SWITCH_STACK
 	addql	#4,%sp
 	movel	%sp@(PT_ORIG_D0),%d1
 	movel	#-ENOSYS,%d0
 	cmpl	#NR_syscalls,%d1
 	jcc	1f
-	jbsr	@(SYMBOL_NAME(sys_call_table),%d1:l:4)@(0)
+	jbsr	@(sys_call_table,%d1:l:4)@(0)
 1:	movel	%d0,%sp@(PT_D0)		| save the return value
 	subql	#4,%sp			| dummy return address
 	SAVE_SWITCH_STACK
-	jbsr	SYMBOL_NAME(syscall_trace)
+	jbsr	syscall_trace
 
-SYMBOL_NAME_LABEL(ret_from_signal)
+ret_from_signal:
 	RESTORE_SWITCH_STACK 
 	addql	#4,%sp
 /* on 68040 complete pending writebacks if any */	
@@ -115,11 +115,11 @@
 	subql	#7,%d0				| bus error frame ?
 	jbne	1f
 	movel	%sp,%sp@-
-	jbsr	SYMBOL_NAME(berr_040cleanup)
+	jbsr	berr_040cleanup
 	addql	#4,%sp
 1:	
 #endif	
-	jra	SYMBOL_NAME(ret_from_exception)
+	jra	ret_from_exception
 
 ENTRY(system_call)
 	SAVE_ALL_SYS
@@ -132,10 +132,10 @@
 	jne	do_trace
 	cmpl	#NR_syscalls,%d0
 	jcc	badsys
-	jbsr	@(SYMBOL_NAME(sys_call_table),%d0:l:4)@(0)
+	jbsr	@(sys_call_table,%d0:l:4)@(0)
 	movel	%d0,%sp@(PT_D0)		| save the return value
 
-SYMBOL_NAME_LABEL(ret_from_exception)
+ret_from_exception:
 	btst	#5,%sp@(PT_SR)		| check if returning to kernel
 	bnes	2f			| if so, skip resched, signals
 	| only allow interrupts when we are really the last one on the
@@ -143,9 +143,9 @@
 	| heavy interrupt load
 	andw	#ALLOWINT,%sr
 	tstl	%curptr@(TASK_NEEDRESCHED)
-	jne	SYMBOL_NAME(reschedule)
+	jne	reschedule
 #if 0
-	cmpl	#SYMBOL_NAME(task),%curptr	| task[0] cannot have signals
+	cmpl	#task,%curptr		| task[0] cannot have signals
 	jeq	2f
 #endif
 					| check for delayed trace
@@ -153,7 +153,7 @@
 	jne	do_delayed_trace
 5:
 	tstl	%curptr@(TASK_STATE)	| state
-	jne	SYMBOL_NAME(reschedule)
+	jne	reschedule
 
 	tstl	%curptr@(TASK_SIGPENDING)
 	jne	Lsignal_return
@@ -164,7 +164,7 @@
 	SAVE_SWITCH_STACK
 	pea	%sp@(SWITCH_STACK_SIZE)
 	clrl	%sp@-
-	bsrl	SYMBOL_NAME(do_signal)
+	bsrl	do_signal
 	addql	#8,%sp
 	RESTORE_SWITCH_STACK
 	addql	#4,%sp
@@ -175,7 +175,7 @@
 	pea	1			| send SIGTRAP
 	movel	%curptr,%sp@-
 	pea	LSIGTRAP
-	jbsr	SYMBOL_NAME(send_sig)
+	jbsr	send_sig
 	addql	#8,%sp
 	addql	#4,%sp
 	jra	5b
@@ -183,15 +183,15 @@
 
 #if 0
 #if CONFIG_AMIGA
-SYMBOL_NAME_LABEL(ami_inthandler)
-	addql	#1,SYMBOL_NAME(irq_stat)+8	| local_irq_count
+ami_inthandler:
+	addql	#1,irq_stat+8		| local_irq_count
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 
 	bfextu	%sp@(PT_VECTOR){#4,#12},%d0
 	movel	%d0,%a0
-	addql	#1,%a0@(SYMBOL_NAME(kstat)+STAT_IRQ-VECOFF(VEC_SPUR))
-	movel	%a0@(SYMBOL_NAME(autoirq_list)-VECOFF(VEC_SPUR)),%a0
+	addql	#1,%a0@(kstat+STAT_IRQ-VECOFF(VEC_SPUR))
+	movel	%a0@(autoirq_list-VECOFF(VEC_SPUR)),%a0
 
 | amiga vector int handler get the req mask instead of irq vector
 	lea	CUSTOMBASE,%a1
@@ -202,7 +202,7 @@
 	pea	%sp@
 	movel	%a0@(IRQ_DEVID),%sp@-
 	movel	%d0,%sp@-
-	pea	%pc@(SYMBOL_NAME(ret_from_interrupt):w)
+	pea	%pc@(ret_from_interrupt:w)
 	jbra	@(IRQ_HANDLER,%a0)@(0)
 
 ENTRY(nmi_handler)
@@ -213,10 +213,10 @@
 /*
 ** This is the main interrupt handler, responsible for calling process_int()
 */
-SYMBOL_NAME_LABEL(inthandler)
+inthandler:
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
-	addql	#1,SYMBOL_NAME(irq_stat)+8	| local_irq_count
+	addql	#1,irq_stat+8		| local_irq_count
 					|  put exception # in d0
 	bfextu %sp@(PT_VECTOR){#4,#10},%d0
 
@@ -227,15 +227,15 @@
 	jbeq	1f
 	btstb	#3,0xff000004		
 	jbeq	1f
-	jbsr	SYMBOL_NAME(floppy_hardint)
+	jbsr	floppy_hardint
 	jbra	3f
 1:
 #endif		
-	jbsr	SYMBOL_NAME(process_int)|  process the IRQ
+	jbsr	process_int|  process the IRQ
 3:     	addql	#8,%sp			|  pop parameters off stack
 
-SYMBOL_NAME_LABEL(ret_from_interrupt)
-	subql	#1,SYMBOL_NAME(irq_stat)+8	| local_irq_count
+ret_from_interrupt:
+	subql	#1,irq_stat+8		| local_irq_count
 	jeq	1f
 2:
 	RESTORE_ALL
@@ -249,24 +249,24 @@
 #endif
 	/* check if we need to do software interrupts */
 
-	movel	SYMBOL_NAME(irq_stat),%d0	| softirq_active
-	andl	SYMBOL_NAME(irq_stat)+4,%d0	| softirq_mask
-	jeq	SYMBOL_NAME(ret_from_exception)
+	movel	irq_stat,%d0		| softirq_active
+	andl	irq_stat+4,%d0		| softirq_mask
+	jeq	ret_from_exception
 
-	pea	SYMBOL_NAME(ret_from_exception)
-	jra	SYMBOL_NAME(do_softirq)
+	pea	ret_from_exception
+	jra	do_softirq
 
 
 /* Handler for uninitialized and spurious interrupts */
 
-SYMBOL_NAME_LABEL(bad_interrupt)
-	addql	#1,SYMBOL_NAME(num_spurious)
+bad_interrupt:
+	addql	#1,num_spurious
 	rte
 
 ENTRY(sys_fork)
 	SAVE_SWITCH_STACK	
 	pea	%sp@(SWITCH_STACK_SIZE)
-	jbsr	SYMBOL_NAME(m68k_fork)
+	jbsr	m68k_fork
 	addql	#4,%sp
 	RESTORE_SWITCH_STACK
 	rts
@@ -274,7 +274,7 @@
 ENTRY(sys_clone)
 	SAVE_SWITCH_STACK
 	pea	%sp@(SWITCH_STACK_SIZE)
-	jbsr	SYMBOL_NAME(m68k_clone)
+	jbsr	m68k_clone
 	addql	#4,%sp
 	RESTORE_SWITCH_STACK
 	rts
@@ -282,7 +282,7 @@
 ENTRY(sys_vfork)
 	SAVE_SWITCH_STACK	
 	pea	%sp@(SWITCH_STACK_SIZE)
-	jbsr	SYMBOL_NAME(m68k_vfork)
+	jbsr	m68k_vfork
 	addql	#4,%sp
 	RESTORE_SWITCH_STACK
 	rts
@@ -290,7 +290,7 @@
 ENTRY(sys_sigsuspend)
 	SAVE_SWITCH_STACK
 	pea	%sp@(SWITCH_STACK_SIZE)
-	jbsr	SYMBOL_NAME(do_sigsuspend)
+	jbsr	do_sigsuspend
 	addql	#4,%sp
 	RESTORE_SWITCH_STACK
 	rts
@@ -298,24 +298,24 @@
 ENTRY(sys_rt_sigsuspend)
 	SAVE_SWITCH_STACK
 	pea	%sp@(SWITCH_STACK_SIZE)
-	jbsr	SYMBOL_NAME(do_rt_sigsuspend)
+	jbsr	do_rt_sigsuspend
 	addql	#4,%sp
 	RESTORE_SWITCH_STACK
 	rts
 
 ENTRY(sys_sigreturn)
 	SAVE_SWITCH_STACK
-	jbsr	SYMBOL_NAME(do_sigreturn)
+	jbsr	do_sigreturn
 	RESTORE_SWITCH_STACK
 	rts
 
 ENTRY(sys_rt_sigreturn)
 	SAVE_SWITCH_STACK
-	jbsr	SYMBOL_NAME(do_rt_sigreturn)
+	jbsr	do_rt_sigreturn
 	RESTORE_SWITCH_STACK
 	rts
 
-SYMBOL_NAME_LABEL(resume)
+resume:
 	/*
 	 * Beware - when entering resume, prev (the current task) is
 	 * in a0, next (the new task) is in a1,so don't change these
@@ -343,14 +343,14 @@
 	/* save floating point context */
 #ifndef CONFIG_M68KFPU_EMU_ONLY
 #ifdef CONFIG_M68KFPU_EMU
-	tstl	SYMBOL_NAME(m68k_fputype)
+	tstl	m68k_fputype
 	jeq	3f
 #endif
 	fsave	%a0@(TASK_THREAD+THREAD_FPSTATE)
 
 #if defined(CONFIG_M68060)
 #if !defined(CPU_M68060_ONLY)
-	btst	#3,SYMBOL_NAME(m68k_cputype)+3
+	btst	#3,m68k_cputype+3
 	beqs	1f
 #endif
 	/* The 060 FPU keeps status in bits 15-8 of the first longword */
@@ -377,12 +377,12 @@
 	/* restore floating point context */
 #ifndef CONFIG_M68KFPU_EMU_ONLY
 #ifdef CONFIG_M68KFPU_EMU
-	tstl	SYMBOL_NAME(m68k_fputype)
+	tstl	m68k_fputype
 	jeq	4f
 #endif
 #if defined(CONFIG_M68060)
 #if !defined(CPU_M68060_ONLY)
-	btst	#3,SYMBOL_NAME(m68k_cputype)+3
+	btst	#3,m68k_cputype+3
 	beqs	1f
 #endif
 	/* The 060 FPU keeps status in bits 15-8 of the first longword */
@@ -424,231 +424,231 @@
 
 .data
 ALIGN
-SYMBOL_NAME_LABEL(sys_call_table)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* 0  -  old "setup()" system call*/
-	.long SYMBOL_NAME(sys_exit)
-	.long SYMBOL_NAME(sys_fork)
-	.long SYMBOL_NAME(sys_read)
-	.long SYMBOL_NAME(sys_write)
-	.long SYMBOL_NAME(sys_open)		/* 5 */
-	.long SYMBOL_NAME(sys_close)
-	.long SYMBOL_NAME(sys_waitpid)
-	.long SYMBOL_NAME(sys_creat)
-	.long SYMBOL_NAME(sys_link)
-	.long SYMBOL_NAME(sys_unlink)		/* 10 */
-	.long SYMBOL_NAME(sys_execve)
-	.long SYMBOL_NAME(sys_chdir)
-	.long SYMBOL_NAME(sys_time)
-	.long SYMBOL_NAME(sys_mknod)
-	.long SYMBOL_NAME(sys_chmod)		/* 15 */
-	.long SYMBOL_NAME(sys_chown16)
-	.long SYMBOL_NAME(sys_ni_syscall)				/* old break syscall holder */
-	.long SYMBOL_NAME(sys_stat)
-	.long SYMBOL_NAME(sys_lseek)
-	.long SYMBOL_NAME(sys_getpid)		/* 20 */
-	.long SYMBOL_NAME(sys_mount)
-	.long SYMBOL_NAME(sys_oldumount)
-	.long SYMBOL_NAME(sys_setuid16)
-	.long SYMBOL_NAME(sys_getuid16)
-	.long SYMBOL_NAME(sys_stime)		/* 25 */
-	.long SYMBOL_NAME(sys_ptrace)
-	.long SYMBOL_NAME(sys_alarm)
-	.long SYMBOL_NAME(sys_fstat)
-	.long SYMBOL_NAME(sys_pause)
-	.long SYMBOL_NAME(sys_utime)		/* 30 */
-	.long SYMBOL_NAME(sys_ni_syscall)				/* old stty syscall holder */
-	.long SYMBOL_NAME(sys_ni_syscall)				/* old gtty syscall holder */
-	.long SYMBOL_NAME(sys_access)
-	.long SYMBOL_NAME(sys_nice)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* 35 */		/* old ftime syscall holder */
-	.long SYMBOL_NAME(sys_sync)
-	.long SYMBOL_NAME(sys_kill)
-	.long SYMBOL_NAME(sys_rename)
-	.long SYMBOL_NAME(sys_mkdir)
-	.long SYMBOL_NAME(sys_rmdir)		/* 40 */
-	.long SYMBOL_NAME(sys_dup)
-	.long SYMBOL_NAME(sys_pipe)
-	.long SYMBOL_NAME(sys_times)
-	.long SYMBOL_NAME(sys_ni_syscall)				/* old prof syscall holder */
-	.long SYMBOL_NAME(sys_brk)		/* 45 */
-	.long SYMBOL_NAME(sys_setgid16)
-	.long SYMBOL_NAME(sys_getgid16)
-	.long SYMBOL_NAME(sys_signal)
-	.long SYMBOL_NAME(sys_geteuid16)
-	.long SYMBOL_NAME(sys_getegid16)	/* 50 */
-	.long SYMBOL_NAME(sys_acct)
-	.long SYMBOL_NAME(sys_umount)					/* recycled never used phys() */
-	.long SYMBOL_NAME(sys_ni_syscall)				/* old lock syscall holder */
-	.long SYMBOL_NAME(sys_ioctl)
-	.long SYMBOL_NAME(sys_fcntl)		/* 55 */
-	.long SYMBOL_NAME(sys_ni_syscall)				/* old mpx syscall holder */
-	.long SYMBOL_NAME(sys_setpgid)
-	.long SYMBOL_NAME(sys_ni_syscall)				/* old ulimit syscall holder */
-	.long SYMBOL_NAME(sys_ni_syscall)
-	.long SYMBOL_NAME(sys_umask)		/* 60 */
-	.long SYMBOL_NAME(sys_chroot)
-	.long SYMBOL_NAME(sys_ustat)
-	.long SYMBOL_NAME(sys_dup2)
-	.long SYMBOL_NAME(sys_getppid)
-	.long SYMBOL_NAME(sys_getpgrp)		/* 65 */
-	.long SYMBOL_NAME(sys_setsid)
-	.long SYMBOL_NAME(sys_sigaction)
-	.long SYMBOL_NAME(sys_sgetmask)
-	.long SYMBOL_NAME(sys_ssetmask)
-	.long SYMBOL_NAME(sys_setreuid16)	/* 70 */
-	.long SYMBOL_NAME(sys_setregid16)
-	.long SYMBOL_NAME(sys_sigsuspend)
-	.long SYMBOL_NAME(sys_sigpending)
-	.long SYMBOL_NAME(sys_sethostname)
-	.long SYMBOL_NAME(sys_setrlimit)	/* 75 */
-	.long SYMBOL_NAME(sys_old_getrlimit)
-	.long SYMBOL_NAME(sys_getrusage)
-	.long SYMBOL_NAME(sys_gettimeofday)
-	.long SYMBOL_NAME(sys_settimeofday)
-	.long SYMBOL_NAME(sys_getgroups16)	/* 80 */
-	.long SYMBOL_NAME(sys_setgroups16)
-	.long SYMBOL_NAME(old_select)
-	.long SYMBOL_NAME(sys_symlink)
-	.long SYMBOL_NAME(sys_lstat)
-	.long SYMBOL_NAME(sys_readlink)		/* 85 */
-	.long SYMBOL_NAME(sys_uselib)
-	.long SYMBOL_NAME(sys_swapon)
-	.long SYMBOL_NAME(sys_reboot)
-	.long SYMBOL_NAME(old_readdir)
-	.long SYMBOL_NAME(old_mmap)		/* 90 */
-	.long SYMBOL_NAME(sys_munmap)
-	.long SYMBOL_NAME(sys_truncate)
-	.long SYMBOL_NAME(sys_ftruncate)
-	.long SYMBOL_NAME(sys_fchmod)
-	.long SYMBOL_NAME(sys_fchown16)		/* 95 */
-	.long SYMBOL_NAME(sys_getpriority)
-	.long SYMBOL_NAME(sys_setpriority)
-	.long SYMBOL_NAME(sys_ni_syscall)				/* old profil syscall holder */
-	.long SYMBOL_NAME(sys_statfs)
-	.long SYMBOL_NAME(sys_fstatfs)		/* 100 */
-	.long SYMBOL_NAME(sys_ioperm)
-	.long SYMBOL_NAME(sys_socketcall)
-	.long SYMBOL_NAME(sys_syslog)
-	.long SYMBOL_NAME(sys_setitimer)
-	.long SYMBOL_NAME(sys_getitimer)	/* 105 */
-	.long SYMBOL_NAME(sys_newstat)
-	.long SYMBOL_NAME(sys_newlstat)
-	.long SYMBOL_NAME(sys_newfstat)
-	.long SYMBOL_NAME(sys_ni_syscall)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* iopl for i386 */ /* 110 */
-	.long SYMBOL_NAME(sys_vhangup)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* obsolete idle() syscall */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* vm86old for i386 */
-	.long SYMBOL_NAME(sys_wait4)
-	.long SYMBOL_NAME(sys_swapoff)		/* 115 */
-	.long SYMBOL_NAME(sys_sysinfo)
-	.long SYMBOL_NAME(sys_ipc)
-	.long SYMBOL_NAME(sys_fsync)
-	.long SYMBOL_NAME(sys_sigreturn)
-	.long SYMBOL_NAME(sys_clone)		/* 120 */
-	.long SYMBOL_NAME(sys_setdomainname)
-	.long SYMBOL_NAME(sys_newuname)
-	.long SYMBOL_NAME(sys_cacheflush)	/* modify_ldt for i386 */
-	.long SYMBOL_NAME(sys_adjtimex)
-	.long SYMBOL_NAME(sys_mprotect)		/* 125 */
-	.long SYMBOL_NAME(sys_sigprocmask)
-	.long SYMBOL_NAME(sys_create_module)
-	.long SYMBOL_NAME(sys_init_module)
-	.long SYMBOL_NAME(sys_delete_module)
-	.long SYMBOL_NAME(sys_get_kernel_syms)	/* 130 */
-	.long SYMBOL_NAME(sys_quotactl)
-	.long SYMBOL_NAME(sys_getpgid)
-	.long SYMBOL_NAME(sys_fchdir)
-	.long SYMBOL_NAME(sys_bdflush)
-	.long SYMBOL_NAME(sys_sysfs)		/* 135 */
-	.long SYMBOL_NAME(sys_personality)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* for afs_syscall */
-	.long SYMBOL_NAME(sys_setfsuid16)
-	.long SYMBOL_NAME(sys_setfsgid16)
-	.long SYMBOL_NAME(sys_llseek)		/* 140 */
-	.long SYMBOL_NAME(sys_getdents)
-	.long SYMBOL_NAME(sys_select)
-	.long SYMBOL_NAME(sys_flock)
-	.long SYMBOL_NAME(sys_msync)
-	.long SYMBOL_NAME(sys_readv)		/* 145 */
-	.long SYMBOL_NAME(sys_writev)
-	.long SYMBOL_NAME(sys_getsid)
-	.long SYMBOL_NAME(sys_fdatasync)
-	.long SYMBOL_NAME(sys_sysctl)
-	.long SYMBOL_NAME(sys_mlock)		/* 150 */
-	.long SYMBOL_NAME(sys_munlock)
-	.long SYMBOL_NAME(sys_mlockall)
-	.long SYMBOL_NAME(sys_munlockall)
-	.long SYMBOL_NAME(sys_sched_setparam)
-	.long SYMBOL_NAME(sys_sched_getparam)   /* 155 */
-	.long SYMBOL_NAME(sys_sched_setscheduler)
-	.long SYMBOL_NAME(sys_sched_getscheduler)
-	.long SYMBOL_NAME(sys_sched_yield)
-	.long SYMBOL_NAME(sys_sched_get_priority_max)
-	.long SYMBOL_NAME(sys_sched_get_priority_min)  /* 160 */
-	.long SYMBOL_NAME(sys_sched_rr_get_interval)
-	.long SYMBOL_NAME(sys_nanosleep)
-	.long SYMBOL_NAME(sys_mremap)
-	.long SYMBOL_NAME(sys_setresuid16)
-	.long SYMBOL_NAME(sys_getresuid16)	/* 165 */
-	.long SYMBOL_NAME(sys_getpagesize)
-	.long SYMBOL_NAME(sys_query_module)
-	.long SYMBOL_NAME(sys_poll)
-	.long SYMBOL_NAME(sys_nfsservctl)
-	.long SYMBOL_NAME(sys_setresgid16)	/* 170 */
-	.long SYMBOL_NAME(sys_getresgid16)
-	.long SYMBOL_NAME(sys_prctl)
-	.long SYMBOL_NAME(sys_rt_sigreturn)
-	.long SYMBOL_NAME(sys_rt_sigaction)
-	.long SYMBOL_NAME(sys_rt_sigprocmask)	/* 175 */
-	.long SYMBOL_NAME(sys_rt_sigpending)
-	.long SYMBOL_NAME(sys_rt_sigtimedwait)
-	.long SYMBOL_NAME(sys_rt_sigqueueinfo)
-	.long SYMBOL_NAME(sys_rt_sigsuspend)
-	.long SYMBOL_NAME(sys_pread)		/* 180 */
-	.long SYMBOL_NAME(sys_pwrite)
-	.long SYMBOL_NAME(sys_lchown16);
-	.long SYMBOL_NAME(sys_getcwd)
-	.long SYMBOL_NAME(sys_capget)
-	.long SYMBOL_NAME(sys_capset)           /* 185 */
-	.long SYMBOL_NAME(sys_sigaltstack)
-	.long SYMBOL_NAME(sys_sendfile)
-	.long SYMBOL_NAME(sys_ni_syscall)		/* streams1 */
-	.long SYMBOL_NAME(sys_ni_syscall)		/* streams2 */
-	.long SYMBOL_NAME(sys_vfork)            /* 190 */
-	.long SYMBOL_NAME(sys_getrlimit)
-	.long SYMBOL_NAME(sys_mmap2)
-	.long SYMBOL_NAME(sys_truncate64)
-	.long SYMBOL_NAME(sys_ftruncate64)
-	.long SYMBOL_NAME(sys_stat64)		/* 195 */
-	.long SYMBOL_NAME(sys_lstat64)
-	.long SYMBOL_NAME(sys_fstat64)
-	.long SYMBOL_NAME(sys_chown)
-	.long SYMBOL_NAME(sys_getuid)
-	.long SYMBOL_NAME(sys_getgid)		/* 200 */
-	.long SYMBOL_NAME(sys_geteuid)
-	.long SYMBOL_NAME(sys_getegid)
-	.long SYMBOL_NAME(sys_setreuid)
-	.long SYMBOL_NAME(sys_setregid)
-	.long SYMBOL_NAME(sys_getgroups)	/* 205 */
-	.long SYMBOL_NAME(sys_setgroups)
-	.long SYMBOL_NAME(sys_fchown)
-	.long SYMBOL_NAME(sys_setresuid)
-	.long SYMBOL_NAME(sys_getresuid)
-	.long SYMBOL_NAME(sys_setresgid)	/* 210 */
-	.long SYMBOL_NAME(sys_getresgid)
-	.long SYMBOL_NAME(sys_lchown)
-	.long SYMBOL_NAME(sys_setuid)
-	.long SYMBOL_NAME(sys_setgid)
-	.long SYMBOL_NAME(sys_setfsuid)		/* 215 */
-	.long SYMBOL_NAME(sys_setfsgid)
-	.long SYMBOL_NAME(sys_ni_syscall)
-	.long SYMBOL_NAME(sys_ni_syscall)
-	.long SYMBOL_NAME(sys_ni_syscall)
-	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
-	.long SYMBOL_NAME(sys_gettid)
-	.long SYMBOL_NAME(sys_tkill)
+sys_call_table:
+	.long sys_ni_syscall	/* 0  -  old "setup()" system call*/
+	.long sys_exit
+	.long sys_fork
+	.long sys_read
+	.long sys_write
+	.long sys_open		/* 5 */
+	.long sys_close
+	.long sys_waitpid
+	.long sys_creat
+	.long sys_link
+	.long sys_unlink	/* 10 */
+	.long sys_execve
+	.long sys_chdir
+	.long sys_time
+	.long sys_mknod
+	.long sys_chmod		/* 15 */
+	.long sys_chown16
+	.long sys_ni_syscall				/* old break syscall holder */
+	.long sys_stat
+	.long sys_lseek
+	.long sys_getpid	/* 20 */
+	.long sys_mount
+	.long sys_oldumount
+	.long sys_setuid16
+	.long sys_getuid16
+	.long sys_stime		/* 25 */
+	.long sys_ptrace
+	.long sys_alarm
+	.long sys_fstat
+	.long sys_pause
+	.long sys_utime		/* 30 */
+	.long sys_ni_syscall				/* old stty syscall holder */
+	.long sys_ni_syscall				/* old gtty syscall holder */
+	.long sys_access
+	.long sys_nice
+	.long sys_ni_syscall	/* 35 */		/* old ftime syscall holder */
+	.long sys_sync
+	.long sys_kill
+	.long sys_rename
+	.long sys_mkdir
+	.long sys_rmdir		/* 40 */
+	.long sys_dup
+	.long sys_pipe
+	.long sys_times
+	.long sys_ni_syscall				/* old prof syscall holder */
+	.long sys_brk		/* 45 */
+	.long sys_setgid16
+	.long sys_getgid16
+	.long sys_signal
+	.long sys_geteuid16
+	.long sys_getegid16	/* 50 */
+	.long sys_acct
+	.long sys_umount					/* recycled never used phys() */
+	.long sys_ni_syscall				/* old lock syscall holder */
+	.long sys_ioctl
+	.long sys_fcntl		/* 55 */
+	.long sys_ni_syscall				/* old mpx syscall holder */
+	.long sys_setpgid
+	.long sys_ni_syscall				/* old ulimit syscall holder */
+	.long sys_ni_syscall
+	.long sys_umask		/* 60 */
+	.long sys_chroot
+	.long sys_ustat
+	.long sys_dup2
+	.long sys_getppid
+	.long sys_getpgrp	/* 65 */
+	.long sys_setsid
+	.long sys_sigaction
+	.long sys_sgetmask
+	.long sys_ssetmask
+	.long sys_setreuid16	/* 70 */
+	.long sys_setregid16
+	.long sys_sigsuspend
+	.long sys_sigpending
+	.long sys_sethostname
+	.long sys_setrlimit	/* 75 */
+	.long sys_old_getrlimit
+	.long sys_getrusage
+	.long sys_gettimeofday
+	.long sys_settimeofday
+	.long sys_getgroups16	/* 80 */
+	.long sys_setgroups16
+	.long old_select
+	.long sys_symlink
+	.long sys_lstat
+	.long sys_readlink	/* 85 */
+	.long sys_uselib
+	.long sys_swapon
+	.long sys_reboot
+	.long old_readdir
+	.long old_mmap		/* 90 */
+	.long sys_munmap
+	.long sys_truncate
+	.long sys_ftruncate
+	.long sys_fchmod
+	.long sys_fchown16	/* 95 */
+	.long sys_getpriority
+	.long sys_setpriority
+	.long sys_ni_syscall				/* old profil syscall holder */
+	.long sys_statfs
+	.long sys_fstatfs	/* 100 */
+	.long sys_ioperm
+	.long sys_socketcall
+	.long sys_syslog
+	.long sys_setitimer
+	.long sys_getitimer	/* 105 */
+	.long sys_newstat
+	.long sys_newlstat
+	.long sys_newfstat
+	.long sys_ni_syscall
+	.long sys_ni_syscall	/* iopl for i386 */ /* 110 */
+	.long sys_vhangup
+	.long sys_ni_syscall	/* obsolete idle() syscall */
+	.long sys_ni_syscall	/* vm86old for i386 */
+	.long sys_wait4
+	.long sys_swapoff	/* 115 */
+	.long sys_sysinfo
+	.long sys_ipc
+	.long sys_fsync
+	.long sys_sigreturn
+	.long sys_clone		/* 120 */
+	.long sys_setdomainname
+	.long sys_newuname
+	.long sys_cacheflush	/* modify_ldt for i386 */
+	.long sys_adjtimex
+	.long sys_mprotect	/* 125 */
+	.long sys_sigprocmask
+	.long sys_create_module
+	.long sys_init_module
+	.long sys_delete_module
+	.long sys_get_kernel_syms	/* 130 */
+	.long sys_quotactl
+	.long sys_getpgid
+	.long sys_fchdir
+	.long sys_bdflush
+	.long sys_sysfs		/* 135 */
+	.long sys_personality
+	.long sys_ni_syscall	/* for afs_syscall */
+	.long sys_setfsuid16
+	.long sys_setfsgid16
+	.long sys_llseek	/* 140 */
+	.long sys_getdents
+	.long sys_select
+	.long sys_flock
+	.long sys_msync
+	.long sys_readv		/* 145 */
+	.long sys_writev
+	.long sys_getsid
+	.long sys_fdatasync
+	.long sys_sysctl
+	.long sys_mlock		/* 150 */
+	.long sys_munlock
+	.long sys_mlockall
+	.long sys_munlockall
+	.long sys_sched_setparam
+	.long sys_sched_getparam   /* 155 */
+	.long sys_sched_setscheduler
+	.long sys_sched_getscheduler
+	.long sys_sched_yield
+	.long sys_sched_get_priority_max
+	.long sys_sched_get_priority_min  /* 160 */
+	.long sys_sched_rr_get_interval
+	.long sys_nanosleep
+	.long sys_mremap
+	.long sys_setresuid16
+	.long sys_getresuid16	/* 165 */
+	.long sys_getpagesize
+	.long sys_query_module
+	.long sys_poll
+	.long sys_nfsservctl
+	.long sys_setresgid16	/* 170 */
+	.long sys_getresgid16
+	.long sys_prctl
+	.long sys_rt_sigreturn
+	.long sys_rt_sigaction
+	.long sys_rt_sigprocmask	/* 175 */
+	.long sys_rt_sigpending
+	.long sys_rt_sigtimedwait
+	.long sys_rt_sigqueueinfo
+	.long sys_rt_sigsuspend
+	.long sys_pread		/* 180 */
+	.long sys_pwrite
+	.long sys_lchown16;
+	.long sys_getcwd
+	.long sys_capget
+	.long sys_capset	/* 185 */
+	.long sys_sigaltstack
+	.long sys_sendfile
+	.long sys_ni_syscall	/* streams1 */
+	.long sys_ni_syscall	/* streams2 */
+	.long sys_vfork		/* 190 */
+	.long sys_getrlimit
+	.long sys_mmap2
+	.long sys_truncate64
+	.long sys_ftruncate64
+	.long sys_stat64	/* 195 */
+	.long sys_lstat64
+	.long sys_fstat64
+	.long sys_chown
+	.long sys_getuid
+	.long sys_getgid	/* 200 */
+	.long sys_geteuid
+	.long sys_getegid
+	.long sys_setreuid
+	.long sys_setregid
+	.long sys_getgroups	/* 205 */
+	.long sys_setgroups
+	.long sys_fchown
+	.long sys_setresuid
+	.long sys_getresuid
+	.long sys_setresgid	/* 210 */
+	.long sys_getresgid
+	.long sys_lchown
+	.long sys_setuid
+	.long sys_setgid
+	.long sys_setfsuid	/* 215 */
+	.long sys_setfsgid
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_getdents64	/* 220 */
+	.long sys_gettid
+	.long sys_tkill
 
-	.rept NR_syscalls-(.-SYMBOL_NAME(sys_call_table))/4
-		.long SYMBOL_NAME(sys_ni_syscall)
+	.rept NR_syscalls-(.-sys_call_table)/4
+		.long sys_ni_syscall
 	.endr
diff -urN linux-sn3/arch/m68k/kernel/head.S linux/arch/m68k/kernel/head.S
--- linux-sn3/arch/m68k/kernel/head.S	Thu Mar  7 21:18:31 2002
+++ linux/arch/m68k/kernel/head.S	Sat Apr 27 23:19:54 2002
@@ -302,15 +302,15 @@
 /* #define FONT_8x16 */	/* 2nd choice */
 /* #define FONT_6x11 */	/* 3rd choice */
 
-.globl SYMBOL_NAME(kernel_pg_dir)
-.globl SYMBOL_NAME(availmem)
-.globl SYMBOL_NAME(m68k_pgtable_cachemode)
-.globl SYMBOL_NAME(m68k_supervisor_cachemode)
+.globl kernel_pg_dir
+.globl availmem
+.globl m68k_pgtable_cachemode
+.globl m68k_supervisor_cachemode
 #ifdef CONFIG_MVME16x
-.globl SYMBOL_NAME(mvme_bdid)
+.globl mvme_bdid
 #endif
 #ifdef CONFIG_Q40
-.globl SYMBOL_NAME(q40_mem_cptr)	
+.globl q40_mem_cptr	
 #endif		
 
 CPUTYPE_040	= 1	/* indicates an 040 */
@@ -585,40 +585,40 @@
 	.long	MACH_MAC, MAC_BOOTI_VERSION
 	.long	MACH_Q40, Q40_BOOTI_VERSION	
 	.long	0
-1:	jra	SYMBOL_NAME(__start)
+1:	jra	__start
 
-.equ	SYMBOL_NAME(kernel_pg_dir),SYMBOL_NAME(_stext)
+.equ	kernel_pg_dir,_stext
 
-.equ	.,SYMBOL_NAME(_stext)+PAGESIZE
+.equ	.,_stext+PAGESIZE
 
 ENTRY(_start)
-	jra	SYMBOL_NAME(__start)
+	jra	__start
 __INIT
 ENTRY(__start)
 
 /*
  * Setup initial stack pointer
  */
-	lea	%pc@(SYMBOL_NAME(_stext)),%sp
+	lea	%pc@(_stext),%sp
 
 /*
  * Record the CPU and machine type.
  */
 
 	get_bi_record	BI_MACHTYPE
-	lea	%pc@(SYMBOL_NAME(m68k_machtype)),%a1
+	lea	%pc@(m68k_machtype),%a1
 	movel	%a0@,%a1@
 
 	get_bi_record	BI_FPUTYPE
-	lea	%pc@(SYMBOL_NAME(m68k_fputype)),%a1
+	lea	%pc@(m68k_fputype),%a1
 	movel	%a0@,%a1@
 
 	get_bi_record	BI_MMUTYPE
-	lea	%pc@(SYMBOL_NAME(m68k_mmutype)),%a1
+	lea	%pc@(m68k_mmutype),%a1
 	movel	%a0@,%a1@
 
 	get_bi_record	BI_CPUTYPE
-	lea	%pc@(SYMBOL_NAME(m68k_cputype)),%a1
+	lea	%pc@(m68k_cputype),%a1
 	movel	%a0@,%a1@
 
 #ifdef CONFIG_MAC
@@ -682,7 +682,7 @@
  * and is converted here from a booter type definition to a separate bit
  * number which allows for the standard is_0x0 macro tests.
  */
-	movel	%pc@(SYMBOL_NAME(m68k_cputype)),%d0
+	movel	%pc@(m68k_cputype),%d0
 	/*
 	 * Assume it's an 030
 	 */
@@ -766,9 +766,9 @@
 L(save_cachetype):
 	/* Save cache mode for supervisor mode and page tables
 	 */
-	lea	%pc@(SYMBOL_NAME(m68k_supervisor_cachemode)),%a0
+	lea	%pc@(m68k_supervisor_cachemode),%a0
 	movel	%d0,%a0@
-	lea	%pc@(SYMBOL_NAME(m68k_pgtable_cachemode)),%a0
+	lea	%pc@(m68k_pgtable_cachemode),%a0
 	movel	%d1,%a0@
 
 /*
@@ -804,7 +804,7 @@
 	tstl	%d0
 	jbmi	1f
 	movel	%a0@,%d3
-	lea	%pc@(SYMBOL_NAME(atari_mch_type)),%a0
+	lea	%pc@(atari_mch_type),%a0
 	movel	%d3,%a0@
 1:
 	/* On the Hades, the iobase must be set up before opening the
@@ -834,7 +834,7 @@
 	tstl	%d0
 	jbmi	1f
 	movel	%a0@,%d3
-	lea	%pc@(SYMBOL_NAME(vme_brdtype)),%a0
+	lea	%pc@(vme_brdtype),%a0
 	movel	%d3,%a0@
 1:
 #ifdef CONFIG_MVME16x
@@ -854,7 +854,7 @@
 	.word	0x70		/* trap 0x70 - .BRD_ID */
 	movel	%sp@+,%a0
 1:
-	lea	%pc@(SYMBOL_NAME(mvme_bdid)),%a1
+	lea	%pc@(mvme_bdid),%a1
 	/* Structure is 32 bytes long */
 	movel	%a0@+,%a1@+
 	movel	%a0@+,%a1@+
@@ -894,16 +894,16 @@
 	putc	'\n'
 	putc	'A'
 	dputn	%pc@(L(cputype))
-	dputn	%pc@(SYMBOL_NAME(m68k_supervisor_cachemode))
-	dputn	%pc@(SYMBOL_NAME(m68k_pgtable_cachemode))
+	dputn	%pc@(m68k_supervisor_cachemode)
+	dputn	%pc@(m68k_pgtable_cachemode)
 	dputc	'\n'
 
 /*
  * Save physical start address of kernel
  */
 	lea	%pc@(L(phys_kernel_start)),%a0
-	lea	%pc@(SYMBOL_NAME(_stext)),%a1
-	subl	#SYMBOL_NAME(_stext),%a1
+	lea	%pc@(_stext),%a1
+	subl	#_stext,%a1
 	addl	#PAGE_OFFSET,%a1
 	movel	%a1,%a0@
 
@@ -920,7 +920,7 @@
  */
 
 	mmu_map	#PAGE_OFFSET,%pc@(L(phys_kernel_start)),#4*1024*1024,\
-		%pc@(SYMBOL_NAME(m68k_supervisor_cachemode))
+		%pc@(m68k_supervisor_cachemode)
 
 	putc	'C'
 
@@ -984,7 +984,7 @@
 
 	/* I/O base addr for non-Medusa, non-Hades: 0x00000000 */
 	moveq	#0,%d0
-	movel	%pc@(SYMBOL_NAME(atari_mch_type)),%d3
+	movel	%pc@(atari_mch_type),%d3
 	cmpl	#ATARI_MACH_MEDUSA,%d3
 	jbeq	2f
 	cmpl	#ATARI_MACH_HADES,%d3
@@ -1263,7 +1263,7 @@
 	 */
 	movel	%pc@(L(phys_kernel_start)),%d0
 	subl	#PAGE_OFFSET,%d0
-	lea	%pc@(SYMBOL_NAME(_stext)),%a0
+	lea	%pc@(_stext),%a0
 	subl	%d0,%a0
 	mmu_fixup_page_mmu_cache	%a0
 
@@ -1461,7 +1461,7 @@
 /*
  * Setup initial stack pointer
  */
-	lea	SYMBOL_NAME(init_task_union),%curptr
+	lea	init_task_union,%curptr
 	lea	0x2000(%curptr),%sp
 
 	putc	'K'
@@ -1471,14 +1471,14 @@
 /*
  * The new 64bit printf support requires an early exception initialization.
  */
-	jbsr	SYMBOL_NAME(base_trap_init)
+	jbsr	base_trap_init
 
 /* jump to the kernel start */
 
 	putc	'\n'
 	leds	0x55
 
-	jbsr	SYMBOL_NAME(start_kernel)
+	jbsr	start_kernel
 
 /*
  * Find a tag record in the bootinfo structure
@@ -1489,7 +1489,7 @@
 func_start	get_bi_record,%d1
 
 	movel	ARG1,%d0
-	lea	%pc@(SYMBOL_NAME(_end)),%a0
+	lea	%pc@(_end),%a0
 1:	tstw	%a0@(BIR_TAG)
 	jeq	3f
 	cmpw	%a0@(BIR_TAG),%d0
@@ -1669,7 +1669,7 @@
 	jbra	1b
 #endif /* MMU 040 Dumping code that's gory and detailed */
 
-	lea	%pc@(SYMBOL_NAME(kernel_pg_dir)),%a5
+	lea	%pc@(kernel_pg_dir),%a5
 	movel	%a5,%a0			/* a0 has the address of the root table ptr */
 	movel	#0x00000000,%a4		/* logical address */
 	moveql	#0,%d0
@@ -2286,7 +2286,7 @@
 
 	movel	%a0@,%d0
 	andil	#_CACHEMASK040,%d0
-	orl	%pc@(SYMBOL_NAME(m68k_pgtable_cachemode)),%d0
+	orl	%pc@(m68k_pgtable_cachemode),%d0
 	movel	%d0,%a0@
 
 	dputc	'\n'
@@ -2516,7 +2516,7 @@
 	 * in mm/init.c simply expects kernel_pg_dir there, the rest of
 	 * page is used for further ptr tables in get_ptr_table.
 	 */
-	lea	%pc@(SYMBOL_NAME(_stext)),%a0
+	lea	%pc@(_stext),%a0
 	lea	%pc@(L(mmu_cached_pointer_tables)),%a1
 	movel	%a0,%a1@
 	addl	#ROOT_TABLE_SIZE*4,%a1@
@@ -2907,7 +2907,7 @@
 	is_not_q40(2f)
 /* debug output goes into SRAM, so we don't do it unless requested
    - check for '%LX$' signature in SRAM   */
-	lea	%pc@(SYMBOL_NAME(q40_mem_cptr)),%a1
+	lea	%pc@(q40_mem_cptr),%a1
 	move.l	#0xff020010,%a1@  /* must be inited - also used by debug=mem */
 	move.l	#0xff020000,%a1   
 	cmp.b	#'%',%a1@
@@ -3040,7 +3040,7 @@
 	 * the SRAM, which is non-standard.
 	 */
 	moveml	%d0-%d7/%a2-%a6,%sp@-
-	movel	SYMBOL_NAME(vme_brdtype),%d1
+	movel	vme_brdtype,%d1
 	jeq	1f			| No tag - use the Bug
 	cmpi	#VME_TYPE_MVME162,%d1
 	jeq	6f
@@ -3112,7 +3112,7 @@
 	is_not_q40(2f)
 	tst.l	%pc@(L(q40_do_debug))	/* only debug if requested */
 	beq	2f
-	lea	%pc@(SYMBOL_NAME(q40_mem_cptr)),%a1
+	lea	%pc@(q40_mem_cptr),%a1
 	move.l	%a1@,%a0
 	move.b	%d0,%a0@
 	addq.l	#4,%a0
@@ -3287,13 +3287,13 @@
 	/* Calculate font size */
 
 #if   defined(FONT_8x8)
-	lea	%pc@(SYMBOL_NAME(font_vga_8x8)), %a0
+	lea	%pc@(font_vga_8x8), %a0
 #elif defined(FONT_8x16)
-	lea	%pc@(SYMBOL_NAME(font_vga_8x16)),%a0
+	lea	%pc@(font_vga_8x16),%a0
 #elif defined(FONT_6x11)
-	lea	%pc@(SYMBOL_NAME(font_vga_6x11)),%a0
+	lea	%pc@(font_vga_6x11),%a0
 #else	/*   (FONT_8x8) default */
-	lea	%pc@(SYMBOL_NAME(font_vga_8x8)), %a0
+	lea	%pc@(font_vga_8x8), %a0
 #endif
 
 	/*
@@ -3347,11 +3347,11 @@
 	putn	%pc@(L(mac_videobase))		/* video addr. */
 
 	puts	"\n  _stext:"
-	lea	%pc@(SYMBOL_NAME(_stext)),%a0
+	lea	%pc@(_stext),%a0
 	putn	%a0
 
 	puts	"\nbootinfo:"
-	lea	%pc@(SYMBOL_NAME(_end)),%a0
+	lea	%pc@(_end),%a0
 	putn	%a0
 
 	puts	"\ncpuid:"
@@ -3380,7 +3380,7 @@
 	subil	#64,%d0		/* snug up against the right edge */
 	clrl	%d1		/* start at the top */
 	movel	#73,%d7
-	lea	%pc@(SYMBOL_NAME(that_penguin)),%a1
+	lea	%pc@(that_penguin),%a1
 console_penguin_row:
 	movel	#31,%d6
 console_penguin_pixel_pair:
@@ -3846,18 +3846,18 @@
 	.data
 	.align	4
 
-SYMBOL_NAME_LABEL(availmem)
+availmem:
 	.long	0
-SYMBOL_NAME_LABEL(m68k_pgtable_cachemode)
+m68k_pgtable_cachemode:
 	.long	0
-SYMBOL_NAME_LABEL(m68k_supervisor_cachemode)
+m68k_supervisor_cachemode:
 	.long	0
 #if defined(CONFIG_MVME16x)
-SYMBOL_NAME_LABEL(mvme_bdid)
+mvme_bdid:
 	.long	0,0,0,0,0,0,0,0
 #endif
 #if defined(CONFIG_Q40)
-SYMBOL_NAME_LABEL(q40_mem_cptr)
+q40_mem_cptr:
 	.long 0
 L(q40_do_debug):	
 	.long 0	
diff -urN linux-sn3/arch/m68k/kernel/signal.c linux/arch/m68k/kernel/signal.c
--- linux-sn3/arch/m68k/kernel/signal.c	Thu Mar  7 21:18:15 2002
+++ linux/arch/m68k/kernel/signal.c	Sat Apr 27 23:19:54 2002
@@ -408,7 +408,7 @@
 			 "2: movesl %4@+,%2\n\t"
 			 "3: movel %2,%/a0@+\n\t"
 			 "   dbra %1,2b\n\t"
-			 "   bral " SYMBOL_NAME_STR(ret_from_signal) "\n"
+			 "   bral ret_from_signal\n"
 			 "4:\n"
 			 ".section __ex_table,\"a\"\n"
 			 "   .align 4\n"
@@ -507,7 +507,7 @@
 			 "2: movesl %4@+,%2\n\t"
 			 "3: movel %2,%/a0@+\n\t"
 			 "   dbra %1,2b\n\t"
-			 "   bral " SYMBOL_NAME_STR(ret_from_signal) "\n"
+			 "   bral ret_from_signal\n"
 			 "4:\n"
 			 ".section __ex_table,\"a\"\n"
 			 "   .align 4\n"
diff -urN linux-sn3/arch/m68k/kernel/sun3-head.S linux/arch/m68k/kernel/sun3-head.S
--- linux-sn3/arch/m68k/kernel/sun3-head.S	Thu Mar  7 21:18:03 2002
+++ linux/arch/m68k/kernel/sun3-head.S	Sat Apr 27 23:19:54 2002
@@ -12,27 +12,27 @@
 ROOT_TABLE_SIZE = 128
 PAGESIZE	= 8192
 SUN3_INVALID_PMEG = 255
-.globl SYMBOL_NAME(bootup_user_stack)
-.globl SYMBOL_NAME(bootup_kernel_stack)
-.globl SYMBOL_NAME(pg0)
-.globl SYMBOL_NAME(empty_bad_page)
-.globl SYMBOL_NAME(empty_bad_page_table)
-.globl SYMBOL_NAME(empty_zero_page)
-.globl SYMBOL_NAME(swapper_pg_dir)
-.globl SYMBOL_NAME(kernel_pmd_table)
-.globl SYMBOL_NAME(availmem)
-.global SYMBOL_NAME(m68k_pgtable_cachemode)
-.global SYMBOL_NAME(kpt)
+.globl bootup_user_stack
+.globl bootup_kernel_stack
+.globl pg0
+.globl empty_bad_page
+.globl empty_bad_page_table
+.globl empty_zero_page
+.globl swapper_pg_dir
+.globl kernel_pmd_table
+.globl availmem
+.global m68k_pgtable_cachemode
+.global kpt
 | todo: all these should be in bss!
-SYMBOL_NAME(swapper_pg_dir):                .skip 0x2000
-SYMBOL_NAME(pg0):                           .skip 0x2000
-SYMBOL_NAME(empty_bad_page):                .skip 0x2000
-SYMBOL_NAME(empty_bad_page_table):          .skip 0x2000
-SYMBOL_NAME(kernel_pmd_table):              .skip 0x2000
-SYMBOL_NAME(empty_zero_page):               .skip 0x2000
+swapper_pg_dir:                .skip 0x2000
+pg0:                           .skip 0x2000
+empty_bad_page:                .skip 0x2000
+empty_bad_page_table:          .skip 0x2000
+kernel_pmd_table:              .skip 0x2000
+empty_zero_page:               .skip 0x2000
 
-.globl SYMBOL_NAME(kernel_pg_dir)
-.equ    SYMBOL_NAME(kernel_pg_dir),SYMBOL_NAME(kernel_pmd_table)
+.globl kernel_pg_dir
+.equ    kernel_pg_dir,kernel_pmd_table
 
 	.section .head
 ENTRY(_stext)
@@ -69,11 +69,11 @@
 	jmp	1f:l		
 
 /* Following code executes at high addresses (0xE000xxx). */
-1:	lea	SYMBOL_NAME(init_task_union),%a2	| get initial thread...
+1:	lea	init_task_union,%a2			| get initial thread...
 	lea	%a2@(KTHREAD_SIZE),%sp			| ...and its stack.
 
 /* copy bootinfo records from the loader to _end */
-	lea	SYMBOL_NAME(_end), %a1
+	lea	_end, %a1
 	lea	BI_START, %a0
 	/* number of longs to copy */
 	movel	%a0@, %d0
@@ -88,22 +88,22 @@
 	moveq	#-1,%d0
 	movsb	%d0,(AC_SEGMAP+0x0)
 
-	jbsr	SYMBOL_NAME(sun3_init)
+	jbsr	sun3_init
 
-	jbsr	SYMBOL_NAME(base_trap_init)
+	jbsr	base_trap_init
 			
-        jbsr    SYMBOL_NAME(start_kernel)
+        jbsr    start_kernel
 	trap	#15			
 
         .data
         .even
-SYMBOL_NAME_LABEL(kpt)
+kpt:
         .long 0
-SYMBOL_NAME_LABEL(availmem)
+availmem:
         .long 0
 | todo: remove next two. --m
-SYMBOL_NAME_LABEL(is_medusa)
+is_medusa:
         .long 0
-SYMBOL_NAME_LABEL(m68k_pgtable_cachemode)
+m68k_pgtable_cachemode:
         .long 0
 
diff -urN linux-sn3/arch/m68k/kernel/traps.c linux/arch/m68k/kernel/traps.c
--- linux-sn3/arch/m68k/kernel/traps.c	Thu Mar  7 21:18:32 2002
+++ linux/arch/m68k/kernel/traps.c	Sat Apr 27 23:19:54 2002
@@ -64,7 +64,7 @@
 /* nmi handler for the Amiga */
 asm(".text\n"
     __ALIGN_STR "\n"
-    SYMBOL_NAME_STR(nmihandler) ": rte");
+    "nmihandler: rte");
 
 /*
  * this must be called very early as the kernel might
diff -urN linux-sn3/arch/m68k/lib/semaphore.S linux/arch/m68k/lib/semaphore.S
--- linux-sn3/arch/m68k/lib/semaphore.S	Thu Mar  7 21:18:06 2002
+++ linux/arch/m68k/lib/semaphore.S	Sat Apr 27 23:19:54 2002
@@ -18,7 +18,7 @@
 ENTRY(__down_failed)
 	moveml %a0/%d0/%d1,-(%sp)
 	movel %a1,-(%sp)
-	jbsr SYMBOL_NAME(__down)
+	jbsr __down
 	movel (%sp)+,%a1
 	moveml (%sp)+,%a0/%d0/%d1
 	rts
@@ -27,7 +27,7 @@
 	movel %a0,-(%sp)
 	movel %d1,-(%sp)
 	movel %a1,-(%sp)
-	jbsr SYMBOL_NAME(__down_interruptible)
+	jbsr __down_interruptible
 	movel (%sp)+,%a1
 	movel (%sp)+,%d1
 	movel (%sp)+,%a0
@@ -37,7 +37,7 @@
 	movel %a0,-(%sp)
 	movel %d1,-(%sp)
 	movel %a1,-(%sp)
-	jbsr SYMBOL_NAME(__down_trylock)
+	jbsr __down_trylock
 	movel (%sp)+,%a1
 	movel (%sp)+,%d1
 	movel (%sp)+,%a0
@@ -46,7 +46,7 @@
 ENTRY(__up_wakeup)
 	moveml %a0/%d0/%d1,-(%sp)
 	movel %a1,-(%sp)
-	jbsr SYMBOL_NAME(__up)
+	jbsr __up
 	movel (%sp)+,%a1
 	moveml (%sp)+,%a0/%d0/%d1
 	rts
diff -urN linux-sn3/arch/m68k/math-emu/fp_entry.S linux/arch/m68k/math-emu/fp_entry.S
--- linux-sn3/arch/m68k/math-emu/fp_entry.S	Thu Mar  7 21:18:08 2002
+++ linux/arch/m68k/math-emu/fp_entry.S	Sat Apr 27 23:19:54 2002
@@ -41,17 +41,17 @@
 
 #include "fp_emu.h"
 
-	.globl	SYMBOL_NAME(fpu_emu)
+	.globl	fpu_emu
 	.globl	fp_debugprint
 	.globl	fp_err_ua1,fp_err_ua2
 
 	.text
-SYMBOL_NAME_LABEL(fpu_emu)
+fpu_emu:
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 
 #if defined(CPU_M68020_OR_M68030) && defined(CPU_M68040_OR_M68060)
-        tst.l	SYMBOL_NAME(m68k_is040or060)
+        tst.l	m68k_is040or060
         jeq	1f
 #endif
 #if defined(CPU_M68040_OR_M68060)
@@ -63,7 +63,7 @@
 
 #if defined(CONFIG_M68060)
 #if !defined(CPU_M68060_ONLY)
-	btst	#3,SYMBOL_NAME(m68k_cputype)+3
+	btst	#3,m68k_cputype+3
 	jeq	1f
 #endif
 	btst	#7,(FPS_SR,%sp)
@@ -72,11 +72,11 @@
 1:
 	| emulation successful?
 	tst.l	%d0
-	jeq	SYMBOL_NAME(ret_from_exception)
+	jeq	ret_from_exception
 
 	| send some signal to program here
 
-	jra	SYMBOL_NAME(ret_from_exception)
+	jra	ret_from_exception
 
 	| we jump here after an access error while trying to access
 	| user space, we correct stackpointer and send a SIGSEGV to
@@ -88,9 +88,9 @@
 	move.l	%a0,-(%sp)
 	pea	SEGV_MAPERR
 	pea	SIGSEGV
-	jsr	SYMBOL_NAME(fpemu_signal)
+	jsr	fpemu_signal
 	add.w	#12,%sp
-	jra	SYMBOL_NAME(ret_from_exception)
+	jra	ret_from_exception
 
 #if defined(CONFIG_M68060)
 	| send a trace signal if we are debugged
@@ -99,9 +99,9 @@
 	move.l	(FPS_PC,%sp),-(%sp)
 	pea	TRAP_TRACE
 	pea	SIGTRAP
-	jsr	SYMBOL_NAME(fpemu_signal)
+	jsr	fpemu_signal
 	add.w	#12,%sp
-	jra	SYMBOL_NAME(ret_from_exception)
+	jra	ret_from_exception
 #endif
 
 	.globl	fp_get_data_reg, fp_put_data_reg
diff -urN linux-sn3/include/asm-m68k/system.h linux/include/asm-m68k/system.h
--- linux-sn3/include/asm-m68k/system.h	Thu Mar  7 21:18:15 2002
+++ linux/include/asm-m68k/system.h	Sat Apr 27 23:19:55 2002
@@ -40,7 +40,7 @@
   register void *_prev __asm__ ("a0") = (prev); \
   register void *_next __asm__ ("a1") = (next); \
   register void *_last __asm__ ("d1"); \
-  __asm__ __volatile__("jbsr " SYMBOL_NAME_STR(resume) \
+  __asm__ __volatile__("jbsr resume" \
 		       : "=d" (_last) : "a" (_prev), "a" (_next) \
 		       : "d0", /* "d1", */ "d2", "d3", "d4", "d5", "a0", "a1"); \
   (last) = _last; \

--------------040203010407000104070707--

