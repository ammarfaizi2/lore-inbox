Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVIZMjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVIZMjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVIZMjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:39:10 -0400
Received: from verein.lst.de ([213.95.11.210]:32644 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932114AbVIZMjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:39:08 -0400
Date: Mon, 26 Sep 2005 14:39:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] unify sys_ptrace prototype
Message-ID: <20050926123900.GB25496@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make sure we always return, as all syscalls should.  Also move the
common prototype to <linux/syscalls.h>


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/arm/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/ptrace.c	2005-09-18 13:46:47.000000000 +0200
+++ linux-2.6/arch/arm/kernel/ptrace.c	2005-09-21 11:40:49.000000000 +0200
@@ -782,7 +782,7 @@
 	return ret;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	int ret;
Index: linux-2.6/arch/arm26/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/arm26/kernel/ptrace.c	2005-09-18 13:46:48.000000000 +0200
+++ linux-2.6/arch/arm26/kernel/ptrace.c	2005-09-21 11:40:51.000000000 +0200
@@ -665,7 +665,7 @@
 	return ret;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	int ret;
Index: linux-2.6/arch/frv/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/frv/kernel/ptrace.c	2005-09-18 13:46:48.000000000 +0200
+++ linux-2.6/arch/frv/kernel/ptrace.c	2005-09-21 11:39:33.000000000 +0200
@@ -106,7 +106,7 @@
 	child->thread.frame0->__status |= REG__STATUS_STEP;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	unsigned long tmp;
Index: linux-2.6/arch/h8300/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/h8300/kernel/ptrace.c	2005-09-18 13:46:48.000000000 +0200
+++ linux-2.6/arch/h8300/kernel/ptrace.c	2005-09-21 11:39:37.000000000 +0200
@@ -57,7 +57,7 @@
 	h8300_disable_trace(child);
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	int ret;
Index: linux-2.6/arch/i386/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/ptrace.c	2005-09-18 13:46:48.000000000 +0200
+++ linux-2.6/arch/i386/kernel/ptrace.c	2005-09-21 11:39:41.000000000 +0200
@@ -354,7 +354,7 @@
 	return 0;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	struct user * dummy = NULL;
Index: linux-2.6/arch/ia64/ia32/sys_ia32.c
===================================================================
--- linux-2.6.orig/arch/ia64/ia32/sys_ia32.c	2005-09-18 13:46:49.000000000 +0200
+++ linux-2.6/arch/ia64/ia32/sys_ia32.c	2005-09-21 11:39:00.000000000 +0200
@@ -36,6 +36,7 @@
 #include <linux/uio.h>
 #include <linux/nfs_fs.h>
 #include <linux/quota.h>
+#include <linux/syscalls.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/cache.h>
Index: linux-2.6/arch/m32r/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/ptrace.c	2005-09-18 13:46:49.000000000 +0200
+++ linux-2.6/arch/m32r/kernel/ptrace.c	2005-09-21 11:39:49.000000000 +0200
@@ -756,7 +756,7 @@
 	return ret;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	int ret;
Index: linux-2.6/arch/m68k/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/ptrace.c	2005-09-18 13:46:50.000000000 +0200
+++ linux-2.6/arch/m68k/kernel/ptrace.c	2005-09-21 11:39:54.000000000 +0200
@@ -121,7 +121,7 @@
 	child->thread.work.syscall_trace = 0;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	unsigned long tmp;
