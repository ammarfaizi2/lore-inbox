Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVCHVws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVCHVws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 16:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVCHVws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 16:52:48 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:2440 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261597AbVCHVwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 16:52:33 -0500
Message-ID: <422E1FA6.3070707@tmr.com>
Date: Tue, 08 Mar 2005 16:56:54 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <4226CA7E.4090905@pobox.com><20050302165830.0a74b85c.davem@davemloft.net> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

Okay, I stayed out of this until the dust has settled, but I do have a 
few thoughts.

First is that naming is important if people are to understand the 
release system, and I think a lot of people don't. So why not:

- put out -devN kernel for testing, lots of people don't know about -bk 
or how to patch. And have the changelog list only the major new features 
and bug fixes, no author, no date, just a list of the important changes. 
That means that the user can see, not internal performance tuning and such.

- call the first rc -rc0, which indicates that only bug fixes from this 
point on, and the level of stability (no much).

I think about rc1 people would be more willing to test, and if I have a 
problem and the -dev claims a solution, I would be more willing to test, 
which might catch more of the "this crap doesn't even compile" errors.

> So let's loook at how we could set that up. We need:

>  - some very _technical_ and objective rules on patches. And they should 
>    limit the patches severely, so that people can never blame the sucker 
>    who does the job. For example, I would suggest that "size" be one hard 
>    technical rule. If the patch is more than 100 lines (with context) in
>    size, it's not trivial any more. Really. Two big screenfuls (or four, 
>    for people who still use the ISO-ANSI standard 80x24 vt100)

It's your ruleset, but I think the next rule is adequate. If there's a 
serious problem, and the solution means fixing bad locking in 50 places 
easily identified, it's probably still worth fixing if there's no 
band-aid available.

In short, trust the maintainer to make a good call on this.
> 
>    Also, I'd suggest that a _hard_ rule (ie nobody can override it) would 
>    also be that the problem causes an oops, a hang, or a real security
>    problem that somebody can come up with an exploit for (ie no "there
>    could be a two-instruction race" crap. Only "there is a race, and
>    here's how you exploit it"). The exploit wouldn't need to be full code 
>    that gets root, but an explanation of it, at least.

Yeah.
> 
>  - a vetting process. You'd have ten people, and five of them would have 
>    to sign off on the patch, and even a single veto would shoot it down. 

Way overkill, if the maintainer can be trusted to either understand or 
pass the vetting to someone who does, more eyes increase the probability 
if someone rejecting a valid patch because they didn't understand it.
> 
>    Again, this is really to protect the sucker, and make it possible to
>    work: I don't think this can work with a creative person (everybody
>    else calls me "flaky", and I much prefer that "creative" word, it sounds
>    so much better), which I personally believe means that we don't _want_
>    people like Alan, Andrea, Andrew etc etc that have historically maintained
>    their own trees that sometimes have tried to do something like this.

I doubt he feels the need, paperwork for the sake of paperwork...
> 
>  - Finally: this tree never has any history past the "last release". When
>    a new kernel comes, the tree is frozen, and never to be touched again.

Which bouncds the effort to maintain a stable tree.

> Does this mean that some patches would never go into this tree? Yes. It
> would mean that patches that some people might feel very _strongly_ are
> good patches would never ever show up in this tree, but on the other hand,
> I can see this tree being useful regardless, and I think the lack of
> flexibility in this case is actually the whole _point_ of the tree. The 
> lack of flexibility is the very thing that makes this be the kind of base 
> that anybody else can then hang their own patches on top of. There should 
> never be a situation where "I'd like that tree, but I think xxxx was done 
> wrong".

As must be to be stable.
> 
> Might something like this make people happier? (I wrote "happy" rather
> than "happier" at first, but let's face it, people are better at whining
> than they are at being happy ;)

I think this is just what's needed, and it addresses both the delay in 
getting new features in as well as delay in getting fixes in a stable 
kernel.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
