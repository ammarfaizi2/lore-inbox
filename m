Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310295AbSCTWNT>; Wed, 20 Mar 2002 17:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310540AbSCTWMY>; Wed, 20 Mar 2002 17:12:24 -0500
Received: from driftcreek.llnl.gov ([134.9.17.68]:60075 "EHLO
	driftcreek.llnl.gov") by vger.kernel.org with ESMTP
	id <S310295AbSCTWMJ>; Wed, 20 Mar 2002 17:12:09 -0500
To: linux-kernel@vger.kernel.org
From: Tom Epperly <tepperly@llnl.gov>
Subject: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell box
Message-Id: <20020320213530.87CFE308D@driftcreek.llnl.gov>
Date: Wed, 20 Mar 2002 13:35:30 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a followup to an earlier thread whose subject was "Re: RH7.2
running 2.4.9-21-SMP (dual Xeon's) yields "Illegal instructions". Now
I am running a self-compiled 2.4.18 kernel with small changes shown
below to log illegal instruction traps in the kernel log.

The kernel log showed me that various standard programs such as
/bin/sh are generating bogus illegal instruction traps on a legal
opcode (0x55) as part of a standard function preamble. After receiving
an illegal instruction trap on opcode (0x55), the modified kernel does
a wbinvd() to flush the cache and a __flush_tlb() to flush the TLB
and then retries the "illegal" opcode. The retry produces a second
illegal instruction trap on the same legal opcode (0x55). Information
from /var/log/messages is shown below.

The problem disappears if I disable the second CPU (via a BIOS
switch). I've tried physically switching processors on the
motherboard, and both chips behave correctly in single-CPU mode. The
system passes Dell's hardware diagnostics (twice) and memtest-86 2.9,
and I seen identical problems on two other Dell Precision 530
Workstations purchased at different times with different clock speeds.

I initiated a support call with Dell at around 3:30pm PST on Friday
15-Mar-2002, and all the feedback I've received from this so far shows
that they are clueless. They are trying to portray this as a Linux
problem.

The machine doesn't run X11, so the nVidia drivers are never loaded. I
pulled the sound card out too. It has 512MB of ECC RAM.

Does anyone else have any suggestions about what could be causing this
problem or how one might further diagnose the issue.  Is there anyway
that this might not be a hardware problem?  Please Cc me in
replies.

Tom Epperly

*SAMPLE MESSAGES* from /var/log/messages:

Mar 18 20:56:30 tux06 kernel: Restarting 13766  0x805aa80 sh
Mar 18 20:56:30 tux06 kernel: 55 89 e5 83 ec 08 8b 45 08 85 c0 74 0a 8b 15 00 24 0c 08 85 
Mar 18 20:56:30 tux06 kernel: invalid operand: 0000
Mar 18 20:56:30 tux06 kernel: CPU:    1
Mar 18 20:56:30 tux06 kernel: EIP:    0023:[usb_stor_exit+134588960/-1072693344]    Not tainted
Mar 18 20:56:30 tux06 kernel: EIP:    0023:[<0805aa80>]    Not tainted
Mar 18 20:56:30 tux06 kernel: EFLAGS: 00010292
Mar 18 20:56:30 tux06 kernel: eax: 000035c6   ebx: 000035c6   ecx: bfffe730   edx: 00000001
Mar 18 20:56:30 tux06 kernel: esi: 00000000   edi: 00000000   ebp: bfffe7c8   esp: bfffe69c
Mar 18 20:56:30 tux06 kernel: ds: 002b   es: 002b   ss: 002b
Mar 18 20:56:30 tux06 kernel: Process sh (pid: 13766, stackpage=caff1000)
Mar 18 20:56:30 tux06 kernel: Stack: 0806f58c 00000000 bfffe730 bfffe6b0 0806f580 00010000 00000000 00000000 
Mar 18 20:56:30 tux06 kernel:        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Mar 18 20:56:30 tux06 kernel:        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Mar 18 20:56:30 tux06 kernel: Call Trace: 
Mar 18 20:56:30 tux06 kernel: 
Mar 18 20:56:30 tux06 kernel: Code: 55 89 e5 83 ec 08 8b 45 08 85 c0 74 0a 8b 15 00 24 0c 08 85 
Mar 19 05:13:01 tux06 kernel:  Restarting 11895  0x4011f8a0 sh
Mar 19 05:13:01 tux06 kernel: 55 53 56 57 8b 5c 24 14 8b 4c 24 18 8b 54 24 1c 8b 74 24 20 
Mar 19 05:13:01 tux06 kernel: invalid operand: 0000
Mar 19 05:13:01 tux06 kernel: CPU:    0
Mar 19 05:13:01 tux06 kernel: EIP:    0023:[usb_stor_exit+1074919488/-1072693344]    Not tainted
Mar 19 05:13:01 tux06 kernel: EIP:    0023:[<4011f8a0>]    Not tainted
Mar 19 05:13:01 tux06 kernel: EFLAGS: 00010206
Mar 19 05:13:01 tux06 kernel: eax: 00001000   ebx: 4017c690   ecx: bfffb200   edx: 00001000
Mar 19 05:13:01 tux06 kernel: esi: 080cd00c   edi: 00001000   ebp: bfffb278   esp: bfffb1dc
Mar 19 05:13:01 tux06 kernel: ds: 002b   es: 002b   ss: 002b
Mar 19 05:13:01 tux06 kernel: Process sh (pid: 11895, stackpage=c6f97000)
Mar 19 05:13:01 tux06 kernel: Stack: 4009d145 00000000 00001000 00000003 00000022 ffffffff 00000000 00000001 
Mar 19 05:13:01 tux06 kernel:        00000001 00000805 00000000 00000000 000517b5 000081a4 00000001 00000000 
Mar 19 05:13:01 tux06 kernel:        00000000 00000000 00000000 00000000 00000a29 00000000 00001000 00000008 
Mar 19 05:13:01 tux06 kernel: Call Trace: 
Mar 19 05:13:01 tux06 kernel: 
Mar 19 05:13:01 tux06 kernel: Code: 55 53 56 57 8b 5c 24 14 8b 4c 24 18 8b 54 24 1c 8b 74 24 20 
Mar 19 05:13:01 tux06 kernel:  Restarting 11898  0x4011f8a0 sh
Mar 19 05:13:01 tux06 kernel: 55 53 56 57 8b 5c 24 14 8b 4c 24 18 8b 54 24 1c 8b 74 24 20 
Mar 19 05:13:01 tux06 kernel: invalid operand: 0000
Mar 19 05:13:01 tux06 kernel: CPU:    0
Mar 19 05:13:01 tux06 kernel: EIP:    0023:[usb_stor_exit+1074919488/-1072693344]    Not tainted
Mar 19 05:13:01 tux06 kernel: EIP:    0023:[<4011f8a0>]    Not tainted
Mar 19 05:13:01 tux06 kernel: EFLAGS: 00010206
Mar 19 05:13:01 tux06 kernel: eax: 00001000   ebx: 4017c690   ecx: bfffb200   edx: 00001000
Mar 19 05:13:01 tux06 kernel: esi: 080cd00c   edi: 00001000   ebp: bfffb278   esp: bfffb1dc
Mar 19 05:13:01 tux06 kernel: ds: 002b   es: 002b   ss: 002b
Mar 19 05:13:01 tux06 kernel: Process sh (pid: 11898, stackpage=c6f97000)
Mar 19 05:13:01 tux06 kernel: Stack: 4009d145 00000000 00001000 00000003 00000022 ffffffff 00000000 00000001 
Mar 19 05:13:01 tux06 kernel:        00000001 00000805 00000000 00000000 000517b5 000081a4 00000001 00000000 
Mar 19 05:13:01 tux06 kernel:        00000000 00000000 00000000 00000000 00000a29 00000000 00001000 00000008 
Mar 19 05:13:01 tux06 kernel: Call Trace: 
Mar 19 05:13:01 tux06 kernel: 
Mar 19 05:13:01 tux06 kernel: Code: 55 53 56 57 8b 5c 24 14 8b 4c 24 18 8b 54 24 1c 8b 74 24 20 
Mar 19 05:13:01 tux06 kernel:  Restarting 11902  0x4011f8a0 runAll
Mar 19 05:13:01 tux06 kernel: 55 53 56 57 8b 5c 24 14 8b 4c 24 18 8b 54 24 1c 8b 74 24 20 
Mar 19 05:13:01 tux06 kernel: invalid operand: 0000
Mar 19 05:13:01 tux06 kernel: CPU:    0
Mar 19 05:13:01 tux06 kernel: EIP:    0023:[usb_stor_exit+1074919488/-1072693344]    Not tainted
Mar 19 05:13:01 tux06 kernel: EIP:    0023:[<4011f8a0>]    Not tainted
Mar 19 05:13:01 tux06 kernel: EFLAGS: 00010206
Mar 19 05:13:01 tux06 kernel: eax: 00001000   ebx: 4017c690   ecx: bfffb260   edx: 00001000
Mar 19 05:13:01 tux06 kernel: esi: 080cd00c   edi: 00001000   ebp: bfffb2d8   esp: bfffb23c
Mar 19 05:13:01 tux06 kernel: ds: 002b   es: 002b   ss: 002b
Mar 19 05:13:01 tux06 kernel: Process runAll (pid: 11902, stackpage=cbe0b000)
Mar 19 05:13:01 tux06 kernel: Stack: 4009d145 00000000 00001000 00000003 00000022 ffffffff 00000000 00000001 
Mar 19 05:13:01 tux06 kernel:        00000001 00000805 00000000 00000000 000517b5 000081a4 00000001 00000000 
Mar 19 05:13:01 tux06 kernel:        00000000 00000000 00000000 00000000 00000a29 00000000 00001000 00000008 
Mar 19 05:13:01 tux06 kernel: Call Trace: 
Mar 19 05:13:01 tux06 kernel: 
Mar 19 05:13:01 tux06 kernel: Code: 55 53 56 57 8b 5c 24 14 8b 4c 24 18 8b 54 24 1c 8b 74 24 20 
Mar 19 05:13:01 tux06 kernel:  Restarting 11919  0x4011f8a0 runAll
Mar 19 05:13:01 tux06 kernel: 55 53 56 57 8b 5c 24 14 8b 4c 24 18 8b 54 24 1c 8b 74 24 20 
Mar 19 05:13:01 tux06 kernel: invalid operand: 0000
Mar 19 05:13:01 tux06 kernel: CPU:    0
Mar 19 05:13:01 tux06 kernel: EIP:    0023:[usb_stor_exit+1074919488/-1072693344]    Not tainted
Mar 19 05:13:01 tux06 kernel: EIP:    0023:[<4011f8a0>]    Not tainted
Mar 19 05:13:01 tux06 kernel: EFLAGS: 00010206
Mar 19 05:13:01 tux06 kernel: eax: 00001000   ebx: 4017c690   ecx: bfffb250   edx: 00001000
Mar 19 05:13:01 tux06 kernel: esi: 080cd00c   edi: 00001000   ebp: bfffb2c8   esp: bfffb22c
Mar 19 05:13:01 tux06 kernel: ds: 002b   es: 002b   ss: 002b
Mar 19 05:13:01 tux06 kernel: Process runAll (pid: 11919, stackpage=cbe0b000)
Mar 19 05:13:01 tux06 kernel: Stack: 4009d145 00000000 00001000 00000003 00000022 ffffffff 00000000 00000001 
Mar 19 05:13:01 tux06 kernel:        00000001 00000805 00000000 00000000 000517b5 000081a4 00000001 00000000 
Mar 19 05:13:01 tux06 kernel:        00000000 00000000 00000000 00000000 00000a29 00000000 00001000 00000008 
Mar 19 05:13:01 tux06 kernel: Call Trace: 
Mar 19 05:13:01 tux06 kernel: 
Mar 19 05:13:01 tux06 kernel: Code: 55 53 56 57 8b 5c 24 14 8b 4c 24 18 8b 54 24 1c 8b 74 24 20 

*PATCH* to add the logging (note this patch is not intended for anything other than experimenting & debugging):


$ diff -c ~epperly/linux/arch/i386/kernel/traps.c /usr/src/linux/arch/i386/kernel/traps.c
*** /home/epperly/linux/arch/i386/kernel/traps.c	Sun Sep 30 12:26:08 2001
--- /usr/src/linux/arch/i386/kernel/traps.c	Fri Mar 15 16:06:06 2002
***************
*** 214,227 ****
  	 * When in-kernel, we also print out the stack and code at the
  	 * time of the fault..
  	 */
! 	if (in_kernel) {
  
  		printk("\nStack: ");
  		show_stack((unsigned long*)esp);
  
  		printk("\nCode: ");
  		if(regs->eip < PAGE_OFFSET)
  			goto bad;
  
  		for(i=0;i<20;i++)
  		{
--- 214,229 ----
  	 * When in-kernel, we also print out the stack and code at the
  	 * time of the fault..
  	 */
! 	if (1|in_kernel) {
  
  		printk("\nStack: ");
  		show_stack((unsigned long*)esp);
  
  		printk("\nCode: ");
+                 /*
  		if(regs->eip < PAGE_OFFSET)
  			goto bad;
+                 */
  
  		for(i=0;i<20;i++)
  		{
***************
*** 267,304 ****
  }
  
  static void inline do_trap(int trapnr, int signr, char *str, int vm86,
! 			   struct pt_regs * regs, long error_code, siginfo_t *info)  {
! 	if (vm86 && regs->eflags & VM_MASK)
! 		goto vm86_trap;
! 	if (!(regs->xcs & 3))
! 		goto kernel_trap;
! 
! 	trap_signal: {
! 		struct task_struct *tsk = current;
! 		tsk->thread.error_code = error_code;
! 		tsk->thread.trap_no = trapnr;
! 		if (info)
! 			force_sig_info(signr, info, tsk);
! 		else
! 			force_sig(signr, tsk);
! 		return;
! 	}
! 
! 	kernel_trap: {
! 		unsigned long fixup = search_exception_table(regs->eip);
! 		if (fixup)
! 			regs->eip = fixup;
! 		else	
! 			die(str, regs, error_code);
! 		return;
! 	}
! 
! 	vm86_trap: {
! 		int ret = handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, trapnr);
! 		if (ret) goto trap_signal;
! 		return;
! 	}
  }
  
  #define DO_ERROR(trapnr, signr, str, name) \
--- 269,340 ----
  }
  
  static void inline do_trap(int trapnr, int signr, char *str, int vm86,
!                            struct pt_regs * regs, long error_code,
! siginfo_t *info)
  {
!   int i;
!   if (vm86 && regs->eflags & VM_MASK)
!     goto vm86_trap;
!   if (!(regs->xcs & 3))
!     goto kernel_trap;
!   
!         trap_signal: {
!                 struct task_struct *tsk = current;
!                 tsk->thread.error_code = error_code;
!                 tsk->thread.trap_no = trapnr;
! 
!                 /*debug for processes getting illegal operation faults*/
!                 if(trapnr==6){
!                         unsigned char c;
! 
!                         __get_user(c, &((unsigned char*)regs->eip)[0]);
! 
!                         if( c==0x55 ){ /*push ebp*/
!                                 if(tsk->per_cpu_utime[31]==regs->eip) {
!                                         /*This guy's been through the mill
! once already*/
!                                         die(str, regs, error_code);
!                                 }else{
!                                         /*first timer, so flag him*/
!                                         tsk->per_cpu_utime[31]=regs->eip;
!                                         printk("Restarting %d  0x%lx %s\n",tsk->pid,regs->eip,tsk->comm);
!                                         for(i=0;i<20;i++) {
!                                                 unsigned char c;
!                                                 if(__get_user(c,
! &((unsigned char*)regs->eip)[i])) {
!                                                         printk(" Bad EIP value.");
!                                                         break;
!                                                 }
!                                                 printk("%02x ", c);
!                                         }
!                                         printk("\n");
!                                         wbinvd();
!                                         __flush_tlb();
!                                         return;
!                                 }
!                         }
!                 }
!                 if (info)
!                         force_sig_info(signr, info, tsk);
!                 else
!                         force_sig(signr, tsk);
!                 return;
!         }
! 
!  kernel_trap: {
!    unsigned long fixup = search_exception_table(regs->eip);
!    if (fixup)
!      regs->eip = fixup;
!    else	
!      die(str, regs, error_code);
!    return;
!  }
!   
!  vm86_trap: {
!    int ret = handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, trapnr);
!    if (ret) goto trap_signal;
!    return;
!  }
  }
  
  #define DO_ERROR(trapnr, signr, str, name) \
