Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317957AbSGLAxY>; Thu, 11 Jul 2002 20:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317958AbSGLAxW>; Thu, 11 Jul 2002 20:53:22 -0400
Received: from dsl-213-023-020-198.arcor-ip.net ([213.23.20.198]:53195 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317957AbSGLAxP>;
	Thu, 11 Jul 2002 20:53:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Sandy Harris <pashley@storm.ca>, Oliver Xymoron <oxymoron@waste.org>
Subject: Re: spinlock assertion macros
Date: Fri, 12 Jul 2002 02:56:59 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jesse Barnes <jbarnes@sgi.com>, Andreas Dilger <adilger@clusterfs.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207111131550.15441-100000@waste.org> <3D2E1A4D.10705EA5@storm.ca>
In-Reply-To: <3D2E1A4D.10705EA5@storm.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Sok0-0002ab-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 July 2002 01:52, Sandy Harris wrote:
> Oliver Xymoron wrote:
> > 
> > On Thu, 11 Jul 2002, Daniel Phillips wrote:
> > 
> > > I was thinking of something as simple as:
> > >
> > >    #define spin_assert_locked(LOCK) BUG_ON(!spin_is_locked(LOCK))
> > >
> > > but in truth I'd be happy regardless of the internal implementation.  A note
> > > on names: Linus likes to shout the names of his BUG macros.  I've never been
> > > one for shouting, but it's not my kernel, and anyway, I'm happy he now likes
> > > asserts.  I bet he'd like it more spelled like this though:
> > >
> > >    MUST_HOLD(&lock);
> > 
> > I prefer that form too.
> 
> Is it worth adding MUST_NOT_HOLD(&lock) in an attempt to catch potential
> deadlocks?
> 
> Say that if two or more of locks A, B and C are to be taken, then
> they must be taken in that order. You might then have code like:
> 
> 	MUST_NOT_HOLD(&lock_B) ;
> 	MUST_NOT_HOLD(&lock_C) ;
> 	spinlock(&lock_A) ;
> 
> I think you need a separate asertion for this !MUST_NOT_HOLD(&lock)
> has different semantics.

MUST_NOT_HOLD is already in Jesse's patch he posted earlier today,
though I imagine it would be used rarely if at all.

!MUST_NOT_HOLD(&lock) is an error, MUST_NOT_HOLD is a statement not a
function.

-- 
Daniel
