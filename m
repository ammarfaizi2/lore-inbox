Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUGBBi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUGBBi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 21:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266256AbUGBBi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 21:38:26 -0400
Received: from gizmo04bw.bigpond.com ([144.140.70.14]:20195 "HELO
	gizmo04bw.bigpond.com") by vger.kernel.org with SMTP
	id S266242AbUGBBiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 21:38:22 -0400
Message-ID: <40E4BC89.8000206@bigpond.net.au>
Date: Fri, 02 Jul 2004 11:38:17 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@osdl.org>, mpm@selenic.com, paul@linuxaudiosystems.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
References: <200406301341.i5UDfkKX010518@localhost.localdomain> <20040701180356.GI5414@waste.org> <20040701181401.GB21066@holomorphy.com> <20040701154554.30063e97.akpm@osdl.org> <20040702004538.GF21066@holomorphy.com>
In-Reply-To: <20040702004538.GF21066@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Thu, Jul 01, 2004 at 03:45:54PM -0700, Andrew Morton wrote:
> 
>>In fairness, the CPU scheduler has been spinning like a top for a
>>couple of years, and it still ain't settled.
>>That's just the one in Linus's tree, let alone the umpteen rewrites
>>which are floating about.
> 
> 
> I've not seen much deep material there. Policy tweaks seem to be
> what's gone on in mainline, and frankly most of the purported rewrites
> are just that. I guess the ones that nuked the duelling queue silliness
> are trying qualify but even they're leaving the load balancer untouched
> and are carrying over large fractions of their predecessors unaltered.

That's because it's not all bad (or the problems are minor and can wait 
until later).

> The stuff that's gone around looks minor. It's not like they're teaching
> sched.c to play cpu tetris for gang scheduling or Kalman filtering
> profiling feedback to stripe tasks using different cpu resources across
> SMT siblings or playing graph games to meet RT deadlines, so it doesn't
> look like very much at all is going on to me.

To my mind, scheduling and load balancing are ALMOST orthogonal 
concepts.  Scheduling is concerned with doing a useful job within a 
single CPU and load balancing is about distributing tasks/load among the 
available CPUs.  To a large extent these are independent and are being 
worked on separately.  I am one of those fiddling with the schedulers 
but I'm leaving load balancing alone as it seems to me that the NUMA and 
hyper threading developers are the main players for that component.

To my mind the only contribution the scheduler component MAY want to 
make to load balancing would be to have some say in which tasks are 
chosen for migration.  I don't think that any of the currently proposed 
schedulers have a strong need to change the current mechanism(s) for 
selecting which tasks get migrated.  If you think otherwise please share 
your thoughts?

> 
> It's pretty obvious why everyone and their brother is grinding out
> purported scheduler rewrites: the code is self-contained,

The main reason is that the standard scheduler is a bit of a mess. The 
fact that the code is self contained just makes it easier to modify 
without touching lots of files. It's not the reason why the changes are 
being tried.

> however,
> nothing interesting is coming of all this. Never been for have so many
> patches been written against the same file, accomplishing so little.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

