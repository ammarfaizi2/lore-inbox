Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSHAVXt>; Thu, 1 Aug 2002 17:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSHAVXt>; Thu, 1 Aug 2002 17:23:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17296 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317117AbSHAVXr>;
	Thu, 1 Aug 2002 17:23:47 -0400
Date: Thu, 1 Aug 2002 17:27:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: martin@dalecki.de
cc: Thunder from the hill <thunder@ngforever.de>,
       Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
In-Reply-To: <3D49A1CC.7080608@evision.ag>
Message-ID: <Pine.GSO.4.21.0208011709390.12627-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Aug 2002, Marcin Dalecki wrote:

> > As for the Martin's comments...  Martin, if you can't write a function
> > that checks whether array of characters has a contents fitting the
> > description above - stand up and say so.  Aloud.  In public.
> 
> Actually you asked me to just shut up. Becouse I assume that you guessed
> that I'm able to write the corresponding code?
> 
> I will anser anyway ;-)
> 
> Sure I'm able to do this. However if I hear the words parser I 
> immediately think *complete* parsers in the formal sense.
> Not a bunch of reg exp guessing. Neither do

Newsflash: for Homsky-3 grammar "reg exp guessing" _IS_ complete parser
in the formal sense.

> I think about that error prone scanning for '\0' or fumbling

OK.  So "check if n bytes starting at address p contain zero and return
the distance of first zero from p if they do and n if they do not" is
error-prone task?  Fiiine...

> So unless you provide me with a... well for example, *complete* BNF
> grammar definition of /proc I will always claim that using it or ASCII 
> based interfaces is:

What the devil does BNF for everything somebody decided to dump in some
file in procfs have to partition tables?

> > is tough".  Examples on demand, including real gems like
> > 	fread(&foo, sizeof(foo), 1, fp);
> > 	if (foo.x >= 100000 || foo.y >= 100000)
> > 		/* fail and exit */
> > 	p = (char *)malloc(foo.x * foo.y);
> > 	if (!p)
> > 		/* fail and exit */
> > 	for (i = 0; i < foo.x; i++)
> > 		fread(p + i*foo.y. 1, foo.y, fp);
> > and similar wonders (if anybody wonders what's wrong with the code above,
> > you need to learn how multiplication is defined on int and compare 10^10 with
> > 2^32).  And yes, it's real-life code, from often-used programs.  Used on
> > untrusted data, at that.
> 
> Storing the constants in question in the above code sample
> as ASCII at the start of where foo is pointing at, would have hardly
> saved the poor overworked programmers mind from precisely the same
> mistake he did above. (Needless to say that you actually forgott
> to mention that the code fails on <= 32 bit systems. Inestad of 
> providing te "hint" for guessing where the actual error is.)

Huh???

you: "it's easy to screw up when working with ASCII strings"
me: "tossers will find a way to screw up on anything, no matter what it is;
     see example of tosser screwing up on plain arithmetics"
you: "use of ASCII wouldn't help them in that case"

Sure thing, it wouldn't.  _Nothing_ short of acquiring some clue would.
Possible solutions:
	A) replace all arithmetics with BIGNUMs (and just you wait for
first out-of-memory)
	B) get rid of tossers.

Matter of taste, indeed, but I'd rather go for (B) - has a benefit of
solving many other problems.

