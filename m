Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262705AbSITO34>; Fri, 20 Sep 2002 10:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262716AbSITO34>; Fri, 20 Sep 2002 10:29:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:18941 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262705AbSITO3z>; Fri, 20 Sep 2002 10:29:55 -0400
Message-ID: <3D8B31F8.40900@us.ibm.com>
Date: Fri, 20 Sep 2002 07:34:32 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maneesh@in.ibm.com
CC: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu,
       Hanna Linder <hannal@us.ibm.com>
Subject: Re: 2.5.36-mm1 dbench 512 profiles
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni wrote:
> On Fri, 20 Sep 2002 05:48:38 +0530, William Lee Irwin III wrote:
> 
>>Hanna Linder wrote:
>>
>>>>Looks like fastwalk might not behave so well on this 32 cpu numa
>>>>system...
>>
>>On Thu, Sep 19, 2002 at 04:38:14PM -0700, Andrew Morton wrote:
>>
>>>I've rather lost the plot.  Have any of the dcache speedup patches been
>>>merged into 2.5?
>>
>>As far as the dcache goes, I'll stick to observing and reporting. I'll
>>rerun with dcache patches applied, though.
>>
> For a 32-way system fastwalk will perform badly from dcache_lock point of 
> view, basically due to increased lock hold time. dcache_rcu-12 should reduce
> dcache_lock contention and hold time.

Isn't increased hold time _good_ on NUMA-Q?  I thought that the really 
costy operation was bouncing the lock around the interconnect, not 
holding it.  Has fastwalk ever been tested on NUMA-Q?

Remember when John Stultz tried MCS (fair) locks on NUMA-Q?  They 
sucked because low hold times, which result from fairness, aren't 
efficient.  It is actually faster to somewhat starve remote CPUs.

In any case, we all know often acquired global locks are a bad idea on 
a 32-way, and should be avoided like the plague.  I just wish we had a 
dcache solution that didn't even need locks as much... :)

-- 
Dave Hansen
haveblue@us.ibm.com

