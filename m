Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVLFAig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVLFAig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbVLFAfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:35:20 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:26574
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751541AbVLFAei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:38 -0500
Message-Id: <20051206000152.812015000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:28 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 02/21] Remove duplicate div_long_long_rem implementation
Content-Disposition: inline; filename=remove-div-long-long-rem-duplicate.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- make posix-timers.c use the generic calc64.h facility

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/posix-timers.c |   10 +---------
 1 files changed, 1 insertion(+), 9 deletions(-)

Index: linux-2.6.15-rc5/kernel/posix-timers.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/posix-timers.c
+++ linux-2.6.15-rc5/kernel/posix-timers.c
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/calc64.h>
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
@@ -48,15 +49,6 @@
 #include <linux/workqueue.h>
 #include <linux/module.h>
 
-#ifndef div_long_long_rem
-#include <asm/div64.h>
-
-#define div_long_long_rem(dividend,divisor,remainder) ({ \
-		       u64 result = dividend;		\
-		       *remainder = do_div(result,divisor); \
-		       result; })
-
-#endif
 #define CLOCK_REALTIME_RES TICK_NSEC  /* In nano seconds. */
 
 static inline u64  mpy_l_X_l_ll(unsigned long mpy1,unsigned long mpy2)

--

