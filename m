Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVALIVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVALIVh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 03:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVALIVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 03:21:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:38099 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261262AbVALIV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 03:21:27 -0500
Date: Wed, 12 Jan 2005 00:17:22 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mundt <paul.mundt@nokia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SuperHyway bus support
Message-ID: <20050112081722.GA2745@kroah.com>
References: <20041027075248.GA26760@pointless.research.nokia.com> <20050107072222.GB24441@kroah.com> <20050107094103.GA7408@pointless.research.nokia.com> <20050107162945.GA19043@pointless.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107162945.GA19043@pointless.research.nokia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 06:29:45PM +0200, Paul Mundt wrote:
> On Fri, Jan 07, 2005 at 11:41:04AM +0200, Paul Mundt wrote:
> > > Also, why have a local list of devices and not just use the list the
> > > driver core provides for you?
> > > 
> > Probably because I wasn't aware that the driver core provided one. Now that I
> > see the bus_for_each_xxx() stuff I'll drop the list and use that instead.
> > 
> I dropped this entirely as the release() stuff did what I was looking for..
> 
> > Thanks for looking at this, I'll post a cleaned up version shortly.
> 
> Here it is against current BK.. let me know if you have any other issues.
> 
> Signed-off-by: Paul Mundt <paul.mundt@nokia.com>
> 
>  drivers/Makefile                         |    1 
>  drivers/sh/Makefile                      |    6 
>  drivers/sh/superhyway/Makefile           |    7 +
>  drivers/sh/superhyway/superhyway-sysfs.c |   47 +++++++
>  drivers/sh/superhyway/superhyway.c       |  205 +++++++++++++++++++++++++++++++

No Kconfig file to enable this option?

> +static struct device superhyway_bus_device = {
> +	.bus_id = "superhyway",
> +};

This device doesn't have a release function, as it's tied to the module.
Are you sure it's race free?  :)

> +static int __init superhyway_init(void)
> +{
> +	extern int superhyway_scan_bus(void);

This should go in a .h file somewhere.

> +EXPORT_SYMBOL(superhyway_bus_type);
> +EXPORT_SYMBOL(superhyway_add_device);
> +EXPORT_SYMBOL(superhyway_register_driver);
> +EXPORT_SYMBOL(superhyway_unregister_driver);

Did you forget a .h file with these function prototypes?

Other than that, looks a whole lot better, nice job.

greg k-h
