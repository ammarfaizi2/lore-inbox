Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbTA2AK2>; Tue, 28 Jan 2003 19:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbTA2AK2>; Tue, 28 Jan 2003 19:10:28 -0500
Received: from dp.samba.org ([66.70.73.150]:12169 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262449AbTA2AK1>;
	Tue, 28 Jan 2003 19:10:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: ookhoi@humilis.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 oops with modprobe lp 
In-reply-to: Your message of "Tue, 28 Jan 2003 15:12:19 BST."
             <20030128151219.A953@humilis> 
Date: Wed, 29 Jan 2003 10:41:19 +1100
Message-Id: <20030129001948.5DAF52C07D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030128151219.A953@humilis> you write:
> Hi all,
> 
> Just booted my fresh compiled 2.5.59 (patched with reiser4 and kexec),
> and did a 'modprobe lp'. It segfaulted. lsmod hangs.

Yep.  This is due to a small bug in Kai's vmlinux.lds.h cleanup:

Hope this helps!
Rusty.

diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Sat Jan 25 12:24:59 2003
+++ b/include/asm-generic/vmlinux.lds.h	Sat Jan 25 12:24:59 2003
@@ -13,18 +13,18 @@
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\
-	__start___ksymtab = .;						\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
+		__start___ksymtab = .;					\
 		*(__ksymtab)						\
+		__stop___ksymtab = .;					\
 	}								\
-	__stop___ksymtab = .;						\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
-	__start___gpl_ksymtab = .;					\
 	__gpl_ksymtab     : AT(ADDR(__gpl_ksymtab) - LOAD_OFFSET) {	\
+		__start___gpl_ksymtab = .;				\
 		*(__gpl_ksymtab)					\
+		__stop___gpl_ksymtab = .;				\
 	}								\
-	__stop___gpl_ksymtab = .;					\
 									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
