Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVCBXaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVCBXaC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVCBX2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:28:21 -0500
Received: from fmr19.intel.com ([134.134.136.18]:19148 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261320AbVCBXZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:25:41 -0500
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Date: Wed, 2 Mar 2005 15:18:39 -0800
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503021518.39359.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 14:21, Linus Torvalds wrote:
> This is an idea that has been brewing for some time: Andrew has mentioned
> it a couple of times, I've talked to some people about it, and today Davem
> sent a suggestion along similar lines to me for 2.6.12.
>
> Namely that we could adopt the even/odd numbering scheme that we used to
> do on a minor number basis, and instead of dropping it entirely like we
> did, we could have just moved it to the release number, as an indication
> of what was the intent of the release.
>
> The problem with major development trees like 2.4.x vs 2.5.x was that the
> release cycles were too long, and that people hated the back- and
> forward-porting. That said, it did serve a purpose - people kind of knew
> where they stood, even though we always ended up having to have big
> changes in the stable tree too, just to keep up with a changing landscape.
>
> So the suggestion on the table would be to go back to even/odd, but do it
> at the "micro-level" of single releases, rather than make it a two- or
> three-year release cycle.
>
> In this setup, all kernels would still be _stable_, in the sense that we
> don't anticipate any real breakage (if we end up having to rip up so much
> basic stuff that we have to break anything, we'd go back to the 2.7.x kind
> of numbering scheme). So we should fear odd releases, but track them, to
> make sure that they are good (if you don't track them, and problems won't
> be fixed in the even version either)
>
> But we'd basically have stricter concerns for an even release, and in
> particular the plan would be that the diff files would alternate between
> bigger ones (the 2.6.10->11 full diff was almost 5MB) and smaller ones (a
> 2.6.11->12 release would be a "stability only" thing, and hopefully the
> diff file would be much smaller).
>
> We'd still do the -rcX candidates as we go along in either case, so as a
> user you wouldn't even _need_ to know, but the numbering would be a rough
> guide to intentions. Ie I'd expect that distributions would always try to
> base their stuff off a 2.6.<even> release.
>
> It seems like a sensible approach, and it's not like the 2.4.x vs 2.5.x
> kind of even/odd thing didn't _work_, the problems really were an issue of
> too big granularity making it hard for user and developers alike. So I see
> this as a tweak of the "let's drop the notion althogether for now"
> decision, and just modify it to "even/odd is meaningful at all levels".
>
> In other words, we'd have an increasing level of instability with an odd
> release number, depending on how long-term the instability is.
>
>  - 2.6.<even>: even at all levels, aim for having had minimally intrusive
>    patches leading up to it (timeframe: a week or two)
>
> with the odd numbers going like:
>
>  - 2.6.<odd>: still a stable kernel, but accept bigger changes leading up
>    to it (timeframe: a month or two).
>  - 2.<odd>.x: aim for big changes that may destabilize the kernel for
>    several releases (timeframe: a year or two)
>  - <odd>.x.x: Linus went crazy, broke absolutely _everything_, and rewrote
>    the kernel to be a microkernel using a special message-passing version
>    of Visual Basic. (timeframe: "we expect that he will be released from
>    the mental institution in a decade or two").
>
> The reason I put a shorter timeframe on the "all-even" kernel is because I
> don't want developers to be too itchy and sitting on stuff for too long if
> they did something slightly bigger. In theory, the longer the better
> there, but in practice this release numbering is still nothing but a hint
> of the _intent_ of the developers - it's still not a guarantee of "we
> fixed all bugs", and anybody who expects that (and tries to avoid all odd
> release entirely) is just setting himself up for not testing - and thus
> bugs.
>
> Comments?


Why be so wishy washy?

You can't say all that good stuff and then end it with " in practice this 
release numbering is still nothing but a hint of the _intent_ of the 
developer" and expect this to work out for more than a couple of builds 
before things fall back to where they are today.

Keep the change sets for the even numbers bug fix and stability changes only.  

While your at it schedule a cut off rc number by which any moderately risky 
bug and stability changes are allowed into the even build cycle,  say RC2, 
after which only stability and bug fixes that are considered to be "safe" 
changes are accepted.

You could also consider using the RC2 rule for odd releases so that  there is 
plenty of time to hash out the bugs from the bigger changes.  Just reject big 
changes after RC2.  The developers will adjust and plan for that after a few 
releases.

Thrashing your users with regressions is a very bad thing.

--mgross

>
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

