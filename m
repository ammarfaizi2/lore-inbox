Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUHIQNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUHIQNM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266720AbUHIQMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:12:37 -0400
Received: from mailout.zma.compaq.com ([161.114.64.105]:60177 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S266725AbUHIQIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:08:31 -0400
Date: Mon, 9 Aug 2004 11:07:43 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix CCISS with PROC_FS=n
Message-ID: <20040809160743.GB4770@beardog.cca.cpqcorp.net>
References: <20040809153446.GS26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809153446.GS26174@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 05:34:46PM +0200, Adrian Bunk wrote:
> I got the following compile error in 2.6.8-rc3-mm2 with 
> CONFIG_PROC_FS=n:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x1b221c): In function `do_cciss_intr':
> : undefined reference to `complete_scsi_command'
> drivers/built-in.o(.text+0x1b2d18): In function `cciss_init_one':
> : undefined reference to `cciss_scsi_setup'
> drivers/built-in.o(.text+0x1b2fd3): In function `cciss_remove_one':
> : undefined reference to `cciss_unregister_scsi'
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> 
> The following patch fixes this issue:
> 
> 
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
> 
> --- linux-2.6.8-rc3-mm2-full/drivers/block/cciss.c.old	2004-08-09 17:26:58.000000000 +0200
> +++ linux-2.6.8-rc3-mm2-full/drivers/block/cciss.c	2004-08-09 17:27:14.000000000 +0200
> @@ -185,10 +185,11 @@
>          }
>          return c;
>  }
> -#ifdef CONFIG_PROC_FS
>  
>  #include "cciss_scsi.c"		/* For SCSI tape support */

We use /proc to hook into the SCSI subsystem. If you do not build /proc support
into your kernel then you should also disable tape support in the driver. 

Thanks,
mikem
>  
> +#ifdef CONFIG_PROC_FS
> +
>  /*
>   * Report information about this controller.
>   */
> 
