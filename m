Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWCBOft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWCBOft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 09:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWCBOft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 09:35:49 -0500
Received: from ns2.suse.de ([195.135.220.15]:12697 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750828AbWCBOfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 09:35:48 -0500
From: Andi Kleen <ak@suse.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Thu, 2 Mar 2006 15:35:35 +0100
User-Agent: KMail/1.9.1
Cc: Michael Monnerie <m.monnerie@zmi.at>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
References: <200603020023.21916@zmi.at> <200603021458.02934.ak@suse.de> <20060302141412.GT4329@suse.de>
In-Reply-To: <20060302141412.GT4329@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021535.36549.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 15:14, Jens Axboe wrote:

[...]

Ok great we agree on everything then.

> > > 
> > > I would not want to call wake_up() unless I have to. Would a
> > > 
> > >         smp_mb();
> > >         if (waitqueue_active(&iommu_wq))
> > >                 ...
> > > 
> > > not be sufficient?
> > 
> > Probably, but one would need to be careful to not miss events this way.
> 
> Definitely, as far as I can see the above should be enough...

Ok - you just need to give me a wait queue then and I would be happy
to add the wakeups to the low level code

(or you can just do it yourself	if you prefer, shouldn't be very difficult ... - just
needs to be done for both swiotlb and GART iommu. The other architectures
can follow then. At the beginning using an ARCH_HAS_* ifdef might be a good
idea for easier transition for everybody) 

-Andi
