Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTAHLfq>; Wed, 8 Jan 2003 06:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbTAHLfq>; Wed, 8 Jan 2003 06:35:46 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:36786 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267267AbTAHLfp>;
	Wed, 8 Jan 2003 06:35:45 -0500
Date: Wed, 8 Jan 2003 22:44:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davem@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] {get,put}_compat_timspec 3/8 sparc64
Message-Id: <20030108224416.3ce388e2.sfr@canb.auug.org.au>
In-Reply-To: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
References: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

sparc 64 part.  This is relative to the previous patches I have sent you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301081106-32bit.2/arch/sparc64/kernel/sys_sparc32.c 2.5.54-200301081106-32bit.3/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.54-200301081106-32bit.2/arch/sparc64/kernel/sys_sparc32.c	2003-01-08 11:40:38.000000000 +1100
+++ 2.5.54-200301081106-32bit.3/arch/sparc64/kernel/sys_sparc32.c	2003-01-08 17:15:17.000000000 +1100
@@ -1729,8 +1729,7 @@
 	set_fs (KERNEL_DS);
 	ret = sys_sched_rr_get_interval(pid, &t);
 	set_fs (old_fs);
-	if (put_user (t.tv_sec, &interval->tv_sec) ||
-	    __put_user (t.tv_nsec, &interval->tv_nsec))
+	if (put_compat_timespec(&t, interval))
 		return -EFAULT;
 	return ret;
 }
@@ -1861,8 +1860,7 @@
 	signotset(&these);
 
 	if (uts) {
-		if (get_user (ts.tv_sec, &uts->tv_sec) ||
-		    get_user (ts.tv_nsec, &uts->tv_nsec))
+		if (get_compat_timespec(&ts, uts))
 			return -EINVAL;
 		if (ts.tv_nsec >= 1000000000L || ts.tv_nsec < 0
 		    || ts.tv_sec < 0)
