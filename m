Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316295AbSEQQLi>; Fri, 17 May 2002 12:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316296AbSEQQLh>; Fri, 17 May 2002 12:11:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23196 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316295AbSEQQLg>;
	Fri, 17 May 2002 12:11:36 -0400
Date: Fri, 17 May 2002 21:44:33 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 16-CPU #s for lockfree rtcache (rt_rcu)
Message-ID: <20020517214433.A15556@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020517192116.G12631@in.ibm.com> <20020517.064921.80183164.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 06:49:21AM -0700, David S. Miller wrote:
>    From: Dipankar Sarma <dipankar@in.ibm.com>
>    Date: Fri, 17 May 2002 19:21:16 +0530
>    
>    2.5.3 : ip_route_output_key [c01bab8c]: 12166
>    2.5.3+rt_rcu : ip_route_output_key [c01bb084]: 6027
>    
> Thanks for doing the testing.  Are you able to do this
> test on some 4 or 8 processor non-NUMA system?

Yes, but may not have been the same test. We have been doing various 
configurations for this test. One fallout of using large number of 
dest addresses is that we have frequent neighbor table garbage collection 
which results in a lot of lock contentions. By slowing down
the packet rate and/or increasing the gc threshold, we can
avoid this. How realistic is this ? If we avoid frequent
gc, we see better gains in route lookup. With frequent gc,
the speedup was of about 22% for an 8 cpu SMP, IIRC. I will rerun
the tests tomorrow or monday to get both sets of numbers for 8-cpu
SMP.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
