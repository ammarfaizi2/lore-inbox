Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288420AbSBIGPw>; Sat, 9 Feb 2002 01:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288432AbSBIGPn>; Sat, 9 Feb 2002 01:15:43 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29340 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288420AbSBIGPa>; Sat, 9 Feb 2002 01:15:30 -0500
Date: Sat, 9 Feb 2002 11:48:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org, Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [PATCH] Read-Copy Update 2.5.4-pre2
Message-ID: <20020209114818.C19737@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020208234217.A18466@in.ibm.com> <Pine.LNX.4.33.0202081847020.30304-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0202081847020.30304-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Fri, Feb 08, 2002 at 06:51:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 06:51:52PM -0500, Mark Hahn wrote:
> > in lkml in the past. Currently there are several potential 
> > applications of RCU that are being developed and some of them look 
> > very promising. Our revamped webpage 
> 
> yes, but have you evaluated whether it's noticably better than
> other forms of locking?  for instance, couldn't your dcache example
> simply use BR locks?

First of all, IMO, RCU is not a wholesale replacement for one form of
locking or another. It provides two things -

1. Simplify locking in certain complicated cases - like module
   unloading or Hotplug CPU support.
2. It can used to avoid *both* lock contention and lock cacheline
   bouncing in performance critical code where it makes sense.

Now, I would argue that RCU in this case has less overhead than BR locks.
Sure, BR locks would allow multiple d_lookups to happen, but
all workloads that we looked did not always have heavily
skewed read-to-write ratios. dbench showed about 4:1 ratio,
httperf showed about 3:1 ratio, other workloads even less skewed.
That is not good for BR locks. Remember, apart from the contention
with the update side, there is also the overhead of that CPU's
BR lock cacheline miss in lookup.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
