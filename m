Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbTHSUh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbTHSUhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:37:04 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:17639 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261245AbTHSUcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:32:09 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jes@wildopensource.com,
       zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 19 Aug 2003 22:31:36 +0200
In-Reply-To: <20030819095547.2bf549e3.davem@redhat.com>
Message-ID: <m34r0dwfrr.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> (d) Makes implementations have to verify the mask is usable
> on every mapping attempt.

No, unless we have hardware which can return success on first mask check
then result error on subsequent mapping request.

We need to decide, though, as I'm going to fix it that way or another:

1) provide the mask argument to actual mapping requests (pci_map_*,
   pci_alloc_*, DMA API) and drop pci_dev->*dma_mask, or

2) add coherent_dma_mask pointer to struct driver as with normal mask,
   pointing to pci_dev->consistent_dma_mask

1: non-trivial, but IMHO makes things more clean and natural (from both
   system's and driver's view), and fits all special cases.


BTW: Why do we have this pointer (I mean u64 *dma_mask) in struct device?
Does it always point to pci_dev->dma_mask (and to similar value on EISA
etc)? I see some code checks for struct device->dma_mask=NULL, is it only
a safety check or does NULL have some meaning there?

Would it make sense to drop the masks in pci_dev and use (u64 not
pointers) *dma_masks in struct device? If so, would 0 there have the same
meaning as now NULL?
-- 
Krzysztof Halasa
Network Administrator
