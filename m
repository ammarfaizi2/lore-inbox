Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319365AbSHQHTP>; Sat, 17 Aug 2002 03:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319366AbSHQHTP>; Sat, 17 Aug 2002 03:19:15 -0400
Received: from waste.org ([209.173.204.2]:57252 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S319365AbSHQHTP>;
	Sat, 17 Aug 2002 03:19:15 -0400
Date: Sat, 17 Aug 2002 02:23:10 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
Message-ID: <20020817072310.GQ5418@waste.org>
References: <80256C17.00376E92.00@notesmta.eur.3com.com> <20020816195254.GL5418@waste.org> <200208161751.35895.henrique@cyclades.com> <20020817004520.GN5418@waste.org> <20020817060507.GM9642@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020817060507.GM9642@clusterfs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 12:05:07AM -0600, Andreas Dilger wrote:
> On Aug 16, 2002  19:45 -0500, Oliver Xymoron wrote:
> > Realistically, the hashing done by /dev/urandom is probably strong
> > enough for most purposes. It's as cryptographically strong as whatever
> > block cipher you're likely to use with it. /dev/random goes one step
> > further and tries to offer something that's theoretically
> > unbreakable. Useful for generating things like large public keys, less
> > useful for generating the session keys used by SSL and the
> > like. They're easier to break by direct attack.
> 
> One of the problems, I believe, is that reading from /dev/urandom will
> also deplete the entropy pool, just like reading from /dev/random.
> The only difference is that when the entropy is gone /dev/random will
> stop and /dev/urandom will continue to provide data.

Yep, this is a longstanding problem. Will look into it and a couple
other things once I get the my current batch of patches running
against -current.
 
BTW, did ttyso ever ACK your last set of random changes or is it safe
to assume it's unmaintained?

> If you are in there fixing things, it might make sense to have
> /dev/urandom extract entropy from the random pool far less often than
> /dev/random.  This way people who use /dev/urandom for a source of
> less-strong randomness (e.g. TCP sequence numbers or whatever), will
> not be shooting themselves in the foot for when they need a 2048-byte
> PGP key, if they are low on entropy sources.

Not sure this is an ideal fix. We might instead have an entropy
low-water mark (say 1/2 pool size), below which /dev/urandom will not
deplete the pool. This way when we have ample entropy, both devices
will behave like TRNGs, with /dev/urandom falling back to PRNG when a
shortage is threatened.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
