Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbUASWc5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUASWc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:32:57 -0500
Received: from mail.kroah.org ([65.200.24.183]:1670 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263771AbUASWcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:32:53 -0500
Date: Mon, 19 Jan 2004 14:32:30 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, anton@samba.org
Subject: Re: [PATCH] ppc64: VIO support, from Dave Boutcher, Hollis Blanchard and Santiago Leon
Message-ID: <20040119223230.GA4885@kroah.com>
References: <200401192200.i0JM0dtb006058@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401192200.i0JM0dtb006058@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 06:21:43PM +0000, Linux Kernel Mailing List wrote:
> +static inline int vio_module_init(struct vio_driver *drv)
> +{
> +        int rc = vio_register_driver (drv);
> +
> +        if (rc > 0)
> +                return 0;
> +
> +        /* iff CONFIG_HOTPLUG and built into kernel, we should
> +         * leave the driver around for future hotplug events.
> +         * For the module case, a hotplug daemon of some sort
> +         * should load a module in response to an insert event. */
> +#if defined(CONFIG_HOTPLUG) && !defined(MODULE)
> +        if (rc == 0)
> +                return 0;
> +#else
> +        if (rc == 0)
> +                rc = -ENODEV;
> +#endif
> +
> +        /* if we get here, we need to clean up vio driver instance
> +         * and return some sort of error */
> +
> +        return rc;
> +}
> +
> +#endif /* _PHYP_H */

Ick ick ick.  I thought you all were not going to add this function, but
just use vio_register_driver() on it's own?  Loading a driver should not
depend on CONFIG_HOTPLUG, as we now have different ways we can bind
drivers to devices after they are loaded (see the new_id stuff for pci
devices as an example.)

In fact I have a patch in my queue to clean this logic up for PCI
drivers from rmk that I need to apply soon...

thanks,

greg k-h
