Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289726AbSBESQS>; Tue, 5 Feb 2002 13:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289727AbSBESQF>; Tue, 5 Feb 2002 13:16:05 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24510 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289726AbSBESPq>;
	Tue, 5 Feb 2002 13:15:46 -0500
Date: Tue, 5 Feb 2002 23:47:57 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New Read-Copy Update patch
Message-ID: <20020205234757.A427@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020205211826.B32506@in.ibm.com> <200202051654.g15GsWH01780@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202051654.g15GsWH01780@ns.caldera.de>; from hch@ns.caldera.de on Tue, Feb 05, 2002 at 05:54:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 05:54:32PM +0100, Christoph Hellwig wrote:
> In article <20020205211826.B32506@in.ibm.com> you wrote:
> > 3. A per-cpu timer support ? - This will allow us to get rid of the krcud
> >    stuff and make RCU even simpler.
> 
> Something like http://people.redhat.com/mingo/scalable-timers-patches/smptimers-2.4.16-A0?

Almost. IIUC, there is still the possibility that a timer queued
in one CPU may get executed in another. While this by itself
doesn't cause a problem for this RCU implementation (we end up
checking some other CPU's queue), if one CPU is starved of timers,
it could be problematic.

Since we have many per-cpu data structures, it would be a useful thing
to have a per-cpu mechanism to manipulate these data structures
in a cache-sensitive way.

> 
> Ingo, Linus:  Any chance to see that in 2.5 soon?

IIRC, timerlist_lock used to show up in lockmetering in some workloads
we were using some time ago. It would be a good thing to get rid
of this global lock soon.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
