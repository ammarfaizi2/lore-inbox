Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267386AbTALSZu>; Sun, 12 Jan 2003 13:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbTALSZu>; Sun, 12 Jan 2003 13:25:50 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:30219 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267386AbTALSZt>; Sun, 12 Jan 2003 13:25:49 -0500
Date: Sun, 12 Jan 2003 18:34:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: GertJan Spoelman <kl@gjs.cc>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] via686a sensors support
Message-ID: <20030112183438.A13025@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	GertJan Spoelman <kl@gjs.cc>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200301121925.14095.kl@gjs.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301121925.14095.kl@gjs.cc>; from kl@gjs.cc on Sun, Jan 12, 2003 at 07:25:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -16,7 +16,7 @@
>  	  while the kernel is running.  If you want to compile it as a module,
>  	  say M here and read <file:Documentation/modules.txt>.
> 
> -	  The module will be called i2c-amd756.o.
> +	  The module will be called i2c-amd756.ko.

Please don't submit unrelated changes in this patch.  While I agree with
this documentation fix it's clearly a separate issue.

> +#include <linux/version.h>

you don't need this header.

> +#ifndef PCI_DEVICE_ID_VIA_82C686_4
> +#define PCI_DEVICE_ID_VIA_82C686_4 0x3057
> +#endif

This one should be in include/linux/pci_ids.h

> +extern inline long IN_FROM_REG(u8 val, int inNum)

All these extern inlines should be static inline instead.

> +static int via686a_find(int *address)
> +{
> +	u16 val;
> +
> +	if (!pci_present())
> +		return -ENODEV;
> +
> +	if (!(s_bridge = pci_find_device(PCI_VENDOR_ID_VIA,
> +					 PCI_DEVICE_ID_VIA_82C686_4,
> +					 NULL)))
> +		return -ENODEV;

I think this should converted to a 2.4/2.5-style PCI driver.  See the
amd drivers.

> +/* No commands defined yet */
> +static int via686a_command(struct i2c_client *client, unsigned int cmd, void *arg)
> +{
> +	return 0;
> +}

->command is optional, so there's no need to have this stub.

> +
> +	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
> +	    (jiffies < data->last_updated) || !data->valid) {

Use time_after here?

