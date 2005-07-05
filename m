Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVGEVF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVGEVF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVGEVDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:03:33 -0400
Received: from ozlabs.org ([203.10.76.45]:7619 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261923AbVGEVBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:01:40 -0400
Date: Wed, 6 Jul 2005 06:58:04 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: sys_ppc32.c cleanups
Message-ID: <20050705205804.GG12786@krispykreme>
References: <20050705205632.GF12786@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050705205632.GF12786@krispykreme>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove some unnecessary includes, an out of date comment and a prototype
for sys_timer_create (which is now in syscalls.h)

Signed-off-by: Anton Blanchard <anton@samba.org>

Index: foobar2/arch/ppc64/kernel/sys_ppc32.c
===================================================================
--- foobar2.orig/arch/ppc64/kernel/sys_ppc32.c	2005-07-04 01:09:20.310694267 +1000
+++ foobar2/arch/ppc64/kernel/sys_ppc32.c	2005-07-04 01:14:30.618438841 +1000
@@ -30,47 +30,26 @@
 #include <linux/sem.h>
 #include <linux/msg.h>
 #include <linux/shm.h>
-#include <linux/slab.h>
-#include <linux/uio.h>
-#include <linux/aio.h>
-#include <linux/nfs_fs.h>
-#include <linux/module.h>
-#include <linux/sunrpc/svc.h>
-#include <linux/nfsd/nfsd.h>
-#include <linux/nfsd/cache.h>
-#include <linux/nfsd/xdr.h>
-#include <linux/nfsd/syscall.h>
 #include <linux/poll.h>
 #include <linux/personality.h>
 #include <linux/stat.h>
-#include <linux/filter.h>
-#include <linux/highmem.h>
-#include <linux/highuid.h>
 #include <linux/mman.h>
-#include <linux/ipv6.h>
 #include <linux/in.h>
-#include <linux/icmpv6.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
-#include <linux/dnotify.h>
 #include <linux/security.h>
 #include <linux/compat.h>
 #include <linux/ptrace.h>
-#include <linux/aio_abi.h>
 #include <linux/elf.h>
 
-#include <net/scm.h>
-#include <net/sock.h>
-
 #include <asm/ptrace.h>
 #include <asm/types.h>
 #include <asm/ipc.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/semaphore.h>
-#include <asm/ppcdebug.h>
 #include <asm/time.h>
 #include <asm/mmu_context.h>
 #include <asm/systemcfg.h>
@@ -350,8 +329,6 @@
 	return ret;
 }
 
-
-/* These are here just in case some old sparc32 binary calls it. */
 asmlinkage long sys32_pause(void)
 {
 	current->state = TASK_INTERRUPTIBLE;
@@ -360,8 +337,6 @@
 	return -ERESTARTNOHAND;
 }
 
-
-
 static inline long get_ts32(struct timespec *o, struct compat_timeval __user *i)
 {
 	long usec;
@@ -1273,8 +1255,6 @@
 			     (u64)len_high << 32 | len_low, advice);
 }
 
-extern asmlinkage long sys_timer_create(clockid_t, sigevent_t __user *, timer_t __user *);
-
 long ppc32_timer_create(clockid_t clock,
 			struct compat_sigevent __user *ev32,
 			timer_t __user *timer_id)

