Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbTIHQ7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTIHQ7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:59:17 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:37007 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263061AbTIHQ7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:59:07 -0400
Date: Mon, 8 Sep 2003 17:58:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nasm over gas?
Message-ID: <20030908165831.GA27097@mail.jlokier.co.uk>
References: <rZQN.83u.21@gated-at.bofh.it> <saVL.7lR.1@gated-at.bofh.it> <soFo.16a.1@gated-at.bofh.it> <ssJa.6M6.25@gated-at.bofh.it> <tcVB.rs.3@gated-at.bofh.it> <3F5C7009.4030004@softhome.net> <20030908161729.GB26829@mail.jlokier.co.uk> <3F5CB218.5030203@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5CB218.5030203@softhome.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ihar 'Philips' Filipau wrote:
> Jamie Lokier wrote:
> >Ihar 'Philips' Filipau wrote:
> >
> >> It will depend on arch CPU only in case if you have unlimited i$ size.
> >> Servers with 8MB of cache - yes it is faster.
> >> Celeron with 128k of cache - +4bytes == higher probability of i$ miss 
> >>== lower performance.
> >
> >Higher probability != optimal performance.
> >
> >It depends on your execution context.  If it's part of a tight loop
> >which is executed often, then saving a cycle in the loop gains more
> >performance than saving icache, even on a 128k Celeron.
> >
> 
>   You think as system-programmer.
>   Every bit of i$ waste - hit user space applications too.
>   128k of $ - is for every app.
> 
>   If you gained one cycle by polluting one more cache line - do not 
> forget that this cache line probably contained some info, which was able 
> to avoid cache miss for another application. So you gained cycle here - 
> and lost it immediately in another app. Not good.

Usually the whole L1 cache is flushed between appliation context
switches anyway, so the cost of a miss is borne by the application
which causes it.

And that _still_ doesn't change the truth of my statement.  One cycle
saved in a loop which executes 1000 times is worth more than an L1
i-cache miss, always.

>   If you can improve performance by NOT polluting cache - it would be 
> another story :-)))

Yes, of course that is better when it is possible.

Modern OOO CPUs are subtle beasts.  Like I said, I added a single
"nop" (one-byte instruction) to a tight graphics loop once, and the
loop went significantly faster.  I could not explain it, except that I
know the Pentium Pro instruction decode stage has many quirks.

>   But still I never saw this kind of thing being used in kernel. 
> Instead of writing normal asm we have something like i386/mmx.c. And 
> i386/checksum.S not the best sample of asm in kernel too. Sad.

Those were written before GAS had a macro facility.  I agree with you,
it should be used more in the kernel.

The two examples you gave have been carefully tuned on particular
CPUs, by trial and error.  Changing the instruction order makes a big
difference to their performance.

-- Jamie
