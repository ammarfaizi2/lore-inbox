Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313138AbSC1Lhr>; Thu, 28 Mar 2002 06:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313137AbSC1Lhg>; Thu, 28 Mar 2002 06:37:36 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:20642 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S313136AbSC1LhT>; Thu, 28 Mar 2002 06:37:19 -0500
Date: Thu, 28 Mar 2002 17:10:21 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] kmem_cache_zalloc
Message-ID: <20020328171021.D22665@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020328165142.A23089@in.ibm.com> <20520.1017314712@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2002 at 11:25:12AM +0000, David Woodhouse wrote:
> 
> 
> dipankar@in.ibm.com said:
> >  I thought that the life span of an object is between
> > kmem_cache_alloc and kmem_cache_free. If you are expecting caching
> > beyond this, you may not get correct data. kmem_cache allocator is
> > supposed to quickly allocate fixed size structures avoiding the need
> > for frequent splitting and coalescing in the allocator.
> 
> > Am I missing something here ?
> 
> Yes. Slab objects can be initialised once when a new page is added to the 
> slab, and returned to the slab in reusable form so that you don't have the
> cost of complete initialisation on each allocation.
> 
> So if for example you have a semaphore in your slab object, instead of
> initialising it on each kmem_cache_alloc() you do it once when the new pages
> are added to the slab. Then you just make sure it's unlocked each time you
> free a slab object.

Ok. That makes clear why hch thought kmem_cache_alloc() can lead
to people writing bad code.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
