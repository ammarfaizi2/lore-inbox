Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWIVScu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWIVScu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWIVScu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:32:50 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58839 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964875AbWIVScs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:32:48 -0400
Date: Fri, 22 Sep 2006 11:32:28 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Jesse Barnes <jesse.barnes@intel.com>
cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rohit Seth <rohitseth@google.com>
Subject: Re: ZONE_DMA
In-Reply-To: <200609221126.31201.jesse.barnes@intel.com>
Message-ID: <Pine.LNX.4.64.0609221129170.8356@schroedinger.engr.sgi.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <200609221039.28436.jesse.barnes@intel.com>
 <Pine.LNX.4.64.0609221107440.8037@schroedinger.engr.sgi.com>
 <200609221126.31201.jesse.barnes@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Jesse Barnes wrote:

> Oh, it's already there in the tree, but obviously some drivers still need 
> to be converted.  See Documentation/DMA-API.txt.  It's not PCI specific 
> like the old PCI DMA interface (Documentation/DMA-mapping.txt) and 
> provides a way for drivers to specify their addressing limitations 
> (dma_supported and dma_set_mask), which allows the underlying architecture 
> code to report a failure if necessary.

AFAICT this is dealing with special dma issues and not with the problem of 
allocating memory for a certain supported address range from the page 
allocator. From the first glance at the docs it looks as if it is relying 
on __GFP_DMAxx to get the allocations right. I think the code could be 
changed though to call a new page allocator function to get the right 
memory and that would work for all devices using that API.