Index: linux-2.6/arch/m68knommu/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/m68knommu/kernel/ptrace.c	2005-09-18 13:46:50.000000000 +0200
+++ linux-2.6/arch/m68knommu/kernel/ptrace.c	2005-09-21 11:39:57.000000000 +0200
@@ -101,7 +101,7 @@
 	put_reg(child, PT_SR, tmp);
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	int ret;
Index: linux-2.6/arch/mips/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/ptrace.c	2005-09-18 13:46:51.000000000 +0200
+++ linux-2.6/arch/mips/kernel/ptrace.c	2005-09-21 11:40:01.000000000 +0200
@@ -47,7 +47,7 @@
 	/* Nothing to do.. */
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	int ret;
Index: linux-2.6/arch/ppc/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/ptrace.c	2005-09-18 13:46:53.000000000 +0200
+++ linux-2.6/arch/ppc/kernel/ptrace.c	2005-09-21 11:40:10.000000000 +0200
@@ -240,7 +240,7 @@
 	clear_single_step(child);
 }
 
-int sys_ptrace(long request, long pid, long addr, long data)
+long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	int ret = -EPERM;
Index: linux-2.6/arch/ppc64/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/ptrace.c	2005-09-18 13:46:55.000000000 +0200
+++ linux-2.6/arch/ppc64/kernel/ptrace.c	2005-09-21 11:40:16.000000000 +0200
@@ -53,7 +53,7 @@
 	clear_single_step(child);
 }
 
-int sys_ptrace(long request, long pid, long addr, long data)
+long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	int ret = -EPERM;
Index: linux-2.6/arch/sh/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/ptrace.c	2005-09-18 13:46:56.000000000 +0200
+++ linux-2.6/arch/sh/kernel/ptrace.c	2005-09-21 11:40:23.000000000 +0200
@@ -80,7 +80,7 @@
 	/* nothing to do.. */
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	struct user * dummy = NULL;
Index: linux-2.6/arch/sh64/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/sh64/kernel/ptrace.c	2005-09-18 13:46:57.000000000 +0200
+++ linux-2.6/arch/sh64/kernel/ptrace.c	2005-09-21 11:40:30.000000000 +0200
@@ -121,7 +121,7 @@
 	return 0;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	extern void poke_real_address_q(unsigned long long addr, unsigned long long data);
Index: linux-2.6/arch/v850/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/v850/kernel/ptrace.c	2005-09-18 13:46:59.000000000 +0200
+++ linux-2.6/arch/v850/kernel/ptrace.c	2005-09-21 11:40:40.000000000 +0200
@@ -113,7 +113,7 @@
 	return 1;
 }
 
-int sys_ptrace(long request, long pid, long addr, long data)
+long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	int rval;
Index: linux-2.6/arch/xtensa/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/xtensa/kernel/ptrace.c	2005-09-18 13:47:00.000000000 +0200
+++ linux-2.6/arch/xtensa/kernel/ptrace.c	2005-09-21 11:40:46.000000000 +0200
@@ -45,7 +45,7 @@
 	/* Nothing to do.. */
 }
 
