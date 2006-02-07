Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWBGKh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWBGKh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 05:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWBGKh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 05:37:29 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41133 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964980AbWBGKh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 05:37:29 -0500
Date: Tue, 7 Feb 2006 11:37:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch] Generic AGP PM support.
Message-ID: <20060207103716.GA1705@elf.ucw.cz>
References: <200602070910.18808.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602070910.18808.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> diff -ruNp 3030-agp-resume-support.patch-old/drivers/char/agp/ati-agp.c 3030-agp-resume-support.patch-new/drivers/char/agp/ati-agp.c
> --- 3030-agp-resume-support.patch-old/drivers/char/agp/ati-agp.c	2005-11-11 14:12:17.000000000 +1100
> +++ 3030-agp-resume-support.patch-new/drivers/char/agp/ati-agp.c	2005-12-05 21:26:57.000000000 +1100
> @@ -9,6 +9,7 @@
>  #include <linux/agp_backend.h>
>  #include <asm/agp.h>
>  #include "agp.h"
> +#include "agp_suspend.h"
>  
>  #define ATI_GART_MMBASE_ADDR	0x14
>  #define ATI_RS100_APSIZE	0xac
> @@ -507,6 +508,17 @@ static void __devexit agp_ati_remove(str
>  	agp_put_bridge(bridge);
>  }
>  
> +static int agp_ati_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	return (agp_common_suspend(pdev, state));
> +}
> +
> +static int agp_ati_resume(struct pci_dev *pdev)
> +{
> +	return agp_common_resume(pdev, &ati_generic_bridge,
> +				 ati_configure);
> +}
> +
>  static struct pci_device_id agp_ati_pci_table[] = {
>  	{
>  	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
> @@ -526,6 +538,8 @@ static struct pci_driver agp_ati_pci_dri
>  	.id_table	= agp_ati_pci_table,
>  	.probe		= agp_ati_probe,
>  	.remove		= agp_ati_remove,
> +	.suspend	= agp_ati_suspend,

Why not = agp_common_suspend here ?
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
