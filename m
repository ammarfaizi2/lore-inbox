Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVBALVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVBALVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 06:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVBALVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 06:21:36 -0500
Received: from mx1.mail.ru ([194.67.23.121]:47188 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261996AbVBALUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 06:20:36 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH 2.6] I2C: New chip driver: sis5595
Date: Tue, 1 Feb 2005 14:20:17 +0200
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200502011420.17466.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005 11:11:35 +0100, Aurelien Jarno wrote:

> Please find below the new version of the patch against kernel
> 2.6.11-rc2-mm2 to add the sis5595 driver (sensor part).

> --- linux-2.6.11-rc2-mm2.orig/drivers/i2c/chips/sis5595.c
> +++ linux-2.6.11-rc2-mm2/drivers/i2c/chips/sis5595.c

> +struct sis5595_data {

> +	char valid;		/* !=0 if following fields are valid */

> +};

> +static struct sis5595_data *sis5595_update_device(struct device *dev)
> +{

> +	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
> +	    (jiffies < data->last_updated) || !data->valid) {

		[snip reading some values]

> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}

> +}

Maybe you should call sis5595_update_device() in initialization finction and
get rid of "value" field. It's sole purpose to fill "struct sis5595" when it's
known that "last_updated" field contains crap.

> +			dev_err(&s_bridge->dev, "sis5595.ko: Error: Looked for SIS5595 but found unsupported device %.4X\n", *i);

> +		dev_err(&s_bridge->dev, "sis5595.ko: base address not set - upgrade BIOS or use force_addr=0xaddr\n");

".ko" isn't needed. "Error: " in the first line too.

	Alexey
