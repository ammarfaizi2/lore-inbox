Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSFJR3B>; Mon, 10 Jun 2002 13:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315595AbSFJR3A>; Mon, 10 Jun 2002 13:29:00 -0400
Received: from [209.237.59.50] ([209.237.59.50]:63016 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S315593AbSFJR27>; Mon, 10 Jun 2002 13:28:59 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <52d6v19r9n.fsf@topspin.com>
	<20020608.222903.122223122.davem@redhat.com>
	<15619.9534.521209.93822@nanango.paulus.ozlabs.org>
	<20020609.212705.00004924.davem@redhat.com>
	<523cvv9laj.fsf@topspin.com>
	<20020610170309.GC14252@opus.bloom.county>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 10 Jun 2002 10:28:55 -0700
Message-ID: <52u1ob82lk.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:

    Roland> So is the consensus now that in general drivers should
    Roland> make sure any buffers passed to pci_map/unmap are aligned
    Roland> to SMP_CACHE_BYTES (and a multiple of SMP_CACHE_BYTES in
    Roland> size)?  In other words if a driver uses an unaligned
    Roland> buffer it should be fixed unless we can prove (and
    Roland> document in a comment :) that it won't cause problems on
    Roland> an arch without cache coherency and with a writeback
    Roland> cache.

    Tom> And how about we don't call it SMP_CACHE_BYTES too?  The
    Tom> processors where this matters certainly aren't doing SMP...

Fair enough... there is of course L1_CACHE_BYTES but I'm not positive
that's always the right thing.  If we want to introduce a new constant
then we will have to touch every arch (which is not necessarily a
killer but it means "fixed" drivers won't compile for everyone until
their arch is fixed).

What would you propose?  I don't have strong feelings about the exact
form of a solution but I would like to decide something so we can have
a standard way of fixing drivers that use unaligned DMA buffers (and
convincing maintainers to apply the patches).

Thanks,
  Roland



