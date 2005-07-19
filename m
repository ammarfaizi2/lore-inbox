Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVGSABO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVGSABO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 20:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVGSABO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 20:01:14 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48655 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261166AbVGSABN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 20:01:13 -0400
Date: Tue, 19 Jul 2005 02:01:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Erik Jacobson <erikj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] QLA2xxx FW_LOADER Kconfig issue results in undefined symbols
Message-ID: <20050719000110.GC5031@stusta.de>
References: <20050718192357.GA8470@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050718192357.GA8470@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2005 at 02:23:57PM -0500, Erik Jacobson wrote:
> I hit a small problem (first observed in 2.6.13-rc3-mm1) that resulted in
> my kernels no longer building because of undefined references to 
> request_firmware and release_firmware.
> 
> After a little research, I found that the QLA stuff requires CONFIG_FW_LOADER.
> 
> I was using the sn2_defconfig as a starting point for my config file. 
> This config file compiles some of the QLA2xxx drivers statically.
> By default, CONFIG_FW_LOADER is set to "m" and not "y".
> 
> So this small change should ensure CONFIG_FW_LOADER is set properly.
> 
> Perhaps there are better ways to do this?
>...
> --- 2.6-akpm-rc-mm-orig/drivers/scsi/qla2xxx/Kconfig	2005-07-15 10:58:54.316985000 -0500
> +++ 2.6-akpm-rc-mm/drivers/scsi/qla2xxx/Kconfig	2005-07-18 14:03:37.888758336 -0500
> @@ -3,6 +3,7 @@
>  	default (SCSI && PCI)
>  	depends on SCSI && PCI
>  	select SCSI_FC_ATTRS
> +	select FW_LOADER
>  
>  config SCSI_QLA21XX
>  	tristate "QLogic ISP2100 host adapter family support"
>...
 
I have to resend my patch for this issue that didn't make it through the 
linux-kernel filters.

Your patch enables FW_LOADER for everyone with (SCSI && PCI) since is a 
not user-visible option that is enabled then.

The correct solution my patch does is to add a "select FW_LOADER" to 
every single of the driver options below.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

