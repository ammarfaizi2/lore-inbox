Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315528AbSEQM1r>; Fri, 17 May 2002 08:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSEQM1o>; Fri, 17 May 2002 08:27:44 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:14858 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S315528AbSEQM0w>; Fri, 17 May 2002 08:26:52 -0400
Date: Fri, 17 May 2002 16:26:21 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@mandrakesoft.com, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
Message-ID: <20020517162621.A24213@jurassic.park.msu.ru>
In-Reply-To: <20020517151154.B16767@jurassic.park.msu.ru> <20020517.040421.38226563.davem@redhat.com> <20020517153903.A24121@jurassic.park.msu.ru> <20020517.044157.34125224.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 04:41:57AM -0700, David S. Miller wrote:
> So, as a (real life) example, suppose you wanted to portably point
> your BTTV card at the framebuffer of a video card, you'd do
> something like:
> 
> 	res = fb_pdev->resource[1];
> 	res_off = OFFSET_INTO_FRAMEBUFFER;
> 	bttv_dma_addr = pci_to_pci_map_single(struct pci_dev *bttv_pdev,
> 					      struct pci_dev *fb_pdev,
> 					      res, res_off, size,
> 					      PCI_DMA_FROMDEVICE);

Exactly. And this function will look like this

	if (domain(bttv_pdev) == domain(fb_pdev))
		return arch_res_to_bus(res->start) + res_off;
	else if (!interdomain_dma_supported)
		return 0;
	else
		return some_iommu_magic(...);

BTW, I don't see anymore why pci domain info should be exposed to
users at all. :-)

Ivan.
