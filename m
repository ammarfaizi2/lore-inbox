Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWAER2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWAER2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWAER2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:28:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43791 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750766AbWAER2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:28:00 -0500
Date: Thu, 5 Jan 2006 17:26:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Vrabel <dvrabel@arcom.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, gregkh@suse.de
Subject: Re: [DRIVER CORE] platform_get_irq*(): return NO_IRQ on error
Message-ID: <20060105172655.GA15968@flint.arm.linux.org.uk>
Mail-Followup-To: David Vrabel <dvrabel@arcom.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, gregkh@suse.de
References: <43BD534E.8050701@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BD534E.8050701@arcom.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 05:11:42PM +0000, David Vrabel wrote:
> platform_get_irq*() cannot return 0 on error as 0 is a valid IRQ on some
> platforms, return NO_IRQ (-1) instead.

This change would require an audit of the users of these functions.
Could you check whether this is going to cause them any problems?

> Index: linux-2.6-working/drivers/base/platform.c
> ===================================================================
> --- linux-2.6-working.orig/drivers/base/platform.c	2006-01-05 16:49:23.000000000 +0000
> +++ linux-2.6-working/drivers/base/platform.c	2006-01-05 17:10:18.000000000 +0000
> @@ -59,7 +59,7 @@
>  {
>  	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
>  
> -	return r ? r->start : 0;
> +	return r ? r->start : NO_IRQ;
>  }
>  
>  /**
> @@ -94,7 +94,7 @@
>  {
>  	struct resource *r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
>  
> -	return r ? r->start : 0;
> +	return r ? r->start : NO_IRQ;
>  }
>  
>  /**


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
