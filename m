Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWEZLeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWEZLeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWEZLeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:34:09 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:2241 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932334AbWEZLeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:34:08 -0400
Date: Fri, 26 May 2006 16:59:39 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
Message-ID: <20060526112939.GA29109@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 02:20:21PM +1000, Peter Williams wrote:
> These patches implement CPU usage rate limits for tasks.
> 
> Although the rlimit mechanism already has a CPU usage limit (RLIMIT_CPU)
> it is a total usage limit and therefore (to my mind) not very useful.
> These patches provide an alternative whereby the (recent) average CPU
> usage rate of a task can be limited to a (per task) specified proportion
> of a single CPU's capacity.  The limits are specified in parts per
> thousand and come in two varieties -- hard and soft.  The difference
> between the two is that the system tries to enforce hard caps regardless
> of the other demand for CPU resources but allows soft caps to be
> exceeded if there are spare CPU resources available.  By default, tasks
> will have both caps set to 1000 (i.e. no limit) but newly forked tasks
> will inherit any caps that have been imposed on their parent from the
> parent.  The mimimim soft cap allowed is 0 (which effectively puts the
> task in the background) and the minimim hard cap allowed is 1.
> 
> Care has been taken to minimize the overhead inflicted on tasks that
> have no caps and my tests using kernbench indicate that it is hidden in
> the noise.
> 
> Note:
> 
> The first patch in this series fixes some problems with priority
> inheritance that are present in 2.6.17-rc4-mm3 but will be fixed in
> the next -mm kernel.
> 

1000 sounds like a course number. A good estimate for the user setting
these limits would be percentage or better yet let the user decide on the
parts. For example, the user could divide the available CPU's capacity
to 2000 parts and ask for 200 parts or divide into 100 parts and as for 10
parts. The default capacity can be 100 or 1000 parts. May be the part
setting could be a system tunable.

I would also prefer making the capacity defined as the a specified portion
of the capacity of all CPU's. This would make the behaviour more predictable.

Consider a task "T" which has 10 percent of a single CPU's capacity as hard
limit. If it migrated to another CPU, would the new CPU also make 10% of its
capacity available "T".

What is the interval over which the 10% is tracked? Does the task that crosses
its hard limit get killed? If not, When does a task which has exceeded its
hard-limit get a new lease of another 10% to use?

I guess I should move on to reading the code for this feature now :-)

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
