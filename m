Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312457AbSEHIv2>; Wed, 8 May 2002 04:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312486AbSEHIv1>; Wed, 8 May 2002 04:51:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27036 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312457AbSEHIvZ>; Wed, 8 May 2002 04:51:25 -0400
Date: Wed, 8 May 2002 14:24:33 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfree rtcache lookup using RCU
Message-ID: <20020508142433.D10505@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020508125711.B10505@in.ibm.com> <20020508.011008.107273722.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 01:10:08AM -0700, David S. Miller wrote:
>    From: Dipankar Sarma <dipankar@in.ibm.com>
>    Date: Wed, 8 May 2002 12:57:11 +0530
>    
>    For 1 to 8 CPUs I used the test script
>    to send a fixed number of packets to a single destination address.
>    The results show that time needed for lookup continuously increases
>    for 2.5.3 wherease for rt_rcu-2.5.3, it remains constant.
> 
> How does it perform for a write-heavy workload such
> as a massive route flap?

Can you suggest a test to do this ? I can't think of anything other
than manually flushing the route cache.

> 
> Both are equally important.

Yes. With RCU, the write-side doesn't affect the performance
of the read-side. However, there is the additional overhead
of calling call_rcu() and queueing up of the RCU callback
for every dst entry that is freed. The other aspect is of
latency, how quickly the deferred rcu callbacks are invoked.
We have done some studies in this regard under various
degrees of workloads. I will put up the graphs in lse. They
will also be presented at OLS2002.

> 
> Also, workload for single destination isn't all that interesting
> since such a workload isn't all that common except in benchmarking.

A heavily loaded webserver with NATed ip addresses. Would this not
result in many server processes looking up the same ip address ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
