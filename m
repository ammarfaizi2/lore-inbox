Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUC0Psu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 10:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUC0Psu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 10:48:50 -0500
Received: from waste.org ([209.173.204.2]:46051 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261793AbUC0Pss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 10:48:48 -0500
Date: Sat, 27 Mar 2004 09:48:39 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
Message-ID: <20040327154839.GC6248@waste.org>
References: <1DLZM-8aK-67@gated-at.bofh.it> <1DLZM-8aK-65@gated-at.bofh.it> <1DOE1-20o-17@gated-at.bofh.it> <1DOXn-2k7-5@gated-at.bofh.it> <1DXxI-Z7-39@gated-at.bofh.it> <1E467-6KK-17@gated-at.bofh.it> <1E4IT-7f3-21@gated-at.bofh.it> <m3fzbvqdqv.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3fzbvqdqv.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 02:29:12AM +0100, Andi Kleen wrote:
> Andrew Morton <akpm@osdl.org> writes:
> >
> > I think this gets it right, but I probably screwed something up.
> >
> > static inline void prefetch_range(void *addr, size_t len)
> > {
> > #ifdef ARCH_HAS_PREFETCH
> > 	char *cp;
> > 	unsigned long end;
> >
> > 	end = ((unsigned long)addr + len + PREFETCH_STRIDE - 1);
> > 	end &= ~(PREFETCH_STRIDE - 1);
> >
> > 	for (cp = addr; cp < (char *)end; cp += PREFETCH_STRIDE)
> > 		prefetch(cp);
> > #endif
> > }
> 
> The memory/bus controller usually only has a limited queue of
> outstanding transactions and for a big buffer you will likely overflow
> it. Also usually on modern CPUs it is enough to do prefetch for 2-3
> cache lines at the beginning, then an automatic hardware prefetcher
> will kick in and take care of the rest.

Presumable the automatic prefetcher doesn't deal well with
non-sequential access patterns. But I suspect the right thing to do is
put the knowledge of what's sensible for prefetch priming inside an
arch-specific prefetch_range.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
