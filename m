Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264314AbSIQQeW>; Tue, 17 Sep 2002 12:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264327AbSIQQeW>; Tue, 17 Sep 2002 12:34:22 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:35305 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S264314AbSIQQeS>;
	Tue, 17 Sep 2002 12:34:18 -0400
Date: Wed, 18 Sep 2002 02:39:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] consolidate _BLOCKABLE
Message-Id: <20020918023905.47d40ec3.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

There were many definitions of _BLOCKABLE across all the architectures.
This patch puts one definition in linux/signal.h and removes almost
all the rest.  There are a couple that are not obviously the same and
these are left.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.35-si.1/arch/alpha/kernel/signal.c 2.5.35-si.2/arch/alpha/kernel/signal.c
--- 2.5.35-si.1/arch/alpha/kernel/signal.c	2002-09-16 13:40:49.000000000 +1000
+++ 2.5.35-si.2/arch/alpha/kernel/signal.c	2002-09-18 02:19:27.000000000 +1000
@@ -30,8 +30,6 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 asmlinkage void ret_from_sys_call(void);
 static int do_signal(sigset_t *, struct pt_regs *, struct switch_stack *,
 		     unsigned long, unsigned long);
diff -ruN 2.5.35-si.1/arch/arm/kernel/signal.c 2.5.35-si.2/arch/arm/kernel/signal.c
--- 2.5.35-si.1/arch/arm/kernel/signal.c	2002-07-17 11:28:15.000000000 +1000
+++ 2.5.35-si.2/arch/arm/kernel/signal.c	2002-09-18 02:19:55.000000000 +1000
@@ -29,8 +29,6 @@
 
 #include "ptrace.h"
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 /*
  * For ARM syscalls, we encode the syscall number into the instruction.
  */
diff -ruN 2.5.35-si.1/arch/cris/kernel/signal.c 2.5.35-si.2/arch/cris/kernel/signal.c
--- 2.5.35-si.1/arch/cris/kernel/signal.c	2002-07-17 11:28:15.000000000 +1000
+++ 2.5.35-si.2/arch/cris/kernel/signal.c	2002-09-18 02:20:08.000000000 +1000
@@ -31,8 +31,6 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 /* a syscall in Linux/CRIS is a break 13 instruction which is 2 bytes */
 /* manipulate regs so that upon return, it will be re-executed */
 
diff -ruN 2.5.35-si.1/arch/i386/kernel/signal.c 2.5.35-si.2/arch/i386/kernel/signal.c
--- 2.5.35-si.1/arch/i386/kernel/signal.c	2002-08-28 09:30:51.000000000 +1000
+++ 2.5.35-si.2/arch/i386/kernel/signal.c	2002-09-18 02:20:23.000000000 +1000
@@ -25,8 +25,6 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
diff -ruN 2.5.35-si.1/arch/ia64/ia32/ia32_signal.c 2.5.35-si.2/arch/ia64/ia32/ia32_signal.c
--- 2.5.35-si.1/arch/ia64/ia32/ia32_signal.c	2002-03-19 08:12:49.000000000 +1100
+++ 2.5.35-si.2/arch/ia64/ia32/ia32_signal.c	2002-09-18 02:20:41.000000000 +1000
@@ -34,7 +34,6 @@
 #define A(__x)		((unsigned long)(__x))
 
 #define DEBUG_SIG	0
-#define _BLOCKABLE	(~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 #define __IA32_NR_sigreturn            119
 #define __IA32_NR_rt_sigreturn         173
diff -ruN 2.5.35-si.1/arch/ia64/kernel/signal.c 2.5.35-si.2/arch/ia64/kernel/signal.c
--- 2.5.35-si.1/arch/ia64/kernel/signal.c	2002-08-28 09:30:54.000000000 +1000
+++ 2.5.35-si.2/arch/ia64/kernel/signal.c	2002-09-18 02:20:57.000000000 +1000
@@ -31,8 +31,6 @@
 
 #define DEBUG_SIG	0
 #define STACK_ALIGN	16		/* minimal alignment for stack pointer */
-#define _BLOCKABLE	(~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 #if _NSIG_WORDS > 1
 # define PUT_SIGSET(k,u)	__copy_to_user((u)->sig, (k)->sig, sizeof(sigset_t))
 # define GET_SIGSET(k,u)	__copy_from_user((k)->sig, (u)->sig, sizeof(sigset_t))
