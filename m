Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTIHKRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 06:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTIHKRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 06:17:10 -0400
Received: from angband.namesys.com ([212.16.7.85]:64452 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262193AbTIHKRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 06:17:06 -0400
Date: Mon, 8 Sep 2003 14:17:04 +0400
From: Oleg Drokin <green@namesys.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Nikita Danilov <god@namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030908101704.GE10487@namesys.com>
References: <slrnbl12sv.i4g.erik@bender.home.hensema.net> <3F50D986.6080707@namesys.com> <20030831191419.A23940@bitwizard.nl> <20030908081206.GA17718@namesys.com> <20030908105639.B26722@bitwizard.nl> <20030908090826.GB10487@namesys.com> <20030908113304.A28123@bitwizard.nl> <20030908094825.GD10487@namesys.com> <20030908120531.A28937@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908120531.A28937@bitwizard.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Sep 08, 2003 at 12:05:31PM +0200, Rogier Wolff wrote:
> > Well, but statfs(2) does not return an "inodes in use" value, that's it.
> > > #define LARGE_NUMBER 100000
> > > out->total_inodes = fs->oids_in_use + LARGE_NUMBER; 
> > > if (out->total_inodes < fs->oids_in_use) 
> > >    out -> total_inods = MAXINT;
> > > out -> free_inodes = LARGE_NUMBER; 
> > > Three lines of code fixes that. 
> > Yes, and you get complete crap once you hit the overflow condition?
> No. Not complete crap. It's a thirty two bit integer. What do you expect
> when you hit the "limit"?

I prefer there to be no limit ;)

> What will ext2 report when you have 4G inodes in use?

This is basically not possible on 32 bit architectures now (and not a problem for 64 bit ones).
We limit ourselves to at least 512 bytes blocks.
You only can have as many inodes as number of blocks on the fs (at least that's the limit imposed on you
by mke2fs).
So 2Tb fs gives you ~4G inodes with 512 bytes blocksize.
Yes, I know there is this support for bigger blockdevices in 2.6, but who will use
those with that small blocksizes anyway?

> Just capping is the best way. 

May be.
At least people in here seems to like the idea so we will implement it.

> Anyway, I happen to (also) work for a company called
> "harddisk-recovery.nl". We get to see varying types of uses for
> harddisk and their contents. So far we've had two clients with more
> than half a million files. One had 3.6 and the other had 4.7 million
> files. Trust me, those are extreme. Oh, and we have on the order of 10
> million files ourselves (but notquite that many inodes!). We're
> extreme.

Hm.

> > > old interface. Remember you can read/write/seek files using the 32bit
> > > interface even though the new (seek-, and stat-) interface uses 64
> > > bits.
> > You need to open a file with O_LARGEFILE first, so old binaries
> > still won't work.
> 1) I can still work on files smaller than 2G without problems. 

Yes, that's for sure ;)

> 2) If my shell uses O_LARGEFILE, I can redirect stdin and stdout
> to large files anyway, even if the app would open without O_LARGEFILE. 

Yes, missed this case ;)

Bye,
    Oleg
