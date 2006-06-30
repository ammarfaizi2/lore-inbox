Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbWF3N5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbWF3N5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 09:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWF3N5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 09:57:55 -0400
Received: from www.osadl.org ([213.239.205.134]:48787 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932711AbWF3N5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 09:57:55 -0400
Subject: Re: SA_TRIGGER_* vs. SA_SAMPLE_RANDOM
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: David Miller <davem@davemloft.net>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060629.141703.59468770.davem@davemloft.net>
References: <20060629.141703.59468770.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 16:00:07 +0200
Message-Id: <1151676007.25491.712.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On Thu, 2006-06-29 at 14:17 -0700, David Miller wrote:
> Since SA_SAMPLE_RANDOM is defined as "SA_RESTART", it
> could be just about any value.
> 
> On sparc, it's value is "2", so it aliases some of
> the SA_TRIGGER_* defines the new genirq code adds.
> And therefore we get a bunch of these on sparc64:
> 
> [   16.650540] setup_irq(2) SA_TRIGGERset. No set_type function available
> 
> (btw: missing space in the kernel log message between 'SA_TRIGGER'
>       and 'set' :-)
> 
> I can't see any reason why SA_SAMPLE_RANDOM is set to
> a signal mask value, or why IRQ flags are defined in
> linux/signal.h :-)
> 
> Anyways, probably the best bet for now is to define
> SA_SAMPLE_RANDOM explicitly to some value instead of
> relying on the arbitrary platform definition of SA_RANDOM.
> 
> Ingo could you cook up and submit a patch which does this?
> Thanks.

We have the same hassle with SA_INTERRUPT. The question arises, if we
should move the SA_XX flags for interrupts completely out of the signal
SA name space. Rename to IRQ_xxx and put them into interrupt.h.

	tglx



