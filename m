Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSFJP7y>; Mon, 10 Jun 2002 11:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315480AbSFJP7x>; Mon, 10 Jun 2002 11:59:53 -0400
Received: from [209.237.59.50] ([209.237.59.50]:24095 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S315479AbSFJP7w>; Mon, 10 Jun 2002 11:59:52 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <52d6v19r9n.fsf@topspin.com>
	<20020608.222903.122223122.davem@redhat.com>
	<15619.9534.521209.93822@nanango.paulus.ozlabs.org>
	<20020609.212705.00004924.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 10 Jun 2002 08:59:48 -0700
Message-ID: <523cvv9laj.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

    Paul> This is the problem scenario.  Suppose we are doing DMA to a
    Paul> buffer B and also independently accessing a variable X which
    Paul> is not part of B.  Suppose that X and the beginning of B are
    Paul> both in cache line C.
   
    David> I see what the problem is.  Hmmm...

    David> I'm trying to specify this such that knowledge of
    David> cachelines and whatnot don't escape the arch specific code,
    David> ho hum...  Looks like that isn't possible.

So is the consensus now that in general drivers should make sure any
buffers passed to pci_map/unmap are aligned to SMP_CACHE_BYTES (and a
multiple of SMP_CACHE_BYTES in size)?  In other words if a driver uses
an unaligned buffer it should be fixed unless we can prove (and
document in a comment :) that it won't cause problems on an arch
without cache coherency and with a writeback cache.

Thanks,
  Roland
