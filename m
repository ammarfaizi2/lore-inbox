Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTJ1KsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 05:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTJ1KsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 05:48:09 -0500
Received: from ns.suse.de ([195.135.220.2]:58798 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263922AbTJ1KsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 05:48:06 -0500
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent PCI driver registration failure oopsing
References: <20031028100402.F22424@flint.arm.linux.org.uk>
From: Andreas Schwab <schwab@suse.de>
X-Yow: How many retired bricklayers from FLORIDA are out purchasing
 PENCIL SHARPENERS right NOW??
Date: Tue, 28 Oct 2003 11:48:05 +0100
In-Reply-To: <20031028100402.F22424@flint.arm.linux.org.uk> (Russell King's
 message of "Tue, 28 Oct 2003 10:04:02 +0000")
Message-ID: <jehe1tvdsq.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> --- orig/include/linux/pci.h	Thu Mar 13 14:24:56 2003
> +++ linux/include/linux/pci.h	Wed Mar 12 19:37:41 2003
> @@ -768,26 +768,7 @@
>  {
>  	int rc = pci_register_driver (drv);
>  
> -	if (rc > 0)
> -		return 0;
> -
> -	/* iff CONFIG_HOTPLUG and built into kernel, we should
> -	 * leave the driver around for future hotplug events.
> -	 * For the module case, a hotplug daemon of some sort
> -	 * should load a module in response to an insert event. */
> -#if defined(CONFIG_HOTPLUG) && !defined(MODULE)
> -	if (rc == 0)
> -		return 0;
> -#else
> -	if (rc == 0)
> -		rc = -ENODEV;		
> -#endif
> -
> -	/* if we get here, we need to clean up pci driver instance
> -	 * and return some sort of error */
> -	pci_unregister_driver (drv);
> -	
> -	return rc;
> +	return rc < 0 ? : 0;

Are you sure you want to return 1 if rc < 0?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
