Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbTAHMCH>; Wed, 8 Jan 2003 07:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbTAHMCH>; Wed, 8 Jan 2003 07:02:07 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:58036 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267076AbTAHMCC>;
	Wed, 8 Jan 2003 07:02:02 -0500
Date: Wed, 8 Jan 2003 23:10:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ralf@gnu.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] {get,put}_compat_timspec 7/8 mips64
Message-Id: <20030108231005.499093d0.sfr@canb.auug.org.au>
In-Reply-To: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
References: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

Here is the mips64 part.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301081106-32bit.2/arch/mips64/kernel/linux32.c 2.5.54-200301081106-32bit.3/arch/mips64/kernel/linux32.c
--- 2.5.54-200301081106-32bit.2/arch/mips64/kernel/linux32.c	2003-01-08 12:04:15.000000000 +1100
+++ 2.5.54-200301081106-32bit.3/arch/mips64/kernel/linux32.c	2003-01-08 17:09:19.000000000 +1100
@@ -1086,8 +1086,7 @@
 	set_fs (KERNEL_DS);
 	ret = sys_sched_rr_get_interval(pid, &t);
 	set_fs (old_fs);
-	if (put_user (t.tv_sec, &interval->tv_sec) ||
-	    __put_user (t.tv_nsec, &interval->tv_nsec))
+	if (put_compat_timespec(&t, interval))
 		return -EFAULT;
 	return ret;
 }
