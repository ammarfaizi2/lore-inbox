Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751705AbWCUNjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbWCUNjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWCUNjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:39:10 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:53515 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751708AbWCUNjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:39:09 -0500
Date: Tue, 21 Mar 2006 14:38:42 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
Subject: Re: interactive task starvation
Message-ID: <20060321133842.GB26171@w.ods.org>
References: <200603090036.49915.kernel@kolivas.org> <200603212253.03637.kernel@kolivas.org> <1142946610.7807.43.camel@homer> <200603220013.15870.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603220013.15870.kernel@kolivas.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 12:13:15AM +1100, Con Kolivas wrote:
> On Wednesday 22 March 2006 00:10, Mike Galbraith wrote:
> > On Tue, 2006-03-21 at 22:53 +1100, Con Kolivas wrote:
> > > On Tuesday 21 March 2006 22:18, Ingo Molnar wrote:
> > > > great work by Mike! One detail: i'd like there to be just one default
> > > > throttling value, i.e. no grace_g tunables [so that we have just one
> > > > default scheduler behavior]. Is the default grace_g[12] setting good
> > > > enough for your workload?
> > >
> > > I agree. If anything is required, a simple on/off tunable makes much more
> > > sense. Much like I suggested ages ago with an "interactive" switch which
> > > was rather unpopular when I first suggested it.
> >
> > Let me try to explain why on/off is not sufficient.
> >
> > You notice how Willy said that his notebook is more responsive with
> > tunables set to 0,0?  That's important, because it's absolutely true...
> > depending what you're doing.  Setting tunables to 0,0 cuts off the idle
> > sleep logic, and the sleep_avg divisor - both of which were put there
> > specifically for interactivity - and returns the scheduler to more or
> > less original O(1) scheduler.  You and I both know that these are most
> > definitely needed in a Desktop environment.  For instance, if Willy
> > starts editing code in X, and scrolls while something is running in the
> > background, he'll suddenly say hey, maybe this _ain't_ more responsive,
> > because all of a sudden the starvation added with the interactivity
> > logic will be sorely missed as my throttle wrings X's neck.
> >
> > How long should Willy be able to scroll without feeling the background,
> > and how long should Apache be able to starve his shell.  They are one
> > and the same, and I can't say, because I'm not Willy.  I don't know how
> > to get there from here without tunables.  Picking defaults is one thing,
> > but I don't know how to make it one-size-fits-all.  For the general
> > case, the values delivered will work fine.  For the apache case, they
> > absolutely 100% guaranteed will not.
> 
> So how do you propose we tune such a beast then? Apache users will use off, 
> everyone else will have no idea but to use the defaults.

What you describe is exactly a case for a tunable. Different people with
different workloads want different values. Seems fair enough. After all,
we already have /proc/sys/vm/swappiness, and things like that for the same
reason : the default value should suit most users, and the ones with
knowledge and different needs can tune their system. Maybe grace_{g1,g2}
should be renamed to be more explicit, may be we can automatically tune
one from the other and let only one tunable. But if both have a useful
effect, I don't see a reason for hiding them.

> Cheers,
> Con

Cheers,
Willy

