Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267364AbSKPVSA>; Sat, 16 Nov 2002 16:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbSKPVSA>; Sat, 16 Nov 2002 16:18:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10770 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267364AbSKPVSA>;
	Sat, 16 Nov 2002 16:18:00 -0500
Message-ID: <3DD6B788.20108@pobox.com>
Date: Sat, 16 Nov 2002 16:24:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
       david.rusling@reo.mts.dec.com, davidm@cs.arizona.edu
Subject: Re: Patch: linux-2.5.47/arch/alpha/kernel/pci.c - do not directly
 set pci_dev.dma_mask where possible
References: <20021116063842.A20141@baldur.yggdrasil.com>
In-Reply-To: <20021116063842.A20141@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:

> --- linux-2.5.47/arch/alpha/kernel/pci.c	2002-11-10 19:28:03.000000000 
> -0800
> +++ linux/arch/alpha/kernel/pci.c	2002-11-16 05:54:00.000000000 -0800
> @@ -124,7 +124,7 @@
>  	unsigned int class = dev->class >> 8;
>
>  	if (class == PCI_CLASS_BRIDGE_ISA || class == PCI_CLASS_BRIDGE_ISA) {
> -		dev->dma_mask = MAX_ISA_DMA_ADDRESS - 1;
> +		pci_set_dma_mask(dev, MAX_ISA_DMA_ADDRESS - 1);
>  		isa_bridge = dev;
>  	}
>  }


No; pci_set_dma_mask is too high-level for the above arch-specific code. 
  When dma_mask is moved this will need to get examined and fixed up in 
another way.

	Jeff



