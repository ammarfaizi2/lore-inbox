Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314675AbSD1EJH>; Sun, 28 Apr 2002 00:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314676AbSD1EJG>; Sun, 28 Apr 2002 00:09:06 -0400
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:61083 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S314675AbSD1EJB>; Sun, 28 Apr 2002 00:09:01 -0400
Message-ID: <3CCB7540.7040603@didntduck.org>
Date: Sun, 28 Apr 2002 00:06:24 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Jones <davej@suse.de>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Removing SYMBOL_NAME part 3
Content-Type: multipart/mixed;
 boundary="------------040906040900050908020205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040906040900050908020205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

SuperH arch

-- 

						Brian Gerst

--------------040906040900050908020205
Content-Type: text/plain;
 name="symbol_name-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="symbol_name-3"

diff -urN linux-sn2/arch/sh/kernel/entry.S linux/arch/sh/kernel/entry.S
--- linux-sn2/arch/sh/kernel/entry.S	Thu Mar  7 21:18:25 2002
+++ linux/arch/sh/kernel/entry.S	Sat Apr 27 23:19:54 2002
@@ -195,8 +195,8 @@
 
 	.align 2
 1:	.long	MMU_TEA
-2:	.long	SYMBOL_NAME(__do_page_fault)
-3:	.long	SYMBOL_NAME(do_page_fault)
+2:	.long	__do_page_fault
+3:	.long	do_page_fault
 
 	.align	2
 address_error_load:
@@ -217,7 +217,7 @@
 
 	.align 2
 1:	.long	MMU_TEA
-2:	.long   SYMBOL_NAME(do_address_error)
+2:	.long   do_address_error
 
 #if defined(CONFIG_SH_STANDARD_BIOS)
 	.align	2
@@ -257,7 +257,7 @@
 	 ldc	k1, ssr
 	.align	2
 1:	.long	0x300000f0
-2:	.long	SYMBOL_NAME(gdb_vbr_vector)
+2:	.long	gdb_vbr_vector
 #endif
 
 	.align	2
@@ -275,7 +275,7 @@
 	 nop
 
 	.align	2
-1:	.long	SYMBOL_NAME(break_point_trap_software)
+1:	.long	break_point_trap_software
 
 	.align	2
 error:	
@@ -285,7 +285,7 @@
 	jmp	@r0
 	 nop
 	.align	2
-1:	.long	SYMBOL_NAME(do_exception_error)
+1:	.long	do_exception_error
 
 
 !
@@ -308,7 +308,7 @@
 	 nop	 
 
 	.align	2
