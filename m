Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSHTNRj>; Tue, 20 Aug 2002 09:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSHTNRj>; Tue, 20 Aug 2002 09:17:39 -0400
Received: from waste.org ([209.173.204.2]:45756 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317073AbSHTNRi>;
	Tue, 20 Aug 2002 09:17:38 -0400
Date: Tue, 20 Aug 2002 08:21:24 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Tommi Kyntola <kynde@ts.ray.fi>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020820132123.GB19225@waste.org>
References: <20020819135222.GB14427@waste.org> <Pine.LNX.4.44.0208201134570.3350-100000@behemoth.ts.ray.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208201134570.3350-100000@behemoth.ts.ray.fi>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 11:59:49AM +0300, Tommi Kyntola wrote:
> On Mon, 19 Aug 2002, Oliver Xymoron wrote:
> > On Mon, Aug 19, 2002 at 01:43:59AM -0400, Theodore Ts'o wrote:
> > > On Sat, Aug 17, 2002 at 09:15:22PM -0500, Oliver Xymoron wrote:
> > >
> > > >  Assuming the interrupt actually has a nice gamma-like distribution
> > > >  (which is unlikely in practice), then this is indeed true. The
> > > >  trouble is that Linux assumes that if a delta is 13 bits, it contains
> > > >  12 bits of actual entropy. A moment of thought will reveal that
> > > >  binary numbers of the form 1xxxx can contain at most 4 bits of
> > > >  entropy - it's a tautology that all binary numbers start with 1 when
> > > >  you take off the leading zeros. This is actually a degenerate case of
> > > >  Benford's Law (http://mathworld.wolfram.com/BenfordsLaw.html), which
> > > >  governs the distribution of leading digits in scale invariant
> > > >  distributions.
> > > > 
> > > >  What we're concerned with is the entropy contained in digits
> > > >  following the leading 1, which we can derive with a simple extension
> > > >  of Benford's Law (and some Python):

> I think you have it slightly wrong there. By snipping away the first digit 
> from a number leaves you with, not Benford's distribution, but 
> uniform distribution, for which the Shannon entropy is naturally roughly
> the bitcount.

No, it's much more complicated than that - that doesn't give us scale
invariance. Observe that the distribution of the first and second
digits in base n is the same as the distribution of the first digit in
base n*2. The probability of finding a 0 as the second digit
base 10 is simply the sum of the probabilities of finding 10, 20,
30,..90 as the first digit, base 100, see? It's .1197, rather than the
expected .1. In base 2, the odds of the second digit being 0 is .58.

My original message included the code I used to calculate the
distribution, along with the calculated entropy content of n-digit
strings.

> Wether the bit count of the smallest of the three deltas is
> actually sufficient to guarantee us that amount of randomness in the 
> choice is another question. Like stated here already, it can be easily 
> fooled, and there's a strong possibility that it gets "fooled" already.

That's why my code makes a distinction between trusted and untrusted
sources. We will only trust sources that can't be used to spoof us.
Detecting spoofing is impossible.
 
> Some level of fourier analysis would be necessary to go further than what 
> we can with the deltas.

There's no point in going further. If an attacker is trusted, he can
send timing streams that would fool _any_ filter. An example is some
subset of the digits of pi, which appear perfectly evenly distributed
but are of course completely deterministic.
 
-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
