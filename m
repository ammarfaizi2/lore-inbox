Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbTHWROf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbTHWROe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:14:34 -0400
Received: from trained-monkey.org ([209.217.122.11]:16658 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S264399AbTHWRLH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 13:11:07 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl> <m38ypl29i4.fsf@defiant.pm.waw.pl>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 23 Aug 2003 13:11:00 -0400
In-Reply-To: <m38ypl29i4.fsf@defiant.pm.waw.pl>
Message-ID: <m3isoo2taz.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Krzysztof" == Krzysztof Halasa <khc@pm.waw.pl> writes:

Krzysztof> I think we should do it the following way: - adding
Krzysztof> pci_alloc_consistent_mask(..., u64 mask),
Krzysztof> pci_map_*_mask(..., mask) and DMA API friends - adding a
Krzysztof> routine checking if a mask is valid on given system -
Krzysztof> renaming existing routines to *_nomask and aliasing old
Krzysztof> names to them.

I don't like this approach as I mentioned before. IMHO it is adding
unnecessary overhead to the runtime point. Why should one pass in the
mask 5 times when it is enough to use pci_set_consistent_dma_mask
etc. For the consistent allocations it's just a nuisance however if
you add this to pci_map_*() then it's going to add real overhead to
the hot paths of drivers which is just plain wrong.

I still haven't seen a strong argument for the current API being
insufficient. Alan mentioned one device causing the problem with
multiple consistent masks, but are there many more device like that
out there?

Jes
