Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVBKJ2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVBKJ2s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVBKJ2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:28:47 -0500
Received: from waste.org ([216.27.176.166]:37350 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262082AbVBKJ1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 04:27:48 -0500
Date: Fri, 11 Feb 2005 01:27:15 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211092715.GI15058@waste.org>
References: <420C25D6.6090807@bigpond.net.au> <200502110341.j1B3fS8o017685@localhost.localdomain> <20050211065753.GE15058@waste.org> <20050211075417.GA2287@elte.hu> <20050211082536.GF15058@waste.org> <20050211090419.GD3980@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211090419.GD3980@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 10:04:19AM +0100, Ingo Molnar wrote:
> 
> * Matt Mackall <mpm@selenic.com> wrote:
> 
> > So the comparison boils down to putting a magic gid in a sysfs
> > file/module parameter or setting an rlimit with standard tools (PAM,
> > etc). I'm really boggled that anyone could prefer the former,
> > especially since we had almost this exact debate over what became the
> > mlock rlimit!
> 
> the big difference to mlock is that for mlock there _is_ a _limit_. For
> RT scheduling the priority is _NOT_ a _limit_. Okay? So you give the
> false pretense of this being some kind of resource 'limit', while in
> fact allowing SCHED_FIFO prio 1 alone enables unprivileged users to lock
> up the system.
>
> so i could agree with RLIMIT_NICE (which _is_ a limit), but
> RLIMIT_RTPRIO sends the wrong message. The proper rlimit would be
> RLIMIT_RT_CPU (the patch i did).

It's not a perfect fit, I'll readily agree.

But consider this: with RLIMIT_RTPRIO, I can restrict a user to the
lowest N RT priorities. Then at N+1, I have an RT watchdog taking care
of runaways, tickled by a SCHED_NORMAL task. So it can still be looked
at as a meaningful limit, just a bit different from the others.

The RT LSM gives full CAP_SYS_NICE out, so there's no way to guarantee
that the watchdog has higher priority.

-- 
Mathematics is the supreme nostalgia of our time.
