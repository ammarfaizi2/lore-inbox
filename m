Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVILLIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVILLIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVILLIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:08:18 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:2253 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750731AbVILLIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:08:17 -0400
Subject: Re: [1/3] Add 4GB DMA32 zone
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
In-Reply-To: <200509121242.20910.ak@suse.de>
References: <43246267.mailL4R11PXCB@suse.de>
	 <1126520900.30449.48.camel@localhost.localdomain>
	 <200509121242.20910.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Sep 2005 12:33:06 +0100
Message-Id: <1126524787.30449.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-12 at 12:42 +0200, Andi Kleen wrote:
> (I cannot in fact remember a report of someone running especially
> into this problem)  And the cards seem to be essentially dead in the market 
> now. So it's really more a theoretical problem than a practical one.
> [Proof of it: the current sources don't seem to handle it, so
> it cannot be that bad ;-]

Current sources don't handle DMA32, so that can't be bad either. Can we
stick to sensible discussion, its quicker.

There have been various reports over time, quite a few early on when we
had a long series of on list discussions trying to debug what appeared
to be an iommu bug but was in fact a kernel bug. 

You hit it on any size AMD64 with iommu, but since most aacraid users
are intel boxes it doesn't hurt too many, and the rest all know about
turning the iommu off on the box (but that hurts the rest), or just run
something else because Linux "doesn't work".

> That is why I essentially ignored the b44. AFAIK the driver
> has a GFP_DMA bounce workaround anyways, so it would work
> anyways.

Usually - the DMA zone at 16MB is too small so allocations sometimes
fail. It btw would want 1GB limits.

> Yes I know some soundcards have similar limits, but for all
> these we still have GFP_DMA and they always have been quite happy
> with that.

No current shipping card, also those that need it typically need small
amounts (they'll live with 8K)

> > Old aacraid actually cannot use IOMMU. It isn't alone in that
> > limitation. Most hardware that has a 30/31bit limit can't go via the
> > IOMMU because IOMMU space appears on the bus above 2GB so is itself
> > invisible to the hardware.
> 
> Yes, true. Use GFP_DMA then.

Doesn't work. The DMA area is way too small with all the users already
and the aacraid can and does want a lot of outstanding I/O. Using a 1GB
or 2GB boundary line hurts nobody doing "allocate me some memory below
4Gb" because nobody asks for .5GB chunks. A 4GB zone means we need to
either increase the 16MB zone or add yet another one.


Alan

