Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWEZH6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWEZH6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWEZH6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:58:53 -0400
Received: from ns.suse.de ([195.135.220.2]:11475 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750823AbWEZH6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:58:52 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH 2/4] x86-64: Calgary IOMMU - move valid_dma_direction into the callers
Date: Fri, 26 May 2006 09:57:01 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Garzik <jeff@garzik.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20060525033550.GD7720@us.ibm.com> <20060525094236.GB22495@granada.merseine.nu> <44757FD3.3070805@garzik.org>
In-Reply-To: <44757FD3.3070805@garzik.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605260957.02163.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 May 2006 11:58, Jeff Garzik wrote:
> Muli Ben-Yehuda wrote:
> > On Thu, May 25, 2006 at 12:35:07AM -0400, Jeff Garzik wrote:
> >> Jon Mason wrote:
> >>> >From Andi Kleen's comments on the original Calgary patch, move
> >>> valid_dma_direction into the calling functions.
> >>>
> >>> Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
> >>> Signed-off-by: Jon Mason <jdmason@us.ibm.com>
> >> Even though BUG_ON() includes unlikely(), this introduces additional 
> >> tests in very hot paths.
> > 
> > Are they really very hot? I mean if you're calling the DMA API, you're
> > about to frob the hardware or have already frobbed it - does this
> > check really matter?
> 
> When you are adding a check that will _never_ be hit in production, to 
> the _hottest_ paths in the kernel, you can be assured it matters...

pci_dma_* shouldn't be that hot. Or at least IO usually has so much
overhead that some more bugging shouldn't matter.

On the other hand if the problem of passing wrong parameters here
isn't common I would be ok with dropping them.

-Andi
