Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266238AbUGOQeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266238AbUGOQeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 12:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266241AbUGOQeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 12:34:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:40602 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266238AbUGOQeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 12:34:09 -0400
Date: Thu, 15 Jul 2004 09:34:08 -0700
From: Chris Wright <chrisw@osdl.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Chris Wright <chrisw@osdl.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Lock free fd lookup
Message-ID: <20040715093408.A1924@build.pdx.osdl.net>
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714045640.GB1220@obelix.in.ibm.com> <20040714081737.N1973@build.pdx.osdl.net> <200407151022.53084.jbarnes@engr.sgi.com> <20040715161054.GB3957@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040715161054.GB3957@in.ibm.com>; from dipankar@in.ibm.com on Thu, Jul 15, 2004 at 09:40:54PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dipankar Sarma (dipankar@in.ibm.com) wrote:
> On Thu, Jul 15, 2004 at 10:22:53AM -0400, Jesse Barnes wrote:
> > On Wednesday, July 14, 2004 11:17 am, Chris Wright wrote:
> > > I'm curious, how much of the performance improvement is from RCU usage
> > > vs. making the basic syncronization primitive aware of a reader and
> > > writer distinction?  Do you have benchmark for simply moving to rwlock_t?
> > 
> > That's a good point.  Also, even though the implementation may be 'lockless', 
> > there are still a lot of cachelines bouncing around, whether due to atomic 
> > counters or cmpxchg (in fact the latter will be worse than simple atomics).
> 
> Chris raises an interesting issue. There are two ways we can benefit from
> lock-free lookup - avoidance of atomic ops in lock acquisition/release
> and avoidance of contention. The latter can also be provided by
> rwlocks in read-mostly situations like this, but rwlock still has
> two atomic ops for acquisition/release. So, in another
> thread, I have suggested looking into the contention angle. IIUC,
> tiobench is threaded and shares fd table. 

Given the read heavy assumption that RCU makes (supported by your
benchmarks), I believe that the comparison with RCU vs. current scheme
is unfair.  Better comparison is against rwlock_t, which may give a
similar improvement w/out the added complexity.  But, I haven't a patch
nor a benchmark, so it's all handwavy at this point.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
