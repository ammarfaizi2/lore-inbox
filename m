Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVBXSmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVBXSmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVBXSmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:42:08 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:3572 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261548AbVBXSlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:41:42 -0500
Subject: [PATCH] Fix sleep_on functions
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1109270495.1527.5.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 24 Feb 2005 10:41:37 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There is a problem with *_sleep_on() functions when they call schedule() . Interrupts
should be enabled , but they aren't. So a warning message is printed letting everyone
know that your calling schedule() from an invalid context. 

Signed-off-by: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.10/kernel/sched.c
===================================================================
--- linux-2.6.10.orig/kernel/sched.c	2005-02-22 21:41:45.000000000 +0000
+++ linux-2.6.10/kernel/sched.c	2005-02-22 21:46:36.000000000 +0000
@@ -3417,7 +3417,7 @@
 #define SLEEP_ON_HEAD					\
 	spin_lock_irqsave(&q->lock,flags);		\
 	__add_wait_queue(q, &wait);			\
-	spin_unlock(&q->lock);
+	spin_unlock_irq(&q->lock);
 
 #define	SLEEP_ON_TAIL					\
 	spin_lock_irq(&q->lock);			\



