Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261728AbSJNOgW>; Mon, 14 Oct 2002 10:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbSJNOgV>; Mon, 14 Oct 2002 10:36:21 -0400
Received: from SMTP5.andrew.cmu.edu ([128.2.10.85]:47823 "EHLO
	smtp5.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S261728AbSJNOgK>; Mon, 14 Oct 2002 10:36:10 -0400
From: <shadow@andrew.cmu.edu>
Date: Mon, 14 Oct 2002 10:41:59 -0400
To: linux-kernel@vger.kernel.org
Subject: PATCH: AFS system call registration function take two
Message-ID: <3DAAD7B7.mailGKO1UAB56@johnstown.andrew.cmu.edu>
User-Agent: nail 9.30 2/20/02
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/alpha/kernel/entry.S linux/arch/alpha/kernel/entry.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/alpha/kernel/entry.S	Fri Aug  2 20:39:42 2002
+++ linux/arch/alpha/kernel/entry.S	Sat Oct 12 13:47:24 2002
@@ -1110,7 +1110,7 @@
 	.quad sys_sched_get_priority_max	/* 335 */
 	.quad sys_sched_get_priority_min
 	.quad sys_sched_rr_get_interval
-	.quad sys_ni_syscall			/* sys_afs_syscall */
+	.quad sys_afs
 	.quad sys_newuname
 	.quad sys_nanosleep			/* 340 */
 	.quad sys_mremap
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/arm/kernel/calls.S linux/arch/arm/kernel/calls.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/arm/kernel/calls.S	Fri Aug  2 20:39:42 2002
+++ linux/arch/arm/kernel/calls.S	Sat Oct 12 13:50:20 2002
@@ -151,7 +151,7 @@
 		.long	SYMBOL_NAME(sys_bdflush)
 /* 135 */	.long	SYMBOL_NAME(sys_sysfs)
 		.long	SYMBOL_NAME(sys_personality)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* .long	_sys_afs_syscall */
+		.long	SYMBOL_NAME(sys_afs)
 		.long	SYMBOL_NAME(sys_setfsuid16)
 		.long	SYMBOL_NAME(sys_setfsgid16)
 /* 140 */	.long	SYMBOL_NAME(sys_llseek)
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/cris/kernel/entry.S linux/arch/cris/kernel/entry.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/cris/kernel/entry.S	Fri Aug  2 20:39:42 2002
+++ linux/arch/cris/kernel/entry.S	Sat Oct 12 13:53:10 2002
@@ -927,7 +927,7 @@
 	.long SYMBOL_NAME(sys_bdflush)
 	.long SYMBOL_NAME(sys_sysfs)		/* 135 */
 	.long SYMBOL_NAME(sys_personality)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* for afs_syscall */
+	.long SYMBOL_NAME(sys_afs)
 	.long SYMBOL_NAME(sys_setfsuid16)
 	.long SYMBOL_NAME(sys_setfsgid16)
 	.long SYMBOL_NAME(sys_llseek)		/* 140 */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/i386/kernel/entry.S	Fri Aug  2 20:39:42 2002
+++ linux/arch/i386/kernel/entry.S	Sat Oct 12 13:47:04 2002
@@ -533,7 +533,7 @@
 	.long SYMBOL_NAME(sys_bdflush)
 	.long SYMBOL_NAME(sys_sysfs)		/* 135 */
 	.long SYMBOL_NAME(sys_personality)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* for afs_syscall */
+	.long SYMBOL_NAME(sys_afs)
 	.long SYMBOL_NAME(sys_setfsuid16)
 	.long SYMBOL_NAME(sys_setfsgid16)
 	.long SYMBOL_NAME(sys_llseek)		/* 140 */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/ia64/ia32/ia32_entry.S linux/arch/ia64/ia32/ia32_entry.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/ia64/ia32/ia32_entry.S	Fri Aug  2 20:39:42 2002
+++ linux/arch/ia64/ia32/ia32_entry.S	Sat Oct 12 13:50:58 2002
@@ -312,7 +312,7 @@
 	data8 sys32_ni_syscall	/* sys_bdflush */
 	data8 sys_sysfs		/* 135 */
 	data8 sys32_personality
-	data8 sys32_ni_syscall	  /* for afs_syscall */
+	data8 sys_afs
 	data8 sys_setfsuid	/* 16-bit version */
 	data8 sys_setfsgid	/* 16-bit version */
 	data8 sys_llseek	  /* 140 */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/ia64/kernel/entry.S linux/arch/ia64/kernel/entry.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/ia64/kernel/entry.S	Fri Aug  2 20:39:42 2002
+++ linux/arch/ia64/kernel/entry.S	Sat Oct 12 13:51:14 2002
@@ -1057,7 +1057,7 @@
 	data8 sys_bdflush
 	data8 sys_sysfs
 	data8 sys_personality			// 1140
-	data8 ia64_ni_syscall		// sys_afs_syscall
+	data8 sys_afs
 	data8 sys_setfsuid
 	data8 sys_setfsgid
 	data8 sys_getdents
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/m68k/kernel/entry.S linux/arch/m68k/kernel/entry.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/m68k/kernel/entry.S	Fri Aug  2 20:39:43 2002
+++ linux/arch/m68k/kernel/entry.S	Sat Oct 12 13:50:02 2002
@@ -559,7 +559,7 @@
 	.long SYMBOL_NAME(sys_bdflush)
 	.long SYMBOL_NAME(sys_sysfs)		/* 135 */
 	.long SYMBOL_NAME(sys_personality)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* for afs_syscall */
+	.long SYMBOL_NAME(sys_afs)
 	.long SYMBOL_NAME(sys_setfsuid16)
 	.long SYMBOL_NAME(sys_setfsgid16)
 	.long SYMBOL_NAME(sys_llseek)		/* 140 */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/mips/kernel/syscalls.h linux/arch/mips/kernel/syscalls.h
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/mips/kernel/syscalls.h	Fri Aug  2 20:39:43 2002
+++ linux/arch/mips/kernel/syscalls.h	Sat Oct 12 13:48:07 2002
@@ -151,7 +151,7 @@
 SYS(sys_bdflush, 2)
 SYS(sys_sysfs, 3)				/* 4135 */
 SYS(sys_personality, 1)
-SYS(sys_ni_syscall, 0) /* for afs_syscall */
+SYS(sys_afs, 5)
 SYS(sys_setfsuid, 1)
 SYS(sys_setfsgid, 1)
 SYS(sys_llseek, 5)				/* 4140 */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/mips64/kernel/scall_64.S linux/arch/mips64/kernel/scall_64.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/mips64/kernel/scall_64.S	Fri Aug  2 20:39:43 2002
+++ linux/arch/mips64/kernel/scall_64.S	Sat Oct 12 13:52:25 2002
@@ -270,7 +270,7 @@
 	PTR	sys_bdflush
 	PTR	sys_sysfs				/* 5135 */
 	PTR	sys_personality
-	PTR	sys_ni_syscall		/* for afs_syscall */
+	PTR	sys_afs
 	PTR	sys_setfsuid
 	PTR	sys_setfsgid
 	PTR	sys_llseek				/* 5140 */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/mips64/kernel/scall_o32.S linux/arch/mips64/kernel/scall_o32.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/mips64/kernel/scall_o32.S	Fri Aug  2 20:39:43 2002
+++ linux/arch/mips64/kernel/scall_o32.S	Sat Oct 12 13:52:08 2002
@@ -383,7 +383,7 @@
 	sys	sys_bdflush	2
 	sys	sys_sysfs	3			/* 4135 */
 	sys	sys32_personality	1
-	sys	sys_ni_syscall	0 /* for afs_syscall */
+	sys	sys_afs		5 
 	sys	sys_setfsuid	1
 	sys	sys_setfsgid	1
 	sys	sys32_llseek	5			/* 4140 */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/parisc/kernel/syscall.S linux/arch/parisc/kernel/syscall.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/parisc/kernel/syscall.S	Fri Aug  2 20:39:43 2002
+++ linux/arch/parisc/kernel/syscall.S	Sat Oct 12 13:52:57 2002
@@ -469,7 +469,7 @@
 	ENTRY_UHOH(bdflush)
 	ENTRY_SAME(sysfs)		/* 135 */
 	ENTRY_SAME(personality)
-	ENTRY_SAME(ni_syscall)	/* for afs_syscall */
+	ENTRY_SAME(afs)
 	ENTRY_SAME(setfsuid)
 	ENTRY_SAME(setfsgid)
 	/* I think this might work */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/ppc/kernel/misc.S linux/arch/ppc/kernel/misc.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/ppc/kernel/misc.S	Fri Aug  2 20:39:43 2002
+++ linux/arch/ppc/kernel/misc.S	Sat Oct 12 13:45:43 2002
@@ -1085,7 +1085,7 @@
 	.long sys_bdflush
 	.long sys_sysfs		/* 135 */
 	.long sys_personality
-	.long sys_ni_syscall	/* for afs_syscall */
+	.long sys_afs
 	.long sys_setfsuid
 	.long sys_setfsgid
 	.long sys_llseek	/* 140 */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/ppc64/kernel/misc.S linux/arch/ppc64/kernel/misc.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/ppc64/kernel/misc.S	Fri Aug  2 20:39:43 2002
+++ linux/arch/ppc64/kernel/misc.S	Sat Oct 12 13:45:26 2002
@@ -658,7 +658,7 @@
 	.llong .sys32_bdflush
 	.llong .sys32_sysfs		/* 135 */
 	.llong .sys32_personality
-	.llong .sys_ni_syscall	        /* for afs_syscall */
+	.llong .sys_afs
 	.llong .sys_setfsuid
 	.llong .sys_setfsgid
 	.llong .sys_llseek	        /* 140 */
@@ -888,7 +888,7 @@
 	.llong .sys_bdflush
 	.llong .sys_sysfs		/* 135 */
 	.llong .sys_personality
-	.llong .sys_ni_syscall	        /* for afs_syscall */
+	.llong .sys_afs
 	.llong .sys_setfsuid
 	.llong .sys_setfsgid
 	.llong .sys_llseek	        /* 140 */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/s390/kernel/entry.S linux/arch/s390/kernel/entry.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/s390/kernel/entry.S	Fri Aug  2 20:39:43 2002
+++ linux/arch/s390/kernel/entry.S	Sat Oct 12 13:52:40 2002
@@ -471,7 +471,7 @@
         .long  sys_bdflush
         .long  sys_sysfs                 /* 135 */
         .long  sys_personality
-        .long  sys_ni_syscall            /* for afs_syscall */
+        .long  sys_afs
         .long  sys_setfsuid16
         .long  sys_setfsgid16
         .long  sys_llseek                /* 140 */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/s390x/kernel/entry.S linux/arch/s390x/kernel/entry.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/s390x/kernel/entry.S	Fri Aug  2 20:39:43 2002
+++ linux/arch/s390x/kernel/entry.S	Sat Oct 12 13:46:29 2002
@@ -504,7 +504,7 @@
         .long  SYSCALL(sys_bdflush,sys32_bdflush_wrapper)
         .long  SYSCALL(sys_sysfs,sys32_sysfs_wrapper)           /* 135 */
         .long  SYSCALL(sys_personality,sys32_personality_wrapper)
-        .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* for afs_syscall */
+        .long  SYSCALL(sys_afs,sys32_afs_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys32_setfsuid16_wrapper) /* old setfsuid16 syscall */
         .long  SYSCALL(sys_ni_syscall,sys32_setfsgid16_wrapper) /* old setfsgid16 syscall */
         .long  SYSCALL(sys_llseek,sys32_llseek_wrapper)         /* 140 */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/s390x/kernel/wrapper32.S linux/arch/s390x/kernel/wrapper32.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/s390x/kernel/wrapper32.S	Mon Feb 25 14:37:56 2002
+++ linux/arch/s390x/kernel/wrapper32.S	Sat Oct 12 13:55:15 2002
@@ -616,6 +616,15 @@
 	llgfr	%r2,%r2			# unsigned long
 	jg	sys_personality		# branch to system call
 
+	.globl  sys32_afs_wrapper 
+sys32_afs_wrapper:
+	lgfr	%r2,%r2			# long
+	lgfr	%r3,%r3			# long
+	lgfr	%r4,%r4			# long
+	lgfr	%r5,%r5			# long
+	lgfr	%r6,%r6			# long
+	jg	sys_afs			# branch to system call
+
 	.globl  sys32_setfsuid16_wrapper 
 sys32_setfsuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t 
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/arch/sh/kernel/entry.S linux/arch/sh/kernel/entry.S
--- /afs/andrew/system/src/local/x86_l24/015/linux/arch/sh/kernel/entry.S	Fri Aug  2 20:39:43 2002
+++ linux/arch/sh/kernel/entry.S	Sat Oct 12 13:50:33 2002
@@ -1213,7 +1213,7 @@
 	.long SYMBOL_NAME(sys_bdflush)
 	.long SYMBOL_NAME(sys_sysfs)		/* 135 */
 	.long SYMBOL_NAME(sys_personality)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* for afs_syscall */
+	.long SYMBOL_NAME(sys_afs)
 	.long SYMBOL_NAME(sys_setfsuid16)
 	.long SYMBOL_NAME(sys_setfsgid16)
 	.long SYMBOL_NAME(sys_llseek)		/* 140 */
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/fs/filesystems.c linux/fs/filesystems.c
--- /afs/andrew/system/src/local/x86_l24/015/linux/fs/filesystems.c	Fri Aug  2 20:39:45 2002
+++ linux/fs/filesystems.c	Sat Oct 12 13:56:50 2002
@@ -12,6 +12,7 @@
 #include <linux/smp_lock.h>
 #include <linux/kmod.h>
 #include <linux/nfsd/interface.h>
+#include <linux/afs_interface.h>
 
 #if ! defined(CONFIG_NFSD)
 struct nfsd_linkage *nfsd_linkage;
@@ -38,3 +39,24 @@
 EXPORT_SYMBOL(nfsd_linkage);
 
 #endif /* CONFIG_NFSD */
+
+struct afs_linkage *afs_linkage = NULL;
+
+long
+asmlinkage sys_afs(long syscall, long parm1, long parm2, long parm3,
+		   long parm4)
+{
+	int ret = -ENOSYS;
+    
+	lock_kernel();
+	
+	if (afs_linkage) {
+		__MOD_INC_USE_COUNT(afs_linkage->owner);
+		unlock_kernel();
+		ret = afs_linkage->do_afs(syscall, parm1, parm2, parm3, parm4);
+		__MOD_DEC_USE_COUNT(afs_linkage->owner);
+	} else
+		unlock_kernel();
+	return ret;
+}
+EXPORT_SYMBOL(afs_linkage);
diff -urN /afs/andrew/system/src/local/x86_l24/015/linux/include/linux/afs_interface.h linux/include/linux/afs_interface.h
--- /afs/andrew/system/src/local/x86_l24/015/linux/include/linux/afs_interface.h	Wed Dec 31 19:00:00 1969
+++ linux/include/linux/afs_interface.h	Sat Oct 12 13:57:08 2002
@@ -0,0 +1,21 @@
+/*
+ * include/linux/afs_interface.h
+ *
+ * defines interface between afs and other bits of
+ * the kernel.  Modelled on NFSd.
+ *
+ * Copyright (C) 2002 Derrick J Brashear <shadow@dementia.org>
+ */
+
+#ifndef LINUX_AFS_INTERFACE_H
+#define LINUX_AFS_INTERFACE_H
+
+#include <linux/config.h>
+
+extern struct afs_linkage {
+	long (*do_afs)(long syscall, long parm1, long parm2, long parm3, 
+		       long parm4);
+	struct module *owner;
+} * afs_linkage;
+
+#endif /* LINUX_AFS_INTERFACE_H */
