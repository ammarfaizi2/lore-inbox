Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbTAPDiy>; Wed, 15 Jan 2003 22:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbTAPDiy>; Wed, 15 Jan 2003 22:38:54 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:62168 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266996AbTAPDiv>;
	Wed, 15 Jan 2003 22:38:51 -0500
Date: Thu, 16 Jan 2003 14:47:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_sigpending and compat_sys_sigprocmask
 ia64
Message-Id: <20030116144741.62ec27b7.sfr@canb.auug.org.au>
In-Reply-To: <20030116144129.2251138d.sfr@canb.auug.org.au>
References: <20030116144129.2251138d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Here is the ia64 part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.5/arch/ia64/ia32/ia32_entry.S 2.5.58-32bit.6/arch/ia64/ia32/ia32_entry.S
--- 2.5.58-32bit.5/arch/ia64/ia32/ia32_entry.S	2003-01-13 11:07:06.000000000 +1100
+++ 2.5.58-32bit.6/arch/ia64/ia32/ia32_entry.S	2003-01-16 01:39:59.000000000 +1100
@@ -264,7 +264,7 @@
 	data8 sys_setreuid	/* 16-bit version */	  /* 70 */
 	data8 sys_setregid	/* 16-bit version */
 	data8 sys32_sigsuspend
-	data8 sys32_sigpending
+	data8 compat_sys_sigpending
 	data8 sys_sethostname
 	data8 sys32_setrlimit	  /* 75 */
 	data8 sys32_old_getrlimit
@@ -317,7 +317,7 @@
 	data8 sys32_modify_ldt
 	data8 sys32_ni_syscall	/* adjtimex */
 	data8 sys32_mprotect	  /* 125 */
-	data8 sys32_sigprocmask
+	data8 compat_sys_sigprocmask
 	data8 sys32_ni_syscall	/* create_module */
 	data8 sys32_ni_syscall	/* init_module */
 	data8 sys32_ni_syscall	/* delete_module */
diff -ruN 2.5.58-32bit.5/arch/ia64/ia32/ia32_signal.c 2.5.58-32bit.6/arch/ia64/ia32/ia32_signal.c
--- 2.5.58-32bit.5/arch/ia64/ia32/ia32_signal.c	2003-01-15 16:03:42.000000000 +1100
+++ 2.5.58-32bit.6/arch/ia64/ia32/ia32_signal.c	2003-01-16 01:39:47.000000000 +1100
@@ -587,12 +587,6 @@
 }
 
 asmlinkage long
-sys32_sigprocmask (int how, unsigned int *set, unsigned int *oset)
-{
-	return sys32_rt_sigprocmask(how, (compat_sigset_t *) set, (compat_sigset_t *) oset, sizeof(*set));
-}
-
-asmlinkage long
 sys32_rt_sigtimedwait (compat_sigset_t *uthese, siginfo_t32 *uinfo,
 		struct compat_timespec *uts, unsigned int sigsetsize)
 {
diff -ruN 2.5.58-32bit.5/arch/ia64/ia32/sys_ia32.c 2.5.58-32bit.6/arch/ia64/ia32/sys_ia32.c
--- 2.5.58-32bit.5/arch/ia64/ia32/sys_ia32.c	2003-01-13 11:07:06.000000000 +1100
+++ 2.5.58-32bit.6/arch/ia64/ia32/sys_ia32.c	2003-01-16 00:30:16.000000000 +1100
@@ -3420,12 +3420,6 @@
 	return ret;
 }
 
-asmlinkage long
-sys32_sigpending (unsigned int *set)
-{
-	return do_sigpending(set, sizeof(*set));
-}
-
 struct sysinfo32 {
 	s32 uptime;
 	u32 loads[3];
