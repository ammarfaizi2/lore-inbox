Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRHPVvz>; Thu, 16 Aug 2001 17:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268897AbRHPVvi>; Thu, 16 Aug 2001 17:51:38 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:34063 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268861AbRHPVv2>; Thu, 16 Aug 2001 17:51:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.4.8preX VM problems
Date: Thu, 16 Aug 2001 23:57:49 +0200
X-Mailer: KMail [version 1.3]
Cc: Mike Black <mblack@csihq.com>, tridge@valinux.com,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br, Andrew Morton <andrewm@uow.edu.au>
In-Reply-To: <Pine.LNX.4.21.0108010504160.9379-100000@freak.distro.conectiva> <01080120392200.00933@starship> <20010811120604.C35@toy.ucw.cz>
In-Reply-To: <20010811120604.C35@toy.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010816215132Z16542-1231+1247@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 11, 2001 02:06 pm, Pavel Machek wrote:
> > > I have come to the opinion that kswapd needs to be a little smarter
> > > -- if it doesn't find anything to swap shouldn't it go to sleep a
> > > little longer before trying again?  That way it could gracefully
> > > degrade itself when it's not making any progress.
> > >
> > > In my testing (on a dual 1Ghz/2G machine) the machine "locks up" for
> > > long periods of time while kswapd runs around trying to do it's
> > > thing. If I could disable kswapd I would just to test this.
> > 
> > Your wish is my command.  This patch provides a crude-but-effective 
> > method of disabling kswapd, using:
> > 
> >   echo 1 >/proc/sys/kernel/disable_kswapd
> > 
> > I tested this with dbench and found it runs about half as fast, but 
> > runs.  This is reassuring because kswapd is supposed to be doing 
> > something useful.
> 
> Why not just killall -STOP kswapd?

Because I didn't think of it and I wanted some code for myself to do 
real-time experimental tuning of the VM behaviour.

> What is expected state of system without kswapd, BTW? Without kflushd, 
> I give up guaranteed time to get data safely to disk [and its usefull
> for spindown]. What happens without kswapd?

Without kswapd you lose much of the system's 'clean-ahead' performance and it 
ends up reacting to try_to_free_pages calls iniated through __alloc_pages 
when processes run out of free pages.  This means lots more synchronous 
waiting on page_launder and friends, but the system still runs.  It's a nice 
way to check how well the system's attempt to anticipate demand is really 
working.

--
Daniel
