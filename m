Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312526AbSDSP5H>; Fri, 19 Apr 2002 11:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312529AbSDSP5G>; Fri, 19 Apr 2002 11:57:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:13981 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S312526AbSDSP5F>; Fri, 19 Apr 2002 11:57:05 -0400
Date: Fri, 19 Apr 2002 11:56:58 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200204191556.g3JFuw131245@devserv.devel.redhat.com>
To: Jan Slupski <jslupski@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wrong IRQ for USB on Sony Vaio (dmi_scan.c, pci-irq.c)
In-Reply-To: <mailman.1019225640.7470.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Broken BIOS of these notebooks assigns IRQ 10 for USB,
> even though it is actually wired to IRQ 9.
> 
> I use PCG-FX240 model of Sony Vaio, but I have proofs of other users, 
> that exactly the same problem exists on models:
> FX200, FX220, FX250, FX270, FX290, FX370, FX503, R505JS, R505JL
> These models use Intel's 82801BA controller, and Phoenix bios.

> Only problem is I don't have DMI Product names for all involved models.
> That's why I left pretty general:
>   MATCH(DMI_PRODUCT_NAME, "PCG-")

My Z505JE works perfectly without it. In general Z505's are
known to work.

> +	/* Work around broken Sony Vaio Notebooks which assign USB to
> +	 * IRQ 10 even though it is actually wired to IRQ 9 
> +	 * Send comments to: Jan Slupski, jslupski@email.com
> +	 */
> +
> +	if (broken_sony_vaio_bios_irq10 && pirq == 0x63 && dev->irq == 9 &&
> +			dev->vendor == 0x8086 && dev->device == 0x2442){
> +		dev->irq = 9;
> +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 9);
> +		r->set(pirq_router_dev, dev, pirq, 9);
> +	}

So...

	if (dev->irq == 9) {
		dev->irq = 9;
	}

Are you sure it's right?

-- Pete
