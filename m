Return-Path: <linux-kernel-owner+w=401wt.eu-S932497AbXAQPhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbXAQPhe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 10:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbXAQPh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 10:37:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1924 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932491AbXAQPg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 10:36:58 -0500
Date: Mon, 15 Jan 2007 13:18:06 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 19/20] XEN-paravirt: Add the Xenbus sysfs and virtual device hotplug driver.
Message-ID: <20070115131806.GC4272@ucw.cz>
References: <20070113014539.408244126@goop.org> <20070113014649.154623814@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070113014649.154623814@goop.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This communicates with the machine control software via a registry
> residing in a controlling virtual machine. This allows dynamic
> creation, destruction and modification of virtual device
> configurations (network devices, block devices and CPUS, to name some
> examples).
> 
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  drivers/xen/Makefile               |    1
>  drivers/xen/xenbus/Makefile        |    7
>  drivers/xen/xenbus/xenbus_client.c |  528 ++++++++++++++++++++
>  drivers/xen/xenbus/xenbus_comms.c  |  222 ++++++++
>  drivers/xen/xenbus/xenbus_comms.h  |   43 +
>  drivers/xen/xenbus/xenbus_probe.c  |  954 +++++++++++++++++++++++++++++++++++++
>  drivers/xen/xenbus/xenbus_xs.c     |  828 ++++++++++++++++++++++++++++++++

Hmm, you have word 'xen' three times in this pathname, and then the
file is name 'xs'. Trying to do xen advertising in path names? :-)

> @@ -0,0 +1,565 @@
> +/******************************************************************************
> + * Client-facing interface for the Xenbus driver.  In other words, the
> + * interface between the Xenbus and the device-specific code, be it the
> + * frontend or the backend of that driver.
> + *
> + * Copyright (C) 2005 XenSource Ltd
> + * 
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation; or, when distributed
> + * separately from the Linux kernel or incorporated into other
> + * software packages, subject to the following license:
> + * 
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this source file (the "Software"), to deal in the Software without
> + * restriction, including without limitation the rights to use, copy, modify,
> + * merge, publish, distribute, sublicense, and/or sell copies of the Software,
> + * and to permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + * 
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.

So this is dual BSD/GPL?

> +#include <linux/types.h>
> +#include <xen/interface/xen.h>
> +#include <xen/interface/event_channel.h>
> +#include "../../../arch/i386/paravirt-xen/events.h"
> +#include <xen/grant_table.h>
> +#include <xen/xenbus.h>
> +#include <xen/driver_util.h>
> +
> +char *xenbus_strstate(enum xenbus_state state)
> +{
> +	static char *name[] = {
> +		[ XenbusStateUnknown      ] = "Unknown",

Constants are normally XENBUS_STATE_UNKNOWN in linux...

Can we get description of its kernel-user interface in Documentation/
somewhere?


> +#include <asm/io.h>
> +#include <asm/page.h>
> +//#include <asm/maddr.h>
> +#include <asm/pgtable.h>
> +#include <asm/hypervisor.h>
> +#include <xen/xenbus.h>
> +//#include <xen/xen_proc.h>
> +//#include <xen/evtchn.h>
> +#include <xen/features.h>
> +//#include <xen/hvm.h>
> +

Just delete the lines.

> +#ifdef HAVE_XEN_PLATFORM_COMPAT_H
> +#include <xen/platform-compat.h>
> +#endif

Is this really neccessary?

> +	.bus = {
> +		.name     = "xen-backend",
> +		.match    = xenbus_match,
> +		.probe    = xenbus_dev_probe,
> +		.remove   = xenbus_dev_remove,
> +//		.shutdown = xenbus_dev_shutdown,

Delete.

> --- /dev/null
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -0,0 +1,840 @@
> +/******************************************************************************
> + * xenbus_xs.c
> + *
> + * This is the kernel equivalent of the "xs" library.  We don't need everything
> + * and we use xenbus_comms for communication.

One line explanation what xs is would be nice.

						Pavel
-- 
Thanks for all the (sleeping) penguins.
