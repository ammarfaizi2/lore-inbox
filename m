Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265328AbRGDOmD>; Wed, 4 Jul 2001 10:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbRGDOly>; Wed, 4 Jul 2001 10:41:54 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:38918 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265328AbRGDOll>; Wed, 4 Jul 2001 10:41:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marco Colombo <marco@esi.it>
Subject: Re: VM Requirement Document - v0.0
Date: Wed, 4 Jul 2001 16:44:24 +0200
X-Mailer: KMail [version 1.2]
Cc: Rik van Riel <riel@conectiva.com.br>, <mike_phillips@urscorp.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107041026140.4236-100000@Megathlon.ESI>
In-Reply-To: <Pine.LNX.4.33.0107041026140.4236-100000@Megathlon.ESI>
MIME-Version: 1.0
Message-Id: <01070416442405.03760@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 July 2001 10:32, Marco Colombo wrote:
> On Tue, 3 Jul 2001, Daniel Phillips wrote:
> > On Monday 02 July 2001 20:42, Rik van Riel wrote:
> > > On Thu, 28 Jun 2001, Marco Colombo wrote:
> > > > I'm not sure that, in general, recent pages with only one access are
> > > > still better eviction candidates compared to 8 hours old pages. Here
> > > > we need either another way to detect one-shot activity (like the one
> > > > performed by updatedb),
> > >
> > > Fully agreed, but there is one problem with this idea.
> > > Suppose you have a maximum of 20% of your RAM for these
> > > "one-shot" things, now how are you going to be able to
> > > page in an application with a working set of, say, 25%
> > > the size of RAM ?
> >
> > Easy.  What's the definition of working set?  Those pages that are
> > frequently referenced.  So as the application starts up some of its pages
> > will get promoted from used-once to used-often.  (On the other hand, the
> > target behavior here conflicts with the goal of grouping together several
> > temporally-related accesses to the same page together as one access, so
> > there's a subtle distinction to be made here, see below.)
>
> [...]
>
> In Rik example, the ws is larger than available memory. Part of it
> (the "hottest" one) will get double-accesses, but other pages will keep
> condending the few available (physical) pages with no chance of being
> accessed twice.  But see my previous posting...

But that's exactly what we want.  Note that the idea of reserving a fixed 
amount of memory for "one-shot" pages wasn't mine.  I see no reason to set a 
limit.  There's only one critereon: does a page get referenced between the 
time it's created and when its probation period expires?

Once a page makes it into the active (level 2) set it's on an equal footing 
with lots of others and it's up to our intrepid one-hand clock to warm it up 
or cool it down as appropriate.  On the other hand, if the page gets sent to 
death row it still has a few chances to prove its worth before being cleaned 
up and sent to the aba^H^H^H^H^H^H^H^H reclaimed.  (Apologies for the 
multiplying metaphors ;-)

--
Daniel
