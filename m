Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUCLC6i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 21:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUCLC6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 21:58:38 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:25551 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261924AbUCLC6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 21:58:37 -0500
Date: Thu, 11 Mar 2004 18:57:58 -0800 (PST)
From: John Hawkes <hawkes@babylon.engr.sgi.com>
Message-Id: <200403120257.i2C2vwCt10074515@babylon.engr.sgi.com>
To: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] 2.6.4-mm1 for ia64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches allow 2.6.4-mm1 to build and boot on an ia64 sn.

-- John Hawkes



diff -X /home/hawkes/Patches/ignore.dirs -Naur linux-2.6.4-mm1/arch/ia64/kernel/unaligned.c linux-2.6.4-mm1-jh/arch/ia64/kernel/unaligned.c
--- linux-2.6.4-mm1/arch/ia64/kernel/unaligned.c	2004-02-23 21:30:26.000000000 -0800
+++ linux-2.6.4-mm1-jh/arch/ia64/kernel/unaligned.c	2004-03-11 17:52:29.000000000 -0800
@@ -1337,7 +1337,7 @@
 			 * be holding locks...
 			 */
 			if (user_mode(regs))
-				tty_write_message(current->tty, buf);
+				tty_write_message(current->signal->tty, buf);
 			buf[len-1] = '\0';	/* drop '\r' */
 			printk(KERN_WARNING "%s", buf);	/* watch for command names containing %s */
 		}
diff -X /home/hawkes/Patches/ignore.dirs -Naur linux-2.6.4-mm1/fs/compat_ioctl.c linux-2.6.4-mm1-jh/fs/compat_ioctl.c
--- linux-2.6.4-mm1/fs/compat_ioctl.c	2004-03-07 21:13:19.000000000 -0800
+++ linux-2.6.4-mm1-jh/fs/compat_ioctl.c	2004-03-11 18:07:10.000000000 -0800
@@ -1604,7 +1604,7 @@
 	 * To have permissions to do most of the vt ioctls, we either have
 	 * to be the owner of the tty, or super-user.
 	 */
-	if (current->tty == tty || capable(CAP_SYS_ADMIN))
+	if (current->signal->tty == tty || capable(CAP_SYS_ADMIN))
 		return 1;
 	return 0;                                                    
 }
diff -X /home/hawkes/Patches/ignore.dirs -Naur linux-2.6.4-mm1/include/asm-ia64/ia32.h linux-2.6.4-mm1-jh/include/asm-ia64/ia32.h
--- linux-2.6.4-mm1/include/asm-ia64/ia32.h	2004-02-23 20:44:17.000000000 -0800
+++ linux-2.6.4-mm1-jh/include/asm-ia64/ia32.h	2004-03-11 18:03:21.000000000 -0800
@@ -6,7 +6,7 @@
 #include <asm/ptrace.h>
 #include <asm/signal.h>
 
-#define IA32_NR_syscalls		275 /* length of syscall table */
+#define IA32_NR_syscalls		281 /* length of syscall table */
 
 #ifndef __ASSEMBLY__
 
