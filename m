Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVCCQ4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVCCQ4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVCCQ4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:56:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:9391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262080AbVCCQzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:55:38 -0500
Date: Thu, 3 Mar 2005 08:55:33 -0800
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303165533.GQ28536@shell0.pdx.osdl.net>
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> On Thu, 3 Mar 2005, Jeff Garzik wrote:
> In fact, if somebody maintained that kind of tree, especially in BK, it 
> would be trivial for me to just pull from it every once in a while (like 
> ever _day_ if necessary). But for that to work, then that tree would have 
> to be about so _obviously_ not wild patches that it's a no-brainer.
> 
> So what's the problem with this approach? It would seem to make everybody
> happy: it would reduce my load, it would give people the alternate "2.6.x
> base kernel plus fixes only" parallell track, and it would _not_ have the 
> testability issue (because I think a lot of people would be happy to test 
> that tree, and if it was always based on the last 2.6.x release, there 
> would be no issues.
> 
> Anybody?

Andres Salomon (-as patches) and I have been talking about that at least
regarding security fixes.  It's worth trying in a more complete and
formalized way.  Guess I can be branded a sucker ;-)

> I'll tell you what the problem is: I don't think you'll find anybody to do
> the parallell "only trivial patches" tree. They'll go crazy in a couple of
> weeks. Why? Because it's a _damn_ hard problem. Where do you draw the
> line? What's an acceptable patch? And if you get it wrong, people will
> complain _very_ loudly, since by now you've "promised" them a kernel that
> is better than the mainline. In other words: there's almost zero glory,
> there are no interesting problems, and there will absolutely be people who 
> claim that you're a dick-head and worse, probably on a weekly basis.
> 
> That said, I think in theory it's a great idea. It might even be 
> technically feasible if there was some hard technical criteria for each 
> patch that gets accepted, so that you don't have the burn-out problem. 
> 
> So let's loook at how we could set that up. We need:
> 
>  - a sucker who wants to do this, or a company that pays for somebody good 
>    to do this (and remember: "good" here doesn't necessarily have to mean 
>    technical genius, it's about taking abuse and being stable). The whole 
>    setup should be such that there can never be any question about the 
>    patches for _other_ reasons (to avoid the sucker becoming a target for 
>    abuse), so this person really to some degree would be fairly 
>    mechanical.
> 
>    Don't make it automated, though. That just gets us down the path of 
>    flaming about the scripts and automation. And I'm not claiming that we 
>    should aim for somebody _stupid_, I'm just claiming that it takes a
>    certain kind of person to do something that is not all that glamorous, 
>    and that puts you in the spot.
> 
>    We don't ever want to have that spark of "wouldn't this be cool" in
>    this project. 
> 
>  - some very _technical_ and objective rules on patches. And they should 
>    limit the patches severely, so that people can never blame the sucker 
>    who does the job. For example, I would suggest that "size" be one hard 
>    technical rule. If the patch is more than 100 lines (with context) in
>    size, it's not trivial any more. Really. Two big screenfuls (or four, 
>    for people who still use the ISO-ANSI standard 80x24 vt100)
> 
>    Also, I'd suggest that a _hard_ rule (ie nobody can override it) would 
>    also be that the problem causes an oops, a hang, or a real security
>    problem that somebody can come up with an exploit for (ie no "there
>    could be a two-instruction race" crap. Only "there is a race, and
>    here's how you exploit it"). The exploit wouldn't need to be full code 
>    that gets root, but an explanation of it, at least.
> 
>  - a vetting process. You'd have ten people, and five of them would have 
>    to sign off on the patch, and even a single veto would shoot it down. 
> 
>    Again, this is really to protect the sucker, and make it possible to
>    work: I don't think this can work with a creative person (everybody
>    else calls me "flaky", and I much prefer that "creative" word, it sounds
>    so much better), which I personally believe means that we don't _want_
>    people like Alan, Andrea, Andrew etc etc that have historically maintained
>    their own trees that sometimes have tried to do something like this.
> 
>  - Finally: this tree never has any history past the "last release". When
>    a new kernel comes, the tree is frozen, and never to be touched again.

I like this definition.  The only remaining question is what determines
a 2.6.x.y release?  One patch?  Sure if it's critical enough.  

>    If somebody _else_ wants to base things off this special "sucker tree", 
>    and make a fourth level tree that is based on the _previous_ stable 
>    tree, that's fine, but that's a separate process. He would be totally 
>    free to do so, but the rule is that this particular maintenance program 
>    _never_ gets stuck on an old kernel, like the vendor trees always are. 
> 
>    This is not a long-range tree, it would _purely_ be about one thing and
>    one thing only: the last stable kernel. The people involved (sucker and 
>    vetters all) would never have to remember two different trees, or care 
>    about problems that aren't in the top-of-tree. Keep ti simple, and keep 
>    the rules clear.
> 
> Does this mean that some patches would never go into this tree? Yes. It
> would mean that patches that some people might feel very _strongly_ are
> good patches would never ever show up in this tree, but on the other hand,
> I can see this tree being useful regardless, and I think the lack of
> flexibility in this case is actually the whole _point_ of the tree. The 
> lack of flexibility is the very thing that makes this be the kind of base 
> that anybody else can then hang their own patches on top of. There should 
> never be a situation where "I'd like that tree, but I think xxxx was done 
> wrong".
> 
> Might something like this make people happier? (I wrote "happy" rather
> than "happier" at first, but let's face it, people are better at whining
> than they are at being happy ;)

Heh, maybe people are happiest when they are whining ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
