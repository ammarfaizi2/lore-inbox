Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUC0GLv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 01:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUC0GLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 01:11:51 -0500
Received: from zero.aec.at ([193.170.194.10]:46088 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261784AbUC0GLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 01:11:50 -0500
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
References: <1DLZM-8aK-67@gated-at.bofh.it> <1DLZM-8aK-65@gated-at.bofh.it>
	<1DOE1-20o-17@gated-at.bofh.it> <1DOXn-2k7-5@gated-at.bofh.it>
	<1DXxI-Z7-39@gated-at.bofh.it> <1E467-6KK-17@gated-at.bofh.it>
	<1E4IT-7f3-21@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 27 Mar 2004 02:29:12 +0100
In-Reply-To: <1E4IT-7f3-21@gated-at.bofh.it> (Andrew Morton's message of
 "Fri, 26 Mar 2004 20:00:15 +0100")
Message-ID: <m3fzbvqdqv.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
>
> I think this gets it right, but I probably screwed something up.
>
> static inline void prefetch_range(void *addr, size_t len)
> {
> #ifdef ARCH_HAS_PREFETCH
> 	char *cp;
> 	unsigned long end;
>
> 	end = ((unsigned long)addr + len + PREFETCH_STRIDE - 1);
> 	end &= ~(PREFETCH_STRIDE - 1);
>
> 	for (cp = addr; cp < (char *)end; cp += PREFETCH_STRIDE)
> 		prefetch(cp);
> #endif
> }

The memory/bus controller usually only has a limited queue of
outstanding transactions and for a big buffer you will likely overflow
it. Also usually on modern CPUs it is enough to do prefetch for 2-3
cache lines at the beginning, then an automatic hardware prefetcher
will kick in and take care of the rest.

-Andi

