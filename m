Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbTBGRzN>; Fri, 7 Feb 2003 12:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbTBGRzM>; Fri, 7 Feb 2003 12:55:12 -0500
Received: from fmr02.intel.com ([192.55.52.25]:42219 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S266224AbTBGRzK> convert rfc822-to-8bit; Fri, 7 Feb 2003 12:55:10 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A847138036@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Jochen Hein <jochen@jochen.org>, Linus Torvalds <torvalds@transmeta.com>
Cc: trivial@rustcorp.com.au, linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [TRIVIAL, RESEND][ACPI, PCI] boot messages need line feeds
Date: Fri, 7 Feb 2003 10:04:34 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, should have acked this patch, but yes I saw it and will be including
it in the next ACPI update, unless an upstream maintainer applies it first.

Thanks -- Regards -- Andy

> -----Original Message-----
> From: Jochen Hein [mailto:jochen@jochen.org] 
> Sent: Friday, February 07, 2003 8:45 AM
> To: Linus Torvalds
> Cc: Grover, Andrew; trivial@rustcorp.com.au; linux-kernel
> Subject: [TRIVIAL, RESEND][ACPI, PCI] boot messages need line feeds
> Importance: High
> 
> 
> 
> [This time sent to Linus, CC to Andrew Grover and the Trivial Patch
> Monkey]
> 
> 
> The messages are:
> 
> pci_link-0331 [15] acpi_pci_link_set     : Link disabled
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 0
> pci_link-0331 [15] acpi_pci_link_set     : Link disabled
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 0
> pci_link-0331 [15] acpi_pci_link_set     : Link disabled
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 0
> pci_link-0331 [15] acpi_pci_link_set     : Link disabled
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 0
> pci_link-0484 [16] acpi_pci_link_get_irq : Link disabled
>  pci_irq-0256 [15] acpi_pci_irq_lookup   : Invalid IRQ link 
> routing entry
>  pci_irq-0295 [15] acpi_pci_irq_derive   : Unable to derive 
> IRQ for device 00:02.0
> ACPI: No IRQ known for interrupt pin A of device 00:02.0 - 
> using IRQ 255
> pci_link-0484 [16] acpi_pci_link_get_irq : Link disabled
>  pci_irq-0256 [15] acpi_pci_irq_lookup   : Invalid IRQ link 
> routing entry
>  pci_irq-0295 [15] acpi_pci_irq_derive   : Unable to derive 
> IRQ for device 00:02.1
> ACPI: No IRQ known for interrupt pin B of device 00:02.1 - 
> using IRQ 255
> pci_link-0484 [16] acpi_pci_link_get_irq : Link disabled
>  pci_irq-0256 [15] acpi_pci_irq_lookup   : Invalid IRQ link 
> routing entry
>  pci_irq-0295 [15] acpi_pci_irq_derive   : Unable to derive 
> IRQ for device 00:03.0
> ACPI: No IRQ known for interrupt pin A of device 
> 00:03.0pci_link-0484 [16] acpi_pci_link_get_irq : Link disabled
> 
>                                                         ^I think, here
> should be a line feed.  Next messages:
> 
>  pci_irq-0256 [15] acpi_pci_irq_lookup   : Invalid IRQ link 
> routing entry
>  pci_irq-0295 [15] acpi_pci_irq_derive   : Unable to derive 
> IRQ for device 00:07.2
> ACPI: No IRQ known for interrupt pin D of device 
> 00:07.2<6>PCI: Using ACPI for IRQ routing
>                                                         ^and again.
> 
> The following patch fixes it.
> 
> --- linux-2.5.59/drivers/acpi/pci_irq.c.jh	2003-01-25 
> 10:09:10.000000000 +0100
> +++ linux-2.5.59/drivers/acpi/pci_irq.c	2003-01-25 
> 10:10:54.000000000 +0100
> @@ -351,8 +351,10 @@
>  			printk(" - using IRQ %d\n", dev->irq);
>  			return_VALUE(dev->irq);
>  		}
> -		else
> +		else {
> +			printk("\n");
>  			return_VALUE(0);
> +		}
>   	}
>  
>  	dev->irq = irq;
> 
> Jochen
> 
> -- 
> Wenn Du nicht weißt was Du tust, tu's mit Eleganz.
> 
