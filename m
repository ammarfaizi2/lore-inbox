Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266436AbUGBEFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266436AbUGBEFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 00:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266442AbUGBEFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 00:05:36 -0400
Received: from mail.shareable.org ([81.29.64.88]:31662 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266436AbUGBEFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 00:05:34 -0400
Date: Fri, 2 Jul 2004 05:02:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org, David Mosberger-Tang <davidm@hpl.hp.com>,
       linux-ia64@linuxia64.org, Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       parisc-linux@parisc-linux.org,
       Richard Curnow <Richard.Curnow@superh.com>,
       Paul Mundt <lethal@linux-sh.org>,
       linuxsh-shmedia-dev@lists.sourceforge.net,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: Comparing PROT_EXEC-only pages on different CPUs
Message-ID: <20040702040218.GA10366@mail.shareable.org>
References: <20040701224016.GB7928@mail.shareable.org> <20040702013636.GA29154@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702013636.GA29154@twiddle.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your input, Richard.

Richard Henderson wrote:
> > Richard raises an interesting point: exec-only pages are useless if
> > the code needs to read jump tables and constant pools.  It seems very
> > likely Alpha and IA64 have these.
> 
> Only if the processor is crippled enough that mixing jump tables and
> constant pools in the same pages as code is considered reasonable.

That's a good point, if the i-cache and/or DTLB are separate from
d-cache and/or DTLB.  Then it makes more sense to put tables in a
separate address block.

However if the caches are unified then it makes sense to put them
together.  Somehow I doubt if any of these 64-bit chips have unified
i- and d-caches though :)

> Anyway, that's a strawman -- it's the toolchain's job to get the bits
> on the pt_load segments correct.
> 
> If the pt_load segment or the mmap prot argument says execute-only,
> then you should honor it.

In other words, PA-RISC and SH64 kernels _should_ create exec-only
pages if requested, as the hardware can do it, right?

And the toolchain _should_ ask read permssion for code segments, if
(and only if) the compiler has generated code which needs that, right?

I very much agree.

(Fwiw, Alpha does gives read permission to a write-only request, even
on chips which don't need that for byte writes to work.  Isn't that a
similar case?)

Thanks,
-- Jamie
