Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVASWSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVASWSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVASWQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:16:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:12540 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261945AbVASWOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:14:36 -0500
Date: Wed, 19 Jan 2005 14:07:07 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: mdharm-usb@one-eyed-alien.net, zaitcev@yahoo.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on USB_STORAGE=n
Message-ID: <20050119220707.GM4151@kroah.com>
References: <20041220001644.GI21288@stusta.de> <20041220003146.GB11358@kroah.com> <20041223024031.GO5217@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041223024031.GO5217@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 03:40:31AM +0100, Adrian Bunk wrote:
> On Sun, Dec 19, 2004 at 04:31:46PM -0800, Greg KH wrote:
> > On Mon, Dec 20, 2004 at 01:16:44AM +0100, Adrian Bunk wrote:
> > > I've already seen people crippling their usb-storage driver with 
> > > enabling BLK_DEV_UB - and I doubt the warning in the help text added 
> > > after 2.6.9 will fix all such problems.
> > > 
> > > Is there except for kernel size any good reason for using BLK_DEV_UB 
> > > instead of USB_STORAGE?
> > 
> > You don't want to use the scsi layer?  You like the stability of it at
> > times?  :)
> > 
> > > If not, I'd suggest the patch below to let BLK_DEV_UB depend
> > > on EMBEDDED.
> > 
> > No, it's good for non-embedded boxes too.
> 
> 
> My current understanding is:
> - BLK_DEV_UB supports a subset of what USB_STORAGE can support
> - for an average user, there's no reason to enable BLK_DEV_UB
> - if you really know what you are doing, there might be several reasons
>   why you might want to use BLK_DEV_UB

I have been running with just the code portion of this patch for a while
now, with good results (no Kconfig changes.)

Pete and Matt, do you mind me applying the following portion of the
patch to the kernel tree?

thanks,

greg k-h
> --- linux-2.6.10-rc3-mm1-full/drivers/usb/storage/unusual_devs.h.old	2004-12-23 03:09:42.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/drivers/usb/storage/unusual_devs.h	2004-12-23 03:09:53.000000000 +0100
> @@ -549,13 +549,11 @@
>  		US_SC_SCSI, US_PR_CB, NULL,
>  		US_FL_SINGLE_LUN ),
>  
> -#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
>  UNUSUAL_DEV(  0x0781, 0x0002, 0x0009, 0x0009, 
>  		"Sandisk",
>  		"ImageMate SDDR-31",
>  		US_SC_DEVICE, US_PR_DEVICE, NULL,
>  		US_FL_IGNORE_SER ),
> -#endif
>  
>  UNUSUAL_DEV(  0x0781, 0x0100, 0x0100, 0x0100,
>  		"Sandisk",
> --- linux-2.6.10-rc3-mm1-full/drivers/usb/storage/usb.c.old	2004-12-23 03:10:00.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/drivers/usb/storage/usb.c	2004-12-23 03:10:13.000000000 +0100
> @@ -144,9 +144,7 @@
>  	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_QIC, US_PR_BULK) },
>  	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_UFI, US_PR_BULK) },
>  	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8070, US_PR_BULK) },
> -#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
>  	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK) },
> -#endif
>  
>  	/* Terminating entry */
>  	{ }
> @@ -220,10 +218,8 @@
>  	  .useTransport = US_PR_BULK},
>  	{ .useProtocol = US_SC_8070,
>  	  .useTransport = US_PR_BULK},
> -#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
>  	{ .useProtocol = US_SC_SCSI,
>  	  .useTransport = US_PR_BULK},
> -#endif
>  
>  	/* Terminating entry */
>  	{ NULL }

-- 
