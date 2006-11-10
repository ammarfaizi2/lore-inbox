Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424229AbWKJCzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424229AbWKJCzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 21:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424231AbWKJCzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 21:55:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:34485 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1424229AbWKJCzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 21:55:38 -0500
Subject: Re: DMA APIs gumble grumble
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       paulus@samba.org, anton@samba.org, greg@kroah.com
In-Reply-To: <20061109.185026.07639529.davem@davemloft.net>
References: <1162950877.28571.623.camel@localhost.localdomain>
	 <20061107.204653.44098205.davem@davemloft.net>
	 <1163120524.4982.61.camel@localhost.localdomain>
	 <20061109.185026.07639529.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 13:55:27 +1100
Message-Id: <1163127327.4982.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> pci_alloc_consistent() is not allowed from atomic contexts.

Yes, but some drivers did it anyway, though I can't remember under which
circumstances (IDE probe possibly ? It's a usual culprit for that sort
of thing). This is why most implementations use GFP_ATOMIC (including
sparc64 :-)

> > I'm splitting it into a pci_do_alloc_consistent that takes a gfp arg,
> > and a pair of pci_alloc_consistent & dma_alloc_consistent wrappers.
> > 
> > Do you think I should have the former pass GFP_KERNEL like the current
> > implementation does or switch it to GFP_ATOMIC like everybody does ? In
> > this case, should I also change the kmalloc done in there to allocate a
> > struct resource to use the gfp argument ? (It's currently doing
> > GFP_KERNEL).
> 
> pci_alloc_consistent() really cannot be allowed to use GFP_ATOMIC.

Oh well, I have no problem with leaving sparc32 do GFP_KERNEL indeed, I
can't remember for sure the reason why we have most architectures do
GFP_ATOMIC, but it probably never hit sparc32.

Ben.


