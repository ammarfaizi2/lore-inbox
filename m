Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVK3X5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVK3X5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVK3X5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:57:05 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:31906
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751276AbVK3X5E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:04 -0500
Subject: [patch 02/43] Remove duplicate div_long_long_rem implementation
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:02:35 +0100
Message-Id: <1133395356.32542.445.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment
(remove-div-long-long-rem-duplicate.patch)
- make posix-timers.c use the generic calc64.h facility

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/posix-timers.c |   10 +---------
 1 files changed, 1 insertion(+), 9 deletions(-)

Index: linux-2.6.15-rc2-rework/kernel/posix-timers.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/posix-timers.c
+++ linux-2.6.15-rc2-rework/kernel/posix-timers.c
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

