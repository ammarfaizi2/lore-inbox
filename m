Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318851AbSHRFUT>; Sun, 18 Aug 2002 01:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318852AbSHRFUT>; Sun, 18 Aug 2002 01:20:19 -0400
Received: from waste.org ([209.173.204.2]:20195 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318851AbSHRFUS>;
	Sun, 18 Aug 2002 01:20:18 -0400
Date: Sun, 18 Aug 2002 00:24:17 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818052417.GL21643@waste.org>
References: <20020818042818.GG21643@waste.org> <Pine.LNX.4.44.0208172141490.1829-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208172141490.1829-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 09:51:32PM -0700, Linus Torvalds wrote:
> 
> On Sat, 17 Aug 2002, Oliver Xymoron wrote:
> > 
> > > We might as well get rid of /dev/random altogether if it is not useful. 
> > 
> > If it's not accounting properly, it's not useful.
> 
> My point exactly.
> 
> And if it isn't useful, it might as well not be there.
> 
> And your accounting isn't "proper" either. It's not useful on a
> network-only device. It's just swinging the error the _other_ way, but
> that's still an error. The point of /dev/random was to have an estimate of
> the amount of truly random data in the algorithm - and the important word
> here is _estimate_. Not "minimum number", nor "maximum number".

The key word is actually conservative, as in conservative estimate.
Conservative here means less than or equal to.
 
> And yes, it still mixes in the random data, but since it doesn't account 
> for the randomness, that only helps /dev/urandom. 
> 
> And helping /dev/urandom is _fine_. Don't get me wrong. It just doesn't 
> make /dev/random any more useful - quite the reverse. Your patch will just 
> make more people say "/dev/random isn't useful, use /dev/urandom instead".

No, it says /dev/random is primarily useful for generating large
(>>160 bit) keys.

> Do you not see the fallacy of that approach? You're trying to make
> /dev/random safer, but what you are actually _doing_ is to make people not
> use it, and use /dev/urandom instead. Which makes all of the estimation
> code useless.

> THIS is my argument. Randomness is like security: if you make it too hard
> to use, then you're shooting yourself in the foot, since people end up
> unable to practically use it.

Actually, half of the point here is in fact to make /dev/urandom safer
too, by allowing mixing of untrusted data that would otherwise
compromise /dev/random. 99.9% of users aren't using network sampling
currently, after these patches we can turn it on for everyone and
still sleep well at night. See?

> The point of /dev/random was to make it _easy_ for people to get random
> numbers that we can feel comfortable about. The point of the accounting is
> not a theoretical argument, but a way to make us feel _comfortable_ with
> the amount of true randomness we're seeding in. It was not meant as a 
> theoretical exercise.

That is an interesting point. A counterpoint is if we account so much
as 1 bit of entropy per network interrupt on a typical system, the
system will basically _always_ feel comfortable (see
/proc/interrupts). It will practically never block and thus it is
again identical to /dev/urandom.

With my scheme, it's usefully distinguished from /dev/urandom for the
purposes of things such as one-time public key generation. 

See my note to RML about who actually uses it currently.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
