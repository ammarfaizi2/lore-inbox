Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbTDGWri (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263744AbTDGWri (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:47:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39552
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263743AbTDGWre (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:47:34 -0400
Date: Tue, 8 Apr 2003 01:06:24 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080006.h3806OC8008935@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: ppc64 syscalls return long purity
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/ppc64/kernel/sys_ppc32.c linux-2.5.67-ac1/arch/ppc64/kernel/sys_ppc32.c
--- linux-2.5.67/arch/ppc64/kernel/sys_ppc32.c	2003-03-26 19:59:50.000000000 +0000
+++ linux-2.5.67-ac1/arch/ppc64/kernel/sys_ppc32.c	2003-04-03 23:27:34.000000000 +0100
@@ -2781,10 +2781,10 @@
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
@@ -2805,10 +2805,10 @@
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
@@ -2914,7 +2914,7 @@
 	return sys_ftruncate(fd, (high << 32) | low);
 }
 
-extern int sys_lookup_dcookie(u64 cookie64, char *buf, size_t len);
+extern long sys_lookup_dcookie(u64 cookie64, char *buf, size_t len);
 
 long ppc32_lookup_dcookie(u32 cookie_high, u32 cookie_low, char *buf,
 			  size_t len)

