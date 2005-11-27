Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVK0Edf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVK0Edf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 23:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVK0Ede
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 23:33:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750861AbVK0Ede (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 23:33:34 -0500
Date: Sat, 26 Nov 2005 20:33:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reboot through the BIOS on newer HP laptops
Message-Id: <20051126203326.07b09394.akpm@osdl.org>
In-Reply-To: <20051124052107.GA28070@srcf.ucam.org>
References: <20051124052107.GA28070@srcf.ucam.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> Newer HP laptops (nc4200, nc6xxx, nc8xxx) hang on reboot with a standard 
> configuration. Passing reboot=b makes them work. This patch adds a DMI 
> quirk that defaults them to this mode, and doesn't appear to have any 
> adverse affects on older HPs.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> --- a/arch/i386/kernel/reboot.c.orig	2005-09-20 18:54:50.000000000 +0100
> +++ a/arch/i386/kernel/reboot.c	2005-09-20 18:58:11.000000000 +0100
> @@ -135,6 +135,14 @@
>  			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
>  		},
>  	},
> +	{       /* HP laptops have weird reboot issues */
> +	        .callback = set_bios_reboot,
> +		.ident = "HP Laptop",
> +		.matches = {
> +		        DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq"),
> +		},
> +	},
>  	{ }
>  };

This seems rather generic.  I recently added one entry:

	{	/* Handle problems with rebooting on HP nc6120 */
		.callback = set_bios_reboot,
		.ident = "HP Compaq nc6120",
		.matches = {
			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
			DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq nc6120"),
		},
	},

But your patch will do this for all HP laptops, will it not?  Worrisome. 
Is it not possible to identify particular models?
