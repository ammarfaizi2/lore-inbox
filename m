Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSGWEet>; Tue, 23 Jul 2002 00:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317951AbSGWEes>; Tue, 23 Jul 2002 00:34:48 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:43653 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317950AbSGWEeV>; Tue, 23 Jul 2002 00:34:21 -0400
Date: Mon, 22 Jul 2002 22:37:09 -0600
Message-Id: <200207230437.g6N4b9S23747@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit 
In-Reply-To: <Pine.GSO.4.21.0207221216240.6045-100000@weyl.math.psu.edu>
References: <200207190019.g6J0JrM28129@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0207221216240.6045-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> On Thu, 18 Jul 2002, Richard Gooch wrote:
> > Can you point to specific problems with the current devfs code?
> 
> Sigh...  How many do you want?  Look, couple of days ago I'd done
> the following: picked a random number in range 1..`wc -l
> fs/devfs/base.c`, checked what function it was in (devfs_readdir())
> and spent less than two minutes reading it before finding a bug (a
> leak - there's a couple of paths that grab an entry and return
> without releasing it).

Ouch. I see what you're referring to: if *readdir() fails, the devfs
entry is not cleaned up. I've fixed that in my tree, as well as made
the (minor) optimisation of avoiding re-taking the parent lock on
error.

> So tell me how many times I should repeat that exercise and while
> you are at it, tell me what stops you from doing the same.

Well, I *have* looked at it. But after a while, it gets harder to spot
bugs because it gets stale. That's why a fresh pair of eyes is so
valuable.

> Because you know, reading devfs code is something I'd rather avoid -
> it's not my idea of fun reading.  IF it will stop you from claiming
> "Al hadn't done public whippings lately, so devfs is bug-free" for a
> couple of months - by all means, tell how many bugs do I need to
> find and report to shut you up for a while.

How about just letting me know about all the bugs you find? I would
find that helpful.

> Richard, devfs code is _ripe_ with bugs; you can't spit into it
> without hitting one.  And excuse me, but when finding one is a
> matter of two minutes I can't believe that you are incapable of
> doing that on your own.  It used to be annoying; by now it's beyond
> annoying - it's ridiculous.

I find it hard to believe that the code is ripe with bugs. While there
may be one or two bugs still lurking, the code overall looks to be in
pretty good shape. All the work I put into adding the locking and
refcounting has paid off. Is it just bad luck that you randomly looked
at devfs_readdir() and found one of the (hopefully few) bugs? Or have
you actually seen a large number of bugs that justifies the "ripe"
label?

I could just go and read the code periodically, looking for bugs, but
I'd quickly burn out, and the incremental benefit would likely be
minor. A fresh pair of eyeballs is much better. And that is supposed
to be the power of open source.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
