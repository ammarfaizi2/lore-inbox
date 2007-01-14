Return-Path: <linux-kernel-owner+w=401wt.eu-S1751310AbXANP1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbXANP1W (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 10:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbXANP1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 10:27:22 -0500
Received: from emerald.lightlink.com ([205.232.34.14]:4253 "EHLO
	emerald.lightlink.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbXANP1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 10:27:21 -0500
Date: Sun, 14 Jan 2007 10:22:49 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jean Delvare <khali@linux-fr.org>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] remove quirk_sis_96x_compatible()
Message-ID: <20070114152249.GB2910@jupiter.solarsys.private>
References: <20061219041315.GE6993@stusta.de> <20070105095233.4ce72e7e.khali@linux-fr.org> <20070105232913.GU20714@stusta.de> <20070107123013.097c1f23.khali@linux-fr.org> <20070107154049.GA22558@jupiter.solarsys.private> <20070114134632.GX7469@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114134632.GX7469@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian:

> On Sun, Jan 07, 2007 at 10:40:49AM -0500, Mark M. Hoffman wrote:
> > It's just cruft from the original quirk.  The "compatible" printk could have
> > had value as a diagnostic in case the new quirk didn't work for some reason,
> > but I never saw any complaints about it (apart from the link order problem,
> > which is something different.)  It's safe to remove by now.

* Adrian Bunk <bunk@stusta.de> [2007-01-14 14:46:32 +0100]:
> Below is a patch to remove it.
> 
> Since 2.6.0-test10, all quirk_sis_96x_compatible() had any effect on
> was a printk().
> 
> This patch therefore removes it.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Mark M. Hoffman <mhoffman@lightlink.com>

> ---
> 
>  drivers/pci/quirks.c |   15 ---------------
>  1 file changed, 15 deletions(-)
> 
> --- linux-2.6.20-rc4-mm1/drivers/pci/quirks.c.old	2007-01-14 09:58:01.000000000 +0100
> +++ linux-2.6.20-rc4-mm1/drivers/pci/quirks.c	2007-01-14 09:58:37.000000000 +0100
> @@ -1141,8 +1141,6 @@
>   *
>   * We can also enable the sis96x bit in the discovery register..
>   */
> -static int __devinitdata sis_96x_compatible = 0;
> -
>  #define SIS_DETECT_REGISTER 0x40
>  
>  static void quirk_sis_503(struct pci_dev *dev)
> @@ -1158,9 +1156,6 @@
>  		return;
>  	}
>  
> -	/* Make people aware that we changed the config.. */
> -	printk(KERN_WARNING "Uncovering SIS%x that hid as a SIS503 (compatible=%d)\n", devid, sis_96x_compatible);
> -
>  	/*
>  	 * Ok, it now shows up as a 96x.. run the 96x quirk by
>  	 * hand in case it has already been processed.
> @@ -1172,16 +1167,6 @@
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
>  
> -static void __init quirk_sis_96x_compatible(struct pci_dev *dev)
> -{
> -	sis_96x_compatible = 1;
> -}
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_645,		quirk_sis_96x_compatible );
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_646,		quirk_sis_96x_compatible );
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_648,		quirk_sis_96x_compatible );
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_650,		quirk_sis_96x_compatible );
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_651,		quirk_sis_96x_compatible );
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_735,		quirk_sis_96x_compatible );
>  
>  /*
>   * On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller

-- 
Mark M. Hoffman
mhoffman@lightlink.com

