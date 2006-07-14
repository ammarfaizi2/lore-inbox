Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbWGNKq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWGNKq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 06:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWGNKq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 06:46:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:12676 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161047AbWGNKq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 06:46:27 -0400
Subject: Re: [2.6 patch] drivers/ide/: cleanups
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060711141637.GS13938@stusta.de>
References: <20060711141637.GS13938@stusta.de>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 20:43:26 +1000
Message-Id: <1152873806.23037.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 16:16 +0200, Adrian Bunk wrote:
> This patch contains the following clenups:
> - setup-pci.c: #if 0 the unused ide_pci_unregister_driver()
> - ide.c: remove the unused EXPORT_SYMBOL(ide_register_hw)

Unused ? The PowerMac media-bay code uses it. It's not yet module-able
but I haven't given up on it just yet :)

Ben.


> - ide-dma.c: remove the unused EXPORT_SYMBOL_GPL(ide_in_drive_list)
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 9 Jul 2006
> - 26 Jun 2006
> - 27 Apr 2006
> - 19 Apr 2006
> - 11 Apr 2006
> 
>  drivers/ide/ide-dma.c   |    2 --
>  drivers/ide/ide.c       |    2 --
>  drivers/ide/setup-pci.c |    4 +++-
>  include/linux/ide.h     |    1 -
>  4 files changed, 3 insertions(+), 6 deletions(-)
> 
> --- linux-2.6.17-rc1-mm2-full/include/linux/ide.h.old	2006-04-10 22:46:27.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/include/linux/ide.h	2006-04-10 22:46:36.000000000 +0200
> @@ -1188,7 +1188,6 @@
>  extern void ide_scan_pcibus(int scan_direction) __init;
>  extern int __ide_pci_register_driver(struct pci_driver *driver, struct module *owner);
>  #define ide_pci_register_driver(d) __ide_pci_register_driver(d, THIS_MODULE)
> -extern void ide_pci_unregister_driver(struct pci_driver *driver);
>  void ide_pci_setup_ports(struct pci_dev *, struct ide_pci_device_s *, int, ata_index_t *);
>  extern void ide_setup_pci_noise (struct pci_dev *dev, struct ide_pci_device_s *d);
>  
> --- linux-2.6.17-rc1-mm2-full/drivers/ide/ide.c.old	2006-04-10 22:43:31.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/drivers/ide/ide.c	2006-04-10 22:43:41.000000000 +0200
> @@ -826,8 +826,6 @@
>  	return ide_register_hw_with_fixup(hw, hwifp, NULL);
>  }
>  
> -EXPORT_SYMBOL(ide_register_hw);
> -
>  /*
>   *	Locks for IDE setting functionality
>   */
> --- linux-2.6.17-rc1-mm2-full/drivers/ide/ide-dma.c.old	2006-04-10 22:44:21.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/drivers/ide/ide-dma.c	2006-04-10 22:44:28.000000000 +0200
> @@ -152,8 +152,6 @@
>  	return 0;
>  }
>  
> -EXPORT_SYMBOL_GPL(ide_in_drive_list);
> -
>  /**
>   *	ide_dma_intr	-	IDE DMA interrupt handler
>   *	@drive: the drive the interrupt is for
> --- linux-2.6.17-rc1-mm2-full/drivers/ide/setup-pci.c.old	2006-04-10 22:46:46.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/drivers/ide/setup-pci.c	2006-04-10 22:47:03.000000000 +0200
> @@ -807,7 +807,8 @@
>   *	Unregister a currently installed IDE driver. Returns are the same
>   *	as for pci_unregister_driver
>   */
> - 
> +
> +#if 0
>  void ide_pci_unregister_driver(struct pci_driver *driver)
>  {
>  	if(!pre_init)
> @@ -817,6 +818,7 @@
>  }
>  
>  EXPORT_SYMBOL_GPL(ide_pci_unregister_driver);
> +#endif  /*  0  */
>  
>  /**
>   *	ide_scan_pcidev		-	find an IDE driver for a device
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

