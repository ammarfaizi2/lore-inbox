Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292536AbSBTWDi>; Wed, 20 Feb 2002 17:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292538AbSBTWD3>; Wed, 20 Feb 2002 17:03:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53258 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292536AbSBTWDL>;
	Wed, 20 Feb 2002 17:03:11 -0500
Message-ID: <3C741D1D.CB66A615@mandrakesoft.com>
Date: Wed, 20 Feb 2002 17:03:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Stroupe <dstroupe@keyed-upsoftware.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Q: PCI Driver ioremap
In-Reply-To: <3C741BAF.9090300@keyed-upsoftware.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Stroupe wrote:
> 
> I am creating a PCI driver for a custom card and want to write 0xffff to
> a location offset from the base by 0x48 and
> have the following code:
> 
> <snip>
> unsigned int io_addr;
> unsigned int io_size;
> void* base;
> pci_enable_device (pdev)
> io_addr = pci_resource_start(pdev, 0);
> io_size = pci_resource_len(pdev, 0);
> if ((pci_resource_flags(pdev, 0) & IORESOURCE_MEM)){
>        if(check_mem_region(io_addr, io_size))
>             DBG("Already In Use");//this is never reached
>         request_mem_region(io_addr, io_size , "Card Driver");

In 2.4 and later, check request_mem_region return value, and never call
check_mem_region.

>         base=ioremap(io_addr, io_size);
>         if(base==0)
>            DBG("memory mapped wrong\n");//this is never reached
>         writew(0xffff, base + 0x48);
> <snip>
> 
> The card is found, io_addr = 0xe9011000 and io_size = 0x200.
> 
> The write is unsuccessful or at least the data never reaches the card.
>  What am I doing incorrectly?

Looks correct to me... maybe you need to do
	readw(base + 0x48)
to flush the transaction?

-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
