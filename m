Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318908AbSHSPHJ>; Mon, 19 Aug 2002 11:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318911AbSHSPHJ>; Mon, 19 Aug 2002 11:07:09 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:774 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S318908AbSHSPHI>; Mon, 19 Aug 2002 11:07:08 -0400
Date: Mon, 19 Aug 2002 17:11:03 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Marco Colombo <marco@esi.it>, Andreas Dilger <adilger@clusterfs.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Problem with random.c and PPC
In-Reply-To: <20020819140207.GC14427@waste.org>
Message-ID: <Pine.LNX.4.44.0208191617400.26653-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2002, Oliver Xymoron wrote:

> > If you need a weak solution (a perturbated PRNG), just read a few bits
> > from /dev/random at times (but in a controlled and defined way).
> 
> It might be helpful to think of /dev/urandom as akin to /dev/random with
> O_NONBLOCK. "Give me stronger bits if you got 'em" is desirable,
> otherwise this thread would be much shorter.

"desirable", yes, I see... B-). But I have to understand why, yet.

"Give me the best you can, but even 0 is ok" just serves to help people
waste resources. If your application is fine with (potentially)
guessable bits, you don't need /dev/random at all. If you do care
about a minimum, you know it in advance, so do fetch those bits
(and only them) from /dev/random, and use them. Yes, it may block,
but that's life.  Resources aren't infinite.

I haven't seen the code, but I guess most programs don't even use
*/dev/random* output correctly. If you read 512 bits from it, you
only get 512 of the kernel 'best effort' for random bits. Using those
512 to produce a 512 bits long key it as optimistic as saying:
"the kernel is a (mathematically) perfect source of random bits".
You'd better scramble them to produce a 256 or 128 or 64 bits key
and hope for the best. (yes it drains away entropy bits even faster,
and yes that's being paranoid)

If you ride Linus' "we're living in a pratical world" horse, and say:
the application can't block, so let's use /dev/urandom, then a good
PRNG (+ all the crypto hiding you need) fits as well. And don't see
anything "sad" about it.

I'm missing any real argument for having /dev/urandom logic into the
kernel.

As regards /dev/random being as strong (and paranoid) as possible,
I'm 101% with you.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

