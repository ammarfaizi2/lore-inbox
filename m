Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWAERgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWAERgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWAERgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:36:51 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:34716 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751226AbWAERgu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:36:50 -0500
Date: Thu, 5 Jan 2006 09:37:17 -0800
From: Greg KH <gregkh@suse.de>
To: David Vrabel <dvrabel@arcom.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [DRIVER CORE] platform_get_irq*(): return NO_IRQ on error
Message-ID: <20060105173717.GA11279@suse.de>
References: <43BD534E.8050701@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BD534E.8050701@arcom.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 05:11:42PM +0000, David Vrabel wrote:
> platform_get_irq*() cannot return 0 on error as 0 is a valid IRQ on some
> platforms, return NO_IRQ (-1) instead.
> 
> Signed-off-by: David Vrabel <dvrabel@arcom.com>
> -- 
> David Vrabel, Design Engineer
> 
> Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
> Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

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

No, I think the whole NO_IRQ stuff has been given up on, see the lkml
archives for details.

thanks,

greg k-h