diff -ruN 2.5.35-si.1/arch/m68k/kernel/signal.c 2.5.35-si.2/arch/m68k/kernel/signal.c
--- 2.5.35-si.1/arch/m68k/kernel/signal.c	2002-07-25 10:42:54.000000000 +1000
+++ 2.5.35-si.2/arch/m68k/kernel/signal.c	2002-09-18 02:21:12.000000000 +1000
@@ -48,8 +48,6 @@
 #include <asm/traps.h>
 #include <asm/ucontext.h>
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs);
 
 const int frame_extra_sizes[16] = {
diff -ruN 2.5.35-si.1/arch/mips/kernel/irixsig.c 2.5.35-si.2/arch/mips/kernel/irixsig.c
--- 2.5.35-si.1/arch/mips/kernel/irixsig.c	2002-02-20 14:12:55.000000000 +1100
+++ 2.5.35-si.2/arch/mips/kernel/irixsig.c	2002-09-18 02:22:17.000000000 +1000
@@ -22,6 +22,7 @@
 
 #define _S(nr) (1<<((nr)-1))
 
+#undef _BLOCKABLE	/* incase linux/signal.h is included */
 #define _BLOCKABLE (~(_S(SIGKILL) | _S(SIGSTOP)))
 
 typedef struct {
diff -ruN 2.5.35-si.1/arch/mips/kernel/signal.c 2.5.35-si.2/arch/mips/kernel/signal.c
--- 2.5.35-si.1/arch/mips/kernel/signal.c	2002-05-30 05:12:21.000000000 +1000
+++ 2.5.35-si.2/arch/mips/kernel/signal.c	2002-09-18 02:22:36.000000000 +1000
@@ -28,8 +28,6 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 extern asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs);
 
 extern asmlinkage int (*save_fp_context)(struct sigcontext *sc);
diff -ruN 2.5.35-si.1/arch/mips64/kernel/signal.c 2.5.35-si.2/arch/mips64/kernel/signal.c
--- 2.5.35-si.1/arch/mips64/kernel/signal.c	2002-05-30 05:12:21.000000000 +1000
+++ 2.5.35-si.2/arch/mips64/kernel/signal.c	2002-09-18 02:22:47.000000000 +1000
@@ -29,8 +29,6 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 extern asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs);
 extern asmlinkage int save_fp_context(struct sigcontext *sc);
 extern asmlinkage int restore_fp_context(struct sigcontext *sc);
diff -ruN 2.5.35-si.1/arch/mips64/kernel/signal32.c 2.5.35-si.2/arch/mips64/kernel/signal32.c
--- 2.5.35-si.1/arch/mips64/kernel/signal32.c	2002-05-30 05:12:21.000000000 +1000
+++ 2.5.35-si.2/arch/mips64/kernel/signal32.c	2002-09-18 02:23:00.000000000 +1000
@@ -28,8 +28,6 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 extern asmlinkage int do_signal32(sigset_t *oldset, struct pt_regs *regs);
 extern asmlinkage int save_fp_context(struct sigcontext *sc);
 extern asmlinkage int restore_fp_context(struct sigcontext *sc);
diff -ruN 2.5.35-si.1/arch/parisc/kernel/signal.c 2.5.35-si.2/arch/parisc/kernel/signal.c
--- 2.5.35-si.1/arch/parisc/kernel/signal.c	2002-05-30 05:12:21.000000000 +1000
+++ 2.5.35-si.2/arch/parisc/kernel/signal.c	2002-09-18 02:23:13.000000000 +1000
@@ -31,8 +31,6 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 extern long sys_wait4 (int, int *, int, struct rusage *);
 int do_signal(sigset_t *oldset, struct pt_regs *regs, int in_syscall);
 
diff -ruN 2.5.35-si.1/arch/ppc/kernel/signal.c 2.5.35-si.2/arch/ppc/kernel/signal.c
--- 2.5.35-si.1/arch/ppc/kernel/signal.c	2002-05-30 05:12:22.000000000 +1000
+++ 2.5.35-si.2/arch/ppc/kernel/signal.c	2002-09-18 02:23:25.000000000 +1000
@@ -38,8 +38,6 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 extern void sigreturn_exit(struct pt_regs *);
 
 #define GP_REGS_SIZE	min(sizeof(elf_gregset_t), sizeof(struct pt_regs))
diff -ruN 2.5.35-si.1/arch/ppc64/kernel/signal.c 2.5.35-si.2/arch/ppc64/kernel/signal.c
--- 2.5.35-si.1/arch/ppc64/kernel/signal.c	2002-09-16 13:40:49.000000000 +1000
+++ 2.5.35-si.2/arch/ppc64/kernel/signal.c	2002-09-18 02:23:47.000000000 +1000
@@ -36,8 +36,6 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 #ifndef MIN
 #define MIN(a,b) (((a) < (b)) ? (a) : (b))
 #endif
