Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWCUViP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWCUViP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWCUViP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:38:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:49118 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932461AbWCUViO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:38:14 -0500
Date: Tue, 21 Mar 2006 15:38:03 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, clameter@sgi.com,
       jes@sgi.com
Subject: [PATCH] Add SA_PERCPU_IRQ flag support
Message-ID: <20060321213803.GC26124@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The generic request_irq/setup_irq code should support the SA_PERCPU_IRQ flag.

This patch was posted previously, but this one should build on all arch's.

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>

Index: linux-2.6.15/kernel/irq/manage.c
===================================================================
--- linux-2.6.15.orig/kernel/irq/manage.c	2006-03-20 13:11:01.766522017 -0600
+++ linux-2.6.15/kernel/irq/manage.c	2006-03-21 15:26:12.305876769 -0600
@@ -206,6 +206,10 @@ int setup_irq(unsigned int irq, struct i
 	 * The following block of code has to be executed atomically
 	 */
 	spin_lock_irqsave(&desc->lock,flags);
+#if defined(ARCH_HAS_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
+	if (new->flags & SA_PERCPU_IRQ)
+		desc->status |= IRQ_PER_CPU;
+#endif
 	p = &desc->action;
 	if ((old = *p) != NULL) {
 		/* Can't share interrupts unless both agree to */

