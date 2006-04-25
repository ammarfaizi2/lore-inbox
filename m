Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWDYNyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWDYNyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 09:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWDYNyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 09:54:17 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:3239 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932220AbWDYNyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 09:54:16 -0400
Date: Tue, 25 Apr 2006 08:58:10 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64: trivial gart clean-up
Message-ID: <20060425135810.GA7779@us.ibm.com>
References: <20060424225342.GB14575@us.ibm.com> <200604250042.43910.ak@suse.de> <20060425052607.GC28558@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425052607.GC28558@granada.merseine.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 08:26:07AM +0300, Muli Ben-Yehuda wrote:
> On Tue, Apr 25, 2006 at 12:42:43AM +0200, Andi Kleen wrote:
> 
> > On Tuesday 25 April 2006 00:53, Jon Mason wrote:
> > > A trivial change to have gart_unmap_sg call gart_unmap_single directly,
> > > instead of bouncing through the dma_unmap_single wrapper in
> > > dma-mapping.h.  This change required moving the gart_unmap_single above
> > > gart_unmap_sg, and under gart_map_single (which seems a more logical
> > > place that its current location IMHO).
> > 
> > What advantage does that have? I think I prefer the old code.
> 
> I don't know what Jon had in mind, but we do avoid a call through a
> function pointer this way. I agree with Jon that it also makes more
> sense - gart code can just call the gart code directly, without going
> through the dma_xxx wrapper that ends up calling it anyway.

Yes, that is exactly what I was trying to say in my comment above.
Sorry for the confusion, and thanks for clearing it up Muli.

The dma_unmap_single call is the only dma_XXX type call in the gart
code.  All other calls use the gart_XXX equivalent.  It seems to me that
this was an oversight.  Also, the dma_XXX type calls go through a
wrapper in asm/dma-mapping.h, which translates this call to the gart
equivalent.  It also makes the code 8 bytes smaller :)

Thanks,
Jon

> 
> Cheers,
> Muli
> -- 
> Muli Ben-Yehuda
> http://www.mulix.org | http://mulix.livejournal.com/
> 
