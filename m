Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129079AbQKHP5T>; Wed, 8 Nov 2000 10:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKHP5K>; Wed, 8 Nov 2000 10:57:10 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:48650 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129079AbQKHP5B>;
	Wed, 8 Nov 2000 10:57:01 -0500
Message-ID: <3A0977A7.53641C52@mandrakesoft.com>
Date: Wed, 08 Nov 2000 10:56:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, axp-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
In-Reply-To: <20001101153420.A2823@jurassic.park.msu.ru> <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Setting bit 1 in dev->resource[x].start, below, seems incorrect.  Should
you be programming the PCI BAR directly, instead?

> +static void __init
> +quirk_cypress_ide_ports(struct pci_dev *dev)
> +{
> +       if (dev->class >> 8 != PCI_CLASS_STORAGE_IDE)
> +               return;
> +       dev->resource[1].start |= 2;
> +       dev->resource[1].end = dev->resource[1].start;
> +       pci_claim_resource(dev, 0);
> +       pci_claim_resource(dev, 1);
> +}


I wonder about this code:

> +               /* ??? Reserve some resources for CardBus */
> +               if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS) {
> +                       io_reserved += 8*1024;
> +                       mem_reserved += 32*1024*1024;
> +                       continue;
> +               }


I think "pdev_enable_device" is a poorly-chosen name, since "pdev_" is
not a common prefix, and we already have pci_enable_device.

Also, should we be setting PCI_CACHE_LINE_SIZE for PCI devices as well
as bridges?

	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
