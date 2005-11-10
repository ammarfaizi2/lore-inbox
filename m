Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVKJXNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVKJXNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVKJXNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:13:37 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:6869 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932244AbVKJXNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:13:36 -0500
Date: Thu, 10 Nov 2005 15:13:29 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Con Kolivas <kernel@kolivas.org>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, alokk@calsoftinc.com
Subject: Re: [RFC, PATCH] Slab counter troubles with swap prefetch?
In-Reply-To: <200511111007.12872.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.62.0511101510240.16588@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511101351120.16380@schroedinger.engr.sgi.com>
 <200511111007.12872.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Con Kolivas wrote:

> > This patch splits the counter into the nr_local_slab which reflects
> > slab pages allocated from the local zones (and this number is useful
> > at least as a guidance for the VM) and the remotely allocated pages.
> 
> How large a contribution is the remote slab size likely to be? Would this 
> information be useful to anyone potentially in future code besides swap 
> prefetch? The nature of prefetch is that this is only a fairly coarse measure 
> of how full the vm is with data we don't want to displace. Thus it is also 
> not important that it is very accurate. 

The size of the remote cache depends on many factors. The application can 
influence that by setting memory policies. 

> Unless the remote slab size can be a very large contribution, or having local 

Yes it can be quite large. On some of my tests with applications these are 
100%. This is typical if the application sets the policy in such a way 
that all allocations are off node or if the kernel has to allocate memory 
on a certain node for a device.

> and remote slab sizes is useful potentially to some other code I'm inclined 
> to say this is unnecessary. A simple comment saying something like "the 
> nr_slab estimation is artificially elevated by remote slab pages on numa, 
> however this contribution is not important to the accuracy of this 
> algorithm". Of course it is nice to be more accurate and if you think 
> worthwhile then we can do this - I'll be happy to be guided by your 
> judgement.

> As a side note I doubt any serious size numa hardware will ever be idle enough 
> by swap prefetch standards to even start prefetching swap pages. If you think 
> hardware of this sort is likely to benefit from swap prefetch then perhaps we 
> should look at relaxing the conditions under which prefetching occurs.

Small scale NUMA machines may benefit from swap prefetch but on larger 
machines people usually try to avoid swap altogether.

