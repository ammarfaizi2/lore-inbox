Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUJaPfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUJaPfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 10:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUJaPfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 10:35:15 -0500
Received: from jade.aracnet.com ([216.99.193.136]:10379 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261171AbUJaPfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 10:35:10 -0500
Date: Sun, 31 Oct 2004 07:35:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@novell.com>, Andrew Morton <akpm@osdl.org>
cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <43630000.1099236900@[10.10.2.4]>
In-Reply-To: <20041030224528.GB3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <20041030140732.2ccc7d22.akpm@osdl.org> <20041030224528.GB3571@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I share your concern on the fact there seems not to be any speedup in my
> 2-way boxes unless I microbenchmark (but if I microbenchmark the best
> case the speedup is very huge). OTOH the same applies to the per-cpu
> queues at large, they only are measurable on the big boxes. Overall if
> we've to use slab for the pte just to cache zero (which for sure won't
> be a measurable speedup either in any small box using a _macro_
> benchmark), this looks better design IMHO since it boosts everything
> zero related, not just the pte. Plus it fixes some mistake in the
> current code (like the failure of utilizing properly all the quicklists
> belonging to each classzone [current code falls back into the buddy
> before falling back in the lower zone quicklist] and the waste of
> resouces in keeping the hot and cold caches separated, and the no point
> for low watermark in the quicklists and other very minor details).

I'll non-micro-benchmark stuff for you on big machines if you want, but I've 
wasted enough time coding this stuff already ;-)

BTW, the one really useful thing the whole page zeroing stuff did was to
shift the profiled cost of page zeroing out to the routine acutally using
the pages, as it's no longer just do_anonymous_page taking the cache hit.

M.


