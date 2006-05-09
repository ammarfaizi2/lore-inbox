Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWEIV1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWEIV1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 17:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWEIV1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 17:27:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:65486 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751026AbWEIV1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 17:27:12 -0400
Date: Tue, 9 May 2006 16:26:03 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, linux-kernel@vger.kernel.org,
       ak@suse.de, linux-ia64@vger.kernel.org, mulix@mulix.org
Subject: Re: [PATCH 2/3] swiotlb: create __alloc_bootmem_low_nopanic and add support in SWIOTLB
Message-ID: <20060509212602.GD22385@us.ibm.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0670403C@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0670403C@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 02:04:08PM -0700, Luck, Tony wrote:
> > I "fixed" it with the hack below.  Please let me know if this is not
> > palatable for you.
> 
> Not really.  The only use of platform_dma_init() that I can see is in
> arch/ia64/mm/init.c:mem_init() ...
> 
> 	platform_dma_init();
> 
> so "void" looks to be the right return value.  Why did it get changed to
> be "int" (here's where I admit that I've only looked superficially at your
> patch).

Ah, then I better describe it.  The patch makes it possible to recover
from an insufficient amount of bootmem during swiotlb_init (instead of
panicing).  For x86_64, I have it bailing out (via the returned int from
swiotlb_init and using the non-iommu DMA routines from
arch/x86_64/kernel/pci-nommu.c).  For ia64, its not that simple.
There are no alternative DMA routines to switch to incase of an error.
Also, There is no way to "bail-out" from its mem_init.  I could add a
panic there, if that is more palatable.

Thanks,
Jon

> 
> -Tony
