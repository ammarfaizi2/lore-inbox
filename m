Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUFXKdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUFXKdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUFXKdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:33:20 -0400
Received: from colin2.muc.de ([193.149.48.15]:33811 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264113AbUFXKdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:33:18 -0400
Date: 24 Jun 2004 12:33:18 +0200
Date: Thu, 24 Jun 2004 12:33:18 +0200
From: Andi Kleen <ak@muc.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Terence Ripperda <tripperda@nvidia.com>,
       discuss@x86-64.org, tiwai@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624103318.GA2946@colin2.muc.de>
References: <2akPm-16l-65@gated-at.bofh.it> <m38yee6j7s.fsf@averell.firstfloor.org> <1088057885.2806.16.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088057885.2806.16.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 08:18:06AM +0200, Arjan van de Ven wrote:
> On Wed, 2004-06-23 at 23:46, Andi Kleen wrote:
> 
> > The VM should be able to handle this, but it may still require
> > some tuning. It would need some generic changes, but not too bad.
> > Still would need a decision on how big GFP_BIGDMA should be. 
> > I suspect 4GB would be too big again.
> 
> What is the problem again, can't the driver us the dynamic pci mapping
> API which does allow more memory to be mapped even on crippled machines
> without iommu ?

In theory one could fix pci_alloc_consistent from the swiotlb pool yes,
the problem is just that this pool is completely preallocated. If 
enough memory is needed that would be quite nasty, because you suddenly
lose 1 or 2GB RAM.

> And isn't this a problem that will vanish since PCI Express and PCI X
> both *require* support for 64 bit addressing, so all higher speed cards
> are going to be ok in principle ?

There are EM64T systems with AGP only and not all PCI-Express cards
seem to follow this. PCI-Express unfortunately discouraged the AGP aperture too,
so not even that can be used on those Intel systems.

-Andi 
