Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266735AbTBLEpo>; Tue, 11 Feb 2003 23:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbTBLEpo>; Tue, 11 Feb 2003 23:45:44 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:24764 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266735AbTBLEpn>;
	Tue, 11 Feb 2003 23:45:43 -0500
Date: Wed, 12 Feb 2003 15:55:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, matthew@wil.cx
Subject: [PATCH][COMPAT] compat_sys_futex 3/7 parisc
Message-Id: <20030212155517.0824e647.sfr@canb.auug.org.au>
In-Reply-To: <20030212154716.7c101942.sfr@canb.auug.org.au>
References: <20030212154716.7c101942.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the parisc part of the patch since Willy asked me to send them
directly to you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.60-32bit.1/arch/parisc/kernel/syscall.S 2.5.60-32bit.2/arch/parisc/kernel/syscall.S
--- 2.5.60-32bit.1/arch/parisc/kernel/syscall.S	2003-02-11 09:39:14.000000000 +1100
+++ 2.5.60-32bit.2/arch/parisc/kernel/syscall.S	2003-02-11 12:21:56.000000000 +1100
@@ -320,7 +320,8 @@
 #ifdef __LP64__
 /* Use ENTRY_SAME for 32-bit syscalls which are the same on wide and
  * narrow palinux.  Use ENTRY_DIFF for those where a 32-bit specific
- * implementation is required on wide palinux.
+ * implementation is required on wide palinux.  Use ENTRY_COMP where
+ * the compatability layer has a useful 32-bit implementation.
  */
 #define ENTRY_SAME(_name_) .dword sys_##_name_
 #define ENTRY_DIFF(_name_) .dword sys32_##_name_
@@ -597,7 +598,7 @@
 	ENTRY_SAME(ni_syscall)		/* tkill */
 
 	ENTRY_SAME(sendfile64)
-	ENTRY_SAME(futex)		/* 210 */
+	ENTRY_COMP(futex)		/* 210 */
 	ENTRY_SAME(sched_setaffinity)
 	ENTRY_SAME(sched_getaffinity)
 	ENTRY_SAME(set_thread_area)
