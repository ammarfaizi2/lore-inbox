Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVFVQan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVFVQan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVFVQac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:30:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:15815 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261650AbVFVQ1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:27:05 -0400
Date: Wed, 22 Jun 2005 09:26:55 -0700
From: Greg KH <greg@kroah.com>
To: Stelian Pop <stelian@popies.net>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: usb sysfs intf files no longer created when probe fails
Message-ID: <20050622162655.GC2274@kroah.com>
References: <Pine.LNX.4.44L0.0506221133230.6938-100000@iolanthe.rowland.org> <1119455608.4651.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119455608.4651.5.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 05:53:28PM +0200, Stelian Pop wrote:
> Le mercredi 22 juin 2005 ?? 11:41 -0400, Alan Stern a ??crit :
> 
> > This is a curious aspect of the driver model core.  Should failure of a 
> > driver to bind be considered serious enough to cause device_add to fail?
> > The current answer is Yes unless the driver's probe routine returns 
> > -ENODEV or -ENXIO, in which case the failure is not considered serious.
> 
> Indeed. I've also tracked my problem down to the hid core which returns
> -EIO when it fails to drive an unknown HID device, instead of a more
> logical -ENODEV (this is not a failure to init a known device, but
> rather the impossibility to init an unknown device).
> 
> The patch below solves the problem for me:
> 
> Index: linux-2.6-trunk.git/drivers/usb/input/hid-core.c
> ===================================================================
> --- linux-2.6-trunk.git.orig/drivers/usb/input/hid-core.c	2005-06-22
> 10:33:23.000000000 +0200
> +++ linux-2.6-trunk.git/drivers/usb/input/hid-core.c	2005-06-22
> 17:43:10.000000000 +0200
> @@ -1784,7 +1784,7 @@
>  	if (!hid->claimed) {
>  		printk ("HID device not claimed by input or hiddev\n");
>  		hid_disconnect(intf);
> -		return -EIO;
> +		return -ENODEV;
>  	}

Also need to do the same a few lines above in the code.  I've fixed that
too now.

thanks again,

greg k-h
