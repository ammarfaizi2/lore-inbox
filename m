Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbTH3VTe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 17:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbTH3VTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 17:19:34 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:36490 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262136AbTH3VTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 17:19:32 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: jes@trained-monkey.org, alan@lxorguk.ukuu.org.uk, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl> <m38ypl29i4.fsf@defiant.pm.waw.pl>
	<m3isoo2taz.fsf@trained-monkey.org> <m3n0dz5kfg.fsf@defiant.pm.waw.pl>
	<20030824060057.7b4c0190.davem@redhat.com>
	<m365kmltdy.fsf@defiant.pm.waw.pl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 30 Aug 2003 23:18:50 +0200
In-Reply-To: <m365kmltdy.fsf@defiant.pm.waw.pl>
Message-ID: <m365kex2rp.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David, any comments?

"David S. Miller" <davem@redhat.com> writes:

> > The code has to get the mask anyway, either from
> > pci_dev->(consistent_)dma_mask or from its arguments.
> 
> But it does not have to verify the mask each and every mapping call
> currently.  We'll need to do that with your suggested changes.

No, why? What we'll need is to verify the mask at driver startup.
It would be driver responsibility to use only valid (verified) masks.

> Nobody is going to agree to any of your proposals at the rate you're
> currently going.

What do you propose instead?

> Effectively, the correct effects are obtained on i386, Alpha,
> IA64, and sparc for all drivers in the tree.  I can say this because
> nobody tries to do anything interesting with consistent_dma_mask
> yet, and that is why nobody has any incentive to "fix" it as you
> keep complaining we need to do.

False. I have a device which needs different mask for consistent allocs.
In fact the whole story began with me trying to put this driver into
the tree.

> See, to show something is broken, you have to show a device that
> will break currently.

SBE wanXL sync serial adapter. 32 bits for buffers but 28 bits for
consistent data.

>  The consistent_dma_mask is only modified
> by tg3, and it does so in such a way that all platforms work properly.

I can't imagine all devices work properly on all platforms wrt
consistent allocs. Say, sound drivers setting only dma_mask to < 32 bits
and expecting consistent alloc will use that and not consistent_dma_mask.

Of course, there is a question if we want to support such sound cards
on Itaniums and Opterons? Of course they work on i386 as
i386 pci_alloc_consistent() ignores consistent_dma_mask.

-- Krzysztof Halasa, B*FH
