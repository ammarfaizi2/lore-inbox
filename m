Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUGYE0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUGYE0z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 00:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUGYE0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 00:26:55 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:38494 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263640AbUGYE0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 00:26:53 -0400
Message-ID: <41033687.4080304@yahoo.com.au>
Date: Sun, 25 Jul 2004 14:26:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: Dimitri Sivanich <sivanich@sgi.com>, linux-kernel@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [RFC] Patch for isolated scheduler domains
References: <20040722164126.GB13189@sgi.com> <200407231603.09055.jbarnes@engr.sgi.com> <4101F2ED.3050208@yahoo.com.au> <200407241140.29453.jbarnes@engr.sgi.com>
In-Reply-To: <200407241140.29453.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Saturday, July 24, 2004 1:26 am, Nick Piggin wrote:
> 
>>You might have the theoretical problem of ending up with more than
>>one disjoint top level domain (ie. no overlap, basically partitioning
>>the CPUs).
> 
> 
> Yes, we'll have several disjoint per-node cpu spans for a large system, but 
> nearby nodes *will* overlap with more distant nodes than any given node, so I 
> think we're covered, unless I'm misunderstanding something.
> 

No, I'm sure you are covered. The situation I thought of would be
something like the following:

CPUs 0-63, all within distance 4 --- gap distance 5 --- CPUs 64-127.

Where you wouldn't have any overlap between the two sets of CPUs.
This is probably not applicable to you though.

> 
>>No doubt you could come up with something provably correct, however
>>it might just be good enough to examine the end result and check that
>>it is good. At least while you test different configurations.
> 
> 
> Right.  And ultimately, I think we'll want the hierarchy I mentioned in the 
> comments, that'll cover us a little better I think.
> 

Yeah I would agree. No doubt you could spend a long time on improving
it. Start simple so you have a baseline of course.

If you're going to be looking at this, take a look at the way we're
building domains in the "[PATCH] consolidate sched domains" patch I
posted the other day. It may simplify your job as well, for example if
you can make use of the init_sched_build_groups function.

