Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWDKWgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWDKWgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWDKWgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:36:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:40579 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751199AbWDKWgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:36:07 -0400
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: "David S. Miller" <davem@davemloft.net>, mb@bu3sch.de,
       netdev@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, linville@tuxdriver.com
In-Reply-To: <20060411223024.GA6543@ens-lyon.fr>
References: <1144719972.19353.24.camel@localhost.localdomain>
	 <20060410.224933.39567033.davem@davemloft.net>
	 <1144788541.19353.41.camel@localhost.localdomain>
	 <20060411.143407.74615246.davem@davemloft.net>
	 <1144794077.19353.53.camel@localhost.localdomain>
	 <20060411223024.GA6543@ens-lyon.fr>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 08:35:39 +1000
Message-Id: <1144794939.19353.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-12 at 00:30 +0200, Benoit Boissinot wrote:
> On Wed, Apr 12, 2006 at 08:21:17AM +1000, Benjamin Herrenschmidt wrote:
> > 
> > > I still think we shouldn't reward shit hardware by complicating
> > > up our DMA mappings internals. :-)
> > 
> > BTW. In the meantime, can't that driver work in PIO only mode ?
> 
> yes, I think you just have to have the pci_set_dma_mask fail with
> DMA30BIT_MASK.

Ok, _that_ makes sense in fact to have ppc do that when the mask is too
big... now the problem is should I compare the mask to the available
RAM ? That is, there is little point in failing for a 30 bits mask if
hte machine only has 512M of RAM.

By extension of the above, what to do on 32 bits kernels, should I test
the mask against total memory or specifically against lowmem ? There is
no clear answer here as some drivers will get highmem pages for DMA,
just not network drivers afaik (block drivers will), though I can't be
sure what will happen with thing like nbd... I'm not familiar enough
with the network stack. It would be sad to have 32 bits laptop switch to
PIO when they have too much RAM if, in practice, skbs are always only in
lowmem..

I think for now, what I may do is just add such a test for ppc64 and not
ppc32 and will talk to paulus see if he happens to have a better idea.

It's all very sad that bcm gets away with such crap though and that so
many vendors just bought it without complaining...

Ben.


