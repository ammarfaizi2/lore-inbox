Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbSLSKrg>; Thu, 19 Dec 2002 05:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267649AbSLSKrf>; Thu, 19 Dec 2002 05:47:35 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:10762 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267647AbSLSKrY>; Thu, 19 Dec 2002 05:47:24 -0500
Date: Thu, 19 Dec 2002 10:55:30 +0000
To: lvm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] [PATCH] add kobject to struct mapped_device
Message-ID: <20021219105530.GA2003@reti>
References: <20021218184307.GA32190@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218184307.GA32190@kroah.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

This looks like patch 1 of many, since it doesn't actually export any
attributes through sysfs yet.  Can you please give me more of an idea
of what the attributes are that you want to export ?  Are you trying
to move the dmfs functionality into sysfs ?

I won't accept this patch on it's own, but am sure what you are trying
to do is the right thing, so will probably have no objections when the
rest of the patches arrive.

On Wed, Dec 18, 2002 at 10:43:07AM -0800, Greg KH wrote:
> Oh, and why isn't struct mapped_device declared in dm.h?  If it was,
> dm_get and dm_put could be inlined, along with a few other potential
> cleanups.

I'm try to keep implementation details out of header files.  dm_get()
and dm_put() are not performance critical so I see no need to inline them.



> diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
> --- a/drivers/block/genhd.c	Wed Dec 18 10:39:48 2002
> +++ b/drivers/block/genhd.c	Wed Dec 18 10:39:48 2002
> @@ -475,3 +475,4 @@
>  EXPORT_SYMBOL(bdev_read_only);
>  EXPORT_SYMBOL(set_device_ro);
>  EXPORT_SYMBOL(set_disk_ro);
> +EXPORT_SYMBOL(block_subsys);


> diff -Nru a/drivers/md/dm.c b/drivers/md/dm.c
> --- a/drivers/md/dm.c	Wed Dec 18 10:39:48 2002
> +++ b/drivers/md/dm.c	Wed Dec 18 10:39:48 2002

   ...

> +
> +extern struct subsystem block_subsys;
> +

Please declare this in a suitable header like genhd.h rather than in
dm.c.  The above two snippets should then be pushed seperately from
the dm patches.

- Joe
