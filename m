Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267529AbTBJBnS>; Sun, 9 Feb 2003 20:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267515AbTBJBmz>; Sun, 9 Feb 2003 20:42:55 -0500
Received: from dp.samba.org ([66.70.73.150]:14510 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267553AbTBJBlw>;
	Sun, 9 Feb 2003 20:41:52 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: ookhoi@humilis.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 Oops with insmod aironet4500_proc 
In-reply-to: Your message of "Mon, 10 Feb 2003 01:14:18 BST."
             <20030210011418.O19693@humilis> 
Date: Mon, 10 Feb 2003 12:50:50 +1100
Message-Id: <20030210015137.4C0B82C053@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030210011418.O19693@humilis> you write:
> Hi,
> 
> When I try to insmod aironet4500_proc, I get an Oops. The driver 
> itself is buildin (pci).
> 
> Kernel (2.5.59) is build with gcc (GCC) 3.2.2 20030131 (Debian prerelease)
> 
> module-init-tools version 0.9.9
> 
> Is there more info I should provide?

Looks like you need the following patch (or moreal equiv).

Hope this helps!
Rusty.

diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Fri Feb  7 21:21:02 2003
+++ b/include/asm-generic/vmlinux.lds.h	Fri Feb  7 21:21:02 2003
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
