Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWFHIvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWFHIvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWFHIvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:51:43 -0400
Received: from tim.rpsys.net ([194.106.48.114]:28388 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964803AbWFHIvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:51:42 -0400
Subject: Re: [PATCH] limit power budget on spitz
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: David Brownell <david-b@pacbell.net>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, patches@arm.linux.org.uk,
       linux-usb-devel@lists.sourceforge.net,
       Oliver Neukum <oliver@neukum.org>,
       David Liontooth <liontooth@cogweb.net>
In-Reply-To: <20060608083412.GJ3688@elf.ucw.cz>
References: <447EB0DC.4040203@cogweb.net> <20060530200134.GB4074@ucw.cz>
	 <200606031129.54580.oliver@neukum.org>
	 <200606050732.53496.david-b@pacbell.net> <20060608083412.GJ3688@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 09:50:58 +0100
Message-Id: <1149756659.16945.149.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 10:34 +0200, Pavel Machek wrote:
> diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
> index acde886..1d8b58c 100644
> --- a/drivers/usb/host/ohci-pxa27x.c
> +++ b/drivers/usb/host/ohci-pxa27x.c
> @@ -185,6 +185,13 @@ int usb_hcd_pxa27x_probe (const struct h
>  	/* Select Power Management Mode */
>  	pxa27x_ohci_select_pmm(inf->port_mode);
>  
> +	if (machine_is_spitz()) {
> +		/* Warning, not coming from any official docs. But
> +		 * spitz is unable to properly power wireless card
> +		 * claiming 500mA -- usb interface work but wireless
> +		 * does not. */
> +		hcd->power_budget = 250;
> +	}
>  	ohci_hcd_init(hcd_to_ohci(hcd));
>  
>  	retval = usb_add_hcd(hcd, pdev->resource[1].start, SA_INTERRUPT);

Should this value not be specified by the platform in the platform data
rather than a set of machine_is_xxx statements in the driver itself? I
already put most of the infrastructure for that into place.

I also strongly suspect the power supply on the device is limited to
150mA.

Richard