-1:	.long	SYMBOL_NAME(schedule_tail)
+1:	.long	schedule_tail
 
 /*
  * Old syscall interface:
@@ -422,7 +422,7 @@
 syscall_ret_trace:
 	mov.l	r0, @(OFF_R0,r15)		! save the return value
 	mov.l	__syscall_trace, r1
-	mova	SYMBOL_NAME(ret_from_syscall), r0
+	mova	ret_from_syscall, r0
 	jmp	@r1    	! Call syscall_trace() which notifies superior
 	 lds	r0, pr    	! Then return to ret_from_syscall()
 
@@ -497,9 +497,9 @@
 	.align	2
 __TRA:	.long	TRA
 __syscall_trace:
-#error    	.long	SYMBOL_NAME(syscall_trace)
+#error    	.long	syscall_trace
 __n_sys:.long	NR_syscalls
-__sct:	.long	SYMBOL_NAME(sys_call_table)
+__sct:	.long	sys_call_table
 __syscall_ret_trace:
 	.long	syscall_ret_trace
 __syscall_ret:
@@ -510,12 +510,12 @@
 
 	.align	2
 reschedule:
-	mova	SYMBOL_NAME(ret_from_syscall), r0
+	mova	ret_from_syscall, r0
 	mov.l	1f, r1
 	jmp	@r1
 	 lds	r0, pr
 	.align	2
-1:	.long	SYMBOL_NAME(schedule)
+1:	.long	schedule
 
 ret_from_irq:
 ret_from_exception:
@@ -560,9 +560,9 @@
 	 lds	r0, pr
 	.align	2
 __do_signal:
-#error	.long	SYMBOL_NAME(do_signal)
+#error	.long	do_signal
 __irq_stat:
-	.long	SYMBOL_NAME(irq_stat)
+	.long	irq_stat
 
 	.align 2
 restore_all:
@@ -729,7 +729,7 @@
 	jmp	@r9
 	 nop
 	.align	2
-1:	.long	SYMBOL_NAME(exception_handling_table)
+1:	.long	exception_handling_table
 3:	.long	0x000000f0	! FD=0, IMASK=15
 5:	.long	0xcfffffff	! RB=0, BL=0
 6:	.long	0x00080000	! SZ=0, PR=1
@@ -750,7 +750,7 @@
 	.long	address_error_load
 	.long	address_error_store
 #if defined(__SH4__)
-	.long	SYMBOL_NAME(do_fpu_error)
+	.long	do_fpu_error
 #else
 	.long	error	! fpu_exception
 #endif
@@ -764,93 +764,93 @@
 	.long	break_point_trap
 ENTRY(interrupt_table)
 	! external hardware
-	.long	SYMBOL_NAME(do_IRQ)	! 0000
-	.long	SYMBOL_NAME(do_IRQ)	! 0001
-	.long	SYMBOL_NAME(do_IRQ)	! 0010
-	.long	SYMBOL_NAME(do_IRQ)	! 0011
-	.long	SYMBOL_NAME(do_IRQ)	! 0100
-	.long	SYMBOL_NAME(do_IRQ)	! 0101
-	.long	SYMBOL_NAME(do_IRQ)	! 0110
-	.long	SYMBOL_NAME(do_IRQ)	! 0111
-	.long	SYMBOL_NAME(do_IRQ)	! 1000
-	.long	SYMBOL_NAME(do_IRQ)	! 1001
-	.long	SYMBOL_NAME(do_IRQ)	! 1010
-	.long	SYMBOL_NAME(do_IRQ)	! 1011
-	.long	SYMBOL_NAME(do_IRQ)	! 1100
-	.long	SYMBOL_NAME(do_IRQ)	! 1101
-	.long	SYMBOL_NAME(do_IRQ)	! 1110
+	.long	do_IRQ			! 0000
+	.long	do_IRQ			! 0001
+	.long	do_IRQ			! 0010
+	.long	do_IRQ			! 0011
+	.long	do_IRQ			! 0100
+	.long	do_IRQ			! 0101
+	.long	do_IRQ			! 0110
+	.long	do_IRQ			! 0111
+	.long	do_IRQ			! 1000
+	.long	do_IRQ			! 1001
+	.long	do_IRQ			! 1010
+	.long	do_IRQ			! 1011
+	.long	do_IRQ			! 1100
+	.long	do_IRQ			! 1101
+	.long	do_IRQ			! 1110
 	.long	error
 	! Internal hardware
-	.long	SYMBOL_NAME(do_IRQ)	! TMU0 tuni0
-	.long	SYMBOL_NAME(do_IRQ)	! TMU1 tuni1
-	.long	SYMBOL_NAME(do_IRQ)	! TMU2 tuni2
-	.long	SYMBOL_NAME(do_IRQ)	!      ticpi2
-	.long	SYMBOL_NAME(do_IRQ)	! RTC  ati
-	.long	SYMBOL_NAME(do_IRQ)	!      pri
-	.long	SYMBOL_NAME(do_IRQ)	!      cui
-	.long	SYMBOL_NAME(do_IRQ)	! SCI  eri
-	.long	SYMBOL_NAME(do_IRQ)	!      rxi
-	.long	SYMBOL_NAME(do_IRQ)	!      txi
-	.long	SYMBOL_NAME(do_IRQ)	!      tei
-	.long	SYMBOL_NAME(do_IRQ)	! WDT  iti
-	.long	SYMBOL_NAME(do_IRQ)	! REF  rcmi
-	.long	SYMBOL_NAME(do_IRQ)	!      rovi
-	.long	SYMBOL_NAME(do_IRQ)
-	.long	SYMBOL_NAME(do_IRQ)
+	.long	do_IRQ			! TMU0 tuni0
+	.long	do_IRQ			! TMU1 tuni1
+	.long	do_IRQ			! TMU2 tuni2
+	.long	do_IRQ			!      ticpi2
+	.long	do_IRQ			! RTC  ati
+	.long	do_IRQ			!      pri
+	.long	do_IRQ			!      cui
+	.long	do_IRQ			! SCI  eri
+	.long	do_IRQ			!      rxi
+	.long	do_IRQ			!      txi
+	.long	do_IRQ			!      tei
+	.long	do_IRQ			! WDT  iti
+	.long	do_IRQ			! REF  rcmi
+	.long	do_IRQ			!      rovi
+	.long	do_IRQ		
+	.long	do_IRQ		
 #if  defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_SH7709)
-	.long	SYMBOL_NAME(do_IRQ)	! 32 IRQ  irq0
-	.long	SYMBOL_NAME(do_IRQ)	! 33      irq1
-	.long	SYMBOL_NAME(do_IRQ)	! 34      irq2
-	.long	SYMBOL_NAME(do_IRQ)	! 35      irq3
-	.long	SYMBOL_NAME(do_IRQ)	! 36      irq4
-	.long	SYMBOL_NAME(do_IRQ)	! 37      irq5
-	.long	SYMBOL_NAME(do_IRQ)	! 38
-	.long	SYMBOL_NAME(do_IRQ)	! 39
-	.long	SYMBOL_NAME(do_IRQ)	! 40 PINT pint0-7
-	.long	SYMBOL_NAME(do_IRQ)	! 41      pint8-15
-	.long	SYMBOL_NAME(do_IRQ)	! 42
-	.long	SYMBOL_NAME(do_IRQ)	! 43
-	.long	SYMBOL_NAME(do_IRQ)	! 44
-	.long	SYMBOL_NAME(do_IRQ)	! 45
-	.long	SYMBOL_NAME(do_IRQ)	! 46
-	.long	SYMBOL_NAME(do_IRQ)	! 47
-	.long	SYMBOL_NAME(do_IRQ)	! 48 DMAC dei0
-	.long	SYMBOL_NAME(do_IRQ)	! 49      dei1
-	.long	SYMBOL_NAME(do_IRQ)	! 50      dei2
-	.long	SYMBOL_NAME(do_IRQ)	! 51      dei3
-	.long	SYMBOL_NAME(do_IRQ)	! 52 IrDA eri1
-	.long	SYMBOL_NAME(do_IRQ)	! 53      rxi1
-	.long	SYMBOL_NAME(do_IRQ)	! 54      bri1
-	.long	SYMBOL_NAME(do_IRQ)	! 55      txi1
-	.long	SYMBOL_NAME(do_IRQ)	! 56 SCIF eri2
-	.long	SYMBOL_NAME(do_IRQ)	! 57      rxi2
-	.long	SYMBOL_NAME(do_IRQ)	! 58      bri2
-	.long	SYMBOL_NAME(do_IRQ)	! 59      txi2
-	.long	SYMBOL_NAME(do_IRQ)	! 60 ADC  adi
+	.long	do_IRQ			! 32 IRQ  irq0
+	.long	do_IRQ			! 33      irq1
+	.long	do_IRQ			! 34      irq2
+	.long	do_IRQ			! 35      irq3
+	.long	do_IRQ			! 36      irq4
+	.long	do_IRQ			! 37      irq5
+	.long	do_IRQ			! 38
+	.long	do_IRQ			! 39
+	.long	do_IRQ			! 40 PINT pint0-7
+	.long	do_IRQ			! 41      pint8-15
+	.long	do_IRQ			! 42
+	.long	do_IRQ			! 43
+	.long	do_IRQ			! 44
+	.long	do_IRQ			! 45
+	.long	do_IRQ			! 46
+	.long	do_IRQ			! 47
+	.long	do_IRQ			! 48 DMAC dei0
+	.long	do_IRQ			! 49      dei1
+	.long	do_IRQ			! 50      dei2
+	.long	do_IRQ			! 51      dei3
+	.long	do_IRQ			! 52 IrDA eri1
+	.long	do_IRQ			! 53      rxi1
+	.long	do_IRQ			! 54      bri1
+	.long	do_IRQ			! 55      txi1
+	.long	do_IRQ			! 56 SCIF eri2
+	.long	do_IRQ			! 57      rxi2
+	.long	do_IRQ			! 58      bri2
+	.long	do_IRQ			! 59      txi2
+	.long	do_IRQ			! 60 ADC  adi
 #if defined(CONFIG_CPU_SUBTYPE_SH7707)
-	.long   SYMBOL_NAME(do_IRQ)	! 61 LCDC lcdi
-	.long   SYMBOL_NAME(do_IRQ)	! 62 PCC  pcc0i
-	.long   SYMBOL_NAME(do_IRQ)	! 63      pcc1i
+	.long   do_IRQ			! 61 LCDC lcdi
+	.long   do_IRQ			! 62 PCC  pcc0i
+	.long   do_IRQ			! 63      pcc1i
 #endif
 #elif defined(__SH4__)
-	.long	SYMBOL_NAME(do_IRQ)	! 32 Hitachi UDI
-	.long	SYMBOL_NAME(do_IRQ)	! 33 GPIO
-	.long	SYMBOL_NAME(do_IRQ)	! 34 DMAC dmte0
-	.long	SYMBOL_NAME(do_IRQ)	! 35      dmte1
-	.long	SYMBOL_NAME(do_IRQ)	! 36      dmte2
-	.long	SYMBOL_NAME(do_IRQ)	! 37      dmte3
-	.long	SYMBOL_NAME(do_IRQ)	! 38      dmae
+	.long	do_IRQ			! 32 Hitachi UDI
+	.long	do_IRQ			! 33 GPIO
+	.long	do_IRQ			! 34 DMAC dmte0
+	.long	do_IRQ			! 35      dmte1
+	.long	do_IRQ			! 36      dmte2
+	.long	do_IRQ			! 37      dmte3
+	.long	do_IRQ			! 38      dmae
 	.long	error			! 39
-	.long	SYMBOL_NAME(do_IRQ)	! 40 SCIF eri
-	.long	SYMBOL_NAME(do_IRQ)	! 41      rxi
-	.long	SYMBOL_NAME(do_IRQ)	! 42      bri
-	.long	SYMBOL_NAME(do_IRQ)	! 43      txi
+	.long	do_IRQ			! 40 SCIF eri
+	.long	do_IRQ			! 41      rxi
+	.long	do_IRQ			! 42      bri
+	.long	do_IRQ			! 43      txi
 	.long	error			! 44
 	.long	error			! 45
 	.long	error			! 46
 	.long	error			! 47
-	.long	SYMBOL_NAME(do_fpu_state_restore)	! 48
-	.long	SYMBOL_NAME(do_fpu_state_restore)	! 49
+	.long	do_fpu_state_restore	! 48
+	.long	do_fpu_state_restore	! 49
 #endif
 #if defined(CONFIG_CPU_SUBTYPE_SH7751)
 	.long	error
@@ -867,14 +867,14 @@
 	.long	error
 	.long	error
 	.long	error
-	.long	SYMBOL_NAME(do_IRQ)	! PCI serr
-	.long	SYMBOL_NAME(do_IRQ)	!     dma3
-	.long	SYMBOL_NAME(do_IRQ)	!     dma2
-	.long	SYMBOL_NAME(do_IRQ)	!     dma1
-	.long	SYMBOL_NAME(do_IRQ)	!     dma0
-	.long	SYMBOL_NAME(do_IRQ)	!     pwon
-	.long	SYMBOL_NAME(do_IRQ)	!     pwdwn
-	.long	SYMBOL_NAME(do_IRQ)	!     err
+	.long	do_IRQ			! PCI serr
+	.long	do_IRQ			!     dma3
+	.long	do_IRQ			!     dma2
+	.long	do_IRQ			!     dma1
+	.long	do_IRQ			!     dma0
+	.long	do_IRQ			!     pwon
+	.long	do_IRQ			!     pwdwn
+	.long	do_IRQ			!     err
 #elif defined(CONFIG_CPU_SUBTYPE_ST40STB1)
 	.long	error			!  50 0x840
 	.long	error			!  51 0x860
@@ -890,25 +890,25 @@
 	.long	error			!  61 0x9a0
 	.long	error			!  62 0x9c0
 	.long	error			!  63 0x9e0
-	.long	SYMBOL_NAME(do_IRQ)	!  64 0xa00 PCI serr
-	.long	SYMBOL_NAME(do_IRQ)	!  65 0xa20     err
-	.long	SYMBOL_NAME(do_IRQ)	!  66 0xa40     ad
-	.long	SYMBOL_NAME(do_IRQ)	!  67 0xa60     pwr_dwn
+	.long	do_IRQ			!  64 0xa00 PCI serr
+	.long	do_IRQ			!  65 0xa20     err
+	.long	do_IRQ			!  66 0xa40     ad
+	.long	do_IRQ			!  67 0xa60     pwr_dwn
 	.long	error			!  68 0xa80
 	.long	error			!  69 0xaa0
 	.long	error			!  70 0xac0
 	.long	error			!  71 0xae0
-	.long	SYMBOL_NAME(do_IRQ)	!  72 0xb00 DMA INT0
-	.long	SYMBOL_NAME(do_IRQ)	!  73 0xb20     INT1
-	.long	SYMBOL_NAME(do_IRQ)	!  74 0xb40     INT2
-	.long	SYMBOL_NAME(do_IRQ)	!  75 0xb60     INT3
-	.long	SYMBOL_NAME(do_IRQ)	!  76 0xb80     INT4
+	.long	do_IRQ			!  72 0xb00 DMA INT0
+	.long	do_IRQ			!  73 0xb20     INT1
+	.long	do_IRQ			!  74 0xb40     INT2
+	.long	do_IRQ			!  75 0xb60     INT3
+	.long	do_IRQ			!  76 0xb80     INT4
 	.long	error			!  77 0xba0
-	.long	SYMBOL_NAME(do_IRQ)	!  78 0xbc0 DMA ERR
+	.long	do_IRQ			!  78 0xbc0 DMA ERR
 	.long	error			!  79 0xbe0
-	.long	SYMBOL_NAME(do_IRQ)	!  80 0xc00 PIO0
-	.long	SYMBOL_NAME(do_IRQ)	!  81 0xc20 PIO1
-	.long	SYMBOL_NAME(do_IRQ)	!  82 0xc40 PIO2
+	.long	do_IRQ			!  80 0xc00 PIO0
+	.long	do_IRQ			!  81 0xc20 PIO1
+	.long	do_IRQ			!  82 0xc40 PIO2
 	.long	error			!  83 0xc60
 	.long	error			!  84 0xc80
 	.long	error			!  85 0xca0
@@ -938,7 +938,7 @@
 	.long	error			! 109 0xfa0
 	.long	error			! 110 0xfc0
 	.long	error			! 111 0xfe0
-	.long	SYMBOL_NAME(do_IRQ)	! 112 0x1000 Mailbox
+	.long	do_IRQ			! 112 0x1000 Mailbox
 	.long	error			! 113 0x1020
 	.long	error			! 114 0x1040
 	.long	error			! 115 0x1060
@@ -966,237 +966,237 @@
 	.long	error			! 137 0x1320
 	.long	error			! 138 0x1340
 	.long	error			! 139 0x1360
-	.long	SYMBOL_NAME(do_IRQ)	! 140 0x1380 EMPI INV_ADDR
+	.long	do_IRQ			! 140 0x1380 EMPI INV_ADDR
 	.long	error			! 141 0x13a0
 	.long	error			! 142 0x13c0
 	.long	error			! 143 0x13e0
 #endif
 
 ENTRY(sys_call_table)
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
-	.long SYMBOL_NAME(sys_lchown16)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old break syscall holder */
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
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old stty syscall holder */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old gtty syscall holder */
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
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old prof syscall holder */
-	.long SYMBOL_NAME(sys_brk)		/* 45 */
-	.long SYMBOL_NAME(sys_setgid16)
-	.long SYMBOL_NAME(sys_getgid16)
-	.long SYMBOL_NAME(sys_signal)
-	.long SYMBOL_NAME(sys_geteuid16)
-	.long SYMBOL_NAME(sys_getegid16)	/* 50 */
-	.long SYMBOL_NAME(sys_acct)
-	.long SYMBOL_NAME(sys_umount)		/* recycled never used phys() */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old lock syscall holder */
-	.long SYMBOL_NAME(sys_ioctl)
-	.long SYMBOL_NAME(sys_fcntl)		/* 55 */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old mpx syscall holder */
-	.long SYMBOL_NAME(sys_setpgid)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old ulimit syscall holder */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* sys_olduname */
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
-	.long SYMBOL_NAME(sys_ni_syscall)	/* sys_oldselect */
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
-	.long SYMBOL_NAME(sys_ni_syscall)	/* old profil syscall holder */
-	.long SYMBOL_NAME(sys_statfs)
-	.long SYMBOL_NAME(sys_fstatfs)		/* 100 */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* ioperm */
-	.long SYMBOL_NAME(sys_socketcall)
-	.long SYMBOL_NAME(sys_syslog)
-	.long SYMBOL_NAME(sys_setitimer)
-	.long SYMBOL_NAME(sys_getitimer)	/* 105 */
-	.long SYMBOL_NAME(sys_newstat)
-	.long SYMBOL_NAME(sys_newlstat)
-	.long SYMBOL_NAME(sys_newfstat)
-	.long SYMBOL_NAME(sys_uname)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* 110 */ /* iopl */
-	.long SYMBOL_NAME(sys_vhangup)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* idle */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* vm86old */
-	.long SYMBOL_NAME(sys_wait4)
-	.long SYMBOL_NAME(sys_swapoff)		/* 115 */
-	.long SYMBOL_NAME(sys_sysinfo)
-	.long SYMBOL_NAME(sys_ipc)
-	.long SYMBOL_NAME(sys_fsync)
-	.long SYMBOL_NAME(sys_sigreturn)
-	.long SYMBOL_NAME(sys_clone)		/* 120 */
-	.long SYMBOL_NAME(sys_setdomainname)
-	.long SYMBOL_NAME(sys_newuname)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* sys_modify_ldt */
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
-	.long SYMBOL_NAME(sys_ni_syscall)	/* vm86 */
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
-	.long SYMBOL_NAME(sys_chown16)
-	.long SYMBOL_NAME(sys_getcwd)
-	.long SYMBOL_NAME(sys_capget)
-	.long SYMBOL_NAME(sys_capset)           /* 185 */
-	.long SYMBOL_NAME(sys_sigaltstack)
-	.long SYMBOL_NAME(sys_sendfile)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* streams1 */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* streams2 */
-	.long SYMBOL_NAME(sys_vfork)            /* 190 */
-	.long SYMBOL_NAME(sys_getrlimit)
-	.long SYMBOL_NAME(sys_mmap2)
-	.long SYMBOL_NAME(sys_truncate64)
-	.long SYMBOL_NAME(sys_ftruncate64)
-	.long SYMBOL_NAME(sys_stat64)		/* 195 */
-	.long SYMBOL_NAME(sys_lstat64)
-	.long SYMBOL_NAME(sys_fstat64)
-	.long SYMBOL_NAME(sys_lchown)
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
-	.long SYMBOL_NAME(sys_chown)
-	.long SYMBOL_NAME(sys_setuid)
-	.long SYMBOL_NAME(sys_setgid)
-	.long SYMBOL_NAME(sys_setfsuid)		/* 215 */
-	.long SYMBOL_NAME(sys_setfsgid)
-	.long SYMBOL_NAME(sys_pivot_root)
-	.long SYMBOL_NAME(sys_mincore)
-	.long SYMBOL_NAME(sys_madvise)
-	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
-	.long SYMBOL_NAME(sys_fcntl64)
-	.long SYMBOL_NAME(sys_gettid)
-	.long SYMBOL_NAME(sys_tkill)
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
+	.long sys_lchown16
+	.long sys_ni_syscall	/* old break syscall holder */
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
+	.long sys_ni_syscall	/* old stty syscall holder */
+	.long sys_ni_syscall	/* old gtty syscall holder */
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
+	.long sys_ni_syscall	/* old prof syscall holder */
+	.long sys_brk		/* 45 */
+	.long sys_setgid16
+	.long sys_getgid16
+	.long sys_signal
+	.long sys_geteuid16
+	.long sys_getegid16	/* 50 */
+	.long sys_acct
+	.long sys_umount	/* recycled never used phys() */
+	.long sys_ni_syscall	/* old lock syscall holder */
+	.long sys_ioctl
+	.long sys_fcntl		/* 55 */
+	.long sys_ni_syscall	/* old mpx syscall holder */
+	.long sys_setpgid
+	.long sys_ni_syscall	/* old ulimit syscall holder */
+	.long sys_ni_syscall	/* sys_olduname */
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
+	.long sys_ni_syscall	/* sys_oldselect */
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
+	.long sys_ni_syscall	/* old profil syscall holder */
+	.long sys_statfs
+	.long sys_fstatfs	/* 100 */
+	.long sys_ni_syscall	/* ioperm */
+	.long sys_socketcall
+	.long sys_syslog
+	.long sys_setitimer
+	.long sys_getitimer	/* 105 */
+	.long sys_newstat
+	.long sys_newlstat
+	.long sys_newfstat
+	.long sys_uname
+	.long sys_ni_syscall	/* 110 */ /* iopl */
+	.long sys_vhangup
+	.long sys_ni_syscall	/* idle */
+	.long sys_ni_syscall	/* vm86old */
+	.long sys_wait4
+	.long sys_swapoff	/* 115 */
+	.long sys_sysinfo
+	.long sys_ipc
+	.long sys_fsync
+	.long sys_sigreturn
+	.long sys_clone		/* 120 */
+	.long sys_setdomainname
+	.long sys_newuname
+	.long sys_ni_syscall	/* sys_modify_ldt */
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
+	.long sys_ni_syscall	/* vm86 */
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
+	.long sys_chown16
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
+	.long sys_lchown
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
+	.long sys_chown
+	.long sys_setuid
+	.long sys_setgid
+	.long sys_setfsuid	/* 215 */
+	.long sys_setfsgid
+	.long sys_pivot_root
+	.long sys_mincore
+	.long sys_madvise
+	.long sys_getdents64	/* 220 */
+	.long sys_fcntl64
+	.long sys_gettid
+	.long sys_tkill
 
 	/*
 	 * NOTE!! This doesn't have to be exact - we just have
@@ -1205,7 +1205,7 @@
 	 * been shrunk every time we add a new system call.
 	 */
 	.rept NR_syscalls-221
