Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132708AbRDNBuj>; Fri, 13 Apr 2001 21:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132711AbRDNBu3>; Fri, 13 Apr 2001 21:50:29 -0400
Received: from zeus.kernel.org ([209.10.41.242]:27613 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132708AbRDNBuY>;
	Fri, 13 Apr 2001 21:50:24 -0400
Message-ID: <3AD7A6ED.7626BE05@mandrakesoft.com>
Date: Fri, 13 Apr 2001 21:25:01 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-17mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@linuxcare.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: modica@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Proposal for a new PCI function call
In-Reply-To: <3AD601B4.7E0B14E4@sgi.com> <3AD604B0.2713F08B@mandrakesoft.com> <d3vgo9ej5r.fsf@lxplus015.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> >>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> >> I think the function idea would let us do some sanity checking to
> >> make sure drivers weren't setting this to 64bit on non-64 bit
> >> busses and stuff.

> Jeff> pci_set_dma_mask.  Modify that to do the additional checks you
> Jeff> need.

> Jeff> Nobody should be setting dma_mask directly anymore, it should be
> Jeff> done through this function.

> Hmmm, I was wondering if could come up with a pretty way to do this on
> 32 bit boxes that wants to enable highmem DMA. Right now
> pci_set_dma_mask() wants a dma_addr_t which means you have to do
> #ifdef CONFIG_HIGHMEM <blah> #else <bleh> #endif.

It seems to me that not doing #ifdef CONFIG_HIGHMEM right now is a
bug...  I think it's the megaraid driver that wants to set dma_addr_t to
a 64-bit mask.


Alan Cox wrote:
> pci_set_dma_mask_bits() ? So you could do
> 
> pci_set_dma_mask_bits(pdev, 64);

As they say, "six of one, 'half-dozen of the other."  I don't have a
preference...

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
