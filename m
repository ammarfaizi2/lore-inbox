Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271749AbTHRPP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271845AbTHRPPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:15:25 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:64467 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S271749AbTHRPPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:15:24 -0400
Date: Mon, 18 Aug 2003 11:15:22 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
Message-ID: <20030818111522.A12835@devserv.devel.redhat.com>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3oeynykuu.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Mon, Aug 18, 2003 at 12:34:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Krzysztof Halasa <khc@pm.waw.pl>
> Date: 18 Aug 2003 00:34:17 +0200

> It's unneeded (it can be easily done in a driver, should a need arrive,
> without polluting the PCI subsystem) and is not supported by "DMA" API.

Are you talking about doing tripple calls, e.g.

       pci_set_dma_mask(pdev, 0xFFFFFFFF);
       foo = pci_alloc_consistent(pdev, size, &handle);
       // Restore for upcoming streaming allocations
       pci_set_dma_mask(pdev, 0xFFFFFFFFFFFFFFFF);

Possibly Jes considered that alternative and decided that it
did not allow for sufficient performance.

> It isn't even implemented on most platforms - only x86_64 and ia64 have
> support for it, while on the remaining archs using it according to the
> docs (with non-default value) could mean Oops or something like that.

Before you go for that, I'd rather see you implementing the
double/tripple calls in drivers, check for effects, THEN
go for removal of the mask. If you cannot do it, plea SGI people
to test it on SN-2 for you (or same for Intel Tiger box).

> This patch doesn't actually change any current kernel behaviour.

Sure it does. It blows all non-mmu ia64 out of the water.

The consistent mask looks a little distasteful to me, and I think
it should not buy us performance because consistent allocations
are not supposed to be fast. They are bad, but what you are doing
is worse: you are trying to ruin the day of legitimate users.
Please, be reasonable. Get SGI buy-in and come back.

-- Pete
