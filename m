Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318911AbSHSPSF>; Mon, 19 Aug 2002 11:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318913AbSHSPSF>; Mon, 19 Aug 2002 11:18:05 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:11270 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S318911AbSHSPSE>; Mon, 19 Aug 2002 11:18:04 -0400
Date: Mon, 19 Aug 2002 17:21:58 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Oliver Neukum <oliver@neukum.name>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <200208191622.39957.oliver@neukum.name>
Message-ID: <Pine.LNX.4.44.0208191711500.26653-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2002, Oliver Neukum wrote:

> 
> > > 1. You create a problem for in kernel users of random numbers.
> > > 2. You forgo the benefit of randomness by concurrent access to
> > > /dev/urandom 3. You will not benefit from hardware random number
> > > generators as easily.
> >
> > You lost me. The kernel of course has "client" access to the internal
> > pool. And since the userspace reads from /dev/random, it benefits
> 
> The kernel users of random numbers may be unable to block.
> Thus the kernel has to have a PRNG anyway.
> You may as well export it.
> 
> > from HRNG just the same way it does now. Point 2 is somewhat obscure
> > to me. The kernel has only one observer to deal with, in theory.
> 
> In theory. In practice what goes out through eg. the network is
> most important. Additional accesses to a PRNG bitstream unknown
> outside make it harder to predict the bitstream.

Not at all. Let me (one process) read 1MB from /dev/urandom,
and analyze it. If I can break SHA-1, I'm able to predict *future*
/dev/urandom output, expecially if I keep draining bits from /dev/random.

And even if it was not the case, you don't necessary need to read
the PRNG output *in order* to be able to guess it. Every N bits you
read, you learn more about its internal state.

Despite that, you tells you I'm not able to capture outgoing network
packets as well?

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

