Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUJLQgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUJLQgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUJLQgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:36:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:56779 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266127AbUJLQgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:36:11 -0400
Date: Tue, 12 Oct 2004 09:34:45 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch] 2.6.9-rc4-mm1: USB compile error with PROC_FS=n
Message-ID: <20041012163445.GA11150@kroah.com>
References: <20041011032502.299dc88d.akpm@osdl.org> <20041012142509.GB18579@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012142509.GB18579@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 04:25:09PM +0200, Adrian Bunk wrote:
> On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
> >...
> > All 741 patches
> >...
> > bk-usb.patch
> >...
> 
> 
> This removes an #ifdef CONFIG_PROC_FS from drivers/usb/core/inode.c 
> which is required, since now compilation fails with CONFIG_PROC_FS=n:
> 
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/usb/core/inode.o
> drivers/usb/core/inode.c: In function `usbfs_init':
> drivers/usb/core/inode.c:750: `proc_bus' undeclared (first use in this function)
> drivers/usb/core/inode.c:750: (Each undeclared identifier is reported only once
> drivers/usb/core/inode.c:750: for each function it appears in.)
> make[3]: *** [drivers/usb/core/inode.o] Error 1
> 
> <--  snip  -->
> 
> 
> The fix is simple:
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.9-rc4-mm1-full/drivers/usb/core/inode.c.old	2004-10-12 16:20:54.000000000 +0200
> +++ linux-2.6.9-rc4-mm1-full/drivers/usb/core/inode.c	2004-10-12 16:23:53.000000000 +0200
> @@ -746,8 +746,10 @@
>  		return retval;
>  	}
>  
> +#ifdef CONFIG_PROC_FS
>  	/* create mount point for usbfs */
>  	usbdir = proc_mkdir("usb", proc_bus);
> +#endif

No, the proper fix is to make the proc_fs.h header file give an empty
definition for proc_bus, so we don't have to have unneeded #ifdefs all
over the place.

thanks,

greg k-h
