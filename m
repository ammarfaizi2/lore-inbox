Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132885AbRAKQ5r>; Thu, 11 Jan 2001 11:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132887AbRAKQ51>; Thu, 11 Jan 2001 11:57:27 -0500
Received: from smtp5.mail.yahoo.com ([128.11.69.102]:55045 "HELO
	smtp5.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132885AbRAKQ5U>; Thu, 11 Jan 2001 11:57:20 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A5DE454.2EFBF5C1@yahoo.com>
Date: Thu, 11 Jan 2001 11:50:28 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.0 i486)
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH-2.4] verify_write not needed 486 & up
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The existing CONFIG_WP_WORKS_OK can be used to exclude
verify_write from being built into kernels for 486 and
higher.

Paul.

--- arch/i386/mm/fault.c~	Mon Nov 20 04:19:42 2000
+++ arch/i386/mm/fault.c	Thu Jan 11 09:03:50 2001
@@ -4,6 +4,7 @@
  *  Copyright (C) 1995  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -25,6 +26,7 @@
 
 extern void die(const char *,struct pt_regs *,long);
 
+#ifndef CONFIG_X86_WP_WORKS_OK
 /*
  * Ugly, ugly, but the goto's result in better assembly..
  */
@@ -76,6 +78,7 @@
 bad_area:
 	return 0;
 }
+#endif
 
 extern spinlock_t console_lock, timerlist_lock;
 
--- arch/i386/kernel/i386_ksyms.c~	Thu Jan 11 09:06:12 2001
+++ arch/i386/kernel/i386_ksyms.c	Thu Jan 11 09:05:57 2001
@@ -53,7 +53,9 @@
 EXPORT_SYMBOL(EISA_bus);
 #endif
 EXPORT_SYMBOL(MCA_bus);
+#ifndef CONFIG_X86_WP_WORKS_OK
 EXPORT_SYMBOL(__verify_write);
+#endif
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(dump_extended_fpu);





_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
