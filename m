Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVGFFyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVGFFyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVGFFxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:53:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:28804 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262121AbVGFEUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 00:20:12 -0400
Date: Tue, 5 Jul 2005 21:17:03 -0700
From: Greg KH <greg@kroah.com>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: Add Dell Systems Management Base driver
Message-ID: <20050706041702.GA10253@kroah.com>
References: <20050706001333.GA3569@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706001333.GA3569@sysman-doug.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 07:13:34PM -0500, Doug Warzecha wrote:
> This patch adds the Dell Systems Management Base driver.
> 
> The Dell Systems Management Base driver is a character driver that
> implements ioctls for Dell systems management software to use to
> communicate with the driver.  The driver provides support for Dell
> systems management software to manage the following Dell PowerEdge
> systems: 300, 1300, 1400, 400SC, 500SC, 1500SC, 1550, 600SC, 1600SC,
> 650, 1655MC, 700, and 750.
> 
> By making a contribution to this project, I certify that:
> The contribution was created in whole or in part by me and
> I have the right to submit it under the open source license
> indicated in the file.
> 
> Signed-off-by: Doug Warzecha <Douglas_Warzecha@dell.com>
> ---
> 
> diff -uprN linux-2.6.13-rc1.orig/drivers/char/dcdbas.c linux-2.6.13-rc1/drivers/char/dcdbas.c
> --- linux-2.6.13-rc1.orig/drivers/char/dcdbas.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.13-rc1/drivers/char/dcdbas.c	2005-07-05 10:26:22.355056432 -0500
> @@ -0,0 +1,777 @@
> +/*
> + *  dcdbas.c: Dell Systems Management Base Driver
> + *
> + *  Copyright (C) 1995-2005 Dell Inc.
> + *
> + *  The Dell Systems Management Base driver is a character driver that
> + *  implements ioctls for Dell systems management software to use to
> + *  communicate with the driver.  The driver provides support for Dell
> + *  systems management software to manage the following Dell PowerEdge
> + *  systems: 300, 1300, 1400, 400SC, 500SC, 1500SC, 1550, 600SC, 1600SC,
> + *  650, 1655MC, 700, and 750.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License v2.0 as published by
> + *  the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/ioctl.h>
> +#include <linux/kernel.h>
> +#include <linux/mc146818rtc.h>
> +#include <linux/module.h>
> +#include <linux/reboot.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/smp.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <asm/io.h>
> +#include <asm/semaphore.h>
> +#include <asm/uaccess.h>
> +
> +#include "dcdbas.h"
> +
> +#define DRIVER_NAME		"dcdbas"
> +#define DRIVER_VERSION		"5.6.0-1"
> +#define DRIVER_DESCRIPTION	"Systems Management Base Driver"
> +
> +static int driver_major;

Why do you need a whole major for this driver?  You have more than one
device in the system at a time?

> +/**
> + * dcdbas_device_release - device release method
> + * @dev: device
> + */

Don't document functions that do nothing, that's just busy work...

> +static void dcdbas_device_release(struct device *dev)
> +{
> +	/* nothing to release */
> +}

This is a symptom of a broken driver.

Hm, I wonder if there's some way for the compiler to check the fact that
a function pointer passed to another function, is really a null
function.  That would stop this kind of nonsense...

I'm sure I commented on this driver already, yet, I never got a response
and the code is not changed.  Is there some reason for this?  That's a
sure way to prevent your patch from ever being applied...

greg k-h
