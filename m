Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWGGWO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWGGWO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWGGWO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:14:29 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12933 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932346AbWGGWO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:14:28 -0400
Date: Sat, 8 Jul 2006 00:09:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060707220954.GA23651@elte.hu>
References: <m34pxt8emn.fsf@defiant.localdomain> <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com> <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org> <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5004]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* linux-os (Dick Johnson) <linux-os@analogic.com> wrote:

> >> Now Linus declares that instead of declaring an object volatile
> >> so that it is actually accessed every time it is referenced, he wants
> >> to use a GNU-ism with assembly that tells the compiler to re-read
> >> __every__ variable existing im memory, instead of just one. Go figure!
> >
> > Actually, it's not just me.
> >
> > Read things like the Intel CPU documentation.
> >
> > IT IS ACTIVELY WRONG to busy-loop on a variable. It will make the CPU
> > potentially over-heat, causing degreaded performance, and you're simply
> > not supposed to do it.
> 
> This is a bait and switch argument. [...]

how could it possibly be? Linus has simply replied to your point:

> > > If I have some code that does:
> > > 
> > > extern int spinner;
> > > 
> > > funct(){
> > >      while(spinner)
> > >            ;
> > >
> > > The 'C' compiler has no choice but to actually make that memory 
> > > access and read the variable [...]

Linus observed that the only possible purpose of the code you cited, 
busy-looping, makes no sense.

If you dont intend to busy-loop, why does the code above look like a 
busy-loop, and what do you need the volatile keyword for?

> [...] In fact, your spin-lock code already inserts "rep nops" and I 
> never implied that they should be removed. I said only that "volatile" 
> still needs to be used, not some macro that tells the compiler that 
> everything in memory probably got trashed. [...]

your position here does seem to make much sense to me, so please help me 
understand it. You suggest that the assembly code should be left alone. 
But then why do you need the volatile keyword to begin with?

> Well, in fact I do know what I'm talking about. Your bait-and-switch 
> arguments just won't work with me.

you seem to be quite self-confident. That is a nice thing to have for 
say a pro boxer, but it can be a disadvantage when dealing with a 
complex OS. Just curious, if you turn out to be wrong will you apologize 
for wasting Linus' (and others') time and for insulting him like that? 
(Or is this a totally impossible scenario not even worth discussing?)

> > Repeat after me (or just shut up about things that you not only don't know
> > about, but are apparently not willing to even learn):
> >
> > 	"'volatile' is useless. The things it did 30 years ago are much
> > 	 more complex these days, and need to be tied to much more
> > 	 detailed rules that depend on the actual particular problem,
> > 	 rather than one keyword to the compiler that doesn't actually
> > 	 give enough information for the compiler to do anything useful"
> >
> > Comprende?

here Linus claims that 'volatile' is useless and that the use of 
'volatile' is almost always a sign of bugs. That includes your 
code-samples too. So a proper answer on a technical forum like lkml 
would _not_ be to ignore Linus' point like you did, but to answer it 
directly. There are a couple of ways to answer it:

- you could explain why your sample code _does_ make sense. That's a 
  powerful way of making your point and you'll sure see an answer 
  either rebutting your point or conceding the point.

- or if you know that it makes no sense (minor nit: in which case you 
  should have pointed that out when writing them) then you could either
  correct it, or cite actual kernel code to which your point applies.

- an even better (and by far my most favorite) method of reply would be 
  if you sent an actual kernel patch (ontop of 2.6.18-rc1 plus my 
  volatile-removal patch) that implements your suggestions! That
  would be a perfect way of making your point - one line of patch is 
  worth a thousand words.

	Ingo
