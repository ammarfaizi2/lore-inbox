Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWHJFNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWHJFNs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWHJFNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:13:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8853 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161027AbWHJFNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:13:48 -0400
Date: Wed, 9 Aug 2006 22:13:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: mpm@selenic.com, npiggin@suse.de, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta information
In-Reply-To: <20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0608092211320.5806@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
 <20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006, KAMEZAWA Hiroyuki wrote:

> > There is no freelist for slabs. slabs are immediately returned to the page
> > allocator.  The page allocator has its own per cpu page queues that should provide
> > enough caching.
> > 
> 
> I think that the advantage of Slab allocator is 
> - object is already initizalized at setup, so you don't have to initialize it again at
>   allocation.
> - object is initialized only once when slab is created.

If you do that then you loose the cache hot advantage. It is advantageous 
to initialize the object and then immediately use it. If you initialize it 
before then the cacheline will be evicted and then brought back.

> If a slab page is returned to page allocator ASAP, # of object initilization may
> increase. 

The initializers in the existing slab are only used in rare cases in the 
kernel.

