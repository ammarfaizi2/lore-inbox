Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271750AbRHURUJ>; Tue, 21 Aug 2001 13:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271748AbRHURUA>; Tue, 21 Aug 2001 13:20:00 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:4000 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271750AbRHURTt>; Tue, 21 Aug 2001 13:19:49 -0400
Date: Tue, 21 Aug 2001 11:19:22 -0600
Message-Id: <200108211719.f7LHJMS18142@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Theodore Tso <tytso@mit.edu>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Johan Adolfsson <johan.adolfsson@axis.com>,
        Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <3B822D2E.69D4380A@evision-ventures.com>
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com>
	<2248596630.998319423@[10.132.112.53]>
	<3B811DD6.9648BE0E@evision-ventures.com>
	<20010820211107.A20957@thunk.org>
	<200108210136.f7L1aa008756@vindaloo.ras.ucalgary.ca>
	<3B822D2E.69D4380A@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki writes:
> Richard Gooch wrote:
> > 
> > Theodore Tso writes:
> > > On Mon, Aug 20, 2001 at 04:25:26PM +0200, Martin Dalecki wrote:
> > > >
> > > > The primary reson of invention of /dev/random was the need
> > > > for a bit of salt to the initial packet sequence number inside
> > > > the networking code in linux. And for this purspose the
> > > > whole /dev/*random stuff is INDEED a gratitious overdesign.
> > > > For anything else crypto related it just doesn't cut the corner.
> > >
> > > A number of other people helped me with the design and development of
> > > the /dev/random driver, including one of the primary authors of the
> > > random number generation routines in PGP 2.x and 5.0.  Most folks feel
> > > that it does a good job.
> > 
> > Indeed. If Martin has some deep insight as to why the /dev/random
> > implementation is insufficient for strong crypto, I'd like to hear
> > it.
> 
> I don't think that it's unsufficient. In fact I think that it just
> doesn't have to be done all inside the kernel.

This is inconsistent with your earlier comment "for anything else
crypto related it just doesn't cut the corner". So are you retracting
that statement?

> And I oppose further extending the places where the event gathering
> code goes in between.
> 
> BTW> There is one strong flaw in the resoning behing this whole entropy
> stuff.
> 
> Iff you trust the cryptographic algorithm for the one way function
> you are using then if you initialize it once - there will be only
> one chance for an attacker to tamper with the values. The
> possibility for tampering with it will have a certain value, which
> remains CONSTANT over the time. You could call it: breaking risk as
> well.

I'm fairly confident that a user on the system can't tamper with my
mouse movements and keyboard presses. As for other interrupt sources
(such as network, disc and so on) which may be vulnerable to
"tampering" (i.e. injection or monitoring of timing data), that's why
we have the concept of "entropy". Think of it as a measure of trust.

> If you continuously reinitialize your one way function, the
> propabilitie to tamper with them will ADD (of course not in pure
> arithmetic terms). An attacer simply get's multiple chances. And
> therefore the overall propability of tampering with the values
> delivered to the user by this device WILL INCREASE.

This is a completely flawed argument. The more entropy inputs there
are, the harder it is for an attacker to predict or control all of
them.

> Multiple initializations help only against cryptographic attacks -
> but THEY HURT overall security of the system, becouse they "open it
> up".

This doesn't make sense. If, as you say, something is better against
cryptographic attacks, then the overall security of the system is
better. A trivially obvious example is TCP.

> So this is indeed a serious FLAW inside the logics behind the
> implementation of this device.

The flaw is in your argument, which isn't logical, and uses
hand-waving in place of coherent step-by-step analysis of how
/dev/random is somehow harmful to security. Use of a few choice words
in uppercase isn't convincing. Furthermore, you talk about a risk to
system security, but you don't even clearly define what you mean be
that.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
