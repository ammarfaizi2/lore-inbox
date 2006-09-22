Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWIVRVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWIVRVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWIVRVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:21:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:13628 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S964798AbWIVRVn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:21:43 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,196,1157353200"; 
   d="scan'208"; a="120864739:sNHT23226273"
From: Jesse Barnes <jesse.barnes@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: ZONE_DMA
Date: Fri, 22 Sep 2006 10:21:15 -0700
User-Agent: KMail/1.9.4
Cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rohit Seth <rohitseth@google.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <45131D2D.8020403@mbligh.org> <Pine.LNX.4.64.0609211937460.4433@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609211937460.4433@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200609221021.16579.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 21, 2006 7:59 pm, Christoph Lameter wrote:
> > So if you just put all of memory in ZONE_DMA for your particular
> > machine, and bumped the DMA limit up to infinity, we wouldn't need
> > any of these patches, right? Which would also match what the other
> > arches do for this (eg PPC64).

This is what Altix did for a long time (and it looks like it still sets 
MAX_DMA_ADDRESS to the top of addressable memory).

> That would mean abusing ZONE_DMA for a purpose it was not intended for.
> ZOME_DMA is used to partition memory for a DMA not for covering all of
> memory. That works yes but it shows a misunderstanding of the purpose
> for which ZONE_DMA was created.

AFAIK ZONE_DMA was created for crappy ISA devices that could only DMA to 
low addresses.  As various architectures were added, they either 
misunderstood its purpose, abused it for their own purposes, or ignored it 
in some way as it didn't really apply.

> ZONE_NORMAL is DMAable. GFP_DMA has never meant this is for DMA but it
> has always meant this is for a special restricted DMA zone. That is also
> why you have GFP_DMA32. Both GFP_DMA and GFP_DMA32 select special
> restricted memory areas for handicapped DMA devices that are not able to
> reach all of memory. Neither should cover all of memory.

If you have a decent enough IOMMU both or either could cover all of memory.  
In the case of an Altix, the IOMMU is 32 bit capable, so it would make 
sense for ZONE_DMA32 to contain all of memory...

But anyway, I agree with your broader point that we really need a different 
allocator for this stuff.  It has to be arch specific in some way though, 
so we can take into account the advantages IOMMUs provide.  I think jejb 
said he'd come up with a sample implementation a couple of years ago... :)

>From a portability and definition perspective, I'd contend that ZONE_DMA 
and ZONE_DMA32 are both broken.  Only ZONE_NORMAL and ZONE_HIGHMEM have 
sane definitions it seems.

Jesse
