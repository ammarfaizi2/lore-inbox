Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVBICxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVBICxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 21:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVBICxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 21:53:20 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:22412 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261759AbVBICxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:53:16 -0500
Message-ID: <42097B11.4090906@yahoo.com.au>
Date: Wed, 09 Feb 2005 13:53:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dobson <colpatch@us.ibm.com>
CC: dino@in.ibm.com, "Martin J. Bligh" <mbligh@aracnet.com>,
       Paul Jackson <pj@sgi.com>, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Simon.Derr@bull.net,
       Andi Kleen <ak@suse.de>, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]> <1097014749.4065.48.camel@arrakis> <420800F5.9070504@us.ibm.com> <20050208095440.GA3976@in.ibm.com> <42088B3E.7050701@yahoo.com.au> <420913E9.4010902@us.ibm.com>
In-Reply-To: <420913E9.4010902@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> Nick Piggin wrote:

>> I didn't really follow where that idea went, but I think at least
>> a few people thought that sort of functionality wasn't nearly
>> fancy enough! :)
> 
> 
> Well, that's about how far the idea was supposed to go. ;)  I think 
> named hierarchical sched_domains would offer the same functionality (at 
> least for CPU partitioning) as CPUSETs.  I'm not sure who didn't think 
> it was fancy enough, but if you or anyone else can describe CPUSETs 
> configurations that couldn't be represented by sched_domains trees, I'd 
> be very curious to hear about them.
> 

OK. Someone mentioned wanting to do overlapping sets of CPUs. For
example, 3 groups, first can run on cpus 0 and 1, second 1 and 2,
third 2 and 0. However this in itself doesn't preculde the use of
sched-domains.

In the (hopefully) common case where there are disjoint partitions
_somewhere_, sched domains can do the job in a much better
way than task cpu affinities (better isolation, multiprocessor
balancing shouldn't break down).

Those users with overlapping CPU sets can then use task affinities
on top of sched domains partitions to get the desired result.