-int sys_ptrace(long request, long pid, long addr, long data)
+long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	int ret = -EPERM;
Index: linux-2.6/include/asm-arm/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-arm/unistd.h	2005-09-18 13:47:35.000000000 +0200
+++ linux-2.6/include/asm-arm/unistd.h	2005-09-21 11:34:34.000000000 +0200
@@ -544,7 +544,6 @@
 asmlinkage int sys_fork(struct pt_regs *regs);
 asmlinkage int sys_vfork(struct pt_regs *regs);
 asmlinkage int sys_pipe(unsigned long *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-arm26/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-arm26/unistd.h	2005-09-18 13:47:35.000000000 +0200
+++ linux-2.6/include/asm-arm26/unistd.h	2005-09-21 11:34:50.000000000 +0200
@@ -480,7 +480,6 @@
 asmlinkage int sys_fork(struct pt_regs *regs);
 asmlinkage int sys_vfork(struct pt_regs *regs);
 asmlinkage int sys_pipe(unsigned long *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-cris/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-cris/unistd.h	2005-09-18 13:47:35.000000000 +0200
+++ linux-2.6/include/asm-cris/unistd.h	2005-09-21 11:34:54.000000000 +0200
@@ -367,7 +367,6 @@
 asmlinkage int sys_vfork(long r10, long r11, long r12, long r13,
 			long mof, long srp, struct pt_regs *regs);
 asmlinkage int sys_pipe(unsigned long __user *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-h8300/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-h8300/unistd.h	2005-09-18 13:47:35.000000000 +0200
+++ linux-2.6/include/asm-h8300/unistd.h	2005-09-21 11:34:58.000000000 +0200
@@ -528,7 +528,6 @@
 asmlinkage int sys_execve(char *name, char **argv, char **envp,
 			int dummy, ...);
 asmlinkage int sys_pipe(unsigned long *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-i386/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-i386/unistd.h	2005-09-18 13:47:35.000000000 +0200
+++ linux-2.6/include/asm-i386/unistd.h	2005-09-21 11:35:01.000000000 +0200
@@ -448,7 +448,6 @@
 asmlinkage int sys_fork(struct pt_regs regs);
 asmlinkage int sys_vfork(struct pt_regs regs);
 asmlinkage int sys_pipe(unsigned long __user *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 asmlinkage long sys_iopl(unsigned long unused);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
Index: linux-2.6/include/asm-ia64/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/unistd.h	2005-09-18 13:47:36.000000000 +0200
+++ linux-2.6/include/asm-ia64/unistd.h	2005-09-21 11:35:12.000000000 +0200
@@ -383,8 +383,6 @@
 long sys_execve(char __user *filename, char __user * __user *argv,
 			   char __user * __user *envp, struct pt_regs *regs);
 asmlinkage long sys_pipe(void);
-asmlinkage long sys_ptrace(long request, pid_t pid,
-			   unsigned long addr, unsigned long data);
 asmlinkage long sys_rt_sigaction(int sig,
 				 const struct sigaction __user *act,
 				 struct sigaction __user *oact,
Index: linux-2.6/include/asm-m32r/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-m32r/unistd.h	2005-09-18 13:47:36.000000000 +0200
+++ linux-2.6/include/asm-m32r/unistd.h	2005-09-21 11:35:07.000000000 +0200
@@ -452,7 +452,6 @@
 asmlinkage int sys_fork(struct pt_regs regs);
 asmlinkage int sys_vfork(struct pt_regs regs);
 asmlinkage int sys_pipe(unsigned long __user *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				 const struct sigaction __user *act,
Index: linux-2.6/include/asm-m68k/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/unistd.h	2005-09-18 13:47:36.000000000 +0200
+++ linux-2.6/include/asm-m68k/unistd.h	2005-09-21 11:35:17.000000000 +0200
@@ -444,7 +444,6 @@
 			unsigned long fd, unsigned long pgoff);
 asmlinkage int sys_execve(char *name, char **argv, char **envp);
 asmlinkage int sys_pipe(unsigned long *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct pt_regs;
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
Index: linux-2.6/include/asm-m68knommu/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-m68knommu/unistd.h	2005-09-18 13:47:38.000000000 +0200
+++ linux-2.6/include/asm-m68knommu/unistd.h	2005-09-21 11:35:19.000000000 +0200
@@ -504,7 +504,6 @@
 			unsigned long fd, unsigned long pgoff);
 asmlinkage int sys_execve(char *name, char **argv, char **envp);
 asmlinkage int sys_pipe(unsigned long *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct pt_regs;
 int sys_request_irq(unsigned int,
 			irqreturn_t (*)(int, void *, struct pt_regs *),
Index: linux-2.6/include/asm-mips/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-mips/unistd.h	2005-09-18 13:47:39.000000000 +0200
+++ linux-2.6/include/asm-mips/unistd.h	2005-09-21 11:35:21.000000000 +0200
@@ -1164,7 +1164,6 @@
 			unsigned long fd, unsigned long pgoff);
 asmlinkage int sys_execve(nabi_no_regargs struct pt_regs regs);
 asmlinkage int sys_pipe(nabi_no_regargs struct pt_regs regs);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-ppc/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/unistd.h	2005-09-18 13:47:40.000000000 +0200
+++ linux-2.6/include/asm-ppc/unistd.h	2005-09-21 11:35:26.000000000 +0200
@@ -469,7 +469,6 @@
 int sys_vfork(int p1, int p2, int p3, int p4, int p5, int p6,
 		struct pt_regs *regs);
 int sys_pipe(int __user *fildes);
-int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 long sys_rt_sigaction(int sig,
 		      const struct sigaction __user *act,
Index: linux-2.6/include/asm-ppc64/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-ppc64/unistd.h	2005-09-18 13:47:41.000000000 +0200
+++ linux-2.6/include/asm-ppc64/unistd.h	2005-09-21 11:35:29.000000000 +0200
@@ -467,7 +467,6 @@
 		unsigned long p4, unsigned long p5, unsigned long p6,
 		struct pt_regs *regs);
 int sys_pipe(int __user *fildes);
-int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 long sys_rt_sigaction(int sig, const struct sigaction __user *act,
 		      struct sigaction __user *oact, size_t sigsetsize);
Index: linux-2.6/include/asm-s390/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-s390/unistd.h	2005-09-18 13:47:41.000000000 +0200
+++ linux-2.6/include/asm-s390/unistd.h	2005-09-21 11:35:31.000000000 +0200
@@ -590,7 +590,6 @@
 asmlinkage long sys_fork(struct pt_regs regs);
 asmlinkage long sys_vfork(struct pt_regs regs);
 asmlinkage long sys_pipe(unsigned long __user *fildes);
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-sh/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-sh/unistd.h	2005-09-18 13:47:41.000000000 +0200
+++ linux-2.6/include/asm-sh/unistd.h	2005-09-21 11:35:33.000000000 +0200
@@ -503,7 +503,6 @@
 asmlinkage int sys_pipe(unsigned long r4, unsigned long r5,
 			unsigned long r6, unsigned long r7,
 			struct pt_regs regs);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 asmlinkage ssize_t sys_pread_wrapper(unsigned int fd, char *buf,
 				size_t count, long dummy, loff_t pos);
 asmlinkage ssize_t sys_pwrite_wrapper(unsigned int fd, const char *buf,
Index: linux-2.6/include/asm-v850/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-v850/unistd.h	2005-09-18 13:47:42.000000000 +0200
+++ linux-2.6/include/asm-v850/unistd.h	2005-09-21 11:35:41.000000000 +0200
@@ -452,7 +452,6 @@
 struct pt_regs;
 int sys_execve (char *name, char **argv, char **envp, struct pt_regs *regs);
 int sys_pipe (int *fildes);
-int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-x86_64/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/unistd.h	2005-09-18 13:47:42.000000000 +0200
+++ linux-2.6/include/asm-x86_64/unistd.h	2005-09-21 11:35:46.000000000 +0200
@@ -780,8 +780,6 @@
 #include <linux/types.h>
 #include <asm/ptrace.h>
 
-asmlinkage long sys_ptrace(long request, long pid,
-				unsigned long addr, long data);
 asmlinkage long sys_iopl(unsigned int level, struct pt_regs *regs);
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on);
 struct sigaction;
Index: linux-2.6/include/linux/syscalls.h
===================================================================
--- linux-2.6.orig/include/linux/syscalls.h	2005-09-18 13:47:44.000000000 +0200
+++ linux-2.6/include/linux/syscalls.h	2005-09-21 11:35:53.000000000 +0200
@@ -491,6 +491,7 @@
 asmlinkage long sys_syslog(int type, char __user *buf, int len);
 asmlinkage long sys_uselib(const char __user *library);
 asmlinkage long sys_ni_syscall(void);
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data);
 
 asmlinkage long sys_add_key(const char __user *_type,
 			    const char __user *_description,
