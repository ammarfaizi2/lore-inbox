Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132607AbRC1Xe1>; Wed, 28 Mar 2001 18:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132608AbRC1XeR>; Wed, 28 Mar 2001 18:34:17 -0500
Received: from 216.41.5.host170 ([216.41.5.170]:61670 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S132607AbRC1XeF>; Wed, 28 Mar 2001 18:34:05 -0500
Message-Id: <200103282333.f2SNX4Q06854@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.3
To: Andreas Rogge <lu01@rogge.yi.org>
cc: james <jdickens@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Ideas for the oom problem 
In-Reply-To: Your message of "Wed, 28 Mar 2001 17:56:47 +0200."
             <64000000.985795007@hades> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Mar 2001 18:33:04 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --On Wednesday, March 28, 2001 09:38:04 -0500 Hacksaw <hacksaw@hacksaw.org> 
> wrote:
> >
> > Deciding what not to kill based on who started it seems like a bad idea.
> > Root  can start netscape just as easily as any user, but if the choice of
> > processes  to kill is root's netscape or a user's experimental database,
> > I'd want the  netscape to go away.
> 
> root does not use netscape -FULLSTOP-

Making assumptions about what users will do is foolish. 

> Anyone working as root is (sorry) an idiot! root's processes are normally
> quite system-relevant and so they should never be killed, if we can avoid 
> it.

The real world intrudes. Root sometimes needs to look at documentation, which, 
these days is often available as html. Sometimes it's only as html. And people 
in a panic who aren't trained sys-admins aren't going to remember to log in as 
someone else.

I completely agree that doing general work as root is a bad idea. I do most 
root things via sudo. It sure would be nice if all the big dists supplied it 
(Hey, RedHat! You listening?) as part of their normal set.

> There can however be processes owned by other users which shouldn't be
> killed in OOM-Situation, but generally root's processes are more important
> than a normal user's processes.

I'd suggest that this is going to change. Not to regular users, though, so 
it's still a good point. But we should be figuring out how to compartmentalize 
all our servers. Rarely do most servers need to run as root. Just login ones, 
and those should be limited.

So which should die, the users experiment, or identd?

> What about doing something really critical to avoid the upcoming OOM-situ
> and get your shell killed because you were to slow?

Right. I agree that roots shell should be exempt. It may be that all shells 
should be exempt, or maybe all recent shells.

Better, though, would be to establish the idea of "linchpins".

A linchpin is a process marked with a don't kill for OOM flag (a capability?). 
Only those in root group should be able to start one. And darn few things 
should be marked as such. Some very small shell, vi, ed, maybe a small emacs. 
Just enough so that our heroic admin can gracefully ease the OOM situ by 
changing a few bits of /etc or killing off a few well chosen processes.

On the other hand, a flag that says "kill me first" might be even better.

In any case, I'd certainly expect the OOM killer to sort by memory usage, and 
kill off the hogs first. I assume it does that.



