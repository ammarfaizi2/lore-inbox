Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313135AbSC1LZl>; Thu, 28 Mar 2002 06:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313136AbSC1LZb>; Thu, 28 Mar 2002 06:25:31 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:1532 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S313135AbSC1LZV>; Thu, 28 Mar 2002 06:25:21 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020328165142.A23089@in.ibm.com> 
To: dipankar@in.ibm.com
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] kmem_cache_zalloc 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Mar 2002 11:25:12 +0000
Message-ID: <20520.1017314712@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



dipankar@in.ibm.com said:
>  I thought that the life span of an object is between
> kmem_cache_alloc and kmem_cache_free. If you are expecting caching
> beyond this, you may not get correct data. kmem_cache allocator is
> supposed to quickly allocate fixed size structures avoiding the need
> for frequent splitting and coalescing in the allocator.

> Am I missing something here ?

Yes. Slab objects can be initialised once when a new page is added to the 
slab, and returned to the slab in reusable form so that you don't have the
cost of complete initialisation on each allocation.

So if for example you have a semaphore in your slab object, instead of
initialising it on each kmem_cache_alloc() you do it once when the new pages
are added to the slab. Then you just make sure it's unlocked each time you
free a slab object.

--
dwmw2


