Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318268AbSHSK77>; Mon, 19 Aug 2002 06:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318278AbSHSK77>; Mon, 19 Aug 2002 06:59:59 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:45839 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S318268AbSHSK77>; Mon, 19 Aug 2002 06:59:59 -0400
Date: Mon, 19 Aug 2002 13:03:53 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Oliver Neukum <oliver@neukum.name>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <200208191225.22517.oliver@neukum.name>
Message-ID: <Pine.LNX.4.44.0208191248130.26653-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2002, Oliver Neukum wrote:

> Am Montag, 19. August 2002 12:15 schrieb Marco Colombo:
> > On Mon, 19 Aug 2002, Theodore Ts'o wrote:
> >
> > [...]
> >
> > > P.S.  /dev/urandom should probably also be changed to use an entirely
> > > separate pool, which then periodically pulls a small amount of entropy
> > > from the priamry pool as necessary.  That would make /dev/urandom
> > > slightly more dependent on the strength of SHA, while causing it to
> > > not draw down as heavily on the entropy stored in /dev/random, which
> > > would be a good thing.
> >
> > Shouldn't it be moved to userpace, instead? Pulling a small amount
> > of entropy from /dev/random can be done in userspace, too. And the
> 
> 1. You create a problem for in kernel users of random numbers.
> 2. You forgo the benefit of randomness by concurrent access to /dev/urandom
> 3. You will not benefit from hardware random number generators as easily.

You lost me. The kernel of course has "client" access to the internal
pool. And since the userspace reads from /dev/random, it benefits
from HRNG just the same way it does now. Point 2 is somewhat obscure
to me. The kernel has only one observer to deal with, in theory.
One that gains *all* the knowlegde about the internal pool the
kernel leaks, mainly by returning random bits to those who ask. Assuming
the observer has less than 100% knowledge of that is just overstimating
the entropy (== understimating the ability of the observer to guess
the internal state). And from the application standpoint, it could just
discard part of the values it gets from the PRNG, to emulate concurrent
access, but what for? The result is as good as the untouched PRNG
sequence...

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

