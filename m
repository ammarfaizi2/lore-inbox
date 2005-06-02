Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVFBGhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVFBGhR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 02:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVFBGhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 02:37:16 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:46299 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S261586AbVFBGgv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 02:36:51 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>
Subject: Accessing monotonic clock from modules
Date: Thu, 2 Jun 2005 08:36:48 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66801B7645C@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to get the posix monotonic clock from a loadable module.
Would a patch to make do_posix_clock_monotonic_gettime exported ok or
should we do it in some other way?

/Mikael

Here is such a patch (against 2.6.11):

Index: posix-timers.c
===================================================================
RCS file: /usr/local/cvs/linux/os/linux-2.6/kernel/posix-timers.c,v
retrieving revision 1.1.1.13
diff -u -r1.1.1.13 posix-timers.c
--- posix-timers.c	3 Mar 2005 08:53:02 -0000	1.1.1.13
+++ posix-timers.c	2 Jun 2005 06:35:30 -0000
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/module.h>
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
@@ -191,6 +192,8 @@
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
 
+EXPORT_SYMBOL(do_posix_clock_monotonic_gettime);
+
 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
 {
 	spin_unlock_irqrestore(&timr->it_lock, flags);

