Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTIAQwu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbTIAQwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:52:50 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:60297 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263140AbTIAQwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:52:46 -0400
Date: Mon, 1 Sep 2003 17:52:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901165239.GB3556@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <1062188787.4062.21.camel@elenuial.steamballoon.com> <20030901091524.A15370@flint.arm.linux.org.uk> <20030901101224.GB1638@mail.jlokier.co.uk> <20030901151710.A22682@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901151710.A22682@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Sep 01, 2003 at 11:12:24AM +0100, Jamie Lokier wrote:
> > Russell King wrote:
> > > This looks like an old kernel on your NetWinder.  Later 2.4 kernels
> > > should get this right (by marking the pages uncacheable in user space.)
> > 
> > How do they know which pages to mark uncacheable?  Surely not all
> > MAP_SHARED|MAP_FIXED mappings are uncacheable?
> 
> By looking at the mappings present in the process.  If a process maps the
> same file using MAP_SHARED _and_ we fault the same page of data into two
> or more mappings, we turn off the cache for those pages.

   1. That's not necessary when the virtual addresses are separated
      by some multiple, is it?

   2. The other architectures with incoherent caches set SHMLBA to the
      multiple, and they don't do anything special in
      update_mmu_cache(), so MAP_FIXED can create incoherent mappings.

      Is there any special reason why ARM is different?

> I've tested on several silicon revisions of StrongARM-110's:
> - H appears buggy (reports as rev. 2)
> - K appears fine (reports as rev. 2)
> - S appears buggy (reports as rev. 3)

It's possible that all of them are buggy, but the write buffer test
doesn't manage to get writes into the buffer with the exact timing
needed to trigger it.  Unfortunately, while the write buffer test does
pretty much guarantee a store/store/load instruction sequence, because
it's generic it can't guarantee how those are executed in a
superscalar or out of order pipeline.

> So it seems your test program finds problems which DaveM's aliastest
> program fails to detect...  Gah. ;(

Well, it's good to know it was useful :/

Thanks,
-- Jamie
