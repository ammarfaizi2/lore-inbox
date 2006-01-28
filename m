Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422801AbWA1CeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801AbWA1CeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbWA1CeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:34:23 -0500
Received: from mail.suse.de ([195.135.220.2]:32956 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422801AbWA1CeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:34:22 -0500
From: Andi Kleen <ak@suse.de>
To: Greg KH <gregkh@suse.de>
Subject: Re: [patch 09/12] Mask off GFP flags before swiotlb_alloc_coherent
Date: Sat, 28 Jan 2006 03:33:23 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk
References: <20060128020629.908825000@press.kroah.org> <20060128022121.GJ17001@kroah.com>
In-Reply-To: <20060128022121.GJ17001@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601280333.25026.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 January 2006 03:21, Greg KH wrote:
> 2.6.15.2 -stable review patch.  If anyone has any objections, please let 
> us know.

That patch isn't in mainline yet and shouldn't be merged to stable before
that happens.

-Andi

> 
> ------------------
> 
> From: Andi Kleen <ak@muc.de>
> 
> Mask off GFP flags before swiotlb_alloc_coherent
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> Signed-off-by: Chris Wright <chris@sous-sol.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
>  arch/x86_64/kernel/pci-gart.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-2.6.15.1.orig/arch/x86_64/kernel/pci-gart.c
> +++ linux-2.6.15.1/arch/x86_64/kernel/pci-gart.c
> @@ -244,6 +244,7 @@ dma_alloc_coherent(struct device *dev, s
>  					   get_order(size));
>  
>  				if (swiotlb) {
> +					gfp &= ~(GFP_DMA32|GFP_DMA);
>  					return
>  					swiotlb_alloc_coherent(dev, size,
>  							       dma_handle,
> 
> --
> 
