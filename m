Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbUKVWjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUKVWjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbUKVWg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:36:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:9725 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261163AbUKVWeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:34:44 -0500
Date: Mon, 22 Nov 2004 14:34:32 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][RFC/v1][8/12] Add IPoIB (IP-over-InfiniBand) driver
Message-ID: <20041122223432.GC15634@kroah.com>
References: <20041122713.FnSlYodJYum7s82D@topspin.com> <20041122714.nKCPmH9LMhT0X7WE@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122714.nKCPmH9LMhT0X7WE@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 07:14:04AM -0800, Roland Dreier wrote:
> 
> +#define ipoib_printk(level, priv, format, arg...)	\
> +	printk(level "%s: " format, ((struct ipoib_dev_priv *) priv)->dev->name , ## arg)
> +#define ipoib_warn(priv, format, arg...)		\
> +	ipoib_printk(KERN_WARNING, priv, format , ## arg)

What's wrong with using the dev_printk() and friends instead of your
own?

And why cast a pointer in a macro, don't you know the type of it anyway?

> Index: linux-bk/drivers/infiniband/ulp/ipoib/ipoib_fs.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-bk/drivers/infiniband/ulp/ipoib/ipoib_fs.c	2004-11-21 21:25:56.924755902 -0800

You're using a separate filesystem to export debug data?  I'm all for
new virtual filesystems, but why not just use sysfs for this?  What are
you doing in here that you can't do with another mechanism (netlink,
sysfs, sockets, relayfs, etc.)?

> +#ifdef CONFIG_INFINIBAND_IPOIB_DEBUG_DATA
> +#define DATA_PATH_DEBUG_HELP " and data path tracing if > 1"
> +#else
> +#define DATA_PATH_DEBUG_HELP ""
> +#endif
> +
> +module_param(debug_level, int, 0644);
> +MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0" DATA_PATH_DEBUG_HELP);

Why not just use 2 different debug variables for this?

> +
> +int mcast_debug_level;

Global?

thanks,

greg k-h
