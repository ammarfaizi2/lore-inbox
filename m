Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbTIFPOi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 11:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTIFPOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 11:14:38 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:3754 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261291AbTIFPOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 11:14:37 -0400
Date: Sat, 06 Sep 2003 08:13:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
Message-ID: <139550000.1062861227@[10.10.2.4]>
In-Reply-To: <3F5980CD.2040600@cyberone.com.au>
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay> <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay> <3F5935EB.4000005@cyberone.com.au> <6470000.1062819391@[10.10.2.4]> <3F5980CD.2040600@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the two will always related. One means giving a higher
> dynamic priority, the other a bigger timeslice. So you want
> say gcc to have a 100ms timeslice with lowest scheduling prio,
> but X to have a 20ms slice and a very high scheduling priority.

Right.
 
> Unfortunately, the way the scheduler currently works, X might
> use all its timeslice, then have to wait 100ms for gcc to finish
> its. The way I do it is give a small timeslice to high prio tasks,
> and lower priority tasks get progressively less.

If the interactive task uses all it's timeslice, then it's not really
very interactive, it's chewing quite a bit of CPU ... presumably in
the common case, these things don't finish their timeslices. I thought
we preempted the running task when a higher prio one woke up, so this
should still work, right?

So it would seem to make sense to boost the prio of a interactive task 
*without* increasing the size of it's timeslice.

> When _only_ low priority tasks are running, they'll all get long
> timeslices.

That at least makes sense. AFIAK at least the early versions of Con's
stuff make cpu bound jobs' timeslices short even if there were no
interactive jobs. I don't like that (or more relevantly, the benchmarks
don't either ;-)).

> OK well just as a rough idea of how mine works: worst case for
> xmms is that X is at its highest dynamic priority (and reniced).
> xmms will be at its highest dynamic prio, or maybe one or two
> below that.
> 
> X will get to run for maybe 30ms first, then xmms is allowed 6ms.
> That is still 15% CPU. And X soon comes down in priority if it
> continues to use a lot of CPU.

If it works in practice, it works, I guess. I just don't see why X
is super special ... are we going to have to renice *all* interactive 
tasks in order to get things to work properly?

M.

