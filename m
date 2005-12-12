Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVLLEVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVLLEVs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 23:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVLLEVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 23:21:48 -0500
Received: from ns2.suse.de ([195.135.220.15]:36748 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751080AbVLLEVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 23:21:48 -0500
Date: Mon, 12 Dec 2005 05:21:42 +0100
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/6] Framework
Message-ID: <20051212042142.GZ11190@wotan.suse.de>
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com> <20051210005445.3887.94119.sendpatchset@schroedinger.engr.sgi.com> <439CF2A2.60105@yahoo.com.au> <20051212035631.GX11190@wotan.suse.de> <439CF93D.5090207@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439CF93D.5090207@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 03:14:53PM +1100, Nick Piggin wrote:
> Andi Kleen wrote:
> >On Mon, Dec 12, 2005 at 02:46:42PM +1100, Nick Piggin wrote:
> >
> >>Christoph Lameter wrote:
> >>
> >>
> >>>+/*
> >>>+ * For use when we know that interrupts are disabled.
> >>>+ */
> >>>+static inline void __mod_zone_page_state(struct zone *zone, enum 
> >>>zone_stat_item item, int delta)
> >>>+{
> >>
> >>Before this goes through, I have a full patch to do similar for the
> >>rest of the statistics, and which will make names consistent with what
> >>you have (shouldn't be a lot of clashes though).
> >
> >
> >I also have a patch to change them all to local_t, greatly simplifying
> >it (e.g. the counters can be done inline then) 
> >
> 
> Cool. That is a patch that should go on top of mine, because most of
> my patch is aimed at moving modifications under interrupts-off sections,

That's obsolete then. With local_t you don't need to turn off interrupts
anymore.

> However I'm still worried about the use of locals tripling the cacheline
> size of a hot-path structure on some 64-bit architectures. Probably we
> should get them to try to move to the atomic64 scheme before using
> local_t here.

I think the right fix for those is to just change the fallback local_t
to disable interrupts again - that should be a better tradeoff and
when they have a better alternative they can implement it in the arch.

(in fact i did a patch for that too, but considered throwing it away
again because I don't have a good way to test it) 

-Andi
