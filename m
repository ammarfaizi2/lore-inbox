Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286271AbRLTPBJ>; Thu, 20 Dec 2001 10:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286269AbRLTPBA>; Thu, 20 Dec 2001 10:01:00 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:32779 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S286266AbRLTPAv>; Thu, 20 Dec 2001 10:00:51 -0500
Date: Thu, 20 Dec 2001 17:59:26 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI updates - prefetchable memory regions
Message-ID: <20011220175926.A6468@jurassic.park.msu.ru>
In-Reply-To: <20011218235035.P13126@flint.arm.linux.org.uk> <20011220161331.A5330@jurassic.park.msu.ru> <20011220133618.A30517@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011220133618.A30517@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Dec 20, 2001 at 01:36:19PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 01:36:19PM +0000, Russell King wrote:
> Could you explain this a bit better.  The reason we need to split the
> prefetchable regions from the non-prefetchable regions is that most
> bridges can only cope with one region which is prefetchable.

No. Most host-to-pci bridges actually have only non-prefetchable memory
region. That is, they don't generate Memory Read Line or Memory Read
Multiple transactions at all.
For pci-to-pci bridges, prefetchable region is optional (as well as I/O),
but most (if not all) bridges have it.
If we place memory-like resource behind the pci-pci bridge in the
prefetchable region, the bridge can convert Memory Read command from
its primary bus to Read Line/Multiply on the secondary bus, improving
performance thus.

> Also, some machines have a limited (sometimes fixed address and size)
> region that can only be used for prefetchable memory.  How do you cater
> for this?

Just fine, if your root_bus->resource[2] is not NULL and initialized
properly. If it's too small to hold all prefetchable resources,
the rest will be allocated in the non-prefetch memory region.

Ivan.
