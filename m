Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315410AbSFJRDS>; Mon, 10 Jun 2002 13:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSFJRDS>; Mon, 10 Jun 2002 13:03:18 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:55245
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315410AbSFJRDQ>; Mon, 10 Jun 2002 13:03:16 -0400
Date: Mon, 10 Jun 2002 10:03:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020610170309.GC14252@opus.bloom.county>
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <20020608.222903.122223122.davem@redhat.com> <15619.9534.521209.93822@nanango.paulus.ozlabs.org> <20020609.212705.00004924.davem@redhat.com> <523cvv9laj.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 08:59:48AM -0700, Roland Dreier wrote:
> >>>>> "David" == David S Miller <davem@redhat.com> writes:
> 
>     Paul> This is the problem scenario.  Suppose we are doing DMA to a
>     Paul> buffer B and also independently accessing a variable X which
>     Paul> is not part of B.  Suppose that X and the beginning of B are
>     Paul> both in cache line C.
>    
>     David> I see what the problem is.  Hmmm...
> 
>     David> I'm trying to specify this such that knowledge of
>     David> cachelines and whatnot don't escape the arch specific code,
>     David> ho hum...  Looks like that isn't possible.
> 
> So is the consensus now that in general drivers should make sure any
> buffers passed to pci_map/unmap are aligned to SMP_CACHE_BYTES (and a
> multiple of SMP_CACHE_BYTES in size)?  In other words if a driver uses
> an unaligned buffer it should be fixed unless we can prove (and
> document in a comment :) that it won't cause problems on an arch
> without cache coherency and with a writeback cache.

And how about we don't call it SMP_CACHE_BYTES too?  The processors
where this matters certainly aren't doing SMP...

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
