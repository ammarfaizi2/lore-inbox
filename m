Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946745AbWJTAPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946745AbWJTAPD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 20:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946744AbWJTAPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 20:15:00 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:32698 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1946735AbWJTAO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 20:14:59 -0400
Date: Thu, 19 Oct 2006 17:14:39 -0700
From: Paul Jackson <pj@sgi.com>
To: Martin Bligh <mbligh@google.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, dino@in.ibm.com,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061019171439.af1e6a07.pj@sgi.com>
In-Reply-To: <4537D6E8.8020501@google.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> We (Google) are planning to use it to do some partitioning, albeit on
> much smaller machines. I'd really like to NOT use cpus_allowed from
> previous experience - if we can get it to to partition using separated
> sched domains, that would be much better.

Are you saying that you wished that cpusets was not implemented using
cpus_allowed, but -instead- implemented using sched domain partitioning?

Well, as you likely can guess by now, that's unlikely.

Cpusets provides hierarchically nested sets of CPU and Memory Nodes,
especially useful for managing nested allocation of processor and
memory resources on large systems.  The essential mechanism at the core
of cpusets is manipulating the cpus_allowed and mems_allowed masks in
each task.

Cpusets have also been dabbling in the business of driving the sched
domain partitioning, but I am getting more inclined as time goes on to
think that was a mistake.


> From my dim recollections of previous discussions when cpusets was
> added in the first place, we asked for exactly the same thing then.

What are you asking for again? ;).

Are you asking for a decent interface to sched domain partitioning?

Perhaps cpusets are not the best way to get that.

I hear tell from my colleague Christoph Lameter that he is considering
trying to make some improvements, that would benefit us all, to the
sched domain partitioning code - smaller, faster, simpler, better and
all that good stuff.  Perhaps you guys at Google should join in that
effort, and see to it that your needs are met as well.  I would
recommend providing whatever kernel-user API's you need for this, if
any, separately from cpusets.

So far, the requirements that I am aware of on such an effort:
 1) Somehow support isolated CPUs (no load balancing to or from them).
    For example, at least one real-time project needs these.
 2) Whatever you were talking about above that Google is planning, some
    sort of partitioning.
 3) Somehow, whether by magic or by implicit or explicit partitioning
    of the systems CPUs, ensure that its load balancing scales to cover
    my employers (SGI) big CPU count systems.
 4) Hopefully smaller, less #ifdef'y and easier to understand than the
    current code.
 5) Avoid poor fit interactions with cpusets, which have a different
    shape (naturally hierarchical), internal mechanism (allowed bitmasks
    rather than scheduler balancing domains), scope (combined processor
    plus memory) and natural API style (a full fledged file system to
    name these sets, rather than a few bitmasks and flags.)

Good luck.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
