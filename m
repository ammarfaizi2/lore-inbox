Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318926AbSHSQQU>; Mon, 19 Aug 2002 12:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318928AbSHSQQU>; Mon, 19 Aug 2002 12:16:20 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:36359 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S318926AbSHSQQT>; Mon, 19 Aug 2002 12:16:19 -0400
Date: Mon, 19 Aug 2002 18:20:14 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Marco Colombo <marco@esi.it>, Andreas Dilger <adilger@clusterfs.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Problem with random.c and PPC
In-Reply-To: <20020819152936.GD14427@waste.org>
Message-ID: <Pine.LNX.4.44.0208191744230.26653-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2002, Oliver Xymoron wrote:

> On Mon, Aug 19, 2002 at 05:11:03PM +0200, Marco Colombo wrote:
> > On Mon, 19 Aug 2002, Oliver Xymoron wrote:
> > 
> > > > If you need a weak solution (a perturbated PRNG), just read a few bits
> > > > from /dev/random at times (but in a controlled and defined way).
> > > 
> > > It might be helpful to think of /dev/urandom as akin to /dev/random with
> > > O_NONBLOCK. "Give me stronger bits if you got 'em" is desirable,
> > > otherwise this thread would be much shorter.
> > 
> > "desirable", yes, I see... B-). But I have to understand why, yet.
> > 
> > "Give me the best you can, but even 0 is ok" just serves to help people
> > waste resources. If your application is fine with (potentially)
> > guessable bits, you don't need /dev/random at all. If you do care
> > about a minimum, you know it in advance, so do fetch those bits
> > (and only them) from /dev/random, and use them. Yes, it may block,
> > but that's life.  Resources aren't infinite.
> 
> For most people, entropy input far exceeds entropy output and the pool
> is a finite size. There's no reason not to use these entropy bits as
> the pool is always full and we're discarding entropy constantly. It's

We're never "discarding" entropy. We're just feeling more and more
confortable in saying we've stored 'poolsize' random bits.

My point being: /dev/urandom is, by definition, for users that are fine
with 0 bits of true entropy. Why give them more?

But what you say is definitely true... on my desktop system I only need
to move the mouse a couple of times to fill the pool completely in a
matter of seconds. Once the first pool is "random enough" according
to our esteem (the entropy_count) it's ok feeding additional random data
to the second pool (used by urandom).

> only a problem when the pool is running low and we risk making
> /dev/random block.

as usual: problems arise when the resouce is low... B-)

> > I'm missing any real argument for having /dev/urandom logic into the
> > kernel.
> 
> Convenience and control of resource sharing. The latter is slightly
> under-implemented.

I see we're in disagreement, here. On the control part, I agree fully,
but it of course applies to /dev/random, too. 

I see little convenience in having /dev/urandom semantic in the kernel
(besides the fact it's already there, of course). You can easily write
an userland deamon which does the same, keeping its own pool and PRNG
algoritm, pulling bits from /dev/random at times, and only when the pool
is almost full. No inside knowledge required here (we may need a
get_random_bytes_if_count_is_over_threshold IOCTL for /dev/random, to
make things really clean). Or it can be done by a library, with
every application managing a pool of desidered size, and an algorithm
of desided crypto strengh, with the desired ratio of real random bits
in the random output (output "quality"), with optional safeguard 
tests (FIPS?) in place. It's just that I see no need to be in kernelland. 
It only requires a working /dev/random, which is definitely a kernel thing,
and a better defined API.

But I see I'm repeating myself, so we can just drop the discussion,
and peacefully live in disagreement... B-)

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

