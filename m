Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVAYGIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVAYGIC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVAYGIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:08:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:57824 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261830AbVAYGHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:07:53 -0500
Date: Mon, 24 Jan 2005 22:05:55 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Enforce USB interface claims
Message-ID: <20050125060555.GC2061@kroah.com>
References: <20050123111258.GA29513@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123111258.GA29513@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 03:12:58AM -0800, Chris Wedgwood wrote:
> Greg,

Adding linux-usb-devel to the CC:

> How would you feel about something like this?
> 
> Index: cw-current/drivers/usb/core/devio.c
> ===================================================================
> --- cw-current.orig/drivers/usb/core/devio.c	2005-01-19 14:52:27.987890276 -0800
> +++ cw-current/drivers/usb/core/devio.c	2005-01-22 18:09:22.753895659 -0800
> @@ -417,10 +417,7 @@
>  		return -EINVAL;
>  	if (test_bit(ifnum, &ps->ifclaimed))
>  		return 0;
> -	/* if not yet claimed, claim it for the driver */
> -	dev_warn(&ps->dev->dev, "usbfs: process %d (%s) did not claim interface %u before use\n",
> -	       current->pid, current->comm, ifnum);
> -	return claimintf(ps, ifnum);
> +	return -EINVAL;
>  }
>  
>  static int findintfep(struct usb_device *dev, unsigned int ep)


Um, why?  I think this is there to help with "broken" userspace code
that was written before we enforced the rules of "you must claim an
interface before using it."  As such, I don't think we can apply this
patch.

thanks,

greg k-h
