Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVHLBYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVHLBYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 21:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbVHLBYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 21:24:32 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:1423 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932421AbVHLBYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 21:24:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3j+5TWw8HbtGBMu2z/w+1Ko1z/y0bcLggWNWmcN5eaqFSy1ujqcd0FjN3ApD7pZHg9KYpUrwtpppOGDJ1+oDRgGkeoHEs61KM6f57wjec/9oBM5E9aLd+9Mi3lAaC4H/mnTymnZgoADoPL/J4xRAVXUwPQFMvmv8tqU1qa5GJwc=  ;
Message-ID: <42FBFA3E.1070706@yahoo.com.au>
Date: Fri, 12 Aug 2005 11:24:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, steiner@sgi.com, dvhltc@us.ibm.com,
       mbligh@mbligh.org
Subject: Re: allow the load to grow upto its cpu_power (was Re: [Patch] don't
 kick ALB in the presence of pinned task)
References: <20050801174221.B11610@unix-os.sc.intel.com> <20050802092717.GB20978@elte.hu> <20050809160813.B1938@unix-os.sc.intel.com> <42F94A00.3070504@yahoo.com.au> <20050809190352.D1938@unix-os.sc.intel.com> <1123729750.5188.13.camel@npiggin-nld.site> <20050811111411.A581@unix-os.sc.intel.com> <42FBE410.9070809@yahoo.com.au> <20050811173917.B581@unix-os.sc.intel.com>
In-Reply-To: <20050811173917.B581@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:

>On Fri, Aug 12, 2005 at 09:49:36AM +1000, Nick Piggin wrote:
>
>>Well, it is a departure from our current idea of balancing.
>>
>
>That idea is already changing from the first line of the patch. 
>And the change is "allowing the load to grow upto the sched 
>group's cpu_power"
>
>

But this is the intended behaviour of the scheduler. IMO
it was a bug in the implementation.

>>I would prefer to use my patch initially to fix the _bug_
>>you found, then we can think about changing policy for
>>power savings.
>>
>
>Second part of the patch is just a logical extension of the
>first one.
>
>
>>Main things I'm worried about:
>>
>>Idle time regressions that pop up any time we put
>>restrictions on balancing.
>>
>
>We are talking about lightly loaded case anyway. We are not changing
>the behavior of a heavily loaded system.
>
>

But if the system is going idle, it _looks_ like it is lightly
loaded to the CPU scheduler. However, it is imperitive that
any spare tasks get moved to idle CPUs in order to keep things
like IO going.

It seems to be a problem with database workloads.

>>This can tend to unbalance memory controllers (eg. on POWER5,
>>CMP Opteron) which can be a performance problem on those
>>systems.
>>
>
>We will do that already with the first line in the patch. 
>
>

But that's because the tasks are already running on that CPU, and
affinity is more important in that case (especially for NUMA systems).

>If we want to distribute uniformly among the memory controllers, 
>cpu_power of the group should reflect it (shared resources bottle neck).
>
>

I don't mean that we want to completely distribute load evenly over
memory controllers, but I think it is better not to introduce this kind
of bias to the scheduler. At least not without some justification.

>>Lastly, complexity in the calculation.
>>
>
>My first patch is a simple straight fwd one.
>
>

It is simpler than the second, but it introduces (yet another) special
case in find_busiest_group.

I'm not saying that I would reject any patch that did this or changed
behaviour in the way that you would propose, however I would like
to merge the version I sent as a bug fix first.

Thanks,
Nick


Send instant messages to your online friends http://au.messenger.yahoo.com 
