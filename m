Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLFXlk>; Wed, 6 Dec 2000 18:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbQLFXla>; Wed, 6 Dec 2000 18:41:30 -0500
Received: from nat-su-33.valinux.com ([198.186.202.33]:27792 "EHLO
	phenoxide.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S129406AbQLFXlR>; Wed, 6 Dec 2000 18:41:17 -0500
Date: Wed, 6 Dec 2000 15:10:06 -0800
From: Johannes Erdfelt <jerdfelt@valinux.com>
To: Miles Lane <miles@megapathdsl.net>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, usb@in.tum.de
Subject: Re: test12-pre6
Message-ID: <20001206151006.S1318@valinux.com>
In-Reply-To: <20001206200803.C847@arthur.ubicom.tudelft.nl> <Pine.LNX.4.10.10012061131320.1873-100000@penguin.transmeta.com> <20001206210928.G847@arthur.ubicom.tudelft.nl> <3A2EAA62.1DB6FCCC@mandrakesoft.com> <3A2EC472.40900@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A2EC472.40900@megapathdsl.net>; from miles@megapathdsl.net on Wed, Dec 06, 2000 at 02:57:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000, Miles Lane <miles@megapathdsl.net> wrote:
> Hmm.  Your patch doesn't test whether pci_enable_device(dev)
> was successful, does it?

Umm, it does. If pci_enable_device wasn't successful, it returns -ENODEV.

Your patch below calls pci_set_master if enabling the device fails and
then ignores the device.

Is that what you meant?

JE

> I think what you want is:
> 
> diff -u --new-file drivers/usb/uhci.c~ drivers/usb/uhci.c
> --- drivers/usb/uhci.c~	Tue Dec  5 23:55:38 2000
> +++ drivers/usb/uhci.c	Wed Dec  6 14:50:00 2000
> @@ -2380,8 +2380,10 @@
>   	/* disable legacy emulation */
>   	pci_write_config_word(dev, USBLEGSUP, 0);
> 
> - 
> if (pci_enable_device(dev) < 0)
> + 
> if (pci_enable_device(dev) < 0) {
> + 
>          pci_set_master(dev);
>   		return -ENODEV;
> + 
> }
> 
>   	if (!dev->irq) {
>   		err("found UHCI device with no IRQ assigned. check BIOS settings!");
> diff -u --new-file drivers/usb/usb-uhci.c~ drivers/usb/usb-uhci.c
> --- drivers/usb/usb-uhci.c~	Tue Dec  5 23:55:38 2000
> +++ drivers/usb/usb-uhci.c	Wed Dec  6 14:50:09 2000
> @@ -2939,8 +2939,10 @@
>   {
>   	int i;
> 
> - 
> if (pci_enable_device(dev) < 0)
> + 
> if (pci_enable_device(dev) < 0) {
> + 
>          pci_set_master(dev);
>   		return -ENODEV;
> + 
> }
>   	
>   	/* Search for the IO base address.. */
>   	for (i = 0; i < 6; i++) {
> diff -u --new-file drivers/usb/usb-ohci.c# drivers/usb/usb-ohci.c
> --- drivers/usb/usb-ohci.c#	Wed Dec  6 14:56:12 2000
> +++ drivers/usb/usb-ohci.c	Wed Dec  6 14:49:34 2000
> @@ -2320,8 +2320,10 @@
>   	unsigned long mem_resource, mem_len;
>   	void *mem_base;
> 
> - 
> if (pci_enable_device(dev) < 0)
> + 
> if (pci_enable_device(dev) < 0) {
> + 
>          pci_set_master(dev);
>   		return -ENODEV;
> + 
> }
>   	
>   	/* we read its hardware registers as memory */
>   	mem_resource = pci_resource_start(dev, 0);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
