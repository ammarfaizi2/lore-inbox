Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWIVRn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWIVRn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWIVRn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:43:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:42760 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S964825AbWIVRn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:43:56 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,204,1157353200"; 
   d="scan'208"; a="133359785:sNHT56764386"
From: Jesse Barnes <jesse.barnes@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: ZONE_DMA
Date: Fri, 22 Sep 2006 10:39:28 -0700
User-Agent: KMail/1.9.4
Cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rohit Seth <rohitseth@google.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <Pine.LNX.4.64.0609211937460.4433@schroedinger.engr.sgi.com> <200609221021.16579.jesse.barnes@intel.com>
In-Reply-To: <200609221021.16579.jesse.barnes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609221039.28436.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 22, 2006 10:21 am, Jesse Barnes wrote:
> If you have a decent enough IOMMU both or either could cover all of
> memory. In the case of an Altix, the IOMMU is 32 bit capable, so it
> would make sense for ZONE_DMA32 to contain all of memory...
>
> But anyway, I agree with your broader point that we really need a
> different allocator for this stuff.  It has to be arch specific in some
> way though, so we can take into account the advantages IOMMUs provide. 
> I think jejb said he'd come up with a sample implementation a couple of
> years ago... :)
>
> From a portability and definition perspective, I'd contend that ZONE_DMA
> and ZONE_DMA32 are both broken.  Only ZONE_NORMAL and ZONE_HIGHMEM have
> sane definitions it seems.

Ok and right after I sent this my brain returned from vacation and I 
remembered jejb's DMA allocation API.  It's powerful enough to cover most 
driver use cases I think (users of GFP_DMA should probably be converted), 
but for example block layer bounce buffering might need a different 
interface as I see you've proposed in another mail.

Hm... s390 driver seem to like GFP_DMA a lot...  and there are a few 
remaining uses in drivers/scsi... and then of course there are the OSS 
drivers...

Jesse
