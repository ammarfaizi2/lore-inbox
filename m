Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132886AbRAKQ5r>; Thu, 11 Jan 2001 11:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132885AbRAKQ51>; Thu, 11 Jan 2001 11:57:27 -0500
Received: from smtp2.mail.yahoo.com ([128.11.68.32]:39690 "HELO
	smtp2.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132886AbRAKQ5Y>; Thu, 11 Jan 2001 11:57:24 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A5DE47A.7E7145C4@yahoo.com>
Date: Thu, 11 Jan 2001 11:51:06 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.0 i486)
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH-2.2] verify_write not needed 486 & up
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The existing CONFIG_WP_WORKS_OK can be used to exclude
verify_write from being built into kernels for 486 and
higher.

Paul.

--- arch/i386/mm/fault.c.orig	Thu May 11 16:41:59 2000
+++ arch/i386/mm/fault.c	Thu Jan 11 09:16:48 2001
@@ -4,6 +4,7 @@
  *  Copyright (C) 1995  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -24,6 +25,7 @@
 
 extern void die(const char *,struct pt_regs *,long);
 
+#ifndef CONFIG_X86_WP_WORKS_OK
 /*
  * Ugly, ugly, but the goto's result in better assembly..
  */
@@ -94,6 +96,7 @@
 	}
 	goto bad_area;
 }
+#endif
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
 extern unsigned long idt;
--- arch/i386/kernel/i386_ksyms.c.orig	Mon Dec 11 17:46:42 2000
+++ arch/i386/kernel/i386_ksyms.c	Thu Jan 11 09:16:48 2001
@@ -31,7 +31,9 @@
 EXPORT_SYMBOL(boot_cpu_data);
 EXPORT_SYMBOL(EISA_bus);
 EXPORT_SYMBOL(MCA_bus);
+#ifndef CONFIG_X86_WP_WORKS_OK
 EXPORT_SYMBOL(__verify_write);
+#endif
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(__ioremap);




__________________________________________________
Do You Yahoo!?
Talk to your friends online with Yahoo! Messenger.
http://im.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
