Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbTDCTbR 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261304AbTDCTbQ 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:31:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:20689 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263513AbTDCTVN 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 14:21:13 -0500
Date: Thu, 3 Apr 2003 11:32:49 +0000
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: matthew@wil.cx, engebret@us.ibm.com, schwidefsky@de.ibm.com,
       zaitcev@redhat.com, davem@redhat.com
Subject: [PATCH] update $ARCH to match syscalls return long
Message-Id: <20030403113249.7d672386.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot about this...sorry about that.

This patch to 2.5.66-bk-current updates several $ARCH syscalls and
prototypes to match the kernel arch-independent syscalls.

Comments?  up?  down?  forward?

Thanks,
--
~Randy



patch_name:	syscall-long-protos.patch
patch_version:	2003-04-03.11:03:07
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	make $ARCH syscalls match arch-independent: <return long>
product:	Linux
product_versions: 2.5.66
maintainers:	matthew@wil.cx (parisc), engebret@us.ibm.com (ppc64),
		schwidefsky@de.ibm.com (s390), zaitcev@redhat.com (sparc),
		davem@redhat.com (sparc64)
diffstat:	=
 arch/parisc/kernel/sys_parisc32.c |    2 +-
 arch/ppc64/kernel/sys_ppc32.c     |   10 +++++-----
 arch/s390x/kernel/linux32.c       |    8 ++++----
 arch/sparc/kernel/sys_sparc.c     |    4 ++--
 arch/sparc64/kernel/sys_sparc32.c |   12 ++++++------
 5 files changed, 18 insertions(+), 18 deletions(-)


diff -Naur ./arch/sparc/kernel/sys_sparc.c%SCPRL ./arch/sparc/kernel/sys_sparc.c
--- ./arch/sparc/kernel/sys_sparc.c%SCPRL	Mon Mar 24 14:00:17 2003
+++ ./arch/sparc/kernel/sys_sparc.c	Thu Apr  3 10:39:42 2003
@@ -269,11 +269,11 @@
 	return do_mmap2(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
 }
 
-extern int sys_remap_file_pages(unsigned long start, unsigned long size,
+extern long sys_remap_file_pages(unsigned long start, unsigned long size,
 				unsigned long prot, unsigned long pgoff,
 				unsigned long flags);
 
-int sparc_remap_file_pages(unsigned long start, unsigned long size,
+long sparc_remap_file_pages(unsigned long start, unsigned long size,
 			   unsigned long prot, unsigned long pgoff,
 			   unsigned long flags)
 {
diff -Naur ./arch/sparc64/kernel/sys_sparc32.c%SCPRL ./arch/sparc64/kernel/sys_sparc32.c
--- ./arch/sparc64/kernel/sys_sparc32.c%SCPRL	Mon Mar 24 14:00:52 2003
+++ ./arch/sparc64/kernel/sys_sparc32.c	Thu Apr  3 10:46:48 2003
@@ -2934,10 +2934,10 @@
 	return error;
 }
 
-extern asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
+extern asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
+asmlinkage long sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
@@ -2958,10 +2958,10 @@
 	return ret;
 }
 
-extern asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
+extern asmlinkage long sys_sched_getaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
+asmlinkage long sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
@@ -2984,9 +2984,9 @@
 	return ret;
 }
 
-extern int sys_lookup_dcookie(u64 cookie64, char *buf, size_t len);
+extern long sys_lookup_dcookie(u64 cookie64, char *buf, size_t len);
 
-int sys32_lookup_dcookie(u32 cookie_high, u32 cookie_low, char *buf, size_t len)
+long sys32_lookup_dcookie(u32 cookie_high, u32 cookie_low, char *buf, size_t len)
 {
 	return sys_lookup_dcookie((u64)cookie_high << 32 | cookie_low,
 				  buf, len);
diff -Naur ./arch/ppc64/kernel/sys_ppc32.c%SCPRL ./arch/ppc64/kernel/sys_ppc32.c
--- ./arch/ppc64/kernel/sys_ppc32.c%SCPRL	Mon Mar 24 14:01:11 2003
+++ ./arch/ppc64/kernel/sys_ppc32.c	Thu Apr  3 10:43:44 2003
@@ -2886,10 +2886,10 @@
 	return secs;
 }
 
-extern asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
+extern asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
+asmlinkage long sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
@@ -2910,10 +2910,10 @@
 	return ret;
 }
 
-extern asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
+extern asmlinkage long sys_sched_getaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
+asmlinkage long sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
@@ -3019,7 +3019,7 @@
 	return sys_ftruncate(fd, (high << 32) | low);
 }
 
-extern int sys_lookup_dcookie(u64 cookie64, char *buf, size_t len);
+extern long sys_lookup_dcookie(u64 cookie64, char *buf, size_t len);
 
 long ppc32_lookup_dcookie(u32 cookie_high, u32 cookie_low, char *buf,
 			  size_t len)
diff -Naur ./arch/parisc/kernel/sys_parisc32.c%SCPRL ./arch/parisc/kernel/sys_parisc32.c
--- ./arch/parisc/kernel/sys_parisc32.c%SCPRL	Mon Mar 24 14:00:15 2003
+++ ./arch/parisc/kernel/sys_parisc32.c	Thu Apr  3 10:41:02 2003
@@ -1636,7 +1636,7 @@
 	return sys_semctl (semid, semnum, cmd, arg);
 }
 
-extern int sys_lookup_dcookie(u64 cookie64, char *buf, size_t len);
+extern long sys_lookup_dcookie(u64 cookie64, char *buf, size_t len);
 
 long sys32_lookup_dcookie(u32 cookie_high, u32 cookie_low, char *buf,
 			  size_t len)
diff -Naur ./arch/s390x/kernel/linux32.c%SCPRL ./arch/s390x/kernel/linux32.c
--- ./arch/s390x/kernel/linux32.c%SCPRL	Mon Mar 24 14:01:13 2003
+++ ./arch/s390x/kernel/linux32.c	Thu Apr  3 10:44:45 2003
@@ -2878,10 +2878,10 @@
 	return error;
 }
 
-extern asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
+extern asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
+asmlinkage long sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
@@ -2902,10 +2902,10 @@
 	return ret;
 }
 
-extern asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
+extern asmlinkage long sys_sched_getaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
+asmlinkage long sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
