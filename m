Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263165AbSITRir>; Fri, 20 Sep 2002 13:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263167AbSITRiq>; Fri, 20 Sep 2002 13:38:46 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:52200 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263165AbSITRio>;
	Fri, 20 Sep 2002 13:38:44 -0400
Date: Fri, 20 Sep 2002 23:18:42 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, maneesh@in.ibm.com,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu, Hanna Linder <hannal@us.ibm.com>
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020920231842.B4357@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <3D8B31F8.40900@us.ibm.com> <509891064.1032512823@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <509891064.1032512823@[10.10.2.3]>; from mbligh@aracnet.com on Fri, Sep 20, 2002 at 04:17:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 04:17:10PM +0000, Martin J. Bligh wrote:
> > Isn't increased hold time _good_ on NUMA-Q?  I thought that the 
> > really costy operation was bouncing the lock around the interconnect, 
> > not holding it. 
> 
> Depends what you get it return. The object of fastwalk was to stop the
> cacheline bouncing on all the individual dentry counters, at the cost
> of increased dcache_lock hold times. It's a tradeoff ... and in this
> instance it wins. In general, long lock hold times are bad.

I don't think individual dentry counters are as much a problem as
acquisition of dcache_lock for every path component lookup as done
by the earlier path walking algorithm. The big deal with fastwalk
is that it decreases the number of acquisitions of dcache_lock
for a webserver workload by 70% on an 8-CPU machine. That is avoiding
a lot of possible cacheline bouncing of dcache_lock.


> > In any case, we all know often acquired global locks are a bad idea 
> > on a 32-way, and should be avoided like the plague.  I just wish we 
> > had a dcache solution that didn't even need locks as much... :)
> 
> Well, avoiding data corruption is a preferable goal too. The point of
> RCU is not to have to take a lock for the common read case. I'd expect
> good results from it on the NUMA machines - never been benchmarked, as
> far as I recall.

You can see that in wli's dbench 512 results on his NUMA box.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
