Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVCHXc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVCHXc2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVCHX2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:28:52 -0500
Received: from waste.org ([216.27.176.166]:42219 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262162AbVCHXPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:15:51 -0500
Date: Tue, 8 Mar 2005 15:15:42 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] make cond_syscall look right
Message-ID: <20050308231542.GS3163@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current cond_syscall #defines add a semicolon on the end, and then
folks leave the semicolons off in kernel/sys_ni.c, which confuses
editors that are language-aware and is just generally bad style. This
sweeps all the users and makes sys_ni.c look like normal C code.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: nosys/include/asm-ppc/unistd.h
===================================================================
--- nosys.orig/include/asm-ppc/unistd.h	2005-03-02 18:30:29.000000000 -0800
+++ nosys/include/asm-ppc/unistd.h	2005-03-08 15:03:39.000000000 -0800
@@ -468,7 +468,7 @@ long sys_rt_sigaction(int sig,
  * but it doesn't work on all toolchains, so we just do it by hand
  */
 #ifndef cond_syscall
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 #endif
 
 #endif /* __KERNEL__ */
Index: nosys/include/asm-sparc64/unistd.h
===================================================================
--- nosys.orig/include/asm-sparc64/unistd.h	2005-03-02 18:30:29.000000000 -0800
+++ nosys/include/asm-sparc64/unistd.h	2005-03-08 15:05:01.000000000 -0800
@@ -509,6 +509,6 @@ asmlinkage long sys_rt_sigaction(int sig
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 
 #endif /* _SPARC64_UNISTD_H */
Index: nosys/kernel/sys_ni.c
===================================================================
--- nosys.orig/kernel/sys_ni.c	2005-03-02 22:51:07.000000000 -0800
+++ nosys/kernel/sys_ni.c	2005-03-08 15:01:13.000000000 -0800
@@ -12,74 +12,74 @@ asmlinkage long sys_ni_syscall(void)
 	return -ENOSYS;
 }
 
-cond_syscall(sys_nfsservctl)
-cond_syscall(sys_quotactl)
-cond_syscall(sys_acct)
-cond_syscall(sys_lookup_dcookie)
-cond_syscall(sys_swapon)
-cond_syscall(sys_swapoff)
-cond_syscall(sys_init_module)
-cond_syscall(sys_delete_module)
-cond_syscall(sys_socketpair)
-cond_syscall(sys_bind)
-cond_syscall(sys_listen)
-cond_syscall(sys_accept)
-cond_syscall(sys_connect)
-cond_syscall(sys_getsockname)
-cond_syscall(sys_getpeername)
-cond_syscall(sys_sendto)
-cond_syscall(sys_send)
-cond_syscall(sys_recvfrom)
-cond_syscall(sys_recv)
-cond_syscall(sys_socket)
-cond_syscall(sys_setsockopt)
-cond_syscall(sys_getsockopt)
-cond_syscall(sys_shutdown)
-cond_syscall(sys_sendmsg)
-cond_syscall(sys_recvmsg)
-cond_syscall(sys_socketcall)
-cond_syscall(sys_futex)
-cond_syscall(compat_sys_futex)
-cond_syscall(sys_epoll_create)
-cond_syscall(sys_epoll_ctl)
-cond_syscall(sys_epoll_wait)
-cond_syscall(sys_semget)
-cond_syscall(sys_semop)
-cond_syscall(sys_semtimedop)
-cond_syscall(sys_semctl)
-cond_syscall(sys_msgget)
-cond_syscall(sys_msgsnd)
-cond_syscall(sys_msgrcv)
-cond_syscall(sys_msgctl)
-cond_syscall(sys_shmget)
-cond_syscall(sys_shmdt)
-cond_syscall(sys_shmctl)
-cond_syscall(sys_mq_open)
-cond_syscall(sys_mq_unlink)
-cond_syscall(sys_mq_timedsend)
-cond_syscall(sys_mq_timedreceive)
-cond_syscall(sys_mq_notify)
-cond_syscall(sys_mq_getsetattr)
-cond_syscall(compat_sys_mq_open)
-cond_syscall(compat_sys_mq_timedsend)
-cond_syscall(compat_sys_mq_timedreceive)
-cond_syscall(compat_sys_mq_notify)
-cond_syscall(compat_sys_mq_getsetattr)
-cond_syscall(sys_mbind)
-cond_syscall(sys_get_mempolicy)
-cond_syscall(sys_set_mempolicy)
-cond_syscall(compat_sys_mbind)
-cond_syscall(compat_sys_get_mempolicy)
-cond_syscall(compat_sys_set_mempolicy)
-cond_syscall(sys_add_key)
-cond_syscall(sys_request_key)
-cond_syscall(sys_keyctl)
-cond_syscall(compat_sys_keyctl)
-cond_syscall(compat_sys_socketcall)
+cond_syscall(sys_nfsservctl);
+cond_syscall(sys_quotactl);
+cond_syscall(sys_acct);
+cond_syscall(sys_lookup_dcookie);
+cond_syscall(sys_swapon);
+cond_syscall(sys_swapoff);
+cond_syscall(sys_init_module);
+cond_syscall(sys_delete_module);
+cond_syscall(sys_socketpair);
+cond_syscall(sys_bind);
+cond_syscall(sys_listen);
+cond_syscall(sys_accept);
+cond_syscall(sys_connect);
+cond_syscall(sys_getsockname);
+cond_syscall(sys_getpeername);
+cond_syscall(sys_sendto);
+cond_syscall(sys_send);
+cond_syscall(sys_recvfrom);
+cond_syscall(sys_recv);
+cond_syscall(sys_socket);
+cond_syscall(sys_setsockopt);
+cond_syscall(sys_getsockopt);
+cond_syscall(sys_shutdown);
+cond_syscall(sys_sendmsg);
+cond_syscall(sys_recvmsg);
+cond_syscall(sys_socketcall);
+cond_syscall(sys_futex);
+cond_syscall(compat_sys_futex);
+cond_syscall(sys_epoll_create);
+cond_syscall(sys_epoll_ctl);
+cond_syscall(sys_epoll_wait);
+cond_syscall(sys_semget);
+cond_syscall(sys_semop);
+cond_syscall(sys_semtimedop);
+cond_syscall(sys_semctl);
+cond_syscall(sys_msgget);
+cond_syscall(sys_msgsnd);
+cond_syscall(sys_msgrcv);
+cond_syscall(sys_msgctl);
+cond_syscall(sys_shmget);
+cond_syscall(sys_shmdt);
+cond_syscall(sys_shmctl);
+cond_syscall(sys_mq_open);
+cond_syscall(sys_mq_unlink);
+cond_syscall(sys_mq_timedsend);
+cond_syscall(sys_mq_timedreceive);
+cond_syscall(sys_mq_notify);
+cond_syscall(sys_mq_getsetattr);
+cond_syscall(compat_sys_mq_open);
+cond_syscall(compat_sys_mq_timedsend);
+cond_syscall(compat_sys_mq_timedreceive);
+cond_syscall(compat_sys_mq_notify);
+cond_syscall(compat_sys_mq_getsetattr);
+cond_syscall(sys_mbind);
+cond_syscall(sys_get_mempolicy);
+cond_syscall(sys_set_mempolicy);
+cond_syscall(compat_sys_mbind);
+cond_syscall(compat_sys_get_mempolicy);
+cond_syscall(compat_sys_set_mempolicy);
+cond_syscall(sys_add_key);
+cond_syscall(sys_request_key);
+cond_syscall(sys_keyctl);
+cond_syscall(compat_sys_keyctl);
+cond_syscall(compat_sys_socketcall);
 
 /* arch-specific weak syscall entries */
-cond_syscall(sys_pciconfig_read)
-cond_syscall(sys_pciconfig_write)
-cond_syscall(sys_pciconfig_iobase)
-cond_syscall(sys32_ipc)
-cond_syscall(sys32_sysctl)
+cond_syscall(sys_pciconfig_read);
+cond_syscall(sys_pciconfig_write);
+cond_syscall(sys_pciconfig_iobase);
+cond_syscall(sys32_ipc);
+cond_syscall(sys32_sysctl);
Index: nosys/include/asm-sh/unistd.h
===================================================================
--- nosys.orig/include/asm-sh/unistd.h	2004-12-24 13:35:25.000000000 -0800
+++ nosys/include/asm-sh/unistd.h	2005-03-08 15:00:47.000000000 -0800
@@ -517,7 +517,7 @@ asmlinkage long sys_rt_sigaction(int sig
  * but it doesn't work on all toolchains, so we just do it by hand
  */
 #ifndef cond_syscall
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 #endif
 
 #endif /* __ASM_SH_UNISTD_H */
Index: nosys/include/asm-m68k/unistd.h
===================================================================
--- nosys.orig/include/asm-m68k/unistd.h	2004-12-24 13:34:45.000000000 -0800
+++ nosys/include/asm-m68k/unistd.h	2005-03-08 15:00:43.000000000 -0800
@@ -460,6 +460,6 @@ asmlinkage long sys_rt_sigaction(int sig
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 
 #endif /* _ASM_M68K_UNISTD_H_ */
Index: nosys/include/asm-frv/unistd.h
===================================================================
--- nosys.orig/include/asm-frv/unistd.h	2005-03-02 18:30:27.000000000 -0800
+++ nosys/include/asm-frv/unistd.h	2005-03-08 15:00:35.000000000 -0800
@@ -495,7 +495,7 @@ static inline pid_t wait(int * wait_stat
  * but it doesn't work on all toolchains, so we just do it by hand
  */
 #ifndef cond_syscall
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 #endif
 
 #endif /* _ASM_UNISTD_H_ */
Index: nosys/include/asm-sh64/unistd.h
===================================================================
--- nosys.orig/include/asm-sh64/unistd.h	2004-12-24 13:33:48.000000000 -0800
+++ nosys/include/asm-sh64/unistd.h	2005-03-08 15:00:31.000000000 -0800
@@ -549,7 +549,7 @@ static inline pid_t wait(int * wait_stat
  * but it doesn't work on all toolchains, so we just do it by hand
  */
 #ifndef cond_syscall
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 #endif
 
 #endif /* __ASM_SH64_UNISTD_H */
Index: nosys/include/asm-m68knommu/unistd.h
===================================================================
--- nosys.orig/include/asm-m68knommu/unistd.h	2004-12-24 13:34:46.000000000 -0800
+++ nosys/include/asm-m68knommu/unistd.h	2005-03-08 15:00:27.000000000 -0800
@@ -524,6 +524,6 @@ asmlinkage long sys_rt_sigaction(int sig
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 
 #endif /* _ASM_M68K_UNISTD_H_ */
Index: nosys/include/asm-i386/unistd.h
===================================================================
--- nosys.orig/include/asm-i386/unistd.h	2004-12-24 13:35:01.000000000 -0800
+++ nosys/include/asm-i386/unistd.h	2005-03-08 15:00:23.000000000 -0800
@@ -460,7 +460,7 @@ asmlinkage long sys_rt_sigaction(int sig
  * but it doesn't work on all toolchains, so we just do it by hand
  */
 #ifndef cond_syscall
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 #endif
 
 #endif /* _ASM_I386_UNISTD_H_ */
Index: nosys/include/asm/unistd.h
===================================================================
--- nosys.orig/include/asm/unistd.h	2005-03-08 14:56:42.000000000 -0800
+++ nosys/include/asm/unistd.h	2005-03-08 15:00:23.000000000 -0800
@@ -460,7 +460,7 @@ asmlinkage long sys_rt_sigaction(int sig
  * but it doesn't work on all toolchains, so we just do it by hand
  */
 #ifndef cond_syscall
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 #endif
 
 #endif /* _ASM_I386_UNISTD_H_ */
Index: nosys/include/asm-ppc64/unistd.h
===================================================================
--- nosys.orig/include/asm-ppc64/unistd.h	2005-03-02 18:30:29.000000000 -0800
+++ nosys/include/asm-ppc64/unistd.h	2005-03-08 15:00:19.000000000 -0800
@@ -472,7 +472,7 @@ long sys_rt_sigaction(int sig, const str
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t." #x "\n\t.set\t." #x ",.sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t." #x "\n\t.set\t." #x ",.sys_ni_syscall")
 
 #endif		/* __KERNEL__ */
 
Index: nosys/include/asm-mips/unistd.h
===================================================================
--- nosys.orig/include/asm-mips/unistd.h	2005-03-02 18:30:29.000000000 -0800
+++ nosys/include/asm-mips/unistd.h	2005-03-08 15:00:14.000000000 -0800
@@ -1180,6 +1180,6 @@ asmlinkage long sys_rt_sigaction(int sig
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n" #x "\t=\tsys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n" #x "\t=\tsys_ni_syscall")
 
 #endif /* _ASM_UNISTD_H */
Index: nosys/include/asm-x86_64/unistd.h
===================================================================
--- nosys.orig/include/asm-x86_64/unistd.h	2005-03-02 18:30:30.000000000 -0800
+++ nosys/include/asm-x86_64/unistd.h	2005-03-08 15:00:11.000000000 -0800
@@ -792,6 +792,6 @@ asmlinkage long sys_rt_sigaction(int sig
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 
 #endif
Index: nosys/include/asm-sparc/unistd.h
===================================================================
--- nosys.orig/include/asm-sparc/unistd.h	2005-03-02 18:30:29.000000000 -0800
+++ nosys/include/asm-sparc/unistd.h	2005-03-08 15:00:07.000000000 -0800
@@ -513,6 +513,6 @@ asmlinkage long sys_rt_sigaction(int sig
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 
 #endif /* _SPARC_UNISTD_H */
Index: nosys/include/asm-m32r/unistd.h
===================================================================
--- nosys.orig/include/asm-m32r/unistd.h	2005-03-02 18:30:28.000000000 -0800
+++ nosys/include/asm-m32r/unistd.h	2005-03-08 15:00:03.000000000 -0800
@@ -468,7 +468,7 @@ asmlinkage long sys_rt_sigaction(int sig
  * but it doesn't work on all toolchains, so we just do it by hand
  */
 #ifndef cond_syscall
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 #endif
 
 #endif /* _ASM_M32R_UNISTD_H */
Index: nosys/include/asm-parisc/unistd.h
===================================================================
--- nosys.orig/include/asm-parisc/unistd.h	2005-03-02 18:30:29.000000000 -0800
+++ nosys/include/asm-parisc/unistd.h	2005-03-08 14:59:58.000000000 -0800
@@ -1024,6 +1024,6 @@ asmlinkage long sys_rt_sigaction(int sig
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 
 #endif /* _ASM_PARISC_UNISTD_H_ */
Index: nosys/include/asm-ia64/unistd.h
===================================================================
--- nosys.orig/include/asm-ia64/unistd.h	2005-03-02 18:30:28.000000000 -0800
+++ nosys/include/asm-ia64/unistd.h	2005-03-08 14:59:48.000000000 -0800
@@ -392,7 +392,7 @@ asmlinkage long sys_rt_sigaction(int sig
  * proper prototype, but we can't use __typeof__ either, because not all cond_syscall()
  * declarations have prototypes at the moment.
  */
-#define cond_syscall(x) asmlinkage long x (void) __attribute__((weak,alias("sys_ni_syscall")));
+#define cond_syscall(x) asmlinkage long x (void) __attribute__((weak,alias("sys_ni_syscall")))
 
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
Index: nosys/include/asm-cris/unistd.h
===================================================================
--- nosys.orig/include/asm-cris/unistd.h	2004-12-24 13:35:28.000000000 -0800
+++ nosys/include/asm-cris/unistd.h	2005-03-08 14:59:43.000000000 -0800
@@ -387,6 +387,6 @@ extern inline _syscall3(pid_t,waitpid,pi
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 
 #endif /* _ASM_CRIS_UNISTD_H_ */
Index: nosys/include/asm-arm26/unistd.h
===================================================================
--- nosys.orig/include/asm-arm26/unistd.h	2005-03-02 18:30:27.000000000 -0800
+++ nosys/include/asm-arm26/unistd.h	2005-03-08 14:59:39.000000000 -0800
@@ -495,6 +495,6 @@ asmlinkage long sys_rt_sigaction(int sig
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 
 #endif /* __ASM_ARM_UNISTD_H */
Index: nosys/include/asm-alpha/unistd.h
===================================================================
--- nosys.orig/include/asm-alpha/unistd.h	2004-12-24 13:34:32.000000000 -0800
+++ nosys/include/asm-alpha/unistd.h	2005-03-08 14:59:35.000000000 -0800
@@ -651,6 +651,6 @@ asmlinkage long sys_rt_sigaction(int sig
    have declarations.  If we use no prototype, then we get warnings from
    -Wstrict-prototypes.  Ho hum.  */
 
-#define cond_syscall(x)  asm(".weak\t" #x "\n" #x " = sys_ni_syscall");
+#define cond_syscall(x)  asm(".weak\t" #x "\n" #x " = sys_ni_syscall")
 
 #endif /* _ALPHA_UNISTD_H */
Index: nosys/include/asm-v850/unistd.h
===================================================================
--- nosys.orig/include/asm-v850/unistd.h	2004-12-24 13:35:39.000000000 -0800
+++ nosys/include/asm-v850/unistd.h	2005-03-08 14:59:21.000000000 -0800
@@ -466,7 +466,7 @@ asmlinkage long sys_rt_sigaction(int sig
  */
 #define cond_syscall(name)						      \
   asm (".weak\t" C_SYMBOL_STRING(name) ";"				      \
-       ".set\t" C_SYMBOL_STRING(name) "," C_SYMBOL_STRING(sys_ni_syscall));
+       ".set\t" C_SYMBOL_STRING(name) "," C_SYMBOL_STRING(sys_ni_syscall))
 #if 0
 /* This doesn't work if there's a function prototype for NAME visible,
    because the argument types probably won't match.  */
Index: nosys/include/asm-arm/unistd.h
===================================================================
--- nosys.orig/include/asm-arm/unistd.h	2005-03-02 18:30:27.000000000 -0800
+++ nosys/include/asm-arm/unistd.h	2005-03-08 14:58:59.000000000 -0800
@@ -509,6 +509,6 @@ asmlinkage long sys_rt_sigaction(int sig
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 
 #endif /* __ASM_ARM_UNISTD_H */
Index: nosys/include/asm-s390/unistd.h
===================================================================
--- nosys.orig/include/asm-s390/unistd.h	2005-03-02 18:30:29.000000000 -0800
+++ nosys/include/asm-s390/unistd.h	2005-03-08 14:57:08.000000000 -0800
@@ -597,6 +597,6 @@ asmlinkage long sys_rt_sigaction(int sig
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 
 #endif /* _ASM_S390_UNISTD_H_ */

-- 
Mathematics is the supreme nostalgia of our time.
