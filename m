Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbWHJH4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbWHJH4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 03:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWHJH4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 03:56:04 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:9477 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1161070AbWHJH4B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 03:56:01 -0400
Date: Thu, 10 Aug 2006 09:56:03 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Komal Shah" <komal_shah802003@yahoo.com>
Cc: tony@atomide.com, David Brownell <david-b@pacbell.net>, r-woodruff2@ti.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, i2c@lm-sensors.org
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #4
Message-Id: <20060810095603.b63b7aa1.khali@linux-fr.org>
In-Reply-To: <1155119476.12635.267974079@webmail.messagingengine.com>
References: <1155119476.12635.267974079@webmail.messagingengine.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Komal,

This one ended up in my spam box once again, although with a lower
score (using the proper type for the attachement seems to have helped.)
Maybe try with a shorter list of recipients next time, and add the name
of people before their address.

> Attached the updated patch as per the review comments on #3 patch.
> 
> Please consider it for the inclusion.

Looks good, I'll take it. One remaining objection:

> +static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
> +{
> +	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
> +		dev->iclk = clk_get(dev->dev, "i2c_ick");
> +		if (IS_ERR(dev->iclk)) {
> +			dev->iclk = NULL;
> +			return -ENODEV;
> +		}
> +	}
> +
> +	dev->fclk = clk_get(dev->dev, "i2c_fck");
> +	if (IS_ERR(dev->fclk)) {
> +		if (dev->iclk != NULL) {
> +			clk_put(dev->iclk);
> +			dev->iclk = NULL;
> +			return -ENODEV;

I think this return shouldn't be there.

> +		}
> +		dev->fclk = NULL;
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

I'll fix it myself if you agree, so that you don't have to resend a
patch. Thanks for the good work! I'll send the patch upstream at the
end of the week, so it should show in -mm soon.

-- 
Jean Delvare
