Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSFJRaV>; Mon, 10 Jun 2002 13:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315606AbSFJRaU>; Mon, 10 Jun 2002 13:30:20 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:9934 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315595AbSFJRaR>; Mon, 10 Jun 2002 13:30:17 -0400
Date: Mon, 10 Jun 2002 10:29:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Oliver Neukum <oliver@neukum.name>
Cc: Roland Dreier <roland@topspin.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020610172909.GE14252@opus.bloom.county>
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <523cvv9laj.fsf@topspin.com> <20020610170309.GC14252@opus.bloom.county> <200206101922.26985.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 07:22:26PM +0200, Oliver Neukum wrote:
> 
> > > So is the consensus now that in general drivers should make sure any
> > > buffers passed to pci_map/unmap are aligned to SMP_CACHE_BYTES (and a
> > > multiple of SMP_CACHE_BYTES in size)?  In other words if a driver uses
> > > an unaligned buffer it should be fixed unless we can prove (and
> > > document in a comment :) that it won't cause problems on an arch
> > > without cache coherency and with a writeback cache.
> >
> > And how about we don't call it SMP_CACHE_BYTES too?  The processors
> > where this matters certainly aren't doing SMP...
> 
> Definitely we should call it something different so we can limit it to 
> architectures that need it.

No.  We should just make it come out to a nop for arches that don't need
it.  Otherwise we'll end up with ugly things like:
#ifdef CONFIG_NOT_CACHE_COHERENT
...
#else
...
#endif

All over things like USB...

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
