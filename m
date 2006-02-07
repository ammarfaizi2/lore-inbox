Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWBGIEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWBGIEA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 03:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWBGIEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 03:04:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43531 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750763AbWBGID7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 03:03:59 -0500
Date: Tue, 7 Feb 2006 08:03:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: stephen@streetfiresound.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, dvrabel@arcom.com,
       david-b@pacbell.net
Subject: Re: [PATCH] spi: Fix modular master driver remove and device suspend/remove
Message-ID: <20060207080351.GA3588@flint.arm.linux.org.uk>
Mail-Followup-To: stephen@streetfiresound.com, greg@kroah.com,
	linux-kernel@vger.kernel.org, dvrabel@arcom.com,
	david-b@pacbell.net
References: <43e80e2b.EZgObIkBxyg9Mb6O%stephen@streetfiresound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e80e2b.EZgObIkBxyg9Mb6O%stephen@streetfiresound.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 07:04:11PM -0800, stephen@streetfiresound.com wrote:
> --- linux-2.6.16-rc2/drivers/spi/spi.c	2006-02-06 18:39:31.746537258 -0800
> +++ linux-spi/drivers/spi/spi.c	2006-02-06 18:39:45.353334421 -0800
> @@ -90,7 +90,7 @@ static int spi_suspend(struct device *de
>  	int			value;
>  	struct spi_driver	*drv = to_spi_driver(dev->driver);
>  
> -	if (!drv->suspend)
> +	if (!drv || !drv->suspend)

Shouldn't this be dev->driver ?  If dev->driver is NULL, drv may be
non-NULL due to an offset in the structure.

> @@ -105,7 +105,7 @@ static int spi_resume(struct device *dev
>  	int			value;
>  	struct spi_driver	*drv = to_spi_driver(dev->driver);
>  
> -	if (!drv->resume)
> +	if (!drv || !drv->resume)

Ditto.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
