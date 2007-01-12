Return-Path: <linux-kernel-owner+w=401wt.eu-S1161066AbXALK1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbXALK1v (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 05:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbXALK1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 05:27:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:52886 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161068AbXALK1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 05:27:50 -0500
Date: Fri, 12 Jan 2007 11:27:40 +0100
From: Nick Piggin <npiggin@suse.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: avoid div in rebalance_tick
Message-ID: <20070112102740.GC28611@wotan.suse.de>
References: <20070112060213.GB28611@wotan.suse.de> <20070112095940.0795a998@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070112095940.0795a998@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 09:59:40AM +0000, Alan wrote:
> On Fri, 12 Jan 2007 07:02:13 +0100
> Nick Piggin <npiggin@suse.de> wrote:
> 
> > Just noticed this while looking at a bug.
> > Avoid an expensive integer divide 3 times per CPU per tick.
> 
> Integer divide is cheap on some modern processors, and multibit shift
> isn't on all embedded ones.

Well integer divide unit is non-pipelined on P4 K8 Core2 and probably
most processors, AFAIK. So the 3 divs would take 240 cycles on a P4,
perhaps.

> How about putting back scale = 1 and using
> 
> scale += scale;
> 
> instead of the shift and getting what ought to be even better results

Yes I gues we ccan do this as well, good idea. I'll make a
quick userspace benchmark and post some numbers with my next
submission.
