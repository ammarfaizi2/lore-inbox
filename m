Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVCJDvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVCJDvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVCJDuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 22:50:10 -0500
Received: from fmr22.intel.com ([143.183.121.14]:31974 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261719AbVCJDrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 22:47:40 -0500
Message-Id: <200503100347.j2A3lRg28975@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel
Date: Wed, 9 Mar 2005 19:47:27 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUlGIrLWr4iFx75TRmara5a3cx0mwABFzVQ
In-Reply-To: <20050309182550.0291c6fd.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote Wednesday, March 09, 2005 6:26 PM
> What does "1/3 of the total benchmark performance regression" mean?  One
> third of 0.1% isn't very impressive.  You haven't told us anything at all
> about the magnitude of this regression.

2.6.9 kernel is 6% slower compare to distributor's 2.4 kernel (RHEL3).  Roughly
2% came from storage driver (I'm not allowed to say anything beyond that, there
is a fix though).

2% came from DIO.

The rest of 2% is still unaccounted for.  We don't know where.

> How much system time?  User time?  All that stuff.
20.5% in the kernel, 79.5% in user space.


> But the first thing to do is to work out where the cycles are going to.
You've seen the profile.  That's where all the cycle went.


> Also, I'm rather peeved that we're hearing about this regression now rather
> than two years ago.  And mystified as to why yours is the only group which
> has reported it.

2.6.X kernel has never been faster than the 2.4 kernel (RHEL3).  At one point
of time, around 2.6.2, the gap is pretty close, at around 1%, but still slower.
Around 2.6.5, we found global plug list is causing huge lock contention on
32-way numa box.  That got fixed in 2.6.7.  Then comes 2.6.8 which took a big
dip at close to 20% regression.  Then we fixed 17% regression in the scheduler
(fixed with cache_decay_tick).  2.6.9 is the last one we measured and it is 6%
slower.  It's a constant moving target, a wild goose to chase.

I don't know why other people have not reported the problem, perhaps they
haven't got a chance to run transaction processing db workload on 2.6 kernel.
Perhaps they have not compared, perhaps they are working on the same problem.
I just don't know.

- Ken


