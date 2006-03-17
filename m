Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbWCQOFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWCQOFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWCQOFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:05:53 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:42187
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932593AbWCQOFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:05:52 -0500
Message-ID: <441AC22F.4090007@tglx.de>
Date: Fri, 17 Mar 2006 15:05:35 +0100
From: Jan Altenberg <tb10alj@tglx.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.16-rc6-rt9 - Remove duplicated REMINDER prints
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

looking at init/main.c, I recognized duplicated REMINDER prints.
(existant since 2.6.16-rc6-rt1)
See attached patch against 2.6.16-rc6-rt9

Signed-off-by: Jan Altenberg <tb10alj@tglx.de>

----------------------

--- linux-2.6.16-rc6-rt9/init/main.c.orig	2006-03-17 14:50:28.000000000 +0100
+++ linux-2.6.16-rc6-rt9/init/main.c	2006-03-17 14:52:06.000000000 +0100
@@ -714,47 +714,6 @@ static int init(void * unused)

 	do_basic_setup();

-#define DEBUG_COUNT (defined(CONFIG_DEBUG_RT_MUTEXES) + defined(CONFIG_DEBUG_PREEMPT) + defined(CONFIG_CRITICAL_PREEMPT_TIMING) + defined(CONFIG_CRITICAL_IRQSOFF_TIMING) + defined(CONFIG_LATENCY_TRACE) + defined(CONFIG_DEBUG_SLAB) + defined(CONFIG_DEBUG_PAGEALLOC))
-
-#if DEBUG_COUNT > 0
-	printk(KERN_ERR "*****************************************************************************\n");
-	printk(KERN_ERR "*                                                                           *\n");
-#if DEBUG_COUNT == 1
-	printk(KERN_ERR "*  REMINDER, the following debugging option is turned on in your .config:   *\n");
-#else
-	printk(KERN_ERR "*  REMINDER, the following debugging options are turned on in your .config: *\n");
-#endif
-	printk(KERN_ERR "*                                                                           *\n");
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	printk(KERN_ERR "*        CONFIG_DEBUG_RT_MUTEXES                                             *\n");
-#endif
-#ifdef CONFIG_DEBUG_PREEMPT
-	printk(KERN_ERR "*        CONFIG_DEBUG_PREEMPT                                               *\n");
-#endif
-#ifdef CONFIG_CRITICAL_PREEMPT_TIMING
-	printk(KERN_ERR "*        CONFIG_CRITICAL_PREEMPT_TIMING                                     *\n");
-#endif
-#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
-	printk(KERN_ERR "*        CONFIG_CRITICAL_IRQSOFF_TIMING                                     *\n");
-#endif
-#ifdef CONFIG_LATENCY_TRACE
-	printk(KERN_ERR "*        CONFIG_LATENCY_TRACE                                               *\n");
-#endif
-#ifdef CONFIG_DEBUG_SLAB
-	printk(KERN_ERR "*        CONFIG_DEBUG_SLAB                                                  *\n");
-#endif
-#ifdef CONFIG_DEBUG_PAGEALLOC
-	printk(KERN_ERR "*        CONFIG_DEBUG_PAGEALLOC                                             *\n");
-#endif
-	printk(KERN_ERR "*                                                                           *\n");
-#if DEBUG_COUNT == 1
-	printk(KERN_ERR "*  it may increase runtime overhead and latencies.                          *\n");
-#else
-	printk(KERN_ERR "*  they may increase runtime overhead and latencies.                        *\n");
-#endif
-	printk(KERN_ERR "*                                                                           *\n");
-	printk(KERN_ERR "*****************************************************************************\n");
-#endif
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
