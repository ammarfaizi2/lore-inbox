Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291372AbSB0CLf>; Tue, 26 Feb 2002 21:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291414AbSB0CLZ>; Tue, 26 Feb 2002 21:11:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14598 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291372AbSB0CLO>;
	Tue, 26 Feb 2002 21:11:14 -0500
Message-ID: <3C7C4043.893429A9@mandrakesoft.com>
Date: Tue, 26 Feb 2002 21:11:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Jaroslav Kysela <perex@suse.cz>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] Conversion of hp100 to new PCI interface
In-Reply-To: <20020226174657.A18197@bougret.hpl.hp.com> <20020226175353.B18197@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> +       /* Conversion to new PCI API :
> +        * The memory block we use, lp->page_vaddr, was DMA allocated via
> +        * pci_alloc_consistent(), so we just need to "retreive" the
> +        * original mapping to bus/phys address - Jean II */
>         ringptr->pdl = pdlptr + 1;
> -       ringptr->pdl_paddr = virt_to_bus(pdlptr + 1);
> +       ringptr->pdl_paddr = virt_to_phys(pdlptr + 1);

Nope..  You need to use the mapping value obtained from
pci_alloc_consistent...

Note for ISA (and EISA and VLB) devices, you also call
pci_alloc_consistent.  You pass NULL for the pci device.

	Jeff



-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