diff -ruN 2.5.35-si.1/arch/ppc64/kernel/signal32.c 2.5.35-si.2/arch/ppc64/kernel/signal32.c
--- 2.5.35-si.1/arch/ppc64/kernel/signal32.c	2002-08-28 09:31:00.000000000 +1000
+++ 2.5.35-si.2/arch/ppc64/kernel/signal32.c	2002-09-18 02:24:00.000000000 +1000
@@ -28,7 +28,6 @@
 #include <asm/unistd.h>
 #include <asm/cacheflush.h>
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 /* 
  * These are the flags in the MSR that the user is allowed to change
  * by modifying the saved value of the MSR on the stack.  SE and BE
diff -ruN 2.5.35-si.1/arch/s390/kernel/signal.c 2.5.35-si.2/arch/s390/kernel/signal.c
--- 2.5.35-si.1/arch/s390/kernel/signal.c	2002-06-09 16:12:27.000000000 +1000
+++ 2.5.35-si.2/arch/s390/kernel/signal.c	2002-09-18 02:24:23.000000000 +1000
@@ -30,9 +30,6 @@
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
-
 typedef struct 
 {
 	__u8 callee_used_stack[__SIGNAL_FRAMESIZE];
diff -ruN 2.5.35-si.1/arch/s390x/kernel/signal.c 2.5.35-si.2/arch/s390x/kernel/signal.c
--- 2.5.35-si.1/arch/s390x/kernel/signal.c	2002-06-09 16:12:28.000000000 +1000
+++ 2.5.35-si.2/arch/s390x/kernel/signal.c	2002-09-18 02:24:39.000000000 +1000
@@ -30,9 +30,6 @@
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
-
 typedef struct 
 {
 	__u8 callee_used_stack[__SIGNAL_FRAMESIZE];
diff -ruN 2.5.35-si.1/arch/s390x/kernel/signal32.c 2.5.35-si.2/arch/s390x/kernel/signal32.c
--- 2.5.35-si.1/arch/s390x/kernel/signal32.c	2002-06-09 16:12:28.000000000 +1000
+++ 2.5.35-si.2/arch/s390x/kernel/signal32.c	2002-09-18 02:24:53.000000000 +1000
@@ -30,8 +30,6 @@
 #include <asm/uaccess.h>
 #include "linux32.h"
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 #define _USER_PSW_MASK32 0x0705C00080000000
 
 typedef struct 
diff -ruN 2.5.35-si.1/arch/sh/kernel/signal.c 2.5.35-si.2/arch/sh/kernel/signal.c
--- 2.5.35-si.1/arch/sh/kernel/signal.c	2002-05-30 05:12:23.000000000 +1000
+++ 2.5.35-si.2/arch/sh/kernel/signal.c	2002-09-18 02:25:03.000000000 +1000
@@ -30,8 +30,6 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 asmlinkage int do_signal(struct pt_regs *regs, sigset_t *oldset);
 
 /*
diff -ruN 2.5.35-si.1/arch/sparc/kernel/signal.c 2.5.35-si.2/arch/sparc/kernel/signal.c
--- 2.5.35-si.1/arch/sparc/kernel/signal.c	2002-09-16 13:40:49.000000000 +1000
+++ 2.5.35-si.2/arch/sparc/kernel/signal.c	2002-09-18 02:25:28.000000000 +1000
@@ -29,8 +29,6 @@
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>	/* flush_sig_insns */
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 extern void fpsave(unsigned long *fpregs, unsigned long *fsr,
 		   void *fpqueue, unsigned long *fpqdepth);
 extern void fpload(unsigned long *fpregs, unsigned long *fsr);
