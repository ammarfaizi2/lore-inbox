Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317491AbSFIAk3>; Sat, 8 Jun 2002 20:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317492AbSFIAk2>; Sat, 8 Jun 2002 20:40:28 -0400
Received: from [209.237.59.50] ([209.237.59.50]:16567 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317491AbSFIAk2>; Sat, 8 Jun 2002 20:40:28 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <52vg8ta4ki.fsf@topspin.com>
	<20020608.160300.37239939.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 08 Jun 2002 17:40:24 -0700
Message-ID: <52lm9p9tdz.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

    David> There is no allocation scheme legal for PCI DMA which gives
    David> you smaller than a cacheline of data, this includes SLAB.
    David> This is why stack buffers and the like are illegal for PCI
    David> DMA.

    David> If the architecture allows SLAB to give smaller than
    David> cacheline sized data, it must handle PCI DMA map/unmap
    David> flushing in an appropriate fashion (ie. handle
    David> sub-cacheline buffers).
   
Thanks, that's great information.  However, there is one question you
didn't cover.  How about using a sub-cache-line piece of a kmalloc()'ed
buffer (eg the case I described of using one member from a struct as a
DMA buffer)?  As far as I can see there is no guarantee that this will
always work.  Do you agree that this should be treated as a bug and
fixed when it is found?  Or should we leave that usage unless it is
observed causing problems (since we almost always get lucky and don't
touch the rest of the cache line near the DMA)?

Thanks,
  Roland
