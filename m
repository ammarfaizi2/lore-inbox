Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVA0St7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVA0St7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVA0St7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:49:59 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:11727 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262702AbVA0StN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:49:13 -0500
Message-ID: <41F937C0.4050803@comcast.net>
Date: Thu, 27 Jan 2005 13:49:36 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org> <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Linus Torvalds wrote:
> 
> On Thu, 27 Jan 2005, John Richard Moser wrote:
> 
>>What the hell?
> 
> 
> John. Stop frothing at the mouth already!
> 

I'm coarse, I'm not angry.

> Your suggestion of 256MB of randomization for the stack SIMPLY IS NOT 
> ACCEPTABLE for a lot of uses. People on 32-bit archtiectures have issues 
> with usable virtual memory areas etc.
> 
> 

It never bothered me on my Barton core or Thoroughbred, or on the Duron,
or the Thoroughbred downstairs.  Then again, I cut a gig and a half out
on top of that too with SEGMEXEC, so I'm probably answering "most people
are afraid of firecrackers" with "I stood through an atomic explosion
and it didn't bother me."

If it's simply not acceptable to do more than a few megs of
randomization, then randomization is simply not acceptable.  Brute
forcing respawning/forking daemons is possible, and gets faster as your
entropy decreases.

I should probably test this, but in theory it'd also be possible to just
spew in a bunch of no-ops or aligned relative jumps and make a 64k or so
wide buffer that lets you jump to the same address regardless of
randomization and just wind up executing an extra N=rand(0,64k/ALIGN)
set of instructions before your actual shellcode.  It becomes
infeasible, then impossible, as the randomization gap gets bigger; if
your stack is 10 megs, you can't inject 256M of no-ops to get around a
random stack alignment.

>>Red Hat is all smoke and mirrors anyway when it comes to security, just
>>like Microsoft.  This just reaffirms that.
> 
> 
> No. This just re-affirms that you are an inflexible person who cannot see 
> the big picture. You concentrate on your issues to the point where 
> everybody elses issues don't matter to you at all. That's a bad thing, in 
> case you haven't realized.
> 
> Intelligent people are able to work constructively in a world with many 
> different (and often contradictory) requirements. 
> 

Of course.  I understand this, but I've come into the opinion that since
certain things are generally useful, they should be generally deployed.
 If they become a problem, the option to disable them becomes very
useful.  Even Exec Shield has PT_GNU_STACK AND a sysctl setting or 3 IIRC.

> A person who cannot see outside his own sphere of interest can be very 
> driven, and can be very useful - in the "please keep uncle Fred tinkering 
> in the basement, but don't show him to any guests" kind of way. 
> 

I'm actually very broad-minded; my opinions do change, when I see
something that changes my opinions.  Normally, though, my opinions are
developed from an analysis of facts; so you have to change the facts
(i.e. make one thing better and overtake the quality of the other) to
change my opinions.

I've been wrong before, on rare occasions.  Rare, but not impossible.
When it's displayed to me in a way that I actually understand that
certain facts I'm relying on are wrong, then I'm prone to re-evaluate my
decisions.

In the end, I've figured out that "not everybody likes pepsi," but also
that "diet soda is flavored with a dangerous neurotoxin and is bad for
EVERYBODY."  Until you pick another flavoring, I'm not going to have
good things to say about your product.  I do, however, know the
difference between "It's toxic to everyone" and "some people are alergic
to peanuts."

Not that that makes any connection to any existing system similar or
dissimilar to ES/PaX/W^X/etc (it intentionally does not).

> I have a clue for you: until PaX people can work with the rest of the
> world, PaX is _never_ going to matter in the real world. Rigidity is a
> total failure at all levels. 
> 

I'm not trying to get PaX in mainline, I'm just focused on the basic
concepts.

> Real engineering is about doing a good job balancing different issues.
> 
> Please remove me from the Cc when you start going off the deep end, btw.
> 

Sorry Linus, I normally don't read the CC list.  I'll be mindful in the
future of that.

This will likely be the last CC you get from me.

> 		Linus
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+Te/hDd4aOud5P8RAmMdAJ0cRImvV0YGkBPMpaOAaTCyQkCWXACaAj1d
JRfUcY+9UPTe3ZVn517MUbU=
=WbU8
-----END PGP SIGNATURE-----
