Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVCXPyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVCXPyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVCXPvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:51:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35087 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263102AbVCXPuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:50:23 -0500
Date: Thu, 24 Mar 2005 15:50:14 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wbsd update
Message-ID: <20050324155014.C4189@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <42408E3F.5040509@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42408E3F.5040509@drzeus.cx>; from drzeus-list@drzeus.cx on Tue, Mar 22, 2005 at 10:29:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 10:29:35PM +0100, Pierre Ossman wrote:
> @@ -1581,7 +1895,7 @@
>  #define wbsd_resume NULL
>  #endif
>  
> -static void wbsd_release(struct device *dev)
> +static void wbsd_release_dev(struct device *dev)
>  {
>  }
>  
> @@ -1589,7 +1903,7 @@
>  	.name		= DRIVER_NAME,
>  	.id			= -1,
>  	.dev		= {
> -		.release = wbsd_release,
> +		.release = wbsd_release_dev,
>  	},
>  };
>  

Please use platform_device_register_simple() instead of providing a buggy
release function.

> @@ -133,13 +139,20 @@
>  #define WBSD_CRC_OK		0x05 /* S010E (00101) */
>  #define WBSD_CRC_FAIL		0x0B /* S101E (01011) */
>  
> +#define WBSD_DMA_SIZE		65536
>  
>  struct wbsd_host
>  {
> +	struct device*		dev;

You might like to consider using mmc->dev instead of duplicating it
here.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
