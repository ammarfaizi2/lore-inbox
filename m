Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSHAU14>; Thu, 1 Aug 2002 16:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSHAU14>; Thu, 1 Aug 2002 16:27:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29123 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317114AbSHAU1x>;
	Thu, 1 Aug 2002 16:27:53 -0400
Date: Thu, 1 Aug 2002 16:31:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Thunder from the hill <thunder@ngforever.de>
cc: Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
In-Reply-To: <Pine.LNX.4.44.0208011328240.5119-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.GSO.4.21.0208011610020.12627-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Aug 2002, Thunder from the hill wrote:

> Hi,
> 
> On Wed, 31 Jul 2002, Alexander Viro wrote:
> > What the bleedin' hell is wrong with <name> <start> <len>\n - all in ASCII?  
> > Terminated by \0.  No need for flags, no need for endianness crap, no
> > need to worry about field becoming too narrow...
> 
> Well, why not long[] fields? Might be more powerful, and possibly not any 
> slower than ASCII.

More powerful in which way?  I see where it's less powerful - sizeof(long)
is platform-dependent and so is endianness.  More powerful?  Maybe, if
you have integers that do not have decimal representation.  I've never
heard of such beasts, but sure would appreciate some examples.

As for the Martin's comments...  Martin, if you can't write a function
that checks whether array of characters has a contents fitting the
description above - stand up and say so.  Aloud.  In public.

The fact that thousands of selfstyled "programmers" manage to screw that
up says only one thing - that they should not be allowed anywhere near
programming.  Because the same guys screw up in _anything_ they do,
no matter what data types are involved.  ASCII is tough?  Make it "arithmetics
is tough".  Examples on demand, including real gems like
	fread(&foo, sizeof(foo), 1, fp);
	if (foo.x >= 100000 || foo.y >= 100000)
		/* fail and exit */
	p = (char *)malloc(foo.x * foo.y);
	if (!p)
		/* fail and exit */
	for (i = 0; i < foo.x; i++)
		fread(p + i*foo.y. 1, foo.y, fp);
and similar wonders (if anybody wonders what's wrong with the code above,
you need to learn how multiplication is defined on int and compare 10^10 with
2^32).  And yes, it's real-life code, from often-used programs.  Used on
untrusted data, at that.

Should we declare that arithmetics is dangerous?

