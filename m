Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLSJaR>; Tue, 19 Dec 2000 04:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbQLSJaA>; Tue, 19 Dec 2000 04:30:00 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:18963 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S129289AbQLSJ3s>;
	Tue, 19 Dec 2000 04:29:48 -0500
Date: Tue, 19 Dec 2000 09:59:06 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Converting drivers/net/rcpci45.c to new PCI API
Message-ID: <20001219095906.A5764@se1.cogenit.fr>
In-Reply-To: <20001219004604.B761@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001219004604.B761@jaquet.dk>
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Andersen <rasmus@jaquet.dk> écrit :
[...]
> There are some other cleanups I want to do, and I need to make my indentation
> match the drivers, but that will be after the basic conversion is done.
> 
> 
> --- linux-240-t13-pre1-clean/drivers/net/rcpci45.c	Sat Nov  4 23:27:08 2000
> +++ linux/drivers/net/rcpci45.c	Thu Dec 14 21:41:17 2000
[...]
> @@ -155,71 +153,29 @@
>  static int RC_allocate_and_post_buffers(struct net_device *, int);
>  
>  
> -/* A list of all installed RC devices, for removing the driver module. */
> -static struct net_device *root_RCdev;
> +static struct pci_device_id rcpci45_pci_table[] __devinitdata = {
> +	{ RC_PCI45_VENDOR_ID, RC_PCI45_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, rcpci_pci_table);
>  
> -static int __init rcpci_init_module (void)
> +static void rcpci45_remove_one(struct pci_dev *pdev)
              ^->  __exit
[...]
> -	if (pci_enable_device(pdev))
> -		break;
> -	pci_set_master(pdev);
> +	unregister_netdev(dev);
> +	iounmap((void *)dev->base_addr);
> +        free_irq(dev->irq, dev);

I'd rather inhibit irq first then release the ressources.
+       free_irq(dev->irq, dev);
+	iounmap((void *)dev->base_addr);
+	unregister_netdev(dev);

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
