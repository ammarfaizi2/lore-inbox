Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTE2MUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 08:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTE2MUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 08:20:20 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:25571 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S262179AbTE2MUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 08:20:15 -0400
Date: Thu, 29 May 2003 14:33:33 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.70: add info to spinlock debugging
Message-ID: <20030529123333.GA28193@rhlx01.fht-esslingen.de>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

- directly print out in_atomic() and irqs_disabled() values to ease debugging
- add comment from original patch submission in order to be able to actually
  know what this is all about...

Not sure whether that's an absolutely brilliant idea, but I think it's
useful.

Patch against vanilla 2.5.70.

Andreas Mohr

diff -urN linux-2.5.70.orig/kernel/sched.c linux-2.5.70/kernel/sched.c
--- linux-2.5.70.orig/kernel/sched.c	2003-05-28 17:59:02.000000000 +0200
+++ linux-2.5.70/kernel/sched.c	2003-05-28 17:52:21.000000000 +0200
@@ -2512,6 +2512,11 @@
 }
 
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
+/*
+ * Detect sleep-inside-spinlock bugs. It prints out a whiny
+ * message and a stack backtrace if someone calls a function which might
+ * sleep from within an atomic region.
+ */
 void __might_sleep(char *file, int line)
 {
 #if defined(in_atomic)
@@ -2522,7 +2527,7 @@
 			return;
 		prev_jiffy = jiffies;
 		printk(KERN_ERR "Debug: sleeping function called from illegal"
-				" context at %s:%d\n", file, line);
+				" context at %s:%d (in_atomic %d, irq_disabled %d)\n", file, line, in_atomic(), irqs_disabled());
 		dump_stack();
 	}
 #endif

-- 
Help prevent Information Technology Fascism! - before it's too late...
http://www.againsttcpa.com
