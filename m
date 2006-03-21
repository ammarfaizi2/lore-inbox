Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWCUXfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWCUXfd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWCUXfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:35:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8643 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965150AbWCUXfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:35:32 -0500
Date: Tue, 21 Mar 2006 15:37:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, clameter@sgi.com,
       jes@sgi.com
Subject: Re: [PATCH] Add SA_PERCPU_IRQ flag support
Message-Id: <20060321153747.79f18016.akpm@osdl.org>
In-Reply-To: <20060321213803.GC26124@sgi.com>
References: <20060321213803.GC26124@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich <sivanich@sgi.com> wrote:
>
> The generic request_irq/setup_irq code should support the SA_PERCPU_IRQ flag.
> 
> This patch was posted previously, but this one should build on all arch's.
> 
> Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>
> 
> Index: linux-2.6.15/kernel/irq/manage.c
> ===================================================================
> --- linux-2.6.15.orig/kernel/irq/manage.c	2006-03-20 13:11:01.766522017 -0600
> +++ linux-2.6.15/kernel/irq/manage.c	2006-03-21 15:26:12.305876769 -0600
> @@ -206,6 +206,10 @@ int setup_irq(unsigned int irq, struct i
>  	 * The following block of code has to be executed atomically
>  	 */
>  	spin_lock_irqsave(&desc->lock,flags);
> +#if defined(ARCH_HAS_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
> +	if (new->flags & SA_PERCPU_IRQ)
> +		desc->status |= IRQ_PER_CPU;
> +#endif
>  	p = &desc->action;
>  	if ((old = *p) != NULL) {
>  		/* Can't share interrupts unless both agree to */

hm.  Last time around I pointed out that we should be checking that all
handlers for this IRQ agree about the percpuness.  What happened to
that?
