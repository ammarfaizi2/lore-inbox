Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272778AbTHRQyg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274964AbTHRQyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:54:36 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:41434 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S272778AbTHRQye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:54:34 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030817233705.0bea9736.davem@redhat.com>
	<m3r83jyw2k.fsf@defiant.pm.waw.pl>
	<20030818054341.2ef07799.davem@redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Aug 2003 17:54:42 +0200
In-Reply-To: <20030818054341.2ef07799.davem@redhat.com>
Message-ID: <m365kvufjx.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> The ia64 support code to do things with consistent_dma_mask just isn't
> in the tree yet.

Ok. Any pointer so I can see how is it used?

> Because the other platforms don't to do anything special wrt. this
> they can just ignore consitent_dma_mask altogether.

No. The documentation states that consistent_dma_mask (and not dma_mask)
will be used when doing pci_alloc_consistent(). This is, obviously, false
on most platforms.
It is perfectly reasonable to expect that setting consistent_dma_mask
to, say, 28 bits will cause pci_alloc_consistent to return memory from
first 256 MB. This is not true on most platforms, for example i386
happily allocs memory near the top in such case.

If we really need two masks, they can't be ignored on some archs.

Perhaps we should drop the masks at all and always supply a mask to
a alloc/map calls (possibly first checking if the mask is valid)?
I don't know.
-- 
Krzysztof Halasa
Network Administrator
