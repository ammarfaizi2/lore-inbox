Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbRGCS0M>; Tue, 3 Jul 2001 14:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265757AbRGCS0C>; Tue, 3 Jul 2001 14:26:02 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:21011 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265754AbRGCSZ5>; Tue, 3 Jul 2001 14:25:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, Marco Colombo <marco@esi.it>
Subject: Re: VM Requirement Document - v0.0
Date: Tue, 3 Jul 2001 20:29:27 +0200
X-Mailer: KMail [version 1.2]
Cc: <mike_phillips@urscorp.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0107021538030.14332-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0107021538030.14332-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Message-Id: <01070320292709.00338@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 July 2001 20:42, Rik van Riel wrote:
> On Thu, 28 Jun 2001, Marco Colombo wrote:
> > I'm not sure that, in general, recent pages with only one access are
> > still better eviction candidates compared to 8 hours old pages. Here
> > we need either another way to detect one-shot activity (like the one
> > performed by updatedb),
>
> Fully agreed, but there is one problem with this idea.
> Suppose you have a maximum of 20% of your RAM for these
> "one-shot" things, now how are you going to be able to
> page in an application with a working set of, say, 25%
> the size of RAM ?

Easy.  What's the definition of working set?  Those pages that are frequently 
referenced.  So as the application starts up some of its pages will get 
promoted from used-once to used-often.  (On the other hand, the target 
behavior here conflicts with the goal of grouping together several 
temporally-related accesses to the same page together as one access, so 
there's a subtle distinction to be made here, see below.)

The point here is that there are such things as run-once program pages, just 
as there are use-once file pages.  Both should get low priority and be 
evicted early, regardless of the fact they were just loaded.

> If you don't have any special measures, the pages from
> this "new" application will always be treated as one-shot
> pages and the process will never be able to be cached in
> memory completely...

The self-balancing way of doing this is to promote pages from the old end of 
the used-once list to the used-often (active) list at a rate corresponding to 
the fault-in rate so we get more aggressive promotion of referenced-often 
pages during program loading, and conversely, aggressive demotion of 
referenced-once pages.

--
Daniel

--
Daniel
