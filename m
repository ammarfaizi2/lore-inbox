Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318919AbSHSPZs>; Mon, 19 Aug 2002 11:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318923AbSHSPZs>; Mon, 19 Aug 2002 11:25:48 -0400
Received: from waste.org ([209.173.204.2]:2695 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318919AbSHSPZr>;
	Mon, 19 Aug 2002 11:25:47 -0400
Date: Mon, 19 Aug 2002 10:29:36 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Marco Colombo <marco@esi.it>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
Message-ID: <20020819152936.GD14427@waste.org>
References: <20020819140207.GC14427@waste.org> <Pine.LNX.4.44.0208191617400.26653-100000@Megathlon.ESI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208191617400.26653-100000@Megathlon.ESI>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 05:11:03PM +0200, Marco Colombo wrote:
> On Mon, 19 Aug 2002, Oliver Xymoron wrote:
> 
> > > If you need a weak solution (a perturbated PRNG), just read a few bits
> > > from /dev/random at times (but in a controlled and defined way).
> > 
> > It might be helpful to think of /dev/urandom as akin to /dev/random with
> > O_NONBLOCK. "Give me stronger bits if you got 'em" is desirable,
> > otherwise this thread would be much shorter.
> 
> "desirable", yes, I see... B-). But I have to understand why, yet.
> 
> "Give me the best you can, but even 0 is ok" just serves to help people
> waste resources. If your application is fine with (potentially)
> guessable bits, you don't need /dev/random at all. If you do care
> about a minimum, you know it in advance, so do fetch those bits
> (and only them) from /dev/random, and use them. Yes, it may block,
> but that's life.  Resources aren't infinite.

For most people, entropy input far exceeds entropy output and the pool
is a finite size. There's no reason not to use these entropy bits as
the pool is always full and we're discarding entropy constantly. It's
only a problem when the pool is running low and we risk making
/dev/random block.
 
> I'm missing any real argument for having /dev/urandom logic into the
> kernel.

Convenience and control of resource sharing. The latter is slightly
under-implemented.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
