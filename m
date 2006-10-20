Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992575AbWJTIDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992575AbWJTIDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 04:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992577AbWJTIDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 04:03:10 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:37784 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S2992575AbWJTIDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 04:03:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SO/lLrzNujbcuCQO+PXL0QnKHCjckYRJiJA49r1FssJIEZrxRd1JZORkwhF0GYDm8qeTHuE7kqOLfm8TIiITrQPj7wn9mEHcz5ErPDox0lWZOMOvsAKMO/C/1yZa61fq1Vd1ZlJJnMhdmhqaFzhnAwhMtC3sVZ44IGICj3k8nP4=  ;
Message-ID: <453882AC.3070500@yahoo.com.au>
Date: Fri, 20 Oct 2006 18:02:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com,
       clameter@sgi.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>	<453750AA.1050803@yahoo.com.au>	<20061019105515.080675fb.pj@sgi.com>	<4537BEDA.8030005@yahoo.com.au>	<20061019115652.562054ca.pj@sgi.com>	<4537CC1E.60204@yahoo.com.au> <20061019203744.09b8c800.pj@sgi.com>
In-Reply-To: <20061019203744.09b8c800.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>>> 1) If your other patch to manipulate sched domains
>>>    has code that belongs in kernel/cpuset.c, and
>>>    special files that belong in /dev/cpuset, why
>>>    shouldn't this one naturally go in the same places?
>>
>>Because they are cpuset specific. This is not.
> 
> 
> Bizarre.  That other patch of yours, that had cpu_exclusive cpusets
> only at the top level defining sched domain partitions, is cpuset

I'm talking about isolcpus. What do isolcpus have to do with cpusets.c?
You can turn off CONFIG_CPUSETS and still use isolcpusets, can't you?

> specific only because you're hijacking the cpu_exclusive flag to add
> new semantics to it, and then claiming you're not adding new semantics
> to it, and then claiming we should be doing this all implicitly without
> additional kernel-user API apparatus, and then claiming that if your
> new abuse of cpuset flags intrudes on other usage patterns of cpusets
> or if they have need of a particular sched domain partitioning that
> they have to explicitly set up top level cpusets to get a desired sched
> domain partitioning ...
> 
> Stop already ...  this is getting insane.
> 
> Where are we?

I'll start again...

set_cpus_allowed is a feature of the scheduler that allows you to
restrict one task to a subset of all cpus. Right?

And cpusets uses this interface as the mechanism to implement the
semantics which the user has asked for. Yes?

sched-domains partitioning is a feature of the scheduler that
allows you to restrict zero or more tasks to the partition, and
zero or more tasks to the complement of the partition. OK?

So if you have a particular policy you need to implement, which is
one cpus_exclusive cpuset off the root, covering half the cpus in
the system (as a simple example)... why is it good to implement
that with set_cpus_allowed and bad to implement it with partitions?

Or, another question, how does my patch hijack cpus_allowed? In
what way does it change the semantics of cpus_allowed?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
