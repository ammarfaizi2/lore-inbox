Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVINJ5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVINJ5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbVINJ5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:57:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49585 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965130AbVINJ5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:57:48 -0400
Date: Wed, 14 Sep 2005 15:22:07 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, ak@suse.de, dgc@sgi.com,
       bharata@in.ibm.com, tytso@mit.edu, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050914095207.GA4833@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050911105709.GA16369@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050913215932.GA1654338@melbourne.sgi.com> <200509141101.16781.ak@suse.de> <4327EA6B.6090102@colorfullife.com> <20050914024313.1e70f2a3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914024313.1e70f2a3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 02:43:13AM -0700, Andrew Morton wrote:
> Manfred Spraul <manfred@colorfullife.com> wrote:
> >
> > One tricky point are directory dentries: As far as I see, they are 
> >  pinned and unfreeable if a (freeable) directory entry is in the cache.
> >
> I don't think it's been demonstrated that Ted's problem was caused by
> internal fragementation, btw.  Ted, could you run slabtop, see what the
> dcache occupancy is?  Monitor it as you start to manually apply pressure? 
> If the occupancy falls to 10% and not many slab pages are freed up yet then
> yup, it's internal fragmentation.
> 
> I've found that internal fragmentation due to pinned directory dentries can
> be very high if you're running silly benchmarks which create some
> regular-shaped directory tree which can easily create pathological
> patterns.  For real-world things with irregular creation and access
> patterns and irregular directory sizes the fragmentation isn't as easy to
> demonstrate.
> 
> Another approach would be to do an aging round on a directory's children
> when an unfreeable dentry is encountered on the LRU.  Something like that. 
> If internal fragmentation is indeed the problem.

One other point to look at is whether fragmentation is due to pinned
dentries or not. We can get that information only from dcache itself.
That is what we need to acertain first using the instrumentation
patch. Solving the problem of large # of pinned dentries and large # of LRU 
free dentries will likely require different approaches. Even the
LRU dentries are sometimes pinned due to the lazy-lru stuff that
we did for lock-free dcache. Let us get some accurate dentry
stats first from the instrumentation patch.

Thanks
Dipankar
