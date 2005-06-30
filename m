Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVF3F66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVF3F66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 01:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVF3F66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 01:58:58 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:9884 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262857AbVF3F6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 01:58:07 -0400
Date: Thu, 30 Jun 2005 01:57:47 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc without GFP_xxx?
In-Reply-To: <42C3081A.1040108@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0506300144530.14989@localhost.localdomain>
References: <42C3081A.1040108@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Jun 2005, Manfred Spraul wrote:

> Hi,
>
> One question from Linux-Tag was about the lack of documentation about/in
> the kernel. I try to maintain docbook entries when I modify code, even
> though I think it's mostly wasted time: Virtually noone reads it anyway,
> instead armchair logic on lkml.

Hmm, I do like to read the comments, see below.

>
> Steven wrote:
>
> >Here we see that task 2 can spin with interrupts off, while the first task
> >is servicing an interrupt, and God forbid if the IRQ handler sends some
> >kind of SMP signal to the CPU running task 2 since that would be a
> >deadlock.  Granted, this is a hypothetical situation, but makes using
> >spin_lock with interrupts enabled a little scary.
> >
> >
> Not, it's not even a hypothetical situation. It's an explicitely
> forbidden situation: SMP signals are sent with smp_call_function and the
> documentation to that function clearly says:

When I said _hypothetical_ I ment it.  That's basically stating that the
situation wont happen, but lets pretend that it will. And no, SMP signals
(on intel anyway) are sent with send_IPI_* which even smp_call_function
uses.

>  *
>  * You must not call this function with disabled interrupts or from a
>  * hardware interrupt handler or from a bottom half handler.
>  */
>

And if you had read my other emails you would have noticed that I
even mentioned this particular comment. When I said:

"This is probably the reason it is not allowed to call most IPIs from
interrupt or bottom half context."

Also, a comment doesn't force this, and there's no test in
smp_call_function that prevents a user from calling this form a
bottom_half!

-- Steve

