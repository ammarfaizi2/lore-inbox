Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSGLMvT>; Fri, 12 Jul 2002 08:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315923AbSGLMvT>; Fri, 12 Jul 2002 08:51:19 -0400
Received: from dsl-213-023-020-198.arcor-ip.net ([213.23.20.198]:60598 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316185AbSGLMvQ>;
	Fri, 12 Jul 2002 08:51:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dave Jones <davej@suse.de>
Subject: Re: spinlock assertion macros
Date: Fri, 12 Jul 2002 14:55:11 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jesse Barnes <jbarnes@sgi.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17SjRh-0002VI-00@starship> <20020712140751.A14671@suse.de>
In-Reply-To: <20020712140751.A14671@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Szx2-0002es-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 July 2002 14:07, Dave Jones wrote:
> On Thu, Jul 11, 2002 at 09:17:44PM +0200, Daniel Phillips wrote:
>  > On Thursday 11 July 2002 20:03, Jesse Barnes wrote:
>  > > How about this?
>  > 
>  > It looks good, the obvious thing we don't get is what the actual lock
>  > count is, and actually, we don't care because we know what it is in
>  > this case.
> 
> Something I've been meaning to hack up for a while is some spinlock
> debugging code that adds a FUNCTION_SLEEPS() to (ta-da) functions that
> may sleep.

Yesss.  May I suggest simply SLEEPS()?  (Chances are, we know it's a
function.)

> This macro then checks whether we're currently holding any
> locks, and if so printk's the names of locks held, and where they were taken.

And then oopes?

> When I came up with the idea[1] I envisioned some linked-lists frobbing,
> but in more recent times, we can now check the preempt_count for a
> quick-n-dirty implementation (without the additional info of which locks
> we hold, lock-taker, etc).

Spin_lock just has to store the address/location of the lock in a
per-cpu vector, and the assert prints that out when it oopses.  Such
bugs won't live too long under those conditions.

Any idea how one might implement NEVER_SLEEPS()?  Maybe as:

   NEVER_ [code goes here] _SLEEPS

which inc/dec the preeempt count, triggering a BUG in schedule().

-- 
Daniel
