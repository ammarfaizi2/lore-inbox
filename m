Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUJLQiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUJLQiY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUJLQiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:38:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:59596 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266143AbUJLQiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:38:21 -0400
Date: Tue, 12 Oct 2004 09:36:57 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch] 2.6.9-rc4-mm1: USB compile error with PROC_FS=n
Message-ID: <20041012163657.GB11150@kroah.com>
References: <20041011032502.299dc88d.akpm@osdl.org> <20041012142509.GB18579@stusta.de> <20041012163445.GA11150@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012163445.GA11150@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 09:34:45AM -0700, Greg KH wrote:
> > The fix is simple:
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.9-rc4-mm1-full/drivers/usb/core/inode.c.old	2004-10-12 16:20:54.000000000 +0200
> > +++ linux-2.6.9-rc4-mm1-full/drivers/usb/core/inode.c	2004-10-12 16:23:53.000000000 +0200
> > @@ -746,8 +746,10 @@
> >  		return retval;
> >  	}
> >  
> > +#ifdef CONFIG_PROC_FS
> >  	/* create mount point for usbfs */
> >  	usbdir = proc_mkdir("usb", proc_bus);
> > +#endif
> 
> No, the proper fix is to make the proc_fs.h header file give an empty
> definition for proc_bus, so we don't have to have unneeded #ifdefs all
> over the place.

Something like this patch.  I'll add this to my trees.

thanks,

greg k-h

===== proc_fs.h 1.25 vs edited =====
--- 1.25/include/linux/proc_fs.h	2004-09-29 20:39:10 -07:00
+++ edited/proc_fs.h	2004-10-12 09:36:00 -07:00
@@ -193,6 +193,7 @@
 
 #define proc_root_driver NULL
 #define proc_net NULL
+#define proc_bus NULL
 
 #define proc_net_fops_create(name, mode, fops)  ({ (void)(mode), NULL; })
 #define proc_net_create(name, mode, info)	({ (void)(mode), NULL; })
