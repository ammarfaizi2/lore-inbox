Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271770AbRHUVpQ>; Tue, 21 Aug 2001 17:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271863AbRHUVpG>; Tue, 21 Aug 2001 17:45:06 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:64007 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271770AbRHUVor>; Tue, 21 Aug 2001 17:44:47 -0400
Subject: Re: /dev/random in 2.4.6
From: Robert Love <rml@tech9.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <2354423401.998425250@[10.132.112.53]>
In-Reply-To: <Pine.LNX.4.30.0108211258080.13373-100000@waste.org> 
	<2354423401.998425250@[10.132.112.53]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.20.07.08 (Preview Release)
Date: 21 Aug 2001 17:44:20 -0400
Message-Id: <998430297.3139.21.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-08-21 at 15:20, Alex Bligh - linux-kernel wrote:
> Only because if not, this argument is irrelevant, in that if SHA-1
> is not broken and can never be, then there is no point in the entropy
> measurement and blocking behaviour at all, and in this case, Robert's
> patch does no harm whatsoever.
>
> Perhaps I'm missing something, but /dev/urandom is only weaker than
> /dev/random NOW if SHA-1 is cracked (if not, the two are identical
> in 'strength'). And, in the extremely theoretical case that
> SHA-1 is crackable (perhaps with an attack that takes many days),
> then wanting to have gathered entropy before reading is useful.

I believe this is all correct.  If the one-way hash is uncrackable, then
we are never giving any clue to the state of the pool out, thus the
entropy estimate means nothing (entropy would never drop on read from
/dev/[u]random).

Thus, as you have pointed out, we have two situations:

One, SHA-1 is unbreakable: my patch does no harm, and (beneficently)
feeds the random pool with bits.

Two, SHA-1 is breakable: the patch, if _enabled_ and iff the entropy
estimate is too large (agreeable entirely possible) will weaken the
entropy estimate.  that is why you need to judge the situation.

> As you point out (above), and as did David, SHA-1 being cracked
> is a remote possibility in the extreme. But this scenario is the
> only one where Robert's patch could make a conceivable difference.
> If SHA-1 is invulnerable, then why argue against Robert's patch
> which merely stops some applications from not working on some machines.

True.  And, if we worry about SHA-1 being cracked, and network
interrupts having some air of predictability, then we might as well
worry up other interrupts causing an overestimate of entropy.

Its all a gamble.  Its all a theoretical estimate.

> But people obviously do have concerns about the reversibility of SHA-1,
> even if only at a very theoretical level, or they wouldn't be
> spending all this time arguing about the importance of metering entropy.
> 
> Adding entropy from the network and not accounting for it is probably
> better than nothing (as it makes the seeding problem better).
> 
> I propose not using Jiffies on machines other than some i386's, and
> not exposing /proc/interrupts 644 which reduces the attack space
> hugely.

agreed.

> IF you can observe packets, and IF you turn the config option
> on against advice [1] THEN the strength of /dev/random
> will be tainted IF and ONLY IF SHA-1 is breakable (in which
> case, as you point out, all sorts of other things break anyway).
> I consider this an acceptable risk.
> 
> [1] against the advice of a config option which should read
> 'DO NOT SWITCH THIS ON IF YOU BELIEVE THERE IS ANY CHANCE OF
> YOUR NETWORK PACKETS BEING OBSERVABLE AND YOU ARE WORRIED
> ABOUT THE SECURITY OF SHA-1' (but the same applies btw using k/b
> interrupts with wireless keyboards).

I will add this wording to the Configure.help of the next patch release.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

