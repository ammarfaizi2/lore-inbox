Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbTBONsj>; Sat, 15 Feb 2003 08:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbTBONsj>; Sat, 15 Feb 2003 08:48:39 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:17130 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S264630AbTBONsi>;
	Sat, 15 Feb 2003 08:48:38 -0500
Date: Sun, 16 Feb 2003 00:58:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Miller <davem@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus <torvalds@transmeta.com>
Subject: [PATCH][COMPAT] compat_sys_futex 3/3 sparc64
Message-Id: <20030216005815.0fe90b8c.sfr@canb.auug.org.au>
In-Reply-To: <20030216005159.16557e36.sfr@canb.auug.org.au>
References: <20030212154716.7c101942.sfr@canb.auug.org.au>
	<20030216005159.16557e36.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

sparc64 part of the patch.  This fixes your 32 bit compatibility version of
sys_futex (you were using the 64 bit version before).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.61-32bit.1/arch/sparc64/kernel/systbls.S 2.5.61-32bit.2/arch/sparc64/kernel/systbls.S
--- 2.5.61-32bit.1/arch/sparc64/kernel/systbls.S	2003-02-15 23:19:38.000000000 +1100
+++ 2.5.61-32bit.2/arch/sparc64/kernel/systbls.S	2003-02-15 23:39:48.000000000 +1100
@@ -47,7 +47,7 @@
 	.word sys_nis_syscall, sys32_setreuid16, sys32_setregid16, sys_rename, sys_truncate
 /*130*/	.word sys_ftruncate, sys_flock, sys_lstat64, sys_nis_syscall, sys_nis_syscall
 	.word sys_nis_syscall, sys_mkdir, sys_rmdir, sys32_utimes, sys_stat64
-/*140*/	.word sys32_sendfile64, sys_nis_syscall, sys_futex, sys_gettid, sys32_getrlimit
+/*140*/	.word sys32_sendfile64, sys_nis_syscall, compat_sys_futex, sys_gettid, sys32_getrlimit
 	.word sys32_setrlimit, sys_pivot_root, sys32_prctl, sys32_pciconfig_read, sys32_pciconfig_write
 /*150*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
 	.word sys32_fcntl64, sys_ni_syscall, compat_sys_statfs, compat_sys_fstatfs, sys_oldumount
