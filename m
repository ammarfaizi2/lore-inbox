Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbTC1GRt>; Fri, 28 Mar 2003 01:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262236AbTC1GRt>; Fri, 28 Mar 2003 01:17:49 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:27557 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262230AbTC1GRr>;
	Fri, 28 Mar 2003 01:17:47 -0500
Date: Fri, 28 Mar 2003 17:28:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
Subject: [PATCH] stop even more macros for comverting compat pointers
Message-Id: <20030328172851.0c96af5c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andi,

Just want to nip this in the bud :-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.66-032708-32bit.1/arch/x86_64/ia32/sys_ia32.c 2.5.66-032708-32bit.3/arch/x86_64/ia32/sys_ia32.c
--- 2.5.66-032708-32bit.1/arch/x86_64/ia32/sys_ia32.c	2003-03-27 11:23:03.000000000 +1100
+++ 2.5.66-032708-32bit.3/arch/x86_64/ia32/sys_ia32.c	2003-03-28 17:21:54.000000000 +1100
@@ -75,7 +75,6 @@
 
 #define A(__x)		((unsigned long)(__x))
 #define AA(__x)		((unsigned long)(__x))
-#define u32_to_ptr(x)	((void *)(u64)(x))
 #define ROUND_UP(x,a)	((__typeof__(x))(((unsigned long)(x) + ((a) - 1)) & ~((a) - 1)))
 #define NAME_OFFSET(de) ((int) ((de)->d_name - (char *) (de)))
 
@@ -2091,7 +2090,7 @@
 } 
 
 asmlinkage long sys32_io_submit(aio_context_t ctx_id, int nr,
-		   u32 *iocbpp)
+		   compat_uptr_t *iocbpp)
 {
 	struct kioctx *ctx;
 	long ret = 0;
@@ -2110,14 +2109,14 @@
 	} 
 
 	for (i=0; i<nr; i++) {
-		u32 p32;
+		compat_uptr_t p32;
 		struct iocb *user_iocb, tmp;
 
 		if (unlikely(__get_user(p32, iocbpp + i))) {
 			ret = -EFAULT;
 			break;
-	} 
-		user_iocb = u32_to_ptr(p32);
+		} 
+		user_iocb = compat_ptr(p32);
 
 		if (unlikely(copy_from_user(&tmp, user_iocb, sizeof(tmp)))) {
 			ret = -EFAULT;
