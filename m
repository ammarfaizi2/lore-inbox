Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281856AbRKWB3g>; Thu, 22 Nov 2001 20:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281862AbRKWB30>; Thu, 22 Nov 2001 20:29:26 -0500
Received: from mta04ps.bigpond.com ([144.135.25.136]:9196 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S281861AbRKWB3N>; Thu, 22 Nov 2001 20:29:13 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updated parameter and modules rewrite (2.4.14) 
In-Reply-To: Your message of "Thu, 22 Nov 2001 11:08:28 BST."
             <200111221008.fAMA8Sa04042@ns.caldera.de> 
Date: Fri, 23 Nov 2001 12:28:17 +1100
Message-Id: <E16758b-0001xO-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200111221008.fAMA8Sa04042@ns.caldera.de> you write:
> In article <E166p1R-0004ll-00@wagner> you wrote:
> >    http://ftp.kernel.org/pub/linux/kernel/people/rusty
> >
> > 	Unified boot/module parameter and module loader rewrite
> > updated to 2.4.14.  I'm off to Linux Kongress, so I'll be difficult to
> > contact for 10 days or so.
> 
> I absolutly oppose to the cosmetic naming changes.

Hi Christoph!

Um, me too.  I should have reposted my previous explanation, sorry!

> Please let module be be initialized by module_init() and exited by
> module_exit().  We had a hard enough time to get it everywhere, not
> to mention the name makes a lot of sense.

Unfortunately, removal needs to be done in two stages, to sanely make
things like IPv6 modular (a deactivate, and a kill stage).  It turns
out that this applies to loading as well, in case the loading fails
part way through (there's also a number of modules at the moment which
initialize in the wrong order, which can lead to an oops).

> Also MODULE_PARAM should just stay, combined with Keith's proposal
> to use it at boottime aswell (as KBUILD_OBJECT.<paramname>).

Firstly, Keith and I agree on KBUILD_OBJECT[/.]paramname, BTW.  I'm
not sure it was his proposal originally, though: it's a pretty simple
and old idea.

The previous module param stuff was prone to user bugs (no type
checking), was not extensible, and required duplicated code for boot
time.  It also did not have the option of appearing in /proc.

It is possible to write macros mapping the NEW macros to the OLD, but
not vice versa, otherwise I wouldn't change at all.

Hope that clarifies,
Rusty.
--
Premature optmztion is rt of all evl. --DK
