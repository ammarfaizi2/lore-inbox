Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262125AbRETRrz>; Sun, 20 May 2001 13:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262127AbRETRrp>; Sun, 20 May 2001 13:47:45 -0400
Received: from t2.redhat.com ([199.183.24.243]:24052 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262126AbRETRrg>; Sun, 20 May 2001 13:47:36 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010520131457.A3769@thyrsus.com> 
In-Reply-To: <20010520131457.A3769@thyrsus.com>  <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> 
To: esr@thyrsus.com
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 May 2001 18:47:31 +0100
Message-ID: <18686.990380851@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thankyou for the clarification.

esr@thyrsus.com said:
>  I used case 3 to explore a touchy question about design philosophy,
> which is really what caused all hell to break loose.  The question is
> this: holding down configuration complexity is a good thing, but
> supporting all hardware configurations that are conceivably possible
> is also a good  thing.  How should we trade these good things off
> against one another? 

I think you already have the mechanism required to answer this - in NOVICE 
mode you disallow the strange choices, in EXPERT mode you allow them.

Embedded boards are a special case in this respect - people add all manner
of strange crap to the reference designs - believe me, I've seen the ways in
which they can fuck it up and yet still they manage to amaze me sometimes.

And because of the multitude of ways in which the monkeys who glue together
these boards can fuck it up, often you really really want to ignore the
on-board Ethernet, for example, and use the PCMCIA card you plugged in,
because they actually managed to route the PCMCIA interrupt to an IRQ line,
not a GPIO pin.


esr@thyrsus.com said:
> So the real question here is whether it is ever acceptable to say that
> a possible configuration is just silly and ruleset will ignore it, in
> order to hold down ruleset complexity and simplify the user
> experience.  The cost of deciding that the answer to that question is
> "yes, sometimes" is that on rare occasions like this one you might
> have to haul out a text editor to tweak something in your config.

As I said earlier, there are two main cases which should be considered
entirely separately. There are the cases which are insane, and which won't
ever work, or probably even compile. Those should be hard-coded off in the 
ruleset and it should not be possible to enable them without hacking.

For the cases where we just want to make life simpler for the users, the 
constraints should be dependent on the user mode. In NOVICE mode you hide 
them, in EXPERT mode you make them available.



The current (CML1) solution has problems, and it only provides real support 
for a small range of people at the hacker end of the spectrum.

Making CML2 useful for a far wider range of people is a laudable goal. But
please take care to ensure that the set of people for whom CML2 is useful is
a strict superset of those for whom CML1 was useful.

In particular, please don't strive to make Aunt Tillie happy on the one
occasion on which she configures her kernel at a cost of rendering CML2 less
useful for those for whom kernel configuration is an every-day task. Once 
weighted appropriately, that tradeoff is particularly easy to decide upon.

If you ever find yourself seriously suggesting that a developer would need
to ditch CML2 and hack the config files directly in order to compile support
for, for example, the DiskOnChip he just dropped into the DIL socket in his
Ethernet card, then I would suggest that you have made a wrong choice
somewhere down the road. Please backtrack and reconsider an earlier decision
before you're eaten by a grue.

We already have a distinction between config options which it's sensible to 
ask the user, and options for which you have to hack #defines in the source 
code. The options which I have put into drivers/mtd/Config.in are there 
because I _wanted_ the user to see them. The options which are hidden in 
the code are there because I made the opposite decision.

There is a reasonably well-defined boundary for such things already, and
it's found all over the kernel. Adding a new, higher boundary for Aunt
Tillie is just fine - but please don't _move_ the existing one that most of
us care about.

--
dwmw2


