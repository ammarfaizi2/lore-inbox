Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVDDCK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVDDCK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 22:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVDDCJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 22:09:07 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:32614 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261973AbVDDCI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 22:08:29 -0400
Message-ID: <4250A195.5030306@yahoo.com.au>
Date: Mon, 04 Apr 2005 12:08:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@engr.sgi.com>
CC: Ingo Molnar <mingo@elte.hu>, kenneth.w.chen@intel.com, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>	<20050402145351.GA11601@elte.hu>	<20050402215332.79ff56cc.pj@engr.sgi.com>	<20050403070415.GA18893@elte.hu>	<20050403043420.212290a8.pj@engr.sgi.com>	<20050403071227.666ac33d.pj@engr.sgi.com>	<20050403152413.GA26631@elte.hu> <20050403160807.35381385.pj@engr.sgi.com>
In-Reply-To: <20050403160807.35381385.pj@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Ingo wrote:
> 
>>if you create a sched-domains hierarchy (based on the SLIT tables, or in 
>>whatever other way) that matches the CPU hierarchy then you'll 
>>automatically get the proper distances detected.
> 
> 
> Yes - agreed.  I should push in the direction of improving the
> SN2 sched domain hierarchy.
> 

I'd just be a bit careful about this. Your biggest systems will have
what? At least 7 or 8 domains if you're just going by the number of
hops, right? And maybe more if there is more to your topology than
just number of hops.

sched-domains firstly has a few problems even with your 2 level NUMA
domains (although I'm looking at fixing them if possible), but also
everything just has to do more work as you traverse the domains and
scan all CPUs for balancing opportunities. And its not like the cpu
scheduler uses any sort of exact science to make choices...

Nick

