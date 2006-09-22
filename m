Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWIVSZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWIVSZy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWIVSZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:25:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:21296 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S964862AbWIVSZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:25:53 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,204,1157353200"; 
   d="scan'208"; a="135233641:sNHT17991015"
From: Jesse Barnes <jesse.barnes@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: ZONE_DMA
Date: Fri, 22 Sep 2006 11:26:31 -0700
User-Agent: KMail/1.9.4
Cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rohit Seth <rohitseth@google.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <200609221039.28436.jesse.barnes@intel.com> <Pine.LNX.4.64.0609221107440.8037@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609221107440.8037@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609221126.31201.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 22, 2006 11:08 am, Christoph Lameter wrote:
> On Fri, 22 Sep 2006, Jesse Barnes wrote:
> > Ok and right after I sent this my brain returned from vacation and I
> > remembered jejb's DMA allocation API.  It's powerful enough to cover
> > most driver use cases I think (users of GFP_DMA should probably be
> > converted), but for example block layer bounce buffering might need a
> > different interface as I see you've proposed in another mail.
>
> Could you dig that out and give us some refs or even better port that
> thing to a current mm tree?

Oh, it's already there in the tree, but obviously some drivers still need 
to be converted.  See Documentation/DMA-API.txt.  It's not PCI specific 
like the old PCI DMA interface (Documentation/DMA-mapping.txt) and 
provides a way for drivers to specify their addressing limitations 
(dma_supported and dma_set_mask), which allows the underlying architecture 
code to report a failure if necessary.

I think many of the examples I cited can be converted to use the DMA API, 
but block layer bounce buffering might need special treatment or perhaps a 
way to get at the underlying struct device for the associated request...

Jesse
