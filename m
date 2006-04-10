Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWDJTLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWDJTLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 15:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWDJTLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 15:11:25 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:40315 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932107AbWDJTLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 15:11:25 -0400
From: David Brownell <david-b@pacbell.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [linux-usb-devel] compile error when building multiple EHCI host controllers as modules
Date: Mon, 10 Apr 2006 12:11:23 -0700
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       LKML mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0604051231030.17147-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0604051231030.17147-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604101211.23871.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +#ifdef CONFIG_PPC_83xx
> +	retval = platform_driver_register(&ehci_fsl_dr_driver);
> +	if (retval < 0)
> +		return retval;
> +
> +	retval = platform_driver_register(&ehci_fsl_dr_driver);
> +	if (retval < 0)
> +		return retval;
> +#endif
> +
> +#ifdef CONFIG_SOC_AU1X00
> +	pr_debug(DRIVER_INFO " (Au1xxx)\n");
> +
> +	retval = driver_register(&ehci_hcd_au1xxx_driver);
> +	if (retval < 0)
> +		return retval;
> +#endif

Can we just get away from all of that extra #ifdeffery?  

This is essentially the same patch you sent the first time.
With the same bugs ... like, not cleaning up the first driver
after errors registering the second one.

