Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319331AbSIKVIl>; Wed, 11 Sep 2002 17:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319336AbSIKVIl>; Wed, 11 Sep 2002 17:08:41 -0400
Received: from dsl-213-023-021-043.arcor-ip.net ([213.23.21.43]:31980 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319331AbSIKVIj>;
	Wed, 11 Sep 2002 17:08:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Oliver Neukum <oliver@neukum.name>, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] Raceless module interface
Date: Wed, 11 Sep 2002 23:15:34 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209101201280.8911-100000@serv> <E17pD2j-0007TM-00@starship> <200209112229.11975.oliver@neukum.name>
In-Reply-To: <200209112229.11975.oliver@neukum.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pEpj-0007Up-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 22:29, Oliver Neukum wrote:
> > > > magic_wait_for_quiescence to complete.  So the try_count approach is
> > > > preferable, where it works.
> > >
> > > But the try_count approach hurts every user of the defined interfaces,
> > > even if modules are not used.
> >
> > Well, it works great for filesystems, which is my point.  And I'll
> > bet beer that somebody out there will find another application
> > where it works well.  It's all about choice, and the thing about
> 
> How would the other version work less well for filesystems ?
> How long unloading takes doesn't matter, as long as it's safe.

Really, that's not so, there are limits.  30 seconds?  Whatever.  
Remember, during this time the service provided by the module is
unavailable, so this is denial-of-service land.  You could of
course put in extra code to abort the unload process on demand,
but, hmm, it probably wouldn't work ;-)

And even if it did work, why would that be better than staying
with a simple, proven solution that works (for filesystems)?

> The overhead while running is the issue, nothing else.

Au contraire, there are a variety of issues, see above for one.

> > the proposed interface is, it gives you the flexibility to make
> > that choice.  The fact that it's also the simplest interface is
> > just nice.
> 
> That makes no difference if you have to support two interfaces.

Mea culpa, I failed to communicate.  The whole point of my [RFC]
is that one new interface does both jobs, and potentially more
besides, by the simple expediant of pushing the support for
variants down into module land where it belongs, and at the same
time, making these variants dead simple to write.  Probably with
the same or less code than we have now.  Downside?

> > > Is the impact on the scheduler limited
> > > to the time magic_wait_for_quiescence is running.
> > > If so, the approach looks superior.
> >
> > It definitely is not superior for filesystem modules.  However,
> > "damm good" would be a nice level of functionality to aim for.
> > The more we come to rely on virtual filesystem, the more we care
> > that the load/unload procedure should be reliable and fast.
> 
> What? Unloading is a rare event in any case.

Maybe for you it is.  Anyway, I prefer that my computer does
whatever I tell it to as quickly as it can, that's why I pay so
much to run Linux on it ;-)

> > Don't forget that point about not being able to put an upper
> > bound on the time required to complete the magic wait.
> >
> > Are you hinting that we only need, and only ever will need, one
> > mechanism here, so the module doesn't need to return a result
> > from cleanup_module?  If so then I should add that we don't just
> 
> Returning the error value is good.

:-)

-- 
Daniel
