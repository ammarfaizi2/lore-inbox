Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWCUXpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWCUXpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWCUXpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:45:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14278 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932416AbWCUXpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:45:34 -0500
Date: Tue, 21 Mar 2006 15:45:24 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Dimitri Sivanich <sivanich@sgi.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, jes@sgi.com
Subject: Re: [PATCH] Add SA_PERCPU_IRQ flag support
In-Reply-To: <20060321153747.79f18016.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603211543430.14462@schroedinger.engr.sgi.com>
References: <20060321213803.GC26124@sgi.com> <20060321153747.79f18016.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Andrew Morton wrote:

> hm.  Last time around I pointed out that we should be checking that all
> handlers for this IRQ agree about the percpuness.  What happened to
> that?

Maybe simply add this patch on top?

Index: linux-2.6.16-rc6-mm2/kernel/irq/manage.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/kernel/irq/manage.c	2006-03-21 15:41:26.000000000 -0800
+++ linux-2.6.16-rc6-mm2/kernel/irq/manage.c	2006-03-21 15:43:15.000000000 -0800
@@ -204,6 +204,8 @@ int setup_irq(unsigned int irq, struct i
 #if defined(ARCH_HAS_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
 	if (new->flags & SA_PERCPU_IRQ)
 		desc->status |= IRQ_PER_CPU;
+	else
+		BUG_ON(desc->status & IRQ_PER_CPU);
 #endif
 	p = &desc->action;
 	if ((old = *p) != NULL) {
