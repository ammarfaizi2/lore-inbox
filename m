Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUBHBRS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUBHBRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:17:17 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11463 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261799AbUBHBPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:15:35 -0500
Date: Sun, 8 Feb 2004 02:15:31 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] lockmeter.h: remove kernel 2.2 #ifdef (i386 + alpha)
Message-ID: <20040208011531.GI7388@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes a kernel 2.2 #ifdef from the i386 and alpha 
lockmeter.h .

Please apply
Adrian

--- linux-2.6.2-mm1/include/asm-i386/lockmeter.h.old	2004-02-08 02:12:35.000000000 +0100
+++ linux-2.6.2-mm1/include/asm-i386/lockmeter.h	2004-02-08 02:12:49.000000000 +0100
@@ -31,14 +31,6 @@
 
 #define THIS_CPU_NUMBER		smp_processor_id()
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-#define local_irq_save(x) \
-    __asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
-
-#define local_irq_restore(x) \
-    __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory")
-#endif	/* Linux version 2.2.x */
-
 /*
  * macros to cache and retrieve an index value inside of a spin lock
  * these macros assume that there are less than 65536 simultaneous
--- linux-2.6.2-mm1/include/asm-alpha/lockmeter.h.old	2004-02-08 02:13:13.000000000 +0100
+++ linux-2.6.2-mm1/include/asm-alpha/lockmeter.h	2004-02-08 02:13:23.000000000 +0100
@@ -16,12 +16,6 @@
 #define THIS_CPU_NUMBER		smp_processor_id()
 
 #include <linux/version.h>
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-#define local_irq_save(x) \
-	__save_and_cli(x)
-#define local_irq_restore(x) \
-	__restore_flags(x)
-#endif	/* Linux version 2.2.x */
 
 #define SPINLOCK_MAGIC_INIT /**/
 
