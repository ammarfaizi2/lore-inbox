Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130362AbRA2VKl>; Mon, 29 Jan 2001 16:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130475AbRA2VKb>; Mon, 29 Jan 2001 16:10:31 -0500
Received: from rs1.Theo-Phys.Uni-Essen.DE ([132.252.73.3]:10139 "EHLO
	rs1.Theo-Phys.Uni-Essen.DE") by vger.kernel.org with ESMTP
	id <S130362AbRA2VKN>; Mon, 29 Jan 2001 16:10:13 -0500
Date: Mon, 29 Jan 2001 22:09:54 +0100 (MET)
Message-Id: <200101292109.WAA87394@indy3.Theo-Phys.Uni-Essen.DE>
From: Martin Schimschak <masch@indy3.Theo-Phys.Uni-Essen.DE>
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH] 2.4.1-pre11: sys_wait4 declarations cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more fixes of sys_wait4() declarations:

declaration of sys_wait4() fixed in:

	include/asm-arm/unistd.h	
	include/asm-arm/unistd.h	
	include/asm-s390/unistd.h	
	include/asm-parisc/unistd.h	
	include/asm-parisc/unistd.h	
	arch/arm/kernel/armksyms.c	

redundant declaration of sys_wait4() removed from:
					
	arch/ia64/kernel/signal.c	
	arch/parisc/kernel/signal.c	

Martin

--- patch against 2.4.1-pre11 below ---

diff -urN -X dontdiff linux-vanilla/arch/arm/kernel/armksyms.c linux/arch/arm/kernel/armksyms.c
--- linux-vanilla/arch/arm/kernel/armksyms.c	Tue Sep 19 00:15:24 2000
+++ linux/arch/arm/kernel/armksyms.c	Mon Jan 29 21:42:58 2001
@@ -48,7 +48,7 @@
 extern int sys_read(int, char *, int);
 extern int sys_lseek(int, off_t, int);
 extern int sys_exit(int);
-extern int sys_wait4(int, int *, int, struct rusage *);
+extern long sys_wait4(pid_t, unsigned int *, int, struct rusage *);
 
 /*
  * libgcc functions - functions that are used internally by the
diff -urN -X dontdiff linux-vanilla/arch/ia64/kernel/signal.c linux/arch/ia64/kernel/signal.c
--- linux-vanilla/arch/ia64/kernel/signal.c	Thu Jan  4 21:50:17 2001
+++ linux/arch/ia64/kernel/signal.c	Mon Jan 29 21:43:49 2001
@@ -52,7 +52,6 @@
 	struct sigcontext sc;
 };
 
-extern long sys_wait4 (int, int *, int, struct rusage *);
 extern long ia64_do_signal (sigset_t *, struct sigscratch *, long);	/* forward decl */
 
 long
diff -urN -X dontdiff linux-vanilla/arch/parisc/kernel/signal.c linux/arch/parisc/kernel/signal.c
--- linux-vanilla/arch/parisc/kernel/signal.c	Wed Dec  6 20:46:39 2000
+++ linux/arch/parisc/kernel/signal.c	Mon Jan 29 21:44:20 2001
@@ -33,7 +33,6 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-extern long sys_wait4 (int, int *, int, struct rusage *);
 int do_signal(sigset_t *oldset, struct pt_regs *regs, int in_syscall);
 
 int copy_siginfo_to_user(siginfo_t *to, siginfo_t *from)
diff -urN -X dontdiff linux-vanilla/include/asm-arm/unistd.h linux/include/asm-arm/unistd.h
--- linux-vanilla/include/asm-arm/unistd.h	Fri Aug 11 23:29:03 2000
+++ linux/include/asm-arm/unistd.h	Mon Jan 29 21:39:22 2001
@@ -400,7 +400,7 @@
 
 static inline pid_t waitpid(pid_t pid, int *wait_stat, int options)
 {
-	extern long sys_wait4(int, int *, int, struct rusage *);
+	extern long sys_wait4(pid_t, unsigned int *, int, struct rusage *);
 	return sys_wait4((int)pid, wait_stat, options, NULL);
 }
 
@@ -412,7 +412,7 @@
 
 static inline pid_t wait(int * wait_stat)
 {
-	extern long sys_wait4(int, int *, int, struct rusage *);
+	extern long sys_wait4(pid_t, unsigned int *, int, struct rusage *);
 	return sys_wait4(-1, wait_stat, 0, NULL);
 }
 
diff -urN -X dontdiff linux-vanilla/include/asm-parisc/unistd.h linux/include/asm-parisc/unistd.h
--- linux-vanilla/include/asm-parisc/unistd.h	Tue Dec  5 21:29:39 2000
+++ linux/include/asm-parisc/unistd.h	Mon Jan 29 21:41:38 2001
@@ -871,7 +871,7 @@
 
 static inline pid_t waitpid(pid_t pid, int *wait_stat, int options)
 {
-	extern int sys_wait4(int, int *, int, struct rusage *);
+	extern long sys_wait4(pid_t, unsigned int *, int, struct rusage *);
 	return sys_wait4((int)pid, wait_stat, options, NULL);
 }
 
@@ -883,7 +883,7 @@
 
 static inline pid_t wait(int * wait_stat)
 {
-	extern int sys_wait4(int, int *, int, struct rusage *);
+	extern long sys_wait4(pid_t, unsigned int *, int, struct rusage *);
 	return sys_wait4(-1, wait_stat, 0, NULL);
 }
 
diff -urN -X dontdiff linux-vanilla/include/asm-s390/unistd.h linux/include/asm-s390/unistd.h
--- linux-vanilla/include/asm-s390/unistd.h	Fri Aug 11 23:29:03 2000
+++ linux/include/asm-s390/unistd.h	Mon Jan 29 21:40:27 2001
@@ -359,7 +359,7 @@
 static inline _syscall1(int,delete_module,const char *,name)
 static inline _syscall2(long,stat,char *,filename,struct stat *,statbuf)
 
-extern int sys_wait4(int, int *, int, struct rusage *);
+extern long sys_wait4(pid_t, unsigned int *, int, struct rusage *);
 static inline pid_t waitpid(int pid, int * wait_stat, int flags)
 {
         return sys_wait4(pid, wait_stat, flags, NULL);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
