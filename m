Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWHIALZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWHIALZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 20:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWHIALY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 20:11:24 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:21167 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1030362AbWHIALX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 20:11:23 -0400
Date: Tue, 8 Aug 2006 17:13:03 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] NUMA futex hashing
Message-ID: <20060809001303.GB3762@localhost.localdomain>
References: <20060808070708.GA3931@localhost.localdomain> <p73bqqvpn14.fsf@verdi.suse.de> <200608081210.40334.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608081210.40334.dada1@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 12:10:39PM +0200, Eric Dumazet wrote:
> On Tuesday 08 August 2006 11:57, Andi Kleen wrote:
> > Ravikiran G Thirumalai <kiran@scalex86.org> writes:
> > > Current futex hash scheme is not the best for NUMA.   The futex hash
> > > table is an array of struct futex_hash_bucket, which is just a spinlock
> > > and a list_head -- this means multiple spinlocks on the same cacheline
> > > and on NUMA machines, on the same internode cacheline.  If futexes of two
> > > unrelated threads running on two different nodes happen to hash onto
> > > adjacent hash buckets, or buckets on the same internode cacheline, then
> > > we have the internode cacheline bouncing between nodes.
> >
> > When I did some testing with a (arguably far too lock intensive) benchmark
> > on a bigger box I got most bouncing cycles not in the futex locks itself,
> > but in the down_read on the mm semaphore.
> 
> This is true, even with a normal application (not a biased benchmark) and 
> using oprofile. mmap_sem is the killer.

Not if two threads of two different process (so no same mmap_sem) hash onto
futexes on the same cacheline.   But agreed, mmap_sem needs to be fixed too.
If everyone agrees on a per-process hash table for private futexes, then
we will work on that approach.  

Thanks,
Kiran
