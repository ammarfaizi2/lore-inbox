Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291297AbSBGUj5>; Thu, 7 Feb 2002 15:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291290AbSBGUjq>; Thu, 7 Feb 2002 15:39:46 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:21545 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S291284AbSBGUje> convert rfc822-to-8bit; Thu, 7 Feb 2002 15:39:34 -0500
Date: Wed, 6 Feb 2002 22:38:27 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
cc: <hch@caldera.de>, <davidm@hpl.hp.com>, <mmadore@turbolinux.com>,
        <linux-ia64@linuxia64.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] Proper fix for sym53c8xx_2 driver and dma64_addr_t
In-Reply-To: <20020206.180915.78161963.davem@redhat.com>
Message-ID: <20020206223023.F2024-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Feb 2002, David S. Miller wrote:

>    From: Christoph Hellwig <hch@caldera.de>
>    Date: Wed, 6 Feb 2002 18:10:42 +0100
>
>    When the sym2 driver is configured with SYM_CONF_DMA_ADDRESSING_MOD > 1
>    it uses DAC accessing and needs dma64_addr_t.  It doesn't use it
>    when using the default addressing mode.
>
> NO it damn well does not!  If the platform is NEVER GOING TO GIVE the
> driver a 64-bit address (because, for example, it has IOMMU hardware),
> dma_addr_t need only be 32-bits and that it how it is declared on
> several platforms.
>
> Please read the DMA API documentation.
>
> dma64_addr_t is _ONLY_, I REPEAT _ONLY_ to be used when the driver
> is making use of the following routines for it's DMA usage:
>
> 	pci_dac_page_to_dma
> 	pci_dac_dma_to_page
> 	pci_dac_dma_to_offset
> 	pci_dac_dma_sync_single
>
> And NO SCSI OR NET driver should ever use these routines.
>
> In fact, no driver in the tree right now should be using this.
> The only known example that needs those interfaces are clustering
> cards.  And thats it!
>
> Everything in the tree right now should use only pci_map_single and
> friends, and it should set the device DMA mask bits properly to
> indicate DAC capability.  Do you see any pci_map_single, pci_map_sg,
> etc. implementation working with dma64_addr_t arguments?  If so, thats
> a huge bug and it must be fixed.

You should calm down, in my opinion. All the burden about the PCI dma API
is your fault to you David and you David. :)
It takes a too long time for you 2 Davids to agree about this API.

Personnally, I donnot care about dma64_addr_t versus dma_addr_t being 32,
64 even 69 bits (why not, some machine with 36 bit addressing are still in
use).

Just change the topic, please. The sym2 driver has nothing to do with this
boring thread.

  Gérard.

