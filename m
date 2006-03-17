Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752460AbWCQAb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbWCQAb2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbWCQAb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:31:28 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:3003 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1752457AbWCQAb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:31:26 -0500
Date: Thu, 16 Mar 2006 18:31:14 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Christoph Lameter <clameter@sgi.com>, Jes Sorensen <jes@sgi.com>
Subject: [PATCH] Add SA_PERCPU_IRQ flag support
Message-ID: <20060317003114.GA1735@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The generic request_irq/setup_irq code should support the SA_PERCPU_IRQ flag.

Not sure why it was left out, but this patch adds that support.

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>

Index: linux/kernel/irq/manage.c
===================================================================
--- linux.orig/kernel/irq/manage.c	2006-03-16 14:05:27.957927445 -0600
+++ linux/kernel/irq/manage.c	2006-03-16 14:06:02.283661867 -0600
@@ -201,6 +201,9 @@ int setup_irq(unsigned int irq, struct i
 	 * The following block of code has to be executed atomically
 	 */
 	spin_lock_irqsave(&desc->lock,flags);
+	if (new->flags & SA_PERCPU_IRQ) {
+		desc->status |= IRQ_PER_CPU;
+	}
 	p = &desc->action;
 	if ((old = *p) != NULL) {
 		/* Can't share interrupts unless both agree to */
