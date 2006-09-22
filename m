Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWIVSj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWIVSj0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWIVSj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:39:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:48709 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S964878AbWIVSjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:39:25 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,196,1157353200"; 
   d="scan'208"; a="120893557:sNHT23612372"
From: Jesse Barnes <jesse.barnes@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: ZONE_DMA
Date: Fri, 22 Sep 2006 11:39:03 -0700
User-Agent: KMail/1.9.4
Cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rohit Seth <rohitseth@google.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <200609221126.31201.jesse.barnes@intel.com> <Pine.LNX.4.64.0609221129170.8356@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609221129170.8356@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609221139.03250.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 22, 2006 11:32 am, Christoph Lameter wrote:
> On Fri, 22 Sep 2006, Jesse Barnes wrote:
> > Oh, it's already there in the tree, but obviously some drivers still
> > need to be converted.  See Documentation/DMA-API.txt.  It's not PCI
> > specific like the old PCI DMA interface
> > (Documentation/DMA-mapping.txt) and provides a way for drivers to
> > specify their addressing limitations (dma_supported and dma_set_mask),
> > which allows the underlying architecture code to report a failure if
> > necessary.
>
> AFAICT this is dealing with special dma issues and not with the problem
> of allocating memory for a certain supported address range from the page
> allocator.

That's right.  But OTOH device drivers shouldn't be using the page 
allocator to get DMAable memory, they should be using one of the DMA APIs 
since only they can portably map memory for DMA.

> From the first glance at the docs it looks as if it is 
> relying on __GFP_DMAxx to get the allocations right. I think the code
> could be changed though to call a new page allocator function to get the
> right memory and that would work for all devices using that API.

Right, the internals are arch specific and don't necessarily have to rely 
on a zone, depending on their DMA constraints.

Jesse