diff -ruN 2.5.35-si.1/arch/sparc/kernel/sys_sunos.c 2.5.35-si.2/arch/sparc/kernel/sys_sunos.c
--- 2.5.35-si.1/arch/sparc/kernel/sys_sunos.c	2002-06-03 12:12:51.000000000 +1000
+++ 2.5.35-si.2/arch/sparc/kernel/sys_sunos.c	2002-09-18 02:26:05.000000000 +1000
@@ -273,8 +273,6 @@
 	return SUNOS_NR_OPEN;
 }
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 asmlinkage unsigned long sunos_sigblock(unsigned long blk_mask)
 {
 	unsigned long old;
diff -ruN 2.5.35-si.1/arch/sparc64/kernel/signal.c 2.5.35-si.2/arch/sparc64/kernel/signal.c
--- 2.5.35-si.1/arch/sparc64/kernel/signal.c	2002-09-16 13:40:49.000000000 +1000
+++ 2.5.35-si.2/arch/sparc64/kernel/signal.c	2002-09-18 02:26:17.000000000 +1000
@@ -31,8 +31,6 @@
 #include <asm/siginfo.h>
 #include <asm/visasm.h>
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 static int do_signal(sigset_t *oldset, struct pt_regs * regs,
 		     unsigned long orig_o0, int ret_from_syscall);
 
diff -ruN 2.5.35-si.1/arch/sparc64/kernel/signal32.c 2.5.35-si.2/arch/sparc64/kernel/signal32.c
--- 2.5.35-si.1/arch/sparc64/kernel/signal32.c	2002-09-16 13:40:49.000000000 +1000
+++ 2.5.35-si.2/arch/sparc64/kernel/signal32.c	2002-09-18 02:26:29.000000000 +1000
@@ -29,8 +29,6 @@
 #include <asm/fpumacro.h>
 #include <asm/visasm.h>
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 int do_signal32(sigset_t *oldset, struct pt_regs *regs,
 		unsigned long orig_o0, int ret_from_syscall);
 
diff -ruN 2.5.35-si.1/arch/sparc64/kernel/sys_sunos32.c 2.5.35-si.2/arch/sparc64/kernel/sys_sunos32.c
--- 2.5.35-si.1/arch/sparc64/kernel/sys_sunos32.c	2002-06-17 13:12:20.000000000 +1000
+++ 2.5.35-si.2/arch/sparc64/kernel/sys_sunos32.c	2002-09-18 02:26:47.000000000 +1000
@@ -228,8 +228,6 @@
 }
 
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 asmlinkage u32 sunos_sigblock(u32 blk_mask)
 {
 	u32 old;
diff -ruN 2.5.35-si.1/arch/sparc64/solaris/signal.c 2.5.35-si.2/arch/sparc64/solaris/signal.c
--- 2.5.35-si.1/arch/sparc64/solaris/signal.c	2002-05-03 11:12:17.000000000 +1000
+++ 2.5.35-si.2/arch/sparc64/solaris/signal.c	2002-09-18 02:27:26.000000000 +1000
@@ -17,6 +17,7 @@
 
 #define _S(nr) (1L<<((nr)-1))
 
+#undef _BLOCKABLE	/* in case linux/signal.h is included */
 #define _BLOCKABLE (~(_S(SIGKILL) | _S(SIGSTOP)))
 
 long linux_to_solaris_signals[] = {
diff -ruN 2.5.35-si.1/arch/um/kernel/signal_kern.c 2.5.35-si.2/arch/um/kernel/signal_kern.c
--- 2.5.35-si.1/arch/um/kernel/signal_kern.c	2002-09-16 13:40:50.000000000 +1000
+++ 2.5.35-si.2/arch/um/kernel/signal_kern.c	2002-09-18 02:28:10.000000000 +1000
@@ -52,6 +52,7 @@
 
 #define _S(nr) (1<<((nr)-1))
 
+#undef _BLOCKABLE	/* in case linux/signal.h is included */
 #define _BLOCKABLE (~(_S(SIGKILL) | _S(SIGSTOP)))
 
 /*
diff -ruN 2.5.35-si.1/arch/x86_64/ia32/ia32_signal.c 2.5.35-si.2/arch/x86_64/ia32/ia32_signal.c
--- 2.5.35-si.1/arch/x86_64/ia32/ia32_signal.c	2002-06-17 13:12:21.000000000 +1000
+++ 2.5.35-si.2/arch/x86_64/ia32/ia32_signal.c	2002-09-18 02:28:22.000000000 +1000
@@ -36,8 +36,6 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 asmlinkage int do_signal(struct pt_regs *regs, sigset_t *oldset);
 
 static int ia32_copy_siginfo_to_user(siginfo_t32 *to, siginfo_t *from)
diff -ruN 2.5.35-si.1/arch/x86_64/kernel/signal.c 2.5.35-si.2/arch/x86_64/kernel/signal.c
--- 2.5.35-si.1/arch/x86_64/kernel/signal.c	2002-06-19 12:41:50.000000000 +1000
+++ 2.5.35-si.2/arch/x86_64/kernel/signal.c	2002-09-18 02:28:38.000000000 +1000
@@ -30,8 +30,6 @@
 
 /* #define DEBUG_SIG 1 */
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 void ia32_setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
                sigset_t *set, struct pt_regs * regs); 
 void ia32_setup_frame(int sig, struct k_sigaction *ka,
diff -ruN 2.5.35-si.1/include/linux/signal.h 2.5.35-si.2/include/linux/signal.h
--- 2.5.35-si.1/include/linux/signal.h	2002-09-17 14:53:23.000000000 +1000
+++ 2.5.35-si.2/include/linux/signal.h	2002-09-18 02:18:23.000000000 +1000
@@ -225,6 +225,8 @@
 extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs);
 #endif
 
+#define _BLOCKABLE	(~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_SIGNAL_H */
