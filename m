Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317600AbSGVQ0A>; Mon, 22 Jul 2002 12:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317685AbSGVQ0A>; Mon, 22 Jul 2002 12:26:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6373 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317600AbSGVQZ7>;
	Mon, 22 Jul 2002 12:25:59 -0400
Date: Mon, 22 Jul 2002 12:29:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit 
In-Reply-To: <200207190019.g6J0JrM28129@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0207221216240.6045-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Jul 2002, Richard Gooch wrote:

> Alexander Viro writes:
> > Call them well-behaving modules if you wish.  For these the answers
> > are "yes"/"a lot of things can be"/"it's easy to handle".  What's
> > left?  The pieces of code with really complex interfaces.  And guess
> > what, race-prevention is complex for these guys - and it's not just
> > about rmmod races.  E.g. parts of procfs, sysctls and devfs are
> > still quite racy even if you compile everything into the tree and
> > remove all module-related syscalls completely.
> 
> Can you point to specific problems with the current devfs code?

Sigh...  How many do you want?  Look, couple of days ago I'd done the
following: picked a random number in range 1..`wc -l fs/devfs/base.c`,
checked what function it was in (devfs_readdir()) and spent less than
two minutes reading it before finding a bug (a leak - there's a couple
of paths that grab an entry and return without releasing it).

So tell me how many times I should repeat that exercise and while you
are at it, tell me what stops you from doing the same.  Because you
know, reading devfs code is something I'd rather avoid - it's not my
idea of fun reading.  IF it will stop you from claiming "Al hadn't
done public whippings lately, so devfs is bug-free" for a couple of
months - by all means, tell how many bugs do I need to find and report
to shut you up for a while.

Richard, devfs code is _ripe_ with bugs; you can't spit into it without
hitting one.  And excuse me, but when finding one is a matter of two
minutes I can't believe that you are incapable of doing that on your own.
It used to be annoying; by now it's beyond annoying - it's ridiculous.

