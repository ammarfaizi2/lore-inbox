Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVAPMGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVAPMGD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 07:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVAPMGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 07:06:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16395 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262490AbVAPMFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 07:05:54 -0500
Date: Sun, 16 Jan 2005 13:05:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@lst.de>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix CONFIG_AGP depencies
Message-ID: <20050116120550.GQ4274@stusta.de>
References: <20050116114457.GA13506@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116114457.GA13506@lst.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 12:44:57PM +0100, Christoph Hellwig wrote:

> When I did an allmodconfig on ppc64 it selected agp although ppc64
> doesn't support agp and has not agp.h so the build failed.
> 
> This patch makes CONFIG_AGP depend on the architectures that actually
> support agp.
> 
> 
> --- 1.39/drivers/char/agp/Kconfig	2005-01-08 01:15:52 +01:00
> +++ edited/drivers/char/agp/Kconfig	2005-01-16 11:39:56 +01:00
> @@ -1,5 +1,6 @@
>  config AGP
> -	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU && !M68K && !ARM
> +	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
> +	depends on ALPHA || IA64 || PPC || X86
>  	default y if GART_IOMMU
>  	---help---
>  	  AGP (Accelerated Graphics Port) is a bus system mainly used to

This doesn't seem to achieve what you want:
PPC is defined on ppc64...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

