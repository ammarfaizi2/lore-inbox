Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVG1E0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVG1E0T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 00:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVG1E0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 00:26:19 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:43325 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261184AbVG1E0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 00:26:19 -0400
Date: Wed, 27 Jul 2005 21:26:07 -0700
From: Greg KH <gregkh@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       mj@ucw.cz, openib-general@openib.org
Subject: Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
Message-ID: <20050728042607.GA12799@suse.de>
References: <20050725223200.GA1545@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050725223200.GA1545@mellanox.co.il>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 01:32:00AM +0300, Michael S. Tsirkin wrote:
> Greg, Martin, does the following make sense?
> If it does, should other architectures be updated as well?
> 
> ---
> 
> Convert i386/pci to use io_remap_pfn_range instead of remap_pfn_range.
> 
> Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
> 
> Index: linux-2.6.12.2/arch/i386/pci/i386.c
> ===================================================================
> --- linux-2.6.12.2.orig/arch/i386/pci/i386.c
> +++ linux-2.6.12.2/arch/i386/pci/i386.c
> @@ -295,9 +295,9 @@ int pci_mmap_page_range(struct pci_dev *
>  	/* Write-combine setting is ignored, it is changed via the mtrr
>  	 * interfaces on this platform.
>  	 */
> -	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> -			     vma->vm_end - vma->vm_start,
> -			     vma->vm_page_prot))
> +	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +			       vma->vm_end - vma->vm_start,
> +			       vma->vm_page_prot))

Hm, you do realize that io_remap_pfn_range() is the same thing as
remap_pfn_range() on i386, right?

So, why would this patch change anything?

thanks,

greg k-h
