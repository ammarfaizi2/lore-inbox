Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289865AbSBKRp0>; Mon, 11 Feb 2002 12:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289885AbSBKRpG>; Mon, 11 Feb 2002 12:45:06 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:42398 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S289865AbSBKRo6>;
	Mon, 11 Feb 2002 12:44:58 -0500
Date: Mon, 11 Feb 2002 18:44:56 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200202111744.SAA08449@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.4 PREEMPT on UP x86 breakage
Cc: rml@tech9.net, roy@karlsbakk.net, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.4, CONFIG_PREEMPT breaks UP x86 kernels by triggering
the BUG in release_kernel_lock(), kernel/sched.c, line 664.
The patch below fixed it for me. It's a bit crude, but smp.h
doesn't export the #define if CONFIG_SMP is disabled.

/Mikael

--- linux-2.5.4/include/asm-i386/smplock.h.~1~	Mon Feb 11 12:21:46 2002
+++ linux-2.5.4/include/asm-i386/smplock.h	Mon Feb 11 16:55:18 2002
@@ -15,7 +15,7 @@
 #else
 #ifdef CONFIG_PREEMPT
 #define kernel_locked()		preempt_get_count()
-#define global_irq_holder	0
+#define global_irq_holder	0xFF	/* XXX: NO_PROC_ID */
 #else
 #define kernel_locked()		1
 #endif
