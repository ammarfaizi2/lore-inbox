Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbWBWKPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWBWKPQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 05:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbWBWKPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 05:15:16 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:35488 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751680AbWBWKPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 05:15:14 -0500
Subject: Re: [Patch 2/3] fast VMA recycling
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200602231105.30581.ak@suse.de>
References: <1140686238.2972.30.camel@laptopd505.fenrus.org>
	 <200602231042.53696.ak@suse.de>
	 <1140688131.4672.21.camel@laptopd505.fenrus.org>
	 <200602231105.30581.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 11:15:06 +0100
Message-Id: <1140689706.4672.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 11:05 +0100, Andi Kleen wrote:
> On Thursday 23 February 2006 10:48, Arjan van de Ven wrote:
> > On Thu, 2006-02-23 at 10:42 +0100, Andi Kleen wrote:
> > > On Thursday 23 February 2006 10:30, Arjan van de Ven wrote:
> > > > This patch adds a per task-struct cache of a free vma. 
> > > > 
> > > > In normal operation, it is a really common action during userspace mmap 
> > > > or malloc to first allocate a vma, and then find out that it can be merged,
> > > > and thus free it again. In fact this is the case roughly 95% of the time.
> > > > 
> > > > In addition, this patch allows code to "prepopulate" the cache, and
> > > > this is done as example for the x86_64 mmap codepath. The advantage of this
> > > > prepopulation is that the memory allocation (which is a sleeping operation
> > > > due to the GFP_KERNEL flag, potentially causing either a direct sleep or a 
> > > > voluntary preempt sleep) will happen before the mmap_sem is taken, and thus 
> > > > reduces lock hold time (and thus the contention potential)
> > > 
> > > The slab fast path doesn't sleep. 
> > 
> > it does via might_sleep()
> 
> Hmm? That shouldn't sleep.

see voluntary preempt.


> If it takes any time in a real workload then it should move into DEBUG_KERNEL
> too. But I doubt it. Something with your analysis is wrong.

well I'm seeing contention; and this is one of the things that can be
moved out of the lock easily, and especially given the high recycle rate
of these things... looks worth it to me.



> P.S.: Your email address bounces.

sorry about that; made a typo when trying to figure out how to set up
non-corrupting patches lkml

