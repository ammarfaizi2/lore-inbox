Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVLPN3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVLPN3A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVLPN3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:29:00 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:49391 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932245AbVLPN26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:28:58 -0500
Date: Fri, 16 Dec 2005 14:28:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 2/3] s390: cleanup Kconfig.
Message-ID: <20051216132858.GC8877@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 2/3] s390: cleanup Kconfig.

Sanitize some s390 Kconfig options. We have ARCH_S390, ARCH_S390X,
ARCH_S390_31, 64BIT, S390_SUPPORT and COMPAT. Replace these 6 options
by S390, 64BIT and COMPAT.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/Kconfig                  |   27 +++++++--------------------
 arch/s390/Makefile                 |    6 ++----
 arch/s390/appldata/appldata_base.c |    8 ++++----
 arch/s390/crypto/crypt_s390.h      |   10 +++++-----
 arch/s390/defconfig                |    4 +---
 arch/s390/kernel/Makefile          |   15 +++++----------
 arch/s390/kernel/cpcmd.c           |   16 ++++++++--------
 arch/s390/kernel/entry64.S         |   18 +++++++++---------
 arch/s390/kernel/head.S            |    4 ++--
 arch/s390/kernel/module.c          |   12 ++++++------
 arch/s390/kernel/process.c         |   12 ++++++------
 arch/s390/kernel/ptrace.c          |   24 ++++++++++++------------
 arch/s390/kernel/reipl_diag.c      |    2 +-
 arch/s390/kernel/setup.c           |   14 +++++++-------
 arch/s390/kernel/signal.c          |    2 +-
 arch/s390/kernel/smp.c             |    8 ++++----
 arch/s390/kernel/sys_s390.c        |   12 +++++-------
 arch/s390/kernel/traps.c           |   10 +++++-----
 arch/s390/kernel/vmlinux.lds.S     |    2 +-
 arch/s390/lib/Makefile             |    5 ++---
 arch/s390/lib/spinlock.c           |    2 +-
 arch/s390/mm/extmem.c              |    2 +-
 arch/s390/mm/fault.c               |   18 +++++++++---------
 arch/s390/mm/init.c                |    8 ++++----
 arch/s390/mm/mmap.c                |    2 +-
 block/Kconfig                      |    2 +-
 crypto/Kconfig                     |    8 ++++----
 drivers/char/Kconfig               |    2 +-
 drivers/char/hangcheck-timer.c     |    2 +-
 drivers/char/watchdog/Kconfig      |    2 +-
 drivers/input/evdev.c              |    2 +-
 drivers/net/phy/Kconfig            |    2 +-
 drivers/s390/block/Kconfig         |    8 ++++----
 drivers/s390/block/dasd.c          |    2 +-
 drivers/s390/block/dasd_diag.c     |    2 +-
 drivers/s390/block/dasd_diag.h     |    6 +++---
 drivers/s390/block/dasd_eckd.c     |    2 +-
 drivers/s390/block/dasd_fba.c      |    2 +-
 drivers/s390/block/xpram.c         |    4 ++--
 drivers/s390/char/vmwatchdog.c     |    2 +-
 drivers/s390/cio/cio.c             |    2 +-
 drivers/s390/cio/device_id.c       |    2 +-
 drivers/s390/cio/ioasm.h           |    4 ++--
 drivers/s390/cio/qdio.c            |    2 +-
 drivers/s390/cio/qdio.h            |   34 +++++++++++++++++-----------------
 drivers/s390/crypto/z90hardware.c  |    8 ++++----
 drivers/s390/net/Kconfig           |    2 +-
 drivers/s390/net/claw.c            |    6 +++---
 drivers/s390/s390mach.c            |   10 +++++-----
 drivers/s390/sysinfo.c             |    2 +-
 drivers/scsi/Kconfig               |    2 +-
 fs/partitions/Kconfig              |    2 +-
 fs/proc/array.c                    |    2 +-
 include/asm-s390/unistd.h          |    2 +-
 include/linux/irq.h                |    2 +-
 init/Kconfig                       |    6 +++---
 init/do_mounts_rd.c                |    4 ++--
 kernel/panic.c                     |    4 ++--
 kernel/sysctl.c                    |    6 +++---
 lib/Kconfig.debug                  |    2 +-
 60 files changed, 185 insertions(+), 210 deletions(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2005-12-16 10:56:42.000000000 +0100
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2005-12-16 10:57:23.000000000 +0100
@@ -40,7 +40,7 @@
 
 #define TOD_MICRO	0x01000			/* nr. of TOD clock units
 						   for 1 microsecond */
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 
 #define APPLDATA_START_INTERVAL_REC 0x00   	/* Function codes for */
 #define APPLDATA_STOP_REC	    0x01	/* DIAG 0xDC	  */
@@ -54,13 +54,13 @@
 #define APPLDATA_GEN_EVENT_RECORD   0x82
 #define APPLDATA_START_CONFIG_REC   0x83
 
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 
 
 /*
  * Parameter list for DIAGNOSE X'DC'
  */
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 struct appldata_parameter_list {
 	u16 diag;		/* The DIAGNOSE code X'00DC'          */
 	u8  function;		/* The function code for the DIAGNOSE */
@@ -82,7 +82,7 @@ struct appldata_parameter_list {
 	u64 product_id_addr;
 	u64 buffer_addr;
 };
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 
 /*
  * /proc entries (sysctl)
diff -urpN linux-2.6/arch/s390/crypto/crypt_s390.h linux-2.6-patched/arch/s390/crypto/crypt_s390.h
--- linux-2.6/arch/s390/crypto/crypt_s390.h	2005-12-16 10:57:13.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/crypt_s390.h	2005-12-16 10:57:23.000000000 +0100
@@ -112,7 +112,7 @@ struct crypt_s390_query_status {
  * [ret] is the variable to receive the error code
  * [ERR] is the error code value
  */
-#ifndef __s390x__
+#ifndef CONFIG_64BIT
 #define __crypt_s390_fixup \
 	".section .fixup,\"ax\" \n"	\
 	"7:	lhi	%0,%h[e1] \n"	\
@@ -129,7 +129,7 @@ struct crypt_s390_query_status {
 	"	.long	0b,7b \n"	\
 	"	.long	1b,8b \n"	\
 	".previous"
-#else /* __s390x__ */
+#else /* CONFIG_64BIT */
 #define __crypt_s390_fixup \
 	".section .fixup,\"ax\" \n"	\
 	"7:	lhi	%0,%h[e1] \n"	\
@@ -142,7 +142,7 @@ struct crypt_s390_query_status {
 	"	.quad	0b,7b \n"	\
 	"	.quad	1b,8b \n"	\
 	".previous"
-#endif /* __s390x__ */
+#endif /* CONFIG_64BIT */
 
 /*
  * Standard code for setting the result of s390 crypto instructions.
@@ -150,10 +150,10 @@ struct crypt_s390_query_status {
  * [result]: the register containing the result (e.g. second operand length
  * to compute number of processed bytes].
  */
-#ifndef __s390x__
+#ifndef CONFIG_64BIT
 #define __crypt_s390_set_result \
 	"	lr	%0,%[result] \n"
-#else /* __s390x__ */
+#else /* CONFIG_64BIT */
 #define __crypt_s390_set_result \
 	"	lgr	%0,%[result] \n"
 #endif
diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2005-12-16 10:57:22.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2005-12-16 10:57:23.000000000 +0100
@@ -6,7 +6,7 @@
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
-CONFIG_ARCH_S390=y
+CONFIG_S390=y
 CONFIG_UID16=y
 
 #
@@ -90,9 +90,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Processor type and features
 #
-# CONFIG_ARCH_S390X is not set
 # CONFIG_64BIT is not set
-CONFIG_ARCH_S390_31=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
 CONFIG_HOTPLUG_CPU=y
diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2005-12-16 10:57:15.000000000 +0100
+++ linux-2.6-patched/arch/s390/Kconfig	2005-12-16 10:57:23.000000000 +0100
@@ -23,14 +23,14 @@ config GENERIC_BUST_SPINLOCK
 
 mainmenu "Linux Kernel Configuration"
 
-config ARCH_S390
+config S390
 	bool
 	default y
 
 config UID16
 	bool
 	default y
-	depends on ARCH_S390X = 'n'
+	depends on !64BIT
 
 source "init/Kconfig"
 
@@ -38,20 +38,12 @@ menu "Base setup"
 
 comment "Processor type and features"
 
-config ARCH_S390X
+config 64BIT
 	bool "64 bit kernel"
 	help
 	  Select this option if you have a 64 bit IBM zSeries machine
 	  and want to use the 64 bit addressing mode.
 
-config 64BIT
-	def_bool ARCH_S390X
-
-config ARCH_S390_31
-	bool
-	depends on ARCH_S390X = 'n'
-	default y
-
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
@@ -101,20 +93,15 @@ config MATHEMU
 	  on older S/390 machines. Say Y unless you know your machine doesn't
 	  need this.
 
-config S390_SUPPORT
+config COMPAT
 	bool "Kernel support for 31 bit emulation"
-	depends on ARCH_S390X
+	depends on 64BIT
 	help
 	  Select this option if you want to enable your system kernel to
 	  handle system-calls from ELF binaries for 31 bit ESA.  This option
 	  (and some other stuff like libraries and such) is needed for
 	  executing 31 bit applications.  It is safe to say "Y".
 
-config COMPAT
-	bool
-	depends on S390_SUPPORT
-	default y
-
 config SYSVIPC_COMPAT
 	bool
 	depends on COMPAT && SYSVIPC
@@ -122,7 +109,7 @@ config SYSVIPC_COMPAT
 
 config BINFMT_ELF32
 	tristate "Kernel support for 31 bit ELF binaries"
-	depends on S390_SUPPORT
+	depends on COMPAT
 	help
 	  This allows you to run 32-bit Linux/ELF binaries on your zSeries
 	  in 64 bit mode. Everybody wants this; say Y.
@@ -135,7 +122,7 @@ choice
 
 config MARCH_G5
 	bool "S/390 model G5 and G6"
-	depends on ARCH_S390_31
+	depends on !64BIT
 	help
 	  Select this to build a 31 bit kernel that works
 	  on all S/390 and zSeries machines.
diff -urpN linux-2.6/arch/s390/kernel/cpcmd.c linux-2.6-patched/arch/s390/kernel/cpcmd.c
--- linux-2.6/arch/s390/kernel/cpcmd.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/cpcmd.c	2005-12-16 10:57:23.000000000 +0100
@@ -39,7 +39,7 @@ int  __cpcmd(const char *cmd, char *resp
 
 	if (response != NULL && rlen > 0) {
 		memset(response, 0, rlen);
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 		asm volatile (	"lra	2,0(%2)\n"
 				"lr	4,%3\n"
 				"o	4,%6\n"
@@ -55,7 +55,7 @@ int  __cpcmd(const char *cmd, char *resp
 				: "a" (cpcmd_buf), "d" (cmdlen),
 				"a" (response), "d" (rlen), "m" (mask)
 				: "cc", "2", "3", "4", "5" );
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
                 asm volatile (	"lrag	2,0(%2)\n"
 				"lgr	4,%3\n"
 				"o	4,%6\n"
@@ -73,11 +73,11 @@ int  __cpcmd(const char *cmd, char *resp
 				: "a" (cpcmd_buf), "d" (cmdlen),
 				"a" (response), "d" (rlen), "m" (mask)
 				: "cc", "2", "3", "4", "5" );
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
                 EBCASC(response, rlen);
         } else {
 		return_len = 0;
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
                 asm volatile (	"lra	2,0(%1)\n"
 				"lr	3,%2\n"
 				"diag	2,3,0x8\n"
@@ -85,7 +85,7 @@ int  __cpcmd(const char *cmd, char *resp
 				: "=d" (return_code)
 				: "a" (cpcmd_buf), "d" (cmdlen)
 				: "2", "3"  );
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
                 asm volatile (	"lrag	2,0(%1)\n"
 				"lgr	3,%2\n"
 				"sam31\n"
@@ -95,7 +95,7 @@ int  __cpcmd(const char *cmd, char *resp
 				: "=d" (return_code)
 				: "a" (cpcmd_buf), "d" (cmdlen)
 				: "2", "3" );
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
         }
 	spin_unlock_irqrestore(&cpcmd_lock, flags);
 	if (response_code != NULL)
@@ -105,7 +105,7 @@ int  __cpcmd(const char *cmd, char *resp
 
 EXPORT_SYMBOL(__cpcmd);
 
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 int cpcmd(const char *cmd, char *response, int rlen, int *response_code)
 {
 	char *lowbuf;
@@ -129,4 +129,4 @@ int cpcmd(const char *cmd, char *respons
 }
 
 EXPORT_SYMBOL(cpcmd);
-#endif		/* CONFIG_ARCH_S390X */
+#endif		/* CONFIG_64BIT */
diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2005-12-16 10:56:42.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2005-12-16 10:57:23.000000000 +0100
@@ -213,7 +213,7 @@ sysc_nr_ok:
 	mvc	SP_ARGS(8,%r15),SP_R7(%r15)
 sysc_do_restart:
 	larl    %r10,sys_call_table
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 	tm	__TI_flags+5(%r9),(_TIF_31BIT>>16)  # running in 31 bit mode ?
 	jno	sysc_noemu
 	larl    %r10,sys_call_table_emu  # use 31 bit emulation system calls
@@ -361,7 +361,7 @@ sys_clone_glue: 
         la      %r2,SP_PTREGS(%r15)    # load pt_regs
         jg      sys_clone              # branch to sys_clone
 
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 sys32_clone_glue: 
         la      %r2,SP_PTREGS(%r15)    # load pt_regs
         jg      sys32_clone            # branch to sys32_clone
@@ -383,7 +383,7 @@ sys_execve_glue:        
         bnz     0(%r12)               # it did fail -> store result in gpr2
         b       6(%r12)               # SKIP STG 2,SP_R2(15) in
                                       # system_call/sysc_tracesys
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 sys32_execve_glue:        
         la      %r2,SP_PTREGS(%r15)   # load pt_regs
 	lgr     %r12,%r14             # save return address
@@ -398,7 +398,7 @@ sys_sigreturn_glue:     
         la      %r2,SP_PTREGS(%r15)   # load pt_regs as parameter
         jg      sys_sigreturn         # branch to sys_sigreturn
 
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 sys32_sigreturn_glue:     
         la      %r2,SP_PTREGS(%r15)   # load pt_regs as parameter
         jg      sys32_sigreturn       # branch to sys32_sigreturn
@@ -408,7 +408,7 @@ sys_rt_sigreturn_glue:     
         la      %r2,SP_PTREGS(%r15)   # load pt_regs as parameter
         jg      sys_rt_sigreturn      # branch to sys_sigreturn
 
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 sys32_rt_sigreturn_glue:     
         la      %r2,SP_PTREGS(%r15)   # load pt_regs as parameter
         jg      sys32_rt_sigreturn    # branch to sys32_sigreturn
@@ -429,7 +429,7 @@ sys_sigsuspend_glue:    
 	la      %r14,6(%r14)          # skip store of return value
         jg      sys_sigsuspend        # branch to sys_sigsuspend
 
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 sys32_sigsuspend_glue:    
 	llgfr	%r4,%r4               # unsigned long			
         lgr     %r5,%r4               # move mask back
@@ -449,7 +449,7 @@ sys_rt_sigsuspend_glue: 
 	la      %r14,6(%r14)          # skip store of return value
         jg      sys_rt_sigsuspend     # branch to sys_rt_sigsuspend
 
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 sys32_rt_sigsuspend_glue: 
 	llgfr	%r3,%r3               # size_t			
         lgr     %r4,%r3               # move sigsetsize parameter
@@ -464,7 +464,7 @@ sys_sigaltstack_glue:
         la      %r4,SP_PTREGS(%r15)   # load pt_regs as parameter
         jg      sys_sigaltstack       # branch to sys_sigreturn
 
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 sys32_sigaltstack_glue:
         la      %r4,SP_PTREGS(%r15)   # load pt_regs as parameter
         jg      sys32_sigaltstack_wrapper # branch to sys_sigreturn
@@ -1009,7 +1009,7 @@ sys_call_table:
 #include "syscalls.S"
 #undef SYSCALL
 
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 
 #define SYSCALL(esa,esame,emu)	.long emu
 	.globl  sys_call_table_emu
diff -urpN linux-2.6/arch/s390/kernel/head.S linux-2.6-patched/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	2005-12-16 10:56:42.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head.S	2005-12-16 10:57:23.000000000 +0100
@@ -30,7 +30,7 @@
 #include <asm/thread_info.h>
 #include <asm/page.h>
 
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 #define ARCH_OFFSET	4
 #else
 #define ARCH_OFFSET	0
@@ -539,7 +539,7 @@ ipl_devno:
 	.word 0
 .endm
 
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 #include "head64.S"
 #else
 #include "head31.S"
diff -urpN linux-2.6/arch/s390/kernel/Makefile linux-2.6-patched/arch/s390/kernel/Makefile
--- linux-2.6/arch/s390/kernel/Makefile	2005-12-16 10:56:42.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/Makefile	2005-12-16 10:57:23.000000000 +0100
@@ -8,31 +8,26 @@ obj-y	:=  bitmap.o traps.o time.o proces
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
             semaphore.o s390_ext.o debug.o profile.o irq.o reipl_diag.o
 
+obj-y	+= $(if $(CONFIG_64BIT),entry64.o,entry.o)
+obj-y	+= $(if $(CONFIG_64BIT),reipl64.o,reipl.o)
+
 extra-y				+= head.o init_task.o vmlinux.lds
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o
 
-obj-$(CONFIG_S390_SUPPORT)	+= compat_linux.o compat_signal.o \
+obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o \
 					compat_ioctl.o compat_wrapper.o \
 					compat_exec_domain.o
 obj-$(CONFIG_BINFMT_ELF32)	+= binfmt_elf32.o
 
-obj-$(CONFIG_ARCH_S390_31)	+= entry.o reipl.o
-obj-$(CONFIG_ARCH_S390X)	+= entry64.o reipl64.o
-
 obj-$(CONFIG_VIRT_TIMER)	+= vtime.o
 
 # Kexec part
 S390_KEXEC_OBJS := machine_kexec.o crash.o
-ifeq ($(CONFIG_ARCH_S390X),y)
-S390_KEXEC_OBJS += relocate_kernel64.o
-else
-S390_KEXEC_OBJS += relocate_kernel.o
-endif
+S390_KEXEC_OBJS += $(if $(CONFIG_64BIT),relocate_kernel64.o,relocate_kernel.o)
 obj-$(CONFIG_KEXEC) += $(S390_KEXEC_OBJS)
 
-
 #
 # This is just to get the dependencies...
 #
diff -urpN linux-2.6/arch/s390/kernel/module.c linux-2.6-patched/arch/s390/kernel/module.c
--- linux-2.6/arch/s390/kernel/module.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/module.c	2005-12-16 10:57:23.000000000 +0100
@@ -37,11 +37,11 @@
 #define DEBUGP(fmt , ...)
 #endif
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 #define PLT_ENTRY_SIZE 12
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 #define PLT_ENTRY_SIZE 20
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 
 void *module_alloc(unsigned long size)
 {
@@ -294,17 +294,17 @@ apply_rela(Elf_Rela *rela, Elf_Addr base
 			unsigned int *ip;
 			ip = me->module_core + me->arch.plt_offset +
 				info->plt_offset;
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 			ip[0] = 0x0d105810; /* basr 1,0; l 1,6(1); br 1 */
 			ip[1] = 0x100607f1;
 			ip[2] = val;
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 			ip[0] = 0x0d10e310; /* basr 1,0; lg 1,10(1); br 1 */
 			ip[1] = 0x100a0004;
 			ip[2] = 0x07f10000;
 			ip[3] = (unsigned int) (val >> 32);
 			ip[4] = (unsigned int) val;
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 			info->plt_initialized = 1;
 		}
 		if (r_type == R_390_PLTOFF16 ||
diff -urpN linux-2.6/arch/s390/kernel/process.c linux-2.6-patched/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	2005-12-16 10:56:42.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/process.c	2005-12-16 10:57:23.000000000 +0100
@@ -235,7 +235,7 @@ int copy_thread(int nr, unsigned long cl
 	/* Save access registers to new thread structure. */
 	save_access_regs(&p->thread.acrs[0]);
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
         /*
 	 * save fprs to current->thread.fp_regs to merge them with
 	 * the emulated registers and then copy the result to the child.
@@ -247,7 +247,7 @@ int copy_thread(int nr, unsigned long cl
 	/* Set a new TLS ?  */
 	if (clone_flags & CLONE_SETTLS)
 		p->thread.acrs[0] = regs->gprs[6];
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 	/* Save the fpu registers to new thread structure. */
 	save_fp_regs(&p->thread.fp_regs);
         p->thread.user_seg = __pa((unsigned long) p->mm->pgd) | _REGION_TABLE;
@@ -260,7 +260,7 @@ int copy_thread(int nr, unsigned long cl
 			p->thread.acrs[1] = (unsigned int) regs->gprs[6];
 		}
 	}
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 	/* start new process with ar4 pointing to the correct address space */
 	p->thread.mm_segment = get_fs();
         /* Don't copy debug registers */
@@ -339,16 +339,16 @@ out:
  */
 int dump_fpu (struct pt_regs * regs, s390_fp_regs *fpregs)
 {
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
         /*
 	 * save fprs to current->thread.fp_regs to merge them with
 	 * the emulated registers and then copy the result to the dump.
 	 */
 	save_fp_regs(&current->thread.fp_regs);
 	memcpy(fpregs, &current->thread.fp_regs, sizeof(s390_fp_regs));
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 	save_fp_regs(fpregs);
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 	return 1;
 }
 
diff -urpN linux-2.6/arch/s390/kernel/ptrace.c linux-2.6-patched/arch/s390/kernel/ptrace.c
--- linux-2.6/arch/s390/kernel/ptrace.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/ptrace.c	2005-12-16 10:57:23.000000000 +0100
@@ -42,7 +42,7 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 #include "compat_ptrace.h"
 #endif
 
@@ -59,7 +59,7 @@ FixPerRegisters(struct task_struct *task
 	
 	if (per_info->single_step) {
 		per_info->control_regs.bits.starting_addr = 0;
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 		if (test_thread_flag(TIF_31BIT))
 			per_info->control_regs.bits.ending_addr = 0x7fffffffUL;
 		else
@@ -112,7 +112,7 @@ ptrace_disable(struct task_struct *child
 	clear_single_step(child);
 }
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 # define __ADDR_MASK 3
 #else
 # define __ADDR_MASK 7
@@ -138,7 +138,7 @@ peek_user(struct task_struct *child, add
 	 * an alignment of 4. Programmers from hell...
 	 */
 	mask = __ADDR_MASK;
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 	if (addr >= (addr_t) &dummy->regs.acrs &&
 	    addr < (addr_t) &dummy->regs.orig_gpr2)
 		mask = 3;
@@ -160,7 +160,7 @@ peek_user(struct task_struct *child, add
 		 * access registers are stored in the thread structure
 		 */
 		offset = addr - (addr_t) &dummy->regs.acrs;
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 		/*
 		 * Very special case: old & broken 64 bit gdb reading
 		 * from acrs[15]. Result is a 64 bit value. Read the
@@ -218,7 +218,7 @@ poke_user(struct task_struct *child, add
 	 * an alignment of 4. Programmers from hell indeed...
 	 */
 	mask = __ADDR_MASK;
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 	if (addr >= (addr_t) &dummy->regs.acrs &&
 	    addr < (addr_t) &dummy->regs.orig_gpr2)
 		mask = 3;
@@ -231,13 +231,13 @@ poke_user(struct task_struct *child, add
 		 * psw and gprs are stored on the stack
 		 */
 		if (addr == (addr_t) &dummy->regs.psw.mask &&
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 		    data != PSW_MASK_MERGE(PSW_USER32_BITS, data) &&
 #endif
 		    data != PSW_MASK_MERGE(PSW_USER_BITS, data))
 			/* Invalid psw mask. */
 			return -EINVAL;
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 		if (addr == (addr_t) &dummy->regs.psw.addr)
 			/* I'd like to reject addresses without the
 			   high order bit but older gdb's rely on it */
@@ -250,7 +250,7 @@ poke_user(struct task_struct *child, add
 		 * access registers are stored in the thread structure
 		 */
 		offset = addr - (addr_t) &dummy->regs.acrs;
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 		/*
 		 * Very special case: old & broken 64 bit gdb writing
 		 * to acrs[15] with a 64 bit value. Ignore the lower
@@ -357,7 +357,7 @@ do_ptrace_normal(struct task_struct *chi
 	return ptrace_request(child, request, addr, data);
 }
 
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 /*
  * Now the fun part starts... a 31 bit program running in the
  * 31 bit emulation tracing another program. PTRACE_PEEKTEXT,
@@ -629,7 +629,7 @@ do_ptrace(struct task_struct *child, lon
 			return peek_user(child, addr, data);
 		if (request == PTRACE_POKEUSR && addr == PT_IEEE_IP)
 			return poke_user(child, addr, data);
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 		if (request == PTRACE_PEEKUSR &&
 		    addr == PT32_IEEE_IP && test_thread_flag(TIF_31BIT))
 			return peek_user_emu31(child, addr, data);
@@ -695,7 +695,7 @@ do_ptrace(struct task_struct *child, lon
 
 	/* Do requests that differ for 31/64 bit */
 	default:
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 		if (test_thread_flag(TIF_31BIT))
 			return do_ptrace_emu31(child, request, addr, data);
 #endif
diff -urpN linux-2.6/arch/s390/kernel/reipl_diag.c linux-2.6-patched/arch/s390/kernel/reipl_diag.c
--- linux-2.6/arch/s390/kernel/reipl_diag.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/reipl_diag.c	2005-12-16 10:57:23.000000000 +0100
@@ -26,7 +26,7 @@ void reipl_diag(void)
 		"   st   %%r4,%0\n"
 		"   st   %%r5,%1\n"
                 ".section __ex_table,\"a\"\n"
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
                 "   .align 8\n"
                 "   .quad 0b, 0b\n"
 #else
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2005-12-16 10:56:42.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2005-12-16 10:57:23.000000000 +0100
@@ -427,7 +427,7 @@ setup_lowcore(void)
 		__alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0) + PAGE_SIZE;
 	lc->current_task = (unsigned long) init_thread_union.thread_info.task;
 	lc->thread_info = (unsigned long) &init_thread_union;
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 	if (MACHINE_HAS_IEEE) {
 		lc->extended_save_area_addr = (__u32)
 			__alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0);
@@ -562,21 +562,21 @@ setup_arch(char **cmdline_p)
         /*
          * print what head.S has found out about the machine
          */
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 	printk((MACHINE_IS_VM) ?
 	       "We are running under VM (31 bit mode)\n" :
 	       "We are running native (31 bit mode)\n");
 	printk((MACHINE_HAS_IEEE) ?
 	       "This machine has an IEEE fpu\n" :
 	       "This machine has no IEEE fpu\n");
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 	printk((MACHINE_IS_VM) ?
 	       "We are running under VM (64 bit mode)\n" :
 	       "We are running native (64 bit mode)\n");
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 
         ROOT_DEV = Root_RAM0;
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 	memory_end = memory_size & ~0x400000UL;  /* align memory end to 4MB */
         /*
          * We need some free virtual space to be able to do vmalloc.
@@ -585,9 +585,9 @@ setup_arch(char **cmdline_p)
          */
         if (memory_end > 1920*1024*1024)
                 memory_end = 1920*1024*1024;
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 	memory_end = memory_size & ~0x200000UL;  /* detected in head.s */
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 
 	init_mm.start_code = PAGE_OFFSET;
 	init_mm.end_code = (unsigned long) &_etext;
diff -urpN linux-2.6/arch/s390/kernel/signal.c linux-2.6-patched/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	2005-12-16 10:57:03.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/signal.c	2005-12-16 10:57:23.000000000 +0100
@@ -501,7 +501,7 @@ int do_signal(struct pt_regs *regs, sigs
 
 	if (signr > 0) {
 		/* Whee!  Actually deliver the signal.  */
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 		if (test_thread_flag(TIF_31BIT)) {
 			extern void handle_signal32(unsigned long sig,
 						    struct k_sigaction *ka,
diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2005-12-16 10:57:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2005-12-16 10:57:23.000000000 +0100
@@ -402,7 +402,7 @@ static void smp_ext_bitcall_others(ec_bi
         }
 }
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 /*
  * this function sends a 'purge tlb' signal to another CPU.
  */
@@ -416,7 +416,7 @@ void smp_ptlb_all(void)
         on_each_cpu(smp_ptlb_callback, NULL, 0, 1);
 }
 EXPORT_SYMBOL(smp_ptlb_all);
-#endif /* ! CONFIG_ARCH_S390X */
+#endif /* ! CONFIG_64BIT */
 
 /*
  * this function sends a 'reschedule' IPI to another CPU.
@@ -783,7 +783,7 @@ void __init smp_prepare_cpus(unsigned in
 		if (stack == 0ULL)
 			panic("smp_boot_cpus failed to allocate memory\n");
 		lowcore_ptr[i]->panic_stack = stack + (PAGE_SIZE);
-#ifndef __s390x__
+#ifndef CONFIG_64BIT
 		if (MACHINE_HAS_IEEE) {
 			lowcore_ptr[i]->extended_save_area_addr =
 				(__u32) __get_free_pages(GFP_KERNEL,0);
@@ -793,7 +793,7 @@ void __init smp_prepare_cpus(unsigned in
 		}
 #endif
 	}
-#ifndef __s390x__
+#ifndef CONFIG_64BIT
 	if (MACHINE_HAS_IEEE)
 		ctl_set_bit(14, 29); /* enable extended save area */
 #endif
diff -urpN linux-2.6/arch/s390/kernel/sys_s390.c linux-2.6-patched/arch/s390/kernel/sys_s390.c
--- linux-2.6/arch/s390/kernel/sys_s390.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/sys_s390.c	2005-12-16 10:57:23.000000000 +0100
@@ -26,9 +26,7 @@
 #include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/utsname.h>
-#ifdef CONFIG_ARCH_S390X
 #include <linux/personality.h>
-#endif /* CONFIG_ARCH_S390X */
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
@@ -121,7 +119,7 @@ out:
 	return error;
 }
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 struct sel_arg_struct {
 	unsigned long n;
 	fd_set *inp, *outp, *exp;
@@ -138,7 +136,7 @@ asmlinkage long old_select(struct sel_ar
 	return sys_select(a.n, a.inp, a.outp, a.exp, a.tvp);
 
 }
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 
 /*
  * sys_ipc() is the de-multiplexer for the SysV IPC calls..
@@ -211,7 +209,7 @@ asmlinkage long sys_ipc(uint call, int f
 	return -EINVAL;
 }
 
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 asmlinkage long s390x_newuname(struct new_utsname __user *name)
 {
 	int ret = sys_newuname(name);
@@ -235,12 +233,12 @@ asmlinkage long s390x_personality(unsign
 
 	return ret;
 }
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 
 /*
  * Wrapper function for sys_fadvise64/fadvise64_64
  */
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 
 asmlinkage long
 s390_fadvise64(int fd, u32 offset_high, u32 offset_low, size_t len, int advice)
diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2005-12-16 10:56:42.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2005-12-16 10:57:23.000000000 +0100
@@ -67,13 +67,13 @@ extern pgm_check_handler_t do_monitor_ca
 
 #define stack_pointer ({ void **sp; asm("la %0,0(15)" : "=&d" (sp)); sp; })
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 #define FOURLONG "%08lx %08lx %08lx %08lx\n"
 static int kstack_depth_to_print = 12;
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 #define FOURLONG "%016lx %016lx %016lx %016lx\n"
 static int kstack_depth_to_print = 20;
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 
 /*
  * For show_trace we have tree different stack to consider:
@@ -702,12 +702,12 @@ void __init trap_init(void)
         pgm_check_table[0x11] = &do_dat_exception;
         pgm_check_table[0x12] = &translation_exception;
         pgm_check_table[0x13] = &special_op_exception;
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
         pgm_check_table[0x38] = &do_dat_exception;
 	pgm_check_table[0x39] = &do_dat_exception;
 	pgm_check_table[0x3A] = &do_dat_exception;
         pgm_check_table[0x3B] = &do_dat_exception;
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
         pgm_check_table[0x15] = &operand_exception;
         pgm_check_table[0x1C] = &space_switch_exception;
         pgm_check_table[0x1D] = &hfp_sqrt_exception;
diff -urpN linux-2.6/arch/s390/kernel/vmlinux.lds.S linux-2.6-patched/arch/s390/kernel/vmlinux.lds.S
--- linux-2.6/arch/s390/kernel/vmlinux.lds.S	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/vmlinux.lds.S	2005-12-16 10:57:23.000000000 +0100
@@ -5,7 +5,7 @@
 #include <asm-generic/vmlinux.lds.h>
 #include <linux/config.h>
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
 OUTPUT_ARCH(s390)
 ENTRY(_start)
diff -urpN linux-2.6/arch/s390/lib/Makefile linux-2.6-patched/arch/s390/lib/Makefile
--- linux-2.6/arch/s390/lib/Makefile	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/Makefile	2005-12-16 10:57:23.000000000 +0100
@@ -4,6 +4,5 @@
 
 EXTRA_AFLAGS := -traditional
 
-lib-y += delay.o string.o
-lib-$(CONFIG_ARCH_S390_31) += uaccess.o spinlock.o
-lib-$(CONFIG_ARCH_S390X) += uaccess64.o spinlock.o
+lib-y += delay.o string.o spinlock.o
+lib-y += $(if $(CONFIG_64BIT),uaccess64.o,uaccess.o)
diff -urpN linux-2.6/arch/s390/lib/spinlock.c linux-2.6-patched/arch/s390/lib/spinlock.c
--- linux-2.6/arch/s390/lib/spinlock.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/spinlock.c	2005-12-16 10:57:23.000000000 +0100
@@ -29,7 +29,7 @@ __setup("spin_retry=", spin_retry_setup)
 static inline void
 _diag44(void)
 {
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
 	if (MACHINE_HAS_DIAG44)
 #endif
 		asm volatile("diag 0,0,0x44");
diff -urpN linux-2.6/arch/s390/Makefile linux-2.6-patched/arch/s390/Makefile
--- linux-2.6/arch/s390/Makefile	2005-12-16 10:56:42.000000000 +0100
+++ linux-2.6-patched/arch/s390/Makefile	2005-12-16 10:57:23.000000000 +0100
@@ -13,16 +13,14 @@
 # Copyright (C) 1994 by Linus Torvalds
 #
 
-ifdef CONFIG_ARCH_S390_31
+ifndef CONFIG_64BIT
 LDFLAGS		:= -m elf_s390
 CFLAGS		+= -m31
 AFLAGS		+= -m31
 UTS_MACHINE	:= s390
 STACK_SIZE	:= 8192
 CHECKFLAGS	+= -D__s390__
-endif
-
-ifdef CONFIG_ARCH_S390X
+else
 LDFLAGS		:= -m elf64_s390
 MODFLAGS	+= -fpic -D__PIC__
 CFLAGS		+= -m64
diff -urpN linux-2.6/arch/s390/mm/extmem.c linux-2.6-patched/arch/s390/mm/extmem.c
--- linux-2.6/arch/s390/mm/extmem.c	2005-12-16 10:56:42.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/extmem.c	2005-12-16 10:57:23.000000000 +0100
@@ -143,7 +143,7 @@ dcss_diag (__u8 func, void *parameter,
 	rx = (unsigned long) parameter;
 	ry = (unsigned long) func;
 	__asm__ __volatile__(
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 		"   sam31\n" // switch to 31 bit
 		"   diag    %0,%1,0x64\n"
 		"   sam64\n" // switch back to 64 bit
diff -urpN linux-2.6/arch/s390/mm/fault.c linux-2.6-patched/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	2005-12-16 10:56:42.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/fault.c	2005-12-16 10:57:23.000000000 +0100
@@ -31,17 +31,17 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 #define __FAIL_ADDR_MASK 0x7ffff000
 #define __FIXUP_MASK 0x7fffffff
 #define __SUBCODE_MASK 0x0200
 #define __PF_RES_FIELD 0ULL
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 #define __FAIL_ADDR_MASK -4096L
 #define __FIXUP_MASK ~0L
 #define __SUBCODE_MASK 0x0600
 #define __PF_RES_FIELD 0x8000000000000000ULL
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 
 #ifdef CONFIG_SYSCTL
 extern int sysctl_userprocess_debug;
@@ -393,11 +393,11 @@ int pfault_init(void)
 		"2:\n"
 		".section __ex_table,\"a\"\n"
 		"   .align 4\n"
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 		"   .long  0b,1b\n"
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 		"   .quad  0b,1b\n"
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 		".previous"
                 : "=d" (rc) : "a" (&refbk), "m" (refbk) : "cc" );
         __ctl_set_bit(0, 9);
@@ -417,11 +417,11 @@ void pfault_fini(void)
 		"0:\n"
 		".section __ex_table,\"a\"\n"
 		"   .align 4\n"
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 		"   .long  0b,0b\n"
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 		"   .quad  0b,0b\n"
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 		".previous"
 		: : "a" (&refbk), "m" (refbk) : "cc" );
 }
diff -urpN linux-2.6/arch/s390/mm/init.c linux-2.6-patched/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/init.c	2005-12-16 10:57:23.000000000 +0100
@@ -44,7 +44,7 @@ void diag10(unsigned long addr)
 {
         if (addr >= 0x7ff00000)
                 return;
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
         asm volatile (
 		"   sam31\n"
 		"   diag %0,%0,0x10\n"
@@ -106,7 +106,7 @@ extern unsigned long __initdata zholes_s
  * paging_init() sets up the page tables
  */
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 void __init paging_init(void)
 {
         pgd_t * pg_dir;
@@ -175,7 +175,7 @@ void __init paging_init(void)
         return;
 }
 
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 void __init paging_init(void)
 {
         pgd_t * pg_dir;
@@ -256,7 +256,7 @@ void __init paging_init(void)
 
         return;
 }
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 
 void __init mem_init(void)
 {
diff -urpN linux-2.6/arch/s390/mm/mmap.c linux-2.6-patched/arch/s390/mm/mmap.c
--- linux-2.6/arch/s390/mm/mmap.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/mmap.c	2005-12-16 10:57:23.000000000 +0100
@@ -50,7 +50,7 @@ static inline unsigned long mmap_base(vo
 
 static inline int mmap_is_legacy(void)
 {
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 	/*
 	 * Force standard allocation for 64 bit programs.
 	 */
diff -urpN linux-2.6/block/Kconfig linux-2.6-patched/block/Kconfig
--- linux-2.6/block/Kconfig	2005-12-16 10:56:42.000000000 +0100
+++ linux-2.6-patched/block/Kconfig	2005-12-16 10:57:23.000000000 +0100
@@ -5,7 +5,7 @@
 #for instance.
 config LBD
 	bool "Support for Large Block Devices"
-	depends on X86 || (MIPS && 32BIT) || PPC32 || ARCH_S390_31 || SUPERH || UML
+	depends on X86 || (MIPS && 32BIT) || PPC32 || (S390 && !64BIT) || SUPERH || UML
 	help
 	  Say Y here if you want to attach large (bigger than 2TB) discs to
 	  your machine, or if you want to have a raid or loopback device
diff -urpN linux-2.6/crypto/Kconfig linux-2.6-patched/crypto/Kconfig
--- linux-2.6/crypto/Kconfig	2005-12-16 10:57:13.000000000 +0100
+++ linux-2.6-patched/crypto/Kconfig	2005-12-16 10:57:23.000000000 +0100
@@ -42,7 +42,7 @@ config CRYPTO_SHA1
 
 config CRYPTO_SHA1_S390
 	tristate "SHA1 digest algorithm (s390)"
-	depends on CRYPTO && ARCH_S390
+	depends on CRYPTO && S390
 	help
 	  This is the s390 hardware accelerated implementation of the
 	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
@@ -58,7 +58,7 @@ config CRYPTO_SHA256
 
 config CRYPTO_SHA256_S390
 	tristate "SHA256 digest algorithm (s390)"
-	depends on CRYPTO && ARCH_S390
+	depends on CRYPTO && S390
 	help
 	  This is the s390 hardware accelerated implementation of the
 	  SHA256 secure hash standard (DFIPS 180-2).
@@ -111,7 +111,7 @@ config CRYPTO_DES
 
 config CRYPTO_DES_S390
 	tristate "DES and Triple DES cipher algorithms (s390)"
-	depends on CRYPTO && ARCH_S390
+	depends on CRYPTO && S390
 	help
 	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
 
@@ -217,7 +217,7 @@ config CRYPTO_AES_X86_64
 
 config CRYPTO_AES_S390
 	tristate "AES cipher algorithms (s390)"
-	depends on CRYPTO && ARCH_S390
+	depends on CRYPTO && S390
 	help
 	  This is the s390 hardware accelerated implementation of the
 	  AES cipher algorithms (FIPS-197). AES uses the Rijndael
diff -urpN linux-2.6/drivers/char/hangcheck-timer.c linux-2.6-patched/drivers/char/hangcheck-timer.c
--- linux-2.6/drivers/char/hangcheck-timer.c	2005-12-16 10:56:43.000000000 +0100
+++ linux-2.6-patched/drivers/char/hangcheck-timer.c	2005-12-16 10:57:23.000000000 +0100
@@ -120,7 +120,7 @@ __setup("hcheck_dump_tasks", hangcheck_p
 #if defined(CONFIG_X86)
 # define HAVE_MONOTONIC
 # define TIMER_FREQ 1000000000ULL
-#elif defined(CONFIG_ARCH_S390)
+#elif defined(CONFIG_S390)
 /* FA240000 is 1 Second in the IBM time universe (Page 4-38 Principles of Op for zSeries */
 # define TIMER_FREQ 0xFA240000ULL
 #elif defined(CONFIG_IA64)
diff -urpN linux-2.6/drivers/char/Kconfig linux-2.6-patched/drivers/char/Kconfig
--- linux-2.6/drivers/char/Kconfig	2005-12-16 10:56:43.000000000 +0100
+++ linux-2.6-patched/drivers/char/Kconfig	2005-12-16 10:57:23.000000000 +0100
@@ -985,7 +985,7 @@ config HPET_MMAP
 
 config HANGCHECK_TIMER
 	tristate "Hangcheck timer"
-	depends on X86 || IA64 || PPC64 || ARCH_S390
+	depends on X86 || IA64 || PPC64 || S390
 	help
 	  The hangcheck-timer module detects when the system has gone
 	  out to lunch past a certain margin.  It can reboot the system
diff -urpN linux-2.6/drivers/char/watchdog/Kconfig linux-2.6-patched/drivers/char/watchdog/Kconfig
--- linux-2.6/drivers/char/watchdog/Kconfig	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/char/watchdog/Kconfig	2005-12-16 10:57:23.000000000 +0100
@@ -438,7 +438,7 @@ config INDYDOG
 
 config ZVM_WATCHDOG
 	tristate "z/VM Watchdog Timer"
-	depends on WATCHDOG && ARCH_S390
+	depends on WATCHDOG && S390
 	help
 	  IBM s/390 and zSeries machines running under z/VM 5.1 or later
 	  provide a virtual watchdog timer to their guest that cause a
diff -urpN linux-2.6/drivers/input/evdev.c linux-2.6-patched/drivers/input/evdev.c
--- linux-2.6/drivers/input/evdev.c	2005-12-16 10:56:43.000000000 +0100
+++ linux-2.6-patched/drivers/input/evdev.c	2005-12-16 10:57:23.000000000 +0100
@@ -157,7 +157,7 @@ struct input_event_compat {
 #  define COMPAT_TEST test_thread_flag(TIF_IA32)
 #elif defined(CONFIG_IA64)
 #  define COMPAT_TEST IS_IA32_PROCESS(ia64_task_regs(current))
-#elif defined(CONFIG_ARCH_S390)
+#elif defined(CONFIG_S390)
 #  define COMPAT_TEST test_thread_flag(TIF_31BIT)
 #elif defined(CONFIG_MIPS)
 #  define COMPAT_TEST (current->thread.mflags & MF_32BIT_ADDR)
diff -urpN linux-2.6/drivers/net/phy/Kconfig linux-2.6-patched/drivers/net/phy/Kconfig
--- linux-2.6/drivers/net/phy/Kconfig	2005-12-16 10:56:46.000000000 +0100
+++ linux-2.6-patched/drivers/net/phy/Kconfig	2005-12-16 10:57:23.000000000 +0100
@@ -6,7 +6,7 @@ menu "PHY device support"
 
 config PHYLIB
 	tristate "PHY Device support and infrastructure"
-	depends on NET_ETHERNET && (BROKEN || !ARCH_S390)
+	depends on NET_ETHERNET && (BROKEN || !S390)
 	help
 	  Ethernet controllers are usually attached to PHY
 	  devices.  This option provides infrastructure for
diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2005-12-16 10:57:09.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2005-12-16 10:57:23.000000000 +0100
@@ -604,7 +604,7 @@ dasd_smalloc_request(char *magic, int cp
 void
 dasd_kfree_request(struct dasd_ccw_req * cqr, struct dasd_device * device)
 {
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 	struct ccw1 *ccw;
 
 	/* Clear any idals used for the request. */
diff -urpN linux-2.6/drivers/s390/block/dasd_diag.c linux-2.6-patched/drivers/s390/block/dasd_diag.c
--- linux-2.6/drivers/s390/block/dasd_diag.c	2005-12-16 10:57:09.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.c	2005-12-16 10:57:23.000000000 +0100
@@ -75,7 +75,7 @@ dia250(void *iob, int cmd)
 	int rc;
 
 	__asm__ __volatile__(
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 		"	lghi	%0,3\n"
 		"	lgr	0,%3\n"
 		"	diag	0,%2,0x250\n"
diff -urpN linux-2.6/drivers/s390/block/dasd_diag.h linux-2.6-patched/drivers/s390/block/dasd_diag.h
--- linux-2.6/drivers/s390/block/dasd_diag.h	2005-12-16 10:57:01.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.h	2005-12-16 10:57:23.000000000 +0100
@@ -45,7 +45,7 @@ struct dasd_diag_characteristics {
 } __attribute__ ((packed, aligned(4)));
 
 
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 #define DASD_DIAG_FLAGA_DEFAULT		DASD_DIAG_FLAGA_FORMAT_64BIT
 
 typedef u64 blocknum_t;
@@ -86,7 +86,7 @@ struct dasd_diag_rw_io {
 	struct dasd_diag_bio *bio_list;
 	u8  spare4[8];
 } __attribute__ ((packed, aligned(8)));
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 #define DASD_DIAG_FLAGA_DEFAULT		0x0
 
 typedef u32 blocknum_t;
@@ -125,4 +125,4 @@ struct dasd_diag_rw_io {
 	u32 interrupt_params;
 	u8 spare3[20];
 } __attribute__ ((packed, aligned(8)));
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2005-12-16 10:57:09.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2005-12-16 10:57:23.000000000 +0100
@@ -1041,7 +1041,7 @@ dasd_eckd_build_cp(struct dasd_device * 
 				/* Eckd can only do full blocks. */
 				return ERR_PTR(-EINVAL);
 			count += bv->bv_len >> (device->s2b_shift + 9);
-#if defined(CONFIG_ARCH_S390X)
+#if defined(CONFIG_64BIT)
 			if (idal_is_needed (page_address(bv->bv_page),
 					    bv->bv_len))
 				cidaw += bv->bv_len >> (device->s2b_shift + 9);
diff -urpN linux-2.6/drivers/s390/block/dasd_fba.c linux-2.6-patched/drivers/s390/block/dasd_fba.c
--- linux-2.6/drivers/s390/block/dasd_fba.c	2005-12-16 10:57:09.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_fba.c	2005-12-16 10:57:23.000000000 +0100
@@ -271,7 +271,7 @@ dasd_fba_build_cp(struct dasd_device * d
 				/* Fba can only do full blocks. */
 				return ERR_PTR(-EINVAL);
 			count += bv->bv_len >> (device->s2b_shift + 9);
-#if defined(CONFIG_ARCH_S390X)
+#if defined(CONFIG_64BIT)
 			if (idal_is_needed (page_address(bv->bv_page),
 					    bv->bv_len))
 				cidaw += bv->bv_len / blksize;
diff -urpN linux-2.6/drivers/s390/block/Kconfig linux-2.6-patched/drivers/s390/block/Kconfig
--- linux-2.6/drivers/s390/block/Kconfig	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/Kconfig	2005-12-16 10:57:23.000000000 +0100
@@ -1,11 +1,11 @@
-if ARCH_S390
+if S390
 
 comment "S/390 block device drivers"
-	depends on ARCH_S390
+	depends on S390
 
 config BLK_DEV_XPRAM
 	tristate "XPRAM disk support"
-	depends on ARCH_S390
+	depends on S390
 	help
 	  Select this option if you want to use your expanded storage on S/390
 	  or zSeries as a disk.  This is useful as a _fast_ swap device if you
@@ -49,7 +49,7 @@ config DASD_FBA
 
 config DASD_DIAG
 	tristate "Support for DIAG access to Disks"
-	depends on DASD && ( ARCH_S390X = 'n' || EXPERIMENTAL)
+	depends on DASD && ( 64BIT = 'n' || EXPERIMENTAL)
 	help
 	  Select this option if you want to use Diagnose250 command to access
 	  Disks under VM.  If you are not running under VM or unsure what it is,
diff -urpN linux-2.6/drivers/s390/block/xpram.c linux-2.6-patched/drivers/s390/block/xpram.c
--- linux-2.6/drivers/s390/block/xpram.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/xpram.c	2005-12-16 10:57:23.000000000 +0100
@@ -160,7 +160,7 @@ static int xpram_page_in (unsigned long 
                 "0: ipm   %0\n"
 		"   srl   %0,28\n"
 		"1:\n"
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 		".section __ex_table,\"a\"\n"
 		"   .align 4\n"
 		"   .long  0b,1b\n"
@@ -208,7 +208,7 @@ static long xpram_page_out (unsigned lon
                 "0: ipm   %0\n"
 		"   srl   %0,28\n"
 		"1:\n"
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 		".section __ex_table,\"a\"\n"
 		"   .align 4\n"
 		"   .long  0b,1b\n"
diff -urpN linux-2.6/drivers/s390/char/vmwatchdog.c linux-2.6-patched/drivers/s390/char/vmwatchdog.c
--- linux-2.6/drivers/s390/char/vmwatchdog.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/vmwatchdog.c	2005-12-16 10:57:23.000000000 +0100
@@ -66,7 +66,7 @@ static int __diag288(enum vmwdt_func fun
 	__cmdl = len;
 	err = 0;
 	asm volatile (
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
 		       "diag %2,%4,0x288\n"
 		"1:	\n"
 		".section .fixup,\"ax\"\n"
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2005-12-16 10:57:19.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2005-12-16 10:57:23.000000000 +0100
@@ -195,7 +195,7 @@ cio_start_key (struct subchannel *sch,	/
 	sch->orb.spnd = sch->options.suspend;
 	sch->orb.ssic = sch->options.suspend && sch->options.inter;
 	sch->orb.lpm = (lpm != 0) ? (lpm & sch->opm) : sch->lpm;
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 	/*
 	 * for 64 bit we always support 64 bit IDAWs with 4k page size only
 	 */
diff -urpN linux-2.6/drivers/s390/cio/device_id.c linux-2.6-patched/drivers/s390/cio/device_id.c
--- linux-2.6/drivers/s390/cio/device_id.c	2005-12-16 10:57:19.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_id.c	2005-12-16 10:57:23.000000000 +0100
@@ -27,7 +27,7 @@
 /*
  * diag210 is used under VM to get information about a virtual device
  */
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 int
 diag210(struct diag210 * addr)
 {
diff -urpN linux-2.6/drivers/s390/cio/ioasm.h linux-2.6-patched/drivers/s390/cio/ioasm.h
--- linux-2.6/drivers/s390/cio/ioasm.h	2005-12-16 10:57:19.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/ioasm.h	2005-12-16 10:57:23.000000000 +0100
@@ -50,7 +50,7 @@ static inline int stsch_err(struct subch
 		"0:  ipm  %0\n"
 		"    srl  %0,28\n"
 		"1:\n"
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 		".section __ex_table,\"a\"\n"
 		"   .align 8\n"
 		"   .quad 0b,1b\n"
@@ -95,7 +95,7 @@ static inline int msch_err(struct subcha
 		"0:  ipm  %0\n"
 		"    srl  %0,28\n"
 		"1:\n"
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 		".section __ex_table,\"a\"\n"
 		"   .align 8\n"
 		"   .quad 0b,1b\n"
diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2005-12-16 10:57:19.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2005-12-16 10:57:23.000000000 +0100
@@ -2394,7 +2394,7 @@ tiqdio_check_chsc_availability(void)
 	sprintf(dbf_text,"hydrati%1x", hydra_thinints);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 	/* Check for QEBSM support in general (bit 58). */
 	is_passthrough = css_general_characteristics.qebsm;
 #endif
diff -urpN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-patched/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	2005-12-16 10:57:16.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.h	2005-12-16 10:57:23.000000000 +0100
@@ -271,7 +271,7 @@ static inline int
 do_sqbs(unsigned long sch, unsigned char state, int queue,
        unsigned int *start, unsigned int *count)
 {
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
        register unsigned long _ccq asm ("0") = *count;
        register unsigned long _sch asm ("1") = sch;
        unsigned long _queuestart = ((unsigned long)queue << 32) | *start;
@@ -295,7 +295,7 @@ static inline int
 do_eqbs(unsigned long sch, unsigned char *state, int queue,
 	unsigned int *start, unsigned int *count)
 {
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 	register unsigned long _ccq asm ("0") = *count;
 	register unsigned long _sch asm ("1") = sch;
 	unsigned long _queuestart = ((unsigned long)queue << 32) | *start;
@@ -323,7 +323,7 @@ do_siga_sync(struct subchannel_id schid,
 {
 	int cc;
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 	asm volatile (
 		"lhi	0,2	\n\t"
 		"lr	1,%1	\n\t"
@@ -336,7 +336,7 @@ do_siga_sync(struct subchannel_id schid,
 		: "d" (schid), "d" (mask1), "d" (mask2)
 		: "cc", "0", "1", "2", "3"
 		);
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 	asm volatile (
 		"lghi	0,2	\n\t"
 		"llgfr	1,%1	\n\t"
@@ -349,7 +349,7 @@ do_siga_sync(struct subchannel_id schid,
 		: "d" (schid), "d" (mask1), "d" (mask2)
 		: "cc", "0", "1", "2", "3"
 		);
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 	return cc;
 }
 
@@ -358,7 +358,7 @@ do_siga_input(struct subchannel_id schid
 {
 	int cc;
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 	asm volatile (
 		"lhi	0,1	\n\t"
 		"lr	1,%1	\n\t"
@@ -370,7 +370,7 @@ do_siga_input(struct subchannel_id schid
 		: "d" (schid), "d" (mask)
 		: "cc", "0", "1", "2", "memory"
 		);
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 	asm volatile (
 		"lghi	0,1	\n\t"
 		"llgfr	1,%1	\n\t"
@@ -382,7 +382,7 @@ do_siga_input(struct subchannel_id schid
 		: "d" (schid), "d" (mask)
 		: "cc", "0", "1", "2", "memory"
 		);
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 	
 	return cc;
 }
@@ -394,7 +394,7 @@ do_siga_output(unsigned long schid, unsi
 	int cc;
 	__u32 busy_bit;
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 	asm volatile (
 		"lhi	0,0	\n\t"
 		"lr	1,%2	\n\t"
@@ -424,7 +424,7 @@ do_siga_output(unsigned long schid, unsi
 		"i" (QDIO_SIGA_ERROR_ACCESS_EXCEPTION)
 		: "cc", "0", "1", "2", "memory"
 		);
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 	asm volatile (
         	"llgfr  0,%5    \n\t"
                 "lgr    1,%2    \n\t"
@@ -449,7 +449,7 @@ do_siga_output(unsigned long schid, unsi
 		"i" (QDIO_SIGA_ERROR_ACCESS_EXCEPTION), "d" (fc)
 		: "cc", "0", "1", "2", "memory"
 		);
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 	
 	(*bb) = busy_bit;
 	return cc;
@@ -461,21 +461,21 @@ do_clear_global_summary(void)
 
 	unsigned long time;
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 	asm volatile (
 		"lhi	1,3	\n\t"
 		".insn	rre,0xb2650000,2,0	\n\t"
 		"lr	%0,3	\n\t"
 		: "=d" (time) : : "cc", "1", "2", "3"
 		);
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 	asm volatile (
 		"lghi	1,3	\n\t"
 		".insn	rre,0xb2650000,2,0	\n\t"
 		"lgr	%0,3	\n\t"
 		: "=d" (time) : : "cc", "1", "2", "3"
 		);
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 	
 	return time;
 }
@@ -542,11 +542,11 @@ struct qdio_perf_stats {
 
 #define MY_MODULE_STRING(x) #x
 
-#ifdef CONFIG_ARCH_S390X
+#ifdef CONFIG_64BIT
 #define QDIO_GET_ADDR(x) ((__u32)(unsigned long)x)
-#else /* CONFIG_ARCH_S390X */
+#else /* CONFIG_64BIT */
 #define QDIO_GET_ADDR(x) ((__u32)(long)x)
-#endif /* CONFIG_ARCH_S390X */
+#endif /* CONFIG_64BIT */
 
 struct qdio_q {
 	volatile struct slsb slsb;
diff -urpN linux-2.6/drivers/s390/crypto/z90hardware.c linux-2.6-patched/drivers/s390/crypto/z90hardware.c
--- linux-2.6/drivers/s390/crypto/z90hardware.c	2005-12-16 10:57:20.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90hardware.c	2005-12-16 10:57:23.000000000 +0100
@@ -785,7 +785,7 @@ testq(int q_nr, int *q_depth, int *dev_t
 	int ccode;
 
 	asm volatile
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
 	("	llgfr	0,%4		\n"
 	 "	slgr	1,1		\n"
 	 "	lgr	2,1		\n"
@@ -855,7 +855,7 @@ resetq(int q_nr, struct ap_status_word *
 	int ccode;
 
 	asm volatile
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
 	("	llgfr	0,%2		\n"
 	 "	lghi	1,1		\n"
 	 "	sll	1,24		\n"
@@ -921,7 +921,7 @@ sen(int msg_len, unsigned char *msg_ext,
 	int ccode;
 
 	asm volatile
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
 	("	lgr	6,%3		\n"
 	 "	llgfr	7,%2		\n"
 	 "	llgt	0,0(6)		\n"
@@ -1000,7 +1000,7 @@ rec(int q_nr, int buff_l, unsigned char 
 	int ccode;
 
 	asm volatile
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
 	("	llgfr	0,%2		\n"
 	 "	lgr	3,%4		\n"
 	 "	lgr	6,%3		\n"
diff -urpN linux-2.6/drivers/s390/net/claw.c linux-2.6-patched/drivers/s390/net/claw.c
--- linux-2.6/drivers/s390/net/claw.c	2005-12-16 10:56:47.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/claw.c	2005-12-16 10:57:23.000000000 +0100
@@ -1603,7 +1603,7 @@ dumpit(char* buf, int len)
         __u32      ct, sw, rm, dup;
         char       *ptr, *rptr;
         char       tbuf[82], tdup[82];
-#if (CONFIG_ARCH_S390X)
+#if (CONFIG_64BIT)
         char       addr[22];
 #else
         char       addr[12];
@@ -1619,7 +1619,7 @@ dumpit(char* buf, int len)
         dup = 0;
         for ( ct=0; ct < len; ct++, ptr++, rptr++ )  {
                 if (sw == 0) {
-#if (CONFIG_ARCH_S390X)
+#if (CONFIG_64BIT)
                         sprintf(addr, "%16.16lX",(unsigned long)rptr);
 #else
                         sprintf(addr, "%8.8X",(__u32)rptr);
@@ -1634,7 +1634,7 @@ dumpit(char* buf, int len)
                 if (sw == 8) {
                         strcat(bhex, "  ");
                 }
-#if (CONFIG_ARCH_S390X)
+#if (CONFIG_64BIT)
                 sprintf(tbuf,"%2.2lX", (unsigned long)*ptr);
 #else
                 sprintf(tbuf,"%2.2X", (__u32)*ptr);
diff -urpN linux-2.6/drivers/s390/net/Kconfig linux-2.6-patched/drivers/s390/net/Kconfig
--- linux-2.6/drivers/s390/net/Kconfig	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/Kconfig	2005-12-16 10:57:23.000000000 +0100
@@ -1,5 +1,5 @@
 menu "S/390 network device drivers"
-	depends on NETDEVICES && ARCH_S390
+	depends on NETDEVICES && S390
 
 config LCS
 	tristate "Lan Channel Station Interface"
diff -urpN linux-2.6/drivers/s390/s390mach.c linux-2.6-patched/drivers/s390/s390mach.c
--- linux-2.6/drivers/s390/s390mach.c	2005-12-16 10:57:19.000000000 +0100
+++ linux-2.6-patched/drivers/s390/s390mach.c	2005-12-16 10:57:23.000000000 +0100
@@ -246,7 +246,7 @@ s390_revalidate_registers(struct mci *mc
 		 */
 		kill_task = 1;
 
-#ifndef __s390x__
+#ifndef CONFIG_64BIT
 	asm volatile("ld 0,0(%0)\n"
 		     "ld 2,8(%0)\n"
 		     "ld 4,16(%0)\n"
@@ -255,7 +255,7 @@ s390_revalidate_registers(struct mci *mc
 #endif
 
 	if (MACHINE_HAS_IEEE) {
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
 		fpt_save_area = &S390_lowcore.floating_pt_save_area;
 		fpt_creg_save_area = &S390_lowcore.fpt_creg_save_area;
 #else
@@ -314,7 +314,7 @@ s390_revalidate_registers(struct mci *mc
 		 */
 		s390_handle_damage("invalid control registers.");
 	else
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
 		asm volatile("lctlg 0,15,0(%0)"
 			     : : "a" (&S390_lowcore.cregs_save_area));
 #else
@@ -327,7 +327,7 @@ s390_revalidate_registers(struct mci *mc
 	 * can't write something sensible into that register.
 	 */
 
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
 	/*
 	 * See if we can revalidate the TOD programmable register with its
 	 * old contents (should be zero) otherwise set it to zero.
@@ -384,7 +384,7 @@ s390_do_machine_check(struct pt_regs *re
 		if (mci->b) {
 			/* Processing backup -> verify if we can survive this */
 			u64 z_mcic, o_mcic, t_mcic;
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
 			z_mcic = (1ULL<<63 | 1ULL<<59 | 1ULL<<29);
 			o_mcic = (1ULL<<43 | 1ULL<<42 | 1ULL<<41 | 1ULL<<40 |
 				  1ULL<<36 | 1ULL<<35 | 1ULL<<34 | 1ULL<<32 |
diff -urpN linux-2.6/drivers/s390/sysinfo.c linux-2.6-patched/drivers/s390/sysinfo.c
--- linux-2.6/drivers/s390/sysinfo.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/sysinfo.c	2005-12-16 10:57:23.000000000 +0100
@@ -106,7 +106,7 @@ static inline int stsi (void *sysinfo, 
 {
 	int cc, retv;
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef CONFIG_64BIT
 	__asm__ __volatile__ (	"lr\t0,%2\n"
 				"\tlr\t1,%3\n"
 				"\tstsi\t0(%4)\n"
diff -urpN linux-2.6/drivers/scsi/Kconfig linux-2.6-patched/drivers/scsi/Kconfig
--- linux-2.6/drivers/scsi/Kconfig	2005-12-16 10:56:47.000000000 +0100
+++ linux-2.6-patched/drivers/scsi/Kconfig	2005-12-16 10:57:23.000000000 +0100
@@ -1802,7 +1802,7 @@ config SCSI_SUNESP
 
 config ZFCP
 	tristate "FCP host bus adapter driver for IBM eServer zSeries"
-	depends on ARCH_S390 && QDIO && SCSI
+	depends on S390 && QDIO && SCSI
 	select SCSI_FC_ATTRS
 	help
           If you want to access SCSI devices attached to your IBM eServer
diff -urpN linux-2.6/fs/partitions/Kconfig linux-2.6-patched/fs/partitions/Kconfig
--- linux-2.6/fs/partitions/Kconfig	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/fs/partitions/Kconfig	2005-12-16 10:57:23.000000000 +0100
@@ -85,7 +85,7 @@ config ATARI_PARTITION
 
 config IBM_PARTITION
 	bool "IBM disk label and partition support"
-	depends on PARTITION_ADVANCED && ARCH_S390
+	depends on PARTITION_ADVANCED && S390
 	help
 	  Say Y here if you would like to be able to read the hard disk
 	  partition table format used by IBM DASD disks operating under CMS.
diff -urpN linux-2.6/fs/proc/array.c linux-2.6-patched/fs/proc/array.c
--- linux-2.6/fs/proc/array.c	2005-12-16 10:56:50.000000000 +0100
+++ linux-2.6-patched/fs/proc/array.c	2005-12-16 10:57:23.000000000 +0100
@@ -308,7 +308,7 @@ int proc_pid_status(struct task_struct *
 	buffer = task_sig(task, buffer);
 	buffer = task_cap(task, buffer);
 	buffer = cpuset_task_status_allowed(task, buffer);
-#if defined(CONFIG_ARCH_S390)
+#if defined(CONFIG_S390)
 	buffer = task_show_regs(task, buffer);
 #endif
 	return buffer - orig;
diff -urpN linux-2.6/include/asm-s390/unistd.h linux-2.6-patched/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2005-12-16 10:56:51.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/unistd.h	2005-12-16 10:57:23.000000000 +0100
@@ -539,7 +539,7 @@ type name(type1 arg1, type2 arg2, type3 
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
-# ifdef CONFIG_ARCH_S390_31
+# ifndef CONFIG_64BIT
 #   define __ARCH_WANT_STAT64
 #   define __ARCH_WANT_SYS_TIME
 # endif
diff -urpN linux-2.6/include/linux/irq.h linux-2.6-patched/include/linux/irq.h
--- linux-2.6/include/linux/irq.h	2005-12-16 10:56:51.000000000 +0100
+++ linux-2.6-patched/include/linux/irq.h	2005-12-16 10:57:23.000000000 +0100
@@ -12,7 +12,7 @@
 #include <linux/config.h>
 #include <asm/smp.h>		/* cpu_online_map */
 
-#if !defined(CONFIG_ARCH_S390)
+#if !defined(CONFIG_S390)
 
 #include <linux/linkage.h>
 #include <linux/cache.h>
diff -urpN linux-2.6/init/do_mounts_rd.c linux-2.6-patched/init/do_mounts_rd.c
--- linux-2.6/init/do_mounts_rd.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/init/do_mounts_rd.c	2005-12-16 10:57:23.000000000 +0100
@@ -145,7 +145,7 @@ int __init rd_load_image(char *from)
 	int nblocks, i, disk;
 	char *buf = NULL;
 	unsigned short rotate = 0;
-#if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
+#if !defined(CONFIG_S390) && !defined(CONFIG_PPC_ISERIES)
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
 #endif
 
@@ -237,7 +237,7 @@ int __init rd_load_image(char *from)
 		}
 		sys_read(in_fd, buf, BLOCK_SIZE);
 		sys_write(out_fd, buf, BLOCK_SIZE);
-#if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
+#if !defined(CONFIG_S390) && !defined(CONFIG_PPC_ISERIES)
 		if (!(i % 16)) {
 			printk("%c\b", rotator[rotate & 0x3]);
 			rotate++;
diff -urpN linux-2.6/init/Kconfig linux-2.6-patched/init/Kconfig
--- linux-2.6/init/Kconfig	2005-12-16 10:56:52.000000000 +0100
+++ linux-2.6-patched/init/Kconfig	2005-12-16 10:57:23.000000000 +0100
@@ -190,7 +190,7 @@ config AUDIT
 
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
-	depends on AUDIT && (X86 || PPC || PPC64 || ARCH_S390 || IA64 || UML || SPARC64)
+	depends on AUDIT && (X86 || PPC || PPC64 || S390 || IA64 || UML || SPARC64)
 	default y if SECURITY_SELINUX
 	help
 	  Enable low-overhead system-call auditing infrastructure that
@@ -198,8 +198,8 @@ config AUDITSYSCALL
 	  such as SELinux.
 
 config HOTPLUG
-	bool "Support for hot-pluggable devices" if !ARCH_S390
-	default ARCH_S390
+	bool "Support for hot-pluggable devices" if !S390
+	default S390
 	help
 	  This option is provided for the case where no in-kernel-tree
 	  modules require HOTPLUG functionality, but a module built
diff -urpN linux-2.6/kernel/panic.c linux-2.6-patched/kernel/panic.c
--- linux-2.6/kernel/panic.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/kernel/panic.c	2005-12-16 10:57:23.000000000 +0100
@@ -60,7 +60,7 @@ NORET_TYPE void panic(const char * fmt, 
 	long i;
 	static char buf[1024];
 	va_list args;
-#if defined(CONFIG_ARCH_S390)
+#if defined(CONFIG_S390)
         unsigned long caller = (unsigned long) __builtin_return_address(0);
 #endif
 
@@ -125,7 +125,7 @@ NORET_TYPE void panic(const char * fmt, 
 		printk(KERN_EMERG "Press Stop-A (L1-A) to return to the boot prom\n");
 	}
 #endif
-#if defined(CONFIG_ARCH_S390)
+#if defined(CONFIG_S390)
         disabled_wait(caller);
 #endif
 	local_irq_enable();
diff -urpN linux-2.6/kernel/sysctl.c linux-2.6-patched/kernel/sysctl.c
--- linux-2.6/kernel/sysctl.c	2005-12-16 10:56:52.000000000 +0100
+++ linux-2.6-patched/kernel/sysctl.c	2005-12-16 10:57:23.000000000 +0100
@@ -110,7 +110,7 @@ extern int pwrsw_enabled;
 extern int unaligned_enabled;
 #endif
 
-#ifdef CONFIG_ARCH_S390
+#ifdef CONFIG_S390
 #ifdef CONFIG_MATHEMU
 extern int sysctl_ieee_emulation_warnings;
 #endif
@@ -544,7 +544,7 @@ static ctl_table kern_table[] = {
 		.extra1		= &minolduid,
 		.extra2		= &maxolduid,
 	},
-#ifdef CONFIG_ARCH_S390
+#ifdef CONFIG_S390
 #ifdef CONFIG_MATHEMU
 	{
 		.ctl_name	= KERN_IEEE_EMULATION_WARNINGS,
@@ -646,7 +646,7 @@ static ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
-#if defined(CONFIG_ARCH_S390)
+#if defined(CONFIG_S390)
 	{
 		.ctl_name	= KERN_SPIN_RETRY,
 		.procname	= "spin_retry",
diff -urpN linux-2.6/lib/Kconfig.debug linux-2.6-patched/lib/Kconfig.debug
--- linux-2.6/lib/Kconfig.debug	2005-12-16 10:56:52.000000000 +0100
+++ linux-2.6-patched/lib/Kconfig.debug	2005-12-16 10:57:23.000000000 +0100
@@ -32,7 +32,7 @@ config MAGIC_SYSRQ
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
 	range 12 21
-	default 17 if ARCH_S390
+	default 17 if S390
 	default 16 if X86_NUMAQ || IA64
 	default 15 if SMP
 	default 14
