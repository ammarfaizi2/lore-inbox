Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263556AbUJ2Uhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbUJ2Uhm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbUJ2UfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:35:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:41348 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263514AbUJ2T44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:56:56 -0400
Date: Fri, 29 Oct 2004 12:56:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Steinmetz <ast@domdv.de>
cc: linux-os@analogic.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <41829C91.5030709@domdv.de>
Message-ID: <Pine.LNX.4.58.0410291249440.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org> <418292C7.2090707@domdv.de>
 <Pine.LNX.4.58.0410291212350.28839@ppc970.osdl.org> <41829C91.5030709@domdv.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, Andreas Steinmetz wrote:
> 
> If you still believe in features I can't find any manufacturer 
> documentation for, well, you're Linus so it's your decision.

It's not that I'm Linus. It's that I am apparently better informed than
you are, and the numbers you are looking at are irrelevant. For example,
have you even _looked_ at the Pentium M stack engine documentation, which
is what this whole argument is all about?

And the documentation you look at is not revelant. For example, when you
look at the latency of "pop", who _cares_? That's the latency to use the
data, and has no meaning, since in this case we don't actually ever use
it. So what matters is other things entirely, like how well the 
instructions can run in parallell.

Try it. 

	popl %eax
	popl %ecx

should one cycle on a Pentium. I pretty much _guarantee_ that

	lea 4(%esp),%esp
	popl %ecx

takes longer, since they have a data dependency on %esp that is hard to 
break (the P4 trace-cache _may_ be able to break it, but the only CPU that 
I think is likely to break it is actually the Transmeta CPU's, which did 
that kind of thing by default and _will_ parallelise the two, and even 
combine the stack offsetting into one single micro-op).

So my argument is that "popl" is smaller, and I doubt you can find a
machine where it's actually slower (most will take two cycles). And I am
pretty confident that I can find machines where it is faster (ie regular
Pentium).

Not that any of this matters, since there's a patch that makes all of this 
moot. If it works.

		Linus
