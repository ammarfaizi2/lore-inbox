Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316973AbSGCIfj>; Wed, 3 Jul 2002 04:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316974AbSGCIfi>; Wed, 3 Jul 2002 04:35:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19108 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316973AbSGCIfh>;
	Wed, 3 Jul 2002 04:35:37 -0400
Date: Wed, 3 Jul 2002 10:35:26 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rob Landley <landley@trommello.org>
Cc: Tom Rini <trini@kernel.crashing.org>, "J.A. Magallon" <jamagallon@able.es>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
In-Reply-To: <200207030709.g6379pL378262@pimout2-int.prodigy.net>
Message-ID: <Pine.LNX.4.44.0207031006050.3017-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Jul 2002, Rob Landley wrote:

> If you want stone tablet stability, why the heck are you upgrading your
> kernel? [...]

to get security and stability fixes.

> The argument here is basically "don't change anything".  It's not
> exactly a series then, is it?  If you want trailing edge, 2.0 is still
> being maintained, let alone 2.2.  Those have a great excuse for not
> accepting anything new beyond a really obvious bugfix.  2.4 does not,
> because 2.6 isn't out yet.  Backporting of somethings from 2.5 to 2.4
> will occur until then, and O(1) is an obvious eventual candidate.

it might be a candidate for inclusion once it has _proven_ stability and
robustness (in terms of tester and developer exposion), on the same order
of magnitude as the 2.4 kernel - but that needs time and exposure in trees
like the -ac tree and vendor trees. It might not happen at all, during the
lifetime of 2.4.

Note that the O(1) scheduler isnt a security or stability fix, neither is
it a driver backport. It isnt a feature backport that enables hardware
that couldnt be used in 2.4 before. The VM was a special case because most
people agreed that it truly sucked, and even though people keep
disagreeing about that decision, the VM is in a pretty good shape now -
and we still have good correlation between the VM in 2.5, and the VM in
2.4. The 2.4 scheduler on the other hand doesnt suck for 99% of the
people, so our hands are not forced in any way - we have the choice of a
'proven-rock-solid good scheduler' vs. an 'even better, but still young
scheduler'.

if say 90% of Linux users on the planet adopt the O(1) scheduler, and in a
year or two there wont be a bigger distro (including Debian of course)
without the O(1) scheduler in it [which, admittedly, is happening
already], then it can and should perhaps be merged into 2.4. But right now
i think that the majority of 2.4 users are running the stock 2.4
scheduler.

> So the fact that it's in Alan Cox's kernel (meaning Red Hat is shipping
> it in 2.4.18-5.55, meaning that if more people aren't actually USING it
> yet than marcelo's 2.4, they will be soon), and andrea's kernel (meaning
> new VM development is being done with it in mind)...  It may not be
> "sufficiently tested" yet but it's GETTING a lot of testing.  You use
> anything EXCEPT a stock vanilla 2.4, you're probably getting O(1) at
> this point.

things like migration to a new kernel happen on a slighly slower scale
than the 6 months this patch has existed. I'd say in 1 year what you say
might be true. 70% of the Linux users are not running the 'very latest'
release.

also note that the O(1) scheduler patch in the Red Hat kernel rpm was a
stability fork done months ago, with stability fixes backported into it.  
The 2.4 O(1) patches being distributed now are more like direct backports
of the 2.5 scheduler - this way we can get testing and feedback even from
those people who do not want to (or cannot) run a 2.5 kernel due to the
massive IO changes being underway.

i do not say that the O(1) scheduler has bugs (if i knew about any i'd
have fixed it already :), i am simply saying that to be able to say to
Marcelo "it does not have bugs and does not introduce problems" it needs
more exposure. [ And if the author of a given piece of code says things
like this then it usually does not get merged ;-) ]

> not there on the scheduler yet, but "should not happen" without a
> qualifier means "never"...

we agree here.

> The real question is, how much MORE conservative than the distros should
> the mainline kernels be?

There's a natural 'feature race' between distros, so the distros can act
as an additional (and pretty powerful) testing tool for various kernel
features - and for which the distros are willing to spend resources and
take risks as well. In fact they also act as a 'user demand' filter, for
kernel features as well. And if all distros pick up a given feature, and
it's been in for more than 6 months, (instead of 'more than 6 months since
first patch') then Marcelo will have a much easier decision :-)

	Ingo

