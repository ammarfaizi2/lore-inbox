Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270644AbRHSRIe>; Sun, 19 Aug 2001 13:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270647AbRHSRI1>; Sun, 19 Aug 2001 13:08:27 -0400
Received: from waste.org ([209.173.204.2]:6198 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S270644AbRHSRIR>;
	Sun, 19 Aug 2001 13:08:17 -0400
Date: Sun, 19 Aug 2001 12:08:31 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Robert Love <rml@tech9.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <riel@conectiva.com.br>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <998193404.653.12.camel@phantasy>
Message-ID: <Pine.LNX.4.30.0108191124430.740-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Aug 2001, Robert Love wrote:

> On 18 Aug 2001 22:36:00 -0500, Oliver Xymoron wrote:
> > But your claim is there _is_ entropy. If you think there is, go ahead and
> > use it. Via /dev/urandom. Yes, I know it's theoretically not secure, but
> > then neither is what you're proposing.
>
> I am only continuing this because I want to explain...
>
> I claim there is entropy from what?  The difference between interrupts
> for net devices?  Everyone agrees that there is.  The issues is that an
> external attacker could influence the interrupts to the net device, and
> thus make some assumptions about the state.

No, everyone does not agree. Entropy is the degree to which data is
unpredictable. If an attacker can know what's being added to the pool, its
entropy value is zero.[1]

My understanding is that net devices are still mixing data into the pool,
but with an entropy estimate of zero. This seems perfectly fair to me,
it's always safe to underestimate entropy. If they're not mixing data into
the pool at all any more, then that seems wrong to me - we should be
adding likely sources of entropy as well, even if we can't rely on them
enough to credit them.

> Again, /dev/urandom is just as "secure" as /dev/random.  Its the same
> pool.  The same stuff.  Except that /dev/random blocks when the entropy
> count hits 0.

The 'except' is the key difference. IFF the entropy estimate is correct
(less than or equal to the real entropy present in the pool), then the
data return by /dev/random is completely unknowable. /dev/urandom is still
quite strong cryptographically, but not 'perfect' (ignoring possible
bugs, of course).

What you're suggesting is weakening that model. If you care enough to use
/dev/random instead of /dev/urandom because of the -theoretical- security
differences, then you're actually concerned about attackers. Namely
attackers who can go after your network, perhaps taking over your routers
and gateways. By making /dev/random mark network data as real entropy, you
are just fooling yourself. The 'perfect' quality of /dev/random is lost,
and the theoretical difference between it and /dev/urandom vanishes.

So why go to the trouble? Just admit that you don't have enough real
entropy on your system and, if you find the risk acceptable, use
/dev/urandom. Adding a kernel option that says 'make /dev/random be
overconfident' is not the answer.

[1] The extent to which an attacker can mount a timing attack against the
interrupt generation on a fast NIC is unknown but we'd prefer not to be
surprised.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

