Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284522AbRLEVxi>; Wed, 5 Dec 2001 16:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284516AbRLEVwT>; Wed, 5 Dec 2001 16:52:19 -0500
Received: from trillium-hollow.org ([209.180.166.89]:38153 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S284451AbRLEVwJ>; Wed, 5 Dec 2001 16:52:09 -0500
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Loadable drivers [was SMP/cc Cluster description ] 
In-Reply-To: Your message of "05 Dec 2001 21:44:06 +0100."
             <p738zch8kix.fsf@amdsim2.suse.de> 
Date: Wed, 05 Dec 2001 13:52:06 -0800
From: erich@uruk.org
Message-Id: <E16BjxW-0005IB-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen <ak@suse.de> wrote:

> erich@uruk.org writes:
> 
> > MS with Windows (and even DOS) went the right direction here.  In fact,
> > they have been hurting themselves by what lack of driver interoperability
> > there is even between Windows NT/2K/XP.  Admittedly they didn't have much
> > of a choice with their closed-source scheme, but it still is a better
> > solution from a usability and stability point of view in general.
> 
> I remember some quote from a Microsoft manager when they released Win2k.
> (paraphrased) "A significant percentage of the blue screens in NT4 were 
> caused by buggy third party drivers." (and then how they will try to avoid
> it in the future by having more stringent windows logo tests etc.

Sure.  Though if they really cared enough, they could have a
"safe-driver" mode that would run the drivers in protected address
spaces or something.  There is a performance loss associated with this
obviously, but it would be a great way to run drivers while testing them
out, or if you had a critical need and a driver would eat itself
occasionally.


> The experience in recemt Linux is basically similar. Single Linux has
> gained vendor support in drivers it has gotten a lot more unstable
> than it used to be (sad but true). There are first a lot more and more
> complex drivers than there used to be.  A lot of drivers both writen
> by individuals and also companies for their are simply crappy buggy
> code. I could give you numerous examples here; names withheld to
> protect the guilty. For hardware companies it might be because driver
> writing is not a profit center, but a cost. There might be other
> reasons. There are just a lot of bad drivers around.

[see above comment about a "safe-driver" mode...  I'm already working
 on this for my own OS project, and have been moderately tempted to do
 it for Linux (as well as an automatic buffer-overflow protector) ]

I'm not disagreeing with you, in fact this is the major reason I'd want
such a framework.

You can pick the drivers that way relatively easily, and stick to the ones
you know work!!  Right now, that is very difficult (and effectively
impossible for most) if you rev anything kernel/driver-related.

There could even be a website that maintained info about drivers and
known-working versions.  Having such info for the kernel tree wouldn't
be a bad idea as is.

The distribution folks could work with the general community on this
pretty easily I'd guess.


> Now when a driver crashes guess who is blamed? Not the driver author
> but the Linux kernel is seen as unstable and it effectively is as
> a end result - it doesn't work for the user. All just because of bad
> drivers.
> 
> The solution that is tried in Linux land to avoid the "buggy drivers" ->
> "linux going to windows levels of stability" trap is to keep drivers in
> tree and aggressively auditing them; trying to fix their bugs.

This works kind of fine when you're talking about developers (though the
problems I mention below aren't completely aleviated either, just not as
bad).  For random people or even IT folks trying to maintain some systems
I would say this is not a feature.

Their only alternative right now is to try out things that work for them
in a very coarse-grained manner ("try out this kernel" : "hmm, didn't work").

A good example is if you need a driver for some new bit of hardware...
you often have to rev your entire kernel/driver tree to get it.  Most would
have no choice but to do so unless hand-held by a kernel hacker.

If it breaks something else (which happens often enough) then you're just
SOL.

I.e. I think too many things are tied together for non-hackers.


> A lot of driver code is actually cut'n'pasted or based
> on other driver code (or you can say they often use common design patterns)
> Now when a bug/race/.. is found and fixed in one driver having the majority
> of drivers in tree makes it actually possible to fix the bug who is likely
> in other drivers who use similar code there too. With having drivers in
> external trees that crashing/angry user/debugging/etc. would likely need
> to be done once per driver; overall causing much more pain for everybody. 
> 
> Your scheme would make this strategy of tight quality control of
> drivers much harder, and I think it wouldn't do good to the long term
> stability of linux.

Not necessarily at all.

You're talking about 2 things:

Driver maintenance:  This mostly need not change, so your example of fixing
problems is the same.

Driver/kernel error reporting:  I say the same thing as I said about MS:
that if we cared enough, we'd have a "safe-driver" framework and driver/
module versioning so that we can tell pretty much exactly where the
problem occured.  You don't use it all the time by any means, but if you
want to get a report answered, there would be some trivial way to turn it
on.

[The "safe-driver" thing obviously may not be the identical footprint so
 a crash may not happen the same way or at all, but if it doesn't happen,
 then hey, you have a way to run stably, which for most people that is
 enough]

Note that MS has been getting a lot of pushback from people about the
inclusion of third-party drivers (to the point where they've partially
disabled the "signed drivers" thing by default, falling back from an
earlier position in the Win XP beta of not accepting them without some
major gyrations on the part of the poor person trying to just run their
hardware).  Just saying "no" isn't that supportable a position.

For example, I think the "module tainted" thing is not terribly useful
along the lines of really fixing bugs.  It may be an indicator and tell
the core kernel folks when not to "waste their time on some binary-only
bug", but I'm not sure what else it does.


> There are other reasons why linux has really no stable driver interface.
> Sometimes it is just needed to break drivers to fix some bugs cleanly.
> Getting rid of this possibility (fixing bugs cleanly even if it requires
> changes in other kernel code) would also cause more bugs in the long term.

This is of course a different problem, but it's unclear if it's one that
would cause more bugs.

Unstable interfaces between major subsystems are often a sign of lack of
design.  [ok, I'm flamebait, but at least I'll be warm-n-toasty now that
it's colder outside]


--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
