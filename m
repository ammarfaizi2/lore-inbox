Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270289AbUJTW3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270289AbUJTW3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUJTWYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:24:43 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:29568 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S270551AbUJTWXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:23:05 -0400
Subject: Re: Stop people including linux/irq.h
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041020191626.G14627@flint.arm.linux.org.uk>
References: <20041020191626.G14627@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1098310762.4989.78.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 21 Oct 2004 08:19:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-10-21 at 04:16, Russell King wrote:
> -struct hw_interrupt_type {
> -	const char * typename;
> -	unsigned int (*startup)(unsigned int irq);
> -	void (*shutdown)(unsigned int irq);
> -	void (*enable)(unsigned int irq);
> -	void (*disable)(unsigned int irq);
> -	void (*ack)(unsigned int irq);
> -	void (*end)(unsigned int irq);
> -	void (*set_affinity)(unsigned int irq, cpumask_t dest);
> -};
> -
> -typedef struct hw_interrupt_type  hw_irq_controller;
> -
> -/*
> - * This is the "IRQ descriptor", which contains various information
> - * about the irq, including what kind of hardware handling it has,
> - * whether it is disabled etc etc.
> - *
> - * Pad this out to 32 bytes for cache and indexing reasons.
> - */
> -typedef struct irq_desc {
> -	unsigned int status;		/* IRQ status */
> -	hw_irq_controller *handler;
> -	struct irqaction *action;	/* IRQ action list */
> -	unsigned int depth;		/* nested irq disables */
> -	unsigned int irq_count;		/* For detecting broken interrupts */
> -	unsigned int irqs_unhandled;
> -	spinlock_t lock;
> -} ____cacheline_aligned irq_desc_t;
> -
> -extern irq_desc_t irq_desc [NR_IRQS];
> -

Hmm. How about suspend-to-disk (and -ram?), lkcd and the like saving and
restoring IRQ affinities?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

