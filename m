Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUDUWl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUDUWl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 18:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUDUWl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 18:41:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:34989 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262648AbUDUWly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 18:41:54 -0400
Date: Wed, 21 Apr 2004 15:41:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: updated-fbmem-patch.patch
Message-ID: <20040421154153.O22989@build.pdx.osdl.net>
References: <20040421021008.GM29954@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040421021008.GM29954@dualathlon.random>; from andrea@suse.de on Wed, Apr 21, 2004 at 04:10:08AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm4/broken-out/updated-fbmem-patch.patch
> 
> this uses get_user for the set_cmap operation too.
> 
> --- 2.6.5-aa3/drivers/video/fbmem.c.~1~	2004-04-04 08:09:23.000000000 +0200
> +++ 2.6.5-aa3/drivers/video/fbmem.c	2004-04-21 03:11:05.878951424 +0200
> @@ -1034,11 +1034,11 @@ fb_ioctl(struct inode *inode, struct fil
>  	case FBIOPUTCMAP:
>  		if (copy_from_user(&cmap, (void *) arg, sizeof(cmap)))
>  			return -EFAULT;
> -		return (fb_set_cmap(&cmap, 0, info));
> +		return (fb_set_cmap(&cmap, 1, info));

0 is userspace, 1 is kernel space.  this change looks wrong.

Perhaps the change below so comment is in sync with code.

--- a/drivers/video/fbcmap.c	Fri Feb  6 00:30:15 2004
+++ b/drivers/video/fbcmap.c	Wed Apr 21 15:40:56 2004
@@ -207,7 +207,7 @@
 /**
  *	fb_set_cmap - set the colormap
  *	@cmap: frame buffer colormap structure
- *	@kspc: boolean, 0 copy local, 1 get_user() function
+ *	@kspc: boolean, 0 get_user() function , 1 copy local
  *	@info: frame buffer info structure
  *
  *	Sets the colormap @cmap for a screen of device @info.
