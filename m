Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWFBVyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWFBVyM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWFBVyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:54:12 -0400
Received: from mga03.intel.com ([143.182.124.21]:39303 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030325AbWFBVyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:54:11 -0400
X-IronPort-AV: i="4.05,205,1146466800"; 
   d="scan'208"; a="45272948:sNHT30037973"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>, <linux-kernel@vger.kernel.org>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, "'Chris Mason'" <mason@suse.com>,
       "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 14:54:11 -0700
Message-ID: <000201c6868f$14ddbfc0$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaGRtIDk32mHzBMTdqcqq5tQbqNEwAR8Mzg
In-Reply-To: <200606022316.41139.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Friday, June 02, 2006 6:17 AM
> On Friday 02 June 2006 20:30, Con Kolivas wrote:
> > On Friday 02 June 2006 18:56, Nick Piggin wrote:
> > > And why do we lock all siblings in the other case, for that matter? (not
> > > that it makes much difference except on niagara today).
> >
> > If we spinlock (and don't trylock as you're proposing) we'd have to do a
> > double rq lock for each sibling. I guess half the time double_rq_lock will
> > only be locking one runqueue... with 32 runqueues we either try to lock all
> > 32 or lock 1.5 runqueues 32 times... ugh both are ugly.
> 
> Thinking some more on this it is also clear that the concept of per_cpu_gain  
> for smt is basically wrong once we get beyond straight forward 2 thread 
> hyperthreading. If we have more than 2 thread units per physical core, the 
> per cpu gain per logical core will decrease the more threads are running on 
> it. While it's always been obvious the gain per logical core is entirely 
> dependant on the type of workload and wont be a simple 25% increase in cpu 
> power, it is clear that even if we assume an "overall" increase in cpu for 
> each logical core added, there will be some non linear function relating 
> power increase to thread units used. :-|


In the context of having more than 2 sibling CPUs in a domain, doesn't the
current code also suffer from thunder hurd problem as well? When high
priority task goes to sleep, it will wake up *all* sibling sleepers and
then they will all fight for CPU resource, but potentially only one will win?


 
