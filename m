Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319316AbSIKTcz>; Wed, 11 Sep 2002 15:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319318AbSIKTcz>; Wed, 11 Sep 2002 15:32:55 -0400
Received: from dsl-213-023-021-043.arcor-ip.net ([213.23.21.43]:27370 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319316AbSIKTcy>;
	Wed, 11 Sep 2002 15:32:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Question about pseudo filesystems
Date: Wed, 11 Sep 2002 21:36:44 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1020911111334.12605B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020911111334.12605B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pDI5-0007TV-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 17:28, Bill Davidsen wrote:
> On Mon, 9 Sep 2002, Daniel Phillips wrote:
> 
> > > The expected behaviour is as it has always been: rmmod fails if anyone
> > > is using the module, and succeeds if nobody is using the module.  The
> > > garbage collection of modules is done using "rmmod -a" periodically, as
> > > it always has been.
> 
> I can't disagree with any of that, but the idea of releasing resources
> when they are not in use and preventing new use of the resource from the
> time of the release request is hardly new to UNIX. It's exactly the way
> filespace is treated when a file is unlinked while open.

It's a little different for modules.  For one thing, modules are
sometimes used like switches: to make the system behave differently,
plug in some module, to make it stop doing that, remove the module
again.  The user wants those transitions to happen *now*, like a
switch.  Sure, we can make various guru arguments about why the user
is wrong, but in the end, the user is never wrong, in the customer
sense.

Anyway, this problem is under control now and the nice solution also
happens to be the simplest, so what more could you ask for.

> > Al's analysis is all focussed on the filesystem case, where you can
> > prove assertions about whether the subsystem defined by the module is
> > active or not.  This doesn't cover the whole range of module applications.
> 
> Which if true doesn't preclude solving the problems it does address.

Oh absolutely.  Please see my recent [RFC] Raceless module interface.
<flamebait>Not to say that I was unable to improve Al's code.</flamebait>

> > There is a significant class of module types that must rely on sheduling
> > techniques to prove inactivity.  My suggestion covers both, Al has his
> > blinders on.
> 
> Clearly there are people who don't agree, and you don't help by insulting
> them.

I wish I could agree with you about that, but Al is a special case.
I think he actually *likes* it, like a Pit Bull likes fighting.  He
certainly became easier to deal with after I fell into the habit of
returning each insult promptly and unambiguously.  Note: Al is the one
person on the list that I deal with this way, and he worked really
hard to get there.

> I'd like a single solution, but it looks as if Al's idea will work
> for filesystems, and it's relatively simple.

And what do you propose to do about the modules it doesn't work for?
Sorry, rhetorical question, the solution is laid out in the above
[RFC].

> > Designs are not always correct just because they work.
> 
> Solutions which work are most certainly correct, and no degree of elegance
> will make a non-working solution correct for any definition of correct I
> use. I think you mean "optimal" here, and clearly an optimal solution is
> simple, reliable, efficient, general, and easy to code and understand.
> Anything less is subject to improvement, and that certainly applies to
> module removal ;-)

Yes, well please read the [RFC] and pass judgement on whether it's
optimal or not.

-- 
Daniel
