Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWIUAcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWIUAcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWIUAcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:32:05 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:49358 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750833AbWIUAcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:32:02 -0400
Date: Wed, 20 Sep 2006 17:31:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: ZONE_DMA (was: Re: 2.6.19 -mm merge plans)
In-Reply-To: <20060920172253.f6d11445.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609201724490.2403@schroedinger.engr.sgi.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <4511D855.7050100@mbligh.org>
 <20060920172253.f6d11445.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Andrew Morton wrote:

> > Would it not make sense to define what ZONE_DMA actually means
> > consistently before trying to change it? The current mess across
> > different architectures seems like a disaster area to me.
> > 
> > What DOES requesting ZONE_DMA from a driver actually mean?

ZONE_DMA is a memory area that is needed by an arch for devices that 
cannot do DMA to all of memory. The high boundary is set by 
MAX_DMA_ADDRESS.

> My concern about these patches is that they'll only be useful for
> self-compiled kernels, because distros will be forced to enable ZONE_DMA
> for evermore anyway.

We already have 4 arches now that do not need ZONE_DMA at all.

ZONE_DMA does not have a bright future with IOMMUs and other things 
around. None of my system uses ZONE_DMA and I have a variety of them.

And yes if we do not have this facility in the kernel then distros cannot 
pick it up. At least on IA64 I know that hardware from the major vendors 
has not been needing ZONE_DMA for a while now.

Also ZONE_DMA is a very bad concept. Multiple drivers may have different 
address requirements. What we need is some way for a driver to tell the 
kernel what the required range of addresses is. If a device is only 
capable of handling 30 valid address bits then we may have to use 
ZONE_DMA and only allow the use of the lower 16MB. It would be better to 
develop a different mechanism.


