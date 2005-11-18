Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVKRTq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVKRTq4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVKRTq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:46:56 -0500
Received: from mtaout2.012.net.il ([84.95.2.4]:45360 "EHLO mtaout2.012.net.il")
	by vger.kernel.org with ESMTP id S932353AbVKRTqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:46:55 -0500
Date: Fri, 18 Nov 2005 21:45:48 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] x86-64: dma_ops for DMA mapping -K4
In-reply-to: <20051117220348.GA9297@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>, niv@us.ibm.com,
       Jon Mason <jdmason@us.ibm.com>, Jimi Xenidis <jimix@watson.ibm.com>,
       Muli Ben-Yehuda <MULI@il.ibm.com>,
       "Shai Fultheim (shai@scalex86.org)" <shai@scalex86.org>
Message-id: <20051118194548.GB3070@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20051117131622.GC11966@granada.merseine.nu>
 <20051117220348.GA9297@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 10:03:48PM +0000, Christoph Hellwig wrote:
> On Thu, Nov 17, 2005 at 03:16:22PM +0200, Muli Ben-Yehuda wrote:
> > Hi Andi,
> > 
> > Here's the latest version of the dma_ops patch. The patch is against
> > Linus's tree as of yesterday and applies cleanly to
> > 2.6.15-rc1-git5. Tested on AMD64 and Intel EM64 (x366) with gart,
> > swiotlb, nommu and iommu=off. Please apply...
> 
> Any chance you could move struct dma_mapping_ops to generic code and
> implement the dma_ operations ontop of them in linux/dma-mapping.h if
> the arch sets a WANT_DMA_MAPPING_OPS symbol?  This kind of switch is
> duplicated in far too many architectures.

I'm looking at this now. PPC, IA64 and parisc have something like
this, as well as x86-64 with my patch applied. The others either have
dma_ops with completely different semantics or choose the dma ops
implementation at compile time. However, each arch needs a slightly
different definition of dma_mapping_ops - I'm not sure having one
definition catering to all archs is better than what we have now,
considering the DMA mapping implementation is inherently arch
specific.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

