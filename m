Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTETIqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 04:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTETIqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 04:46:13 -0400
Received: from dp.samba.org ([66.70.73.150]:52654 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263637AbTETIqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 04:46:11 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-reply-to: Your message of "Tue, 20 May 2003 08:27:03 +0200."
             <Pine.LNX.4.44.0305200821010.2445-100000@localhost.localdomain> 
Date: Tue, 20 May 2003 18:55:29 +1000
Message-Id: <20030520085911.8AC522C12C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0305200821010.2445-100000@localhost.localdomain> you write:
> yes, but the damage has been done already, and now we've got to start the
> slow wait for the old syscall to flush out of our tree. It will a few
> years to get rid of the compat code, but we better start now. hch is
> perfectly right that the old futex multiplexer interface is quite ugly,
> the requeue op only made this even more prominent.

It's a judgement call: how simple it is to change vs. the amount of
damage done by not changing it.

I don't think it's worth changing, but I don't think we're going to
convince each other.

> > Comment says: /* Must be "naturally" aligned */.  This used to be true
> > in a much earlier version of the code, now AFAICT the requirement test
> > should be:
> > 

> > 	/* Handling futexes on multiple pages?  -ETOOHARD */
> > 	if (pos_in_page + sizeof(u32) > PAGE_SIZE)
> > 		return -EINVAL;
> 
> yes - but i'd rather enforce this for every futex, than to hit it in every
> 1000th app that manages to misalign a futex _and_ lay it across two pages.  

Good point.  I'd prefer to fix the comment though, since it's not
true.  How about changing it to something like:

      	/* We can't handle futexes across multiple pages: best to reject
	   any crazy alignment to save the users from themselves. */

> Also, it's only x86 that guarantees atomic instructions on misaligned
> futexes (even then it comes with a cycle penalty), are you sure this also
> works on other architectures? So i'd rather be a bit more strict with this
> requirement.

Sure.  My point was that this comment is actually from a v. early futex
version where the kernel actually did the atomic ops itself.

Hope that clarifies!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
