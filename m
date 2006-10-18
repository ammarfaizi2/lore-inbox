Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWJRMQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWJRMQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 08:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWJRMQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 08:16:54 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:20065 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751472AbWJRMQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 08:16:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hMi5G5kONJ5i/qS9R/W3NfhCI3mBtl9VzIvxmI1y6dSuKo1w0Ta9pZm1Zb1M4dtl+r7ja6oWBRXPXCgyhu3UXPX/ylZUwkIpVnTzK6Cv3pIT4jftpmCC2DyicKsaUW1zKcBkWbs/B6ThcK6cpNrv9b6ZkVTNrewO2h/VC3tmz9k=  ;
Message-ID: <45361B32.8040604@yahoo.com.au>
Date: Wed, 18 Oct 2006 22:16:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Robin Holt <holt@sgi.com>, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
References: <20061017192547.B19901@unix-os.sc.intel.com>	<20061018001424.0c22a64b.pj@sgi.com>	<20061018095621.GB15877@lnx-holt.americas.sgi.com> <20061018031021.9920552e.pj@sgi.com>
In-Reply-To: <20061018031021.9920552e.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Robin wrote:
> 
>>Could this be as simple as a CPU_UP_PREPARE or CPU_DOWN_PREPARE
>>removing all the cpu_exclusive cpusets and a CPU_UP_CANCELLED,
>>CPU_DOWN_CANCELLED, CPU_ONLINE, CPU_DEAD going through and
>>partitioning all the cpu_exclusive cpusets.
> 
> 
> Perhaps.
> 
> The somewhat related problems, in my book, are:
> 
>  1) I don't know how to tell what sched domains/groups a system has, nor
>     how to tell my customers how to see what sched domains they have, and

I don't know if you want customers do know what domains they have. I think
you should avoid having explicit control over sched-domains in your cpusets
completely, and just have the cpusets create partitioned domains whenever
it can.

> 
>  2) I suspect that Mr. Cpusets doesn't understand sched domains and that
>     Mr. Sched Domain doesn't understand cpusets, and that we've ended
>     up with some inscrutable and likely unsuitable interactions between
>     the two as a result, which in particular don't result in cpusets
>     driving the sched domain configuration in the desired ways for some
>     of the less trivial configs.
> 
>     Well ... at least the first suspcicion above is a near certainty ;).

cpusets is the only thing that messes with sched-domains (excluding the
isolcpus -- that seems to require a small change to partition_sched_domains,
but forget that for now).

And so you should know what partitioning to build at any point when asked.
So we could have a call to cpusets at the end of arch_init_sched_domains,
which asks for the domains to be partitioned, no?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
