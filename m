Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267114AbTAHMDi>; Wed, 8 Jan 2003 07:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbTAHMDi>; Wed, 8 Jan 2003 07:03:38 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:4533 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267114AbTAHMDa>;
	Wed, 8 Jan 2003 07:03:30 -0500
Date: Wed, 8 Jan 2003 23:12:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: matthew@wil.cx
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] {get,put}_compat_timspec 8/8 parisc
Message-Id: <20030108231206.72f133d5.sfr@canb.auug.org.au>
In-Reply-To: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
References: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Here is the parisc part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301081106-32bit.2/arch/parisc/kernel/sys_parisc32.c 2.5.54-200301081106-32bit.3/arch/parisc/kernel/sys_parisc32.c
--- 2.5.54-200301081106-32bit.2/arch/parisc/kernel/sys_parisc32.c	2003-01-08 12:04:15.000000000 +1100
+++ 2.5.54-200301081106-32bit.3/arch/parisc/kernel/sys_parisc32.c	2003-01-08 17:10:25.000000000 +1100
@@ -490,15 +490,6 @@
 }
 #endif /* CONFIG_SYSCTL */
 
-static int
-put_compat_timespec(struct compat_timespec *u, struct timespec *t)
-{
-	struct compat_timespec t32;
-	t32.tv_sec = t->tv_sec;
-	t32.tv_nsec = t->tv_nsec;
-	return copy_to_user(u, &t32, sizeof t32);
-}
-
 asmlinkage long sys32_sched_rr_get_interval(pid_t pid,
 	struct compat_timespec *interval)
 {
@@ -507,7 +498,7 @@
 	extern asmlinkage long sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 	
 	KERNEL_SYSCALL(ret, sys_sched_rr_get_interval, pid, &t);
-	if (put_compat_timespec(interval, &t))
+	if (put_compat_timespec(&t, interval))
 		return -EFAULT;
 	return ret;
 }
