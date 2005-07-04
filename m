Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVGDHjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVGDHjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 03:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVGDHgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 03:36:48 -0400
Received: from mailfe10.tele2.se ([212.247.155.33]:35783 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261268AbVGDH2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 03:28:37 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: If ACPI doesn't find an irq listed, don't accept 0 as a valid
	PCI irq.
From: Alexander Nyberg <alexn@telia.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: stable@kernel.org, torvalds@osdl.org
In-Reply-To: <200507021908.j62J8m4D009707@hera.kernel.org>
References: <200507021908.j62J8m4D009707@hera.kernel.org>
Content-Type: text/plain
Date: Mon, 04 Jul 2005 09:28:35 +0200
Message-Id: <1120462115.1172.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> tree e6a38b3d6bf434f08054562113bb660c4227769f
> parent 4a89a04f1ee21a7c1f4413f1ad7dcfac50ff9b63
> author Linus Torvalds <torvalds@g5.osdl.org> Sun, 03 Jul 2005 00:35:33 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 03 Jul 2005 00:35:33 -0700
> 
> If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.
> 
> That zero just means that nothing else found any irq information either.
> 
>  drivers/acpi/pci_irq.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -433,7 +433,7 @@ acpi_pci_irq_enable (
>  		printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: no GSI",
>  			pci_name(dev), ('A' + pin));
>  		/* Interrupt Line values above 0xF are forbidden */
> -		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
> +		if (dev->irq > 0 && (dev->irq <= 0xF)) {
>  			printk(" - using IRQ %d\n", dev->irq);
>  			acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
>  			return_VALUE(0);

Could this go into stable please? I've got it confirmed it fixes:
http://bugme.osdl.org/show_bug.cgi?id=4824

Which was introduced in -stable 2.6.12.2.

