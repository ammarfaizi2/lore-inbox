Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUDBHxC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 02:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbUDBHxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 02:53:01 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:2225 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262931AbUDBHw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 02:52:58 -0500
Message-ID: <406D1BCB.3090304@yahoo.com.au>
Date: Fri, 02 Apr 2004 17:52:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: Ingo Molnar <mingo@redhat.com>, John Hawkes <hawkes@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler balancing statistics
References: <200404020735.i327Zk604510@owlet.beaverton.ibm.com>
In-Reply-To: <200404020735.i327Zk604510@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
> The important thing, as always, is that collecting the stats not impact
> the action being taken.  If you stick with incrementing counters and
> not taking additional locks, then you've probably done what you can to
> minimize any impact.
> 

Yes, they're all simple increments without the need for any
locking.

>>From an analysis standpoint it would be nice to know which of the major
> features are being activated for a particular load.  So imbalance-driven
> moves, power-driven moves, and the number of times each domain tried
> to balance and failed would all be useful.  I think your output covered
> those.
> 

It doesn't get into the finer points of how the imbalance
is derived, but maybe it should...

> Another useful stat might be how many times the self-adjusting fields
> (min, max) adjusted themselves.  That might yield some insights on
> whether that's working well (or correctly).
> 

Might be a good idea.

> When I started thinking about these stats, I started thinking about how to
> identify the domains.  "domain0" and "domain1" do uniquely identify some
> data structures, but especially as they get hierarchical, can we easily
> tie them to the cpus they manage?  Perhaps the stats should include a
> bitmap of what cpus are covered by the domain too.
> 

Well, every domain that is reported here will cover the entire
system because it simply takes the sum of statistics from all
domains.

It is a good overview, but it probably would be a good idea to
be able to break down the views and zoom in a bit.

> Looks very useful for those times when some workload causes the scheduler
> to burp -- between scheduler stats and domain stats we may find it much
> easier to track down issues.
> 
> Would you say these would be in addition to the schedstats or would
> these replace them?

It will replace some of them, I think.
For example, all load_balance operations are done within the
context of a sched domain, so you would use the sched domain's
statistics there. However you have other statistics that are
specific to the runqueue, for example, which would stay where
they are.

Thanks
Nick
