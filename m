Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317658AbSGKFaq>; Thu, 11 Jul 2002 01:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317672AbSGKFaq>; Thu, 11 Jul 2002 01:30:46 -0400
Received: from zeus.kernel.org ([204.152.189.113]:52730 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317658AbSGKFap>;
	Thu, 11 Jul 2002 01:30:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jesse Barnes <jbarnes@sgi.com>, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: spinlock assertion macros
Date: Thu, 11 Jul 2002 07:31:09 +0200
X-Mailer: KMail [version 1.3.2]
Cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17SPsV-00028p-00@starship> <20020710233616.GA696482@sgi.com>
In-Reply-To: <20020710233616.GA696482@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17SWXm-0002BL-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 01:36, Jesse Barnes wrote:
> On Thu, Jul 11, 2002 at 12:24:06AM +0200, Daniel Phillips wrote:
> > Acme, which is to replace all those above-the-function lock coverage
> > comments with assert-like thingies:
> > 
> >    spin_assert(&pagemap_lru_lock);
> > 
> > And everbody knows what that does: when compiled with no spinlock
> > debugging it does nothing, but with spinlock debugging enabled, it oopses
> > unless pagemap_lru_lock is held at that point in the code.  The practical
> > effect of this is that lots of 3 line comments get replaced with a
> > one line assert that actually does something useful.  That is, besides
> > documenting the lock coverage, this thing will actually check to see if
> > you're telling the truth, if you ask it to.
> > 
> > Oh, and they will stay up to date much better than the comments do,
> > because nobody needs to to be an ueber-hacker to turn on the option and
> > post any resulting oopses to lkml.
> 
> Sounds like a great idea to me.  Were you thinking of something along
> the lines of what I have below or perhaps something more
> sophisticated?  I suppose it would be helpful to have the name of the
> lock in addition to the file and line number...

I was thinking of something as simple as:

   #define spin_assert_locked(LOCK) BUG_ON(!spin_is_locked(LOCK))

but in truth I'd be happy regardless of the internal implementation.  A note
on names: Linus likes to shout the names of his BUG macros.  I've never been
one for shouting, but it's not my kernel, and anyway, I'm happy he now likes
asserts.  I bet he'd like it more spelled like this though:

   MUST_HOLD(&lock);

And, dare I say it, what I'd *really* like to happen when the thing triggers
is to get dropped into kdb.  Ah well, perhaps in a parallel universe...

When one of these things triggers I do think you want everything to come to
a screeching halt, since, to misquote Matrix, "you're already dead", and you
don't want any one-per-year warnings to slip off into the gloomy depths of
some forgotten log file.

-- 
Daniel
