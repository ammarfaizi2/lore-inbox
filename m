Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266059AbTGDP7J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 11:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266062AbTGDP7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 11:59:09 -0400
Received: from voldemort.codesourcery.com ([65.73.237.138]:35529 "EHLO
	mail.codesourcery.com") by vger.kernel.org with ESMTP
	id S266059AbTGDP7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 11:59:06 -0400
From: "Zack Weinberg" <zack@codesourcery.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Garbage collectors and VM
References: <20030703184825.GA17090@mail.jlokier.co.uk>
	<87u1a2srwl.fsf@egil.codesourcery.com>
	<20030704120732.GD22105@mail.jlokier.co.uk>
Date: Fri, 04 Jul 2003 09:13:33 -0700
In-Reply-To: <20030704120732.GD22105@mail.jlokier.co.uk> (Jamie Lokier's
 message of "Fri, 4 Jul 2003 13:07:32 +0100")
Message-ID: <87d6gqs21e.fsf@egil.codesourcery.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Zack Weinberg wrote:
>> Thus, a new pseudo-device, with the semantics:
>
> I like it!  I'd use it, too.

Thanks.  Implementing it is way beyond me, but it's good to hear that
other people might find it useful.

>>  * Reading from the descriptor produces a list of user-space pointers
>>    to all the pages that have been reset to read-write since the last
>>    read.
>
> Would it be appropriate to have a limit on the number of pages which
> become writable before a signal is delivered instead of continuing to
> make more pages writable?  Just like the kernel, sometimes its good to
> limit the number of dirty pages in flight in userspace, too.

Maybe.  The GC I wanted to use this with is rather constrained in some
ways - it can't walk the stack, for instance - so it can only collect
when the mutator tells it it's okay.  I suppose it could just copy the
list to its own buffer and continue, which saves the kernel from
having to store a potentially very large list.

>>  * I never decided what to do if the program forks.  The application I
>>    personally care about doesn't do that, but for a general GC like
>>    Boehm it matters.
>
> It should clone the state, obviously, and COW should be invisible to
> the application :)

Well, yeah, that would be the cleanest thing, but it does require two
dirty bits.

> Btw, are these pages swappable?

They certainly ought to be.

> On a different but related topic, it would be most cool if there were
> a way for the kernel to request memory to be released from a userspace
> GC, prior to swapping the GC's memory.  Currently the best strategy is
> for each GC to guess how much of the machine's RAM it can use, however
> this is not a good strategy if you wish to launch multiple programs
> each of which has its own GC, nor is it a particularly good balance
> between GC application pages and other page-cache pages.

Again, this is not particularly useful to me since the collector can't
collect at arbitrary points - but it would be a good thing to have for
a general GC, and maybe I ought to be using a general GC anyway...

zw
