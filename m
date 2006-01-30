Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWA3Nw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWA3Nw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 08:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWA3Nw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 08:52:26 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:27039 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932275AbWA3Nw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 08:52:26 -0500
Date: Mon, 30 Jan 2006 07:52:14 -0600
From: Mark Maule <maule@sgi.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-ID: <20060130135213.GA1381@sgi.com>
References: <20060129144533.128af741.akpm@osdl.org> <20060130094049.GF23968@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130094049.GF23968@granada.merseine.nu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry 'bout that ... 

Yes, this is the coorect fix.  thanks.

Mark

On Mon, Jan 30, 2006 at 11:40:49AM +0200, Muli Ben-Yehuda wrote:
> On Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton wrote:
> > 
> >
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/
> 
> IA64 defconfig breaks with:
> 
>   CC      arch/ia64/sn/pci/tioce_provider.o
> /home/muli/kernel/common-swiotlb/mm4.swiotlb/arch/ia64/sn/pci/tioce_provider.c:721:32:
> macro "ATE_MAKE" requires 3 arguments, but only 2 given
> /home/muli/kernel/common-swiotlb/mm4.swiotlb/arch/ia64/sn/pci/tioce_provider.c:
> In function `tioce_reserve_m32':
> 
> Attached patch fixes it. Mark, looks like it's your Altix MSI support
> patch (http://patchwork.ozlabs.org/linuxppc64/patch?id=4231) that
> broke it. Is the fix correct?
> 
> Signed-off-by: Muli Ben-Yehuda <mulix@mulix.org>
> 
> diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/arch/ia64/sn/pci/tioce_provider.c mm4.ate/arch/ia64/sn/pci/tioce_provider.c
> --- mm4.orig/arch/ia64/sn/pci/tioce_provider.c	2006-01-30 10:34:57.000000000 +0200
> +++ mm4.ate/arch/ia64/sn/pci/tioce_provider.c	2006-01-30 11:27:58.000000000 +0200
> @@ -717,7 +717,7 @@ tioce_reserve_m32(struct tioce_kernel *c
>  	while (ate_index <= last_ate) {
>  		u64 ate;
>  
> -		ate = ATE_MAKE(0xdeadbeef, ps);
> +		ate = ATE_MAKE(0xdeadbeef, ps, 0);
>  		ce_kern->ce_ate3240_shadow[ate_index] = ate;
>  		tioce_mmr_storei(ce_kern, &ce_mmr->ce_ure_ate3240[ate_index],
>  				 ate);
> 
> 
> -- 
> Muli Ben-Yehuda
> http://www.mulix.org | http://mulix.livejournal.com/
