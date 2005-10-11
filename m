Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVJKALj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVJKALj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 20:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVJKALj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 20:11:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:64481 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751306AbVJKALi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 20:11:38 -0400
Date: Mon, 10 Oct 2005 17:10:56 -0700
From: Greg KH <greg@kroah.com>
To: linas <linas@austin.ibm.com>
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 20/22] PCI Error Recovery: e100 network device driver
Message-ID: <20051011001056.GA16634@kroah.com>
References: <20051006232032.GA29826@austin.ibm.com> <20051006235729.GU29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006235729.GU29826@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 06:57:29PM -0500, linas wrote:
> +config E100_EEH_RECOVERY
> +	bool "Enable PCI bus error recovery"
> +	depends on E100 && PPC_PSERIES
> +   help
> +      If you say Y here, the driver will be able to recover from
> +      PCI bus errors on many PowerPC platforms. IBM pSeries users
> +      should answer Y.

Why make a config option for this at all?  Who would turn it off?

> @@ -2661,6 +2731,9 @@
>  	.resume =       e100_resume,
>  #endif
>  	.shutdown =	e100_shutdown,
> +#ifdef CONFIG_E100_EEH_RECOVERY
> +	.err_handler = &e100_err_handler,
> +#endif /* CONFIG_E100_EEH_RECOVERY */

No, don't put #ifdefs in the middle of a structure, remember we made
err_handler always present in the .h file for a reason...

thanks,

greg k-h
