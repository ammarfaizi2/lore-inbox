Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRCHA7L>; Wed, 7 Mar 2001 19:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131255AbRCHA7B>; Wed, 7 Mar 2001 19:59:01 -0500
Received: from jalon.able.es ([212.97.163.2]:43002 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131244AbRCHA6u>;
	Wed, 7 Mar 2001 19:58:50 -0500
Date: Thu, 8 Mar 2001 01:58:24 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: MATSUSHIMA Akihiro <amatsus@jaist.ac.jp>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Can't compile 2.4.2-ac14
Message-ID: <20010308015824.C1158@werewolf.able.es>
In-Reply-To: <20010308091307Z.amatsus@jaist.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010308091307Z.amatsus@jaist.ac.jp>; from amatsus@jaist.ac.jp on Thu, Mar 08, 2001 at 01:13:07 +0100
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.08 MATSUSHIMA Akihiro wrote:
> Hello,
> I receive the following error with make bzImage:
> 
> i386_ksyms.c:170: `do_BUG' undeclared here (not in a function)
> i386_ksyms.c:170: initializer element is not constant
> i386_ksyms.c:170: (near initialization for `__ksymtab_do_BUG.value')
> make[1]: *** [i386_ksyms.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.2-ac14/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2
> 

Try this:

--- linux-2.4.2-ac14/arch/i386/mm/fault.c.orig	Thu Mar  8 01:26:47 2001
+++ linux-2.4.2-ac14/arch/i386/mm/fault.c	Thu Mar  8 01:27:10 2001
@@ -110,11 +110,13 @@
 	}
 }
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE
 void do_BUG(const char *file, int line)
 {
 	bust_spinlocks(1);
 	printk("kernel BUG at %s:%d!\n", file, line);
 }
+#endif
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
 extern unsigned long idt;
--- linux-2.4.2-ac14/arch/i386/kernel/i386_ksyms.c.orig	Thu Mar  8
01:27:56 2001
+++ linux-2.4.2-ac14/arch/i386/kernel/i386_ksyms.c	Thu Mar  8 01:28:13
2001
@@ -167,5 +167,7 @@
 EXPORT_SYMBOL(empty_zero_page);
 #endif
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE
 EXPORT_SYMBOL(do_BUG);
+#endif
 

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac13 #3 SMP Wed Mar 7 00:09:17 CET 2001 i686

