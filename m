Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130747AbQK2Rfz>; Wed, 29 Nov 2000 12:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131358AbQK2Rfp>; Wed, 29 Nov 2000 12:35:45 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:39953
        "EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
        id <S130747AbQK2Rf3>; Wed, 29 Nov 2000 12:35:29 -0500
Date: Wed, 29 Nov 2000 12:15:45 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test12-pre2
Message-ID: <20001129121545.A4583@animx.eu.org>
In-Reply-To: <Pine.LNX.4.10.10011271838080.15454-100000@penguin.transmeta.com> <20001128213003.A3720@animx.eu.org> <20001129121504.A1794@jurassic.park.msu.ru> <20001129072631.A4193@animx.eu.org> <20001129165011.A2205@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20001129165011.A2205@jurassic.park.msu.ru>; from Ivan Kokshaysky on Wed, Nov 29, 2000 at 04:50:11PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ok, I won't have time this morning to try it, but I'll try it when I get off
> > work
> 
> Ok. If that patch won't help, here is another one - setting
> cacheline/latency also might cause a trouble.

the patch helped, but it ooped after finding the last scsi drive (the
cdrom).  I'll try removing the cdrom from the system as I've had problems
with it in the past. (might want to post your prior patch to the list)

> > I have no idea what 00:07.0 is.
> 
> PCI to ISA bridge.

It does have 2 eisa slots.

> --- linux/drivers/pci/setup-res.c.orig	Tue Nov 28 14:27:54 2000
> +++ linux/drivers/pci/setup-res.c	Wed Nov 29 16:01:13 2000
> @@ -208,11 +208,11 @@ pdev_enable_device(struct pci_dev *dev)
>  	/* ??? Always turn on bus mastering.  If the device doesn't support
>  	   it, the bit will go into the bucket. */
>  	cmd |= PCI_COMMAND_MASTER;
> -
> +#if 0
>  	/* Set the cache line and default latency (32).  */
>  	pci_write_config_word(dev, PCI_CACHE_LINE_SIZE,
>  			(32 << 8) | (L1_CACHE_BYTES / sizeof(u32)));
> -
> +#endif
>  	/* Enable the appropriate bits in the PCI command register.  */
>  	pci_write_config_word(dev, PCI_COMMAND, cmd);

I'll try this once I get back on the system.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