-		.long SYMBOL_NAME(sys_ni_syscall)
+		.long sys_ni_syscall
 	.endr
 
 /* End of entry.S */
diff -urN linux-sn2/arch/sh/kernel/head.S linux/arch/sh/kernel/head.S
--- linux-sn2/arch/sh/kernel/head.S	Thu Mar  7 21:18:28 2002
+++ linux/arch/sh/kernel/head.S	Sat Apr 27 23:19:54 2002
@@ -69,8 +69,8 @@
 
 	.balign 4
 1:	.long	0x400080F0		! MD=1, RB=0, BL=0, FD=1, IMASK=0xF
-2:	.long	SYMBOL_NAME(stack)
-3:	.long	SYMBOL_NAME(__bss_start)
-4:	.long	SYMBOL_NAME(_end)
-5:	.long	SYMBOL_NAME(start_kernel)
-6:	.long	SYMBOL_NAME(cache_init)
+2:	.long	stack
+3:	.long	__bss_start
+4:	.long	_end
+5:	.long	start_kernel
+6:	.long	cache_init
diff -urN linux-sn2/arch/sh/lib/memmove.S linux/arch/sh/lib/memmove.S
--- linux-sn2/arch/sh/lib/memmove.S	Thu Mar  7 21:18:06 2002
+++ linux/arch/sh/lib/memmove.S	Sat Apr 27 23:19:54 2002
@@ -20,7 +20,7 @@
 	jmp	@r0
 	 nop
 	.balign 4
-2:	.long	SYMBOL_NAME(memcpy)
+2:	.long	memcpy
 1:
 	sub	r5,r4		! From here, r4 has the distance to r0
 	tst	r6,r6

--------------040906040900050908020205--

