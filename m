Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbTFSUUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265335AbTFSUUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:20:37 -0400
Received: from palrel13.hp.com ([156.153.255.238]:22167 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265276AbTFSUUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:20:36 -0400
Date: Thu, 19 Jun 2003 13:34:34 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200306192034.h5JKYYcm001734@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: patch to avoid declaring irq_desc on ia64
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My understanding is that the big irq.c unification is still being
worked on.  Until that happens, would you mind accepting the attached
patch?  The CONFIG_IA64 is of course not ideal, but it will trivially
disappear once the unified irq.c work is in.

This change is, I believe, the last one that prevents ia64 from
compiling out of the box (apart from the show_stack() patches which
are already in Andrew's tree).

	--david

PS: Yes, I could work around the problem by changing the irq_desc()
    macro name to something else.  But that would be lot of wasted
    effort given that the unified irq.c will also be using a macro of
    the same name.

diff -Nru a/include/linux/irq.h b/include/linux/irq.h
--- a/include/linux/irq.h	Thu Jun 19 13:28:02 2003
+++ b/include/linux/irq.h	Thu Jun 19 13:28:02 2003
@@ -56,7 +56,7 @@
  *
  * Pad this out to 32 bytes for cache and indexing reasons.
  */
-typedef struct {
+typedef struct irq_desc {
 	unsigned int status;		/* IRQ status */
 	hw_irq_controller *handler;
 	struct irqaction *action;	/* IRQ action list */
@@ -66,7 +66,9 @@
 	spinlock_t lock;
 } ____cacheline_aligned irq_desc_t;
 
+#ifndef CONFIG_IA64
 extern irq_desc_t irq_desc [NR_IRQS];
+#endif
 
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
