Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVJFXe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVJFXe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVJFXe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:34:27 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:24407 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932075AbVJFXe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:34:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=FFGxI48IgL4hhIwrWuQThaEa8bp5JOvLU+DtotPs53VlVkFGTg//GX4ZRaWm3UeneadVcb7KaIf10/Xp3mIYIs7++yBWDhOSyC7da1yyoGWO/RkVRhesp53xN6mMoHrU5QwhNFeVpDk6yzpIUX4/Q0S7LCjjQBKplwTYR+93AdY=
Date: Fri, 7 Oct 2005 03:45:50 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Sebastien.Bouchard@ca.kontron.com, mark.gross@intel.com
Subject: Re: Fwd: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Message-ID: <20051006234550.GF2370@mipter.zuzino.mipt.ru>
References: <200510060803.21470.mgross@linux.intel.com> <20051006182022.GA14414@kroah.com> <200510061554.35039.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510061554.35039.mgross@linux.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached is an update that I think addresses your other comments.

> +config TELCLOCK
> +	tristate "Telecom clock driver for ATCA"
> +	depends on EXPERIMENTAL
> +	default n
> +	help
> +	  The telecom clock device allows direct userspace access to the
> +	  configuration of the telecom clock configuration settings.
> +	  This device is used for hardware synchronization across the ATCA
> +	  backplane fabric.

People usually tell here how the module will be called. See plenty
examples around.

> --- linux-2.6.14-rc2-mm2/drivers/char/tlclk.c
> +++ linux-2.6.14-rc2-mm2-tlclk/drivers/char/tlclk.c
> +Uppon loading the driver will create a sysfs directory under class/misc/tlclk.

Upon.

> +static int __init tlclk_init(void)
> +{

Missing unregister_chrdev() on error unrolling.

> +		printk(KERN_ERR" misc_register retruns %d\n", ret);

returns.

> +	return 0;
> +out3:
> +	release_region(TLCLK_BASE, 8);
> +out2:
> +	kfree(alarm_events);
> +out1:
> +	return ret;
> +}

