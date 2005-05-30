Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVE3JyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVE3JyC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 05:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVE3JyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 05:54:02 -0400
Received: from colin.muc.de ([193.149.48.1]:4623 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261589AbVE3Jxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 05:53:50 -0400
Date: 30 May 2005 11:53:49 +0200
Date: Mon, 30 May 2005 11:53:49 +0200
From: Andi Kleen <ak@muc.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050530095349.GK86087@muc.de>
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu> <20050527133122.GF86087@muc.de> <s5hwtpkwz4z.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hwtpkwz4z.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 03:56:44PM +0200, Takashi Iwai wrote:
> At 27 May 2005 15:31:22 +0200,
> Andi Kleen wrote:
> > 
> > On Fri, May 27, 2005 at 03:13:17PM +0200, Ingo Molnar wrote:
> > > 
> > > > > but it's certainly not for free. Just like there's no zero-cost
> > > > > virtualization, or there's no zero-cost nanokernel approach either,
> > > > > there's no zero-cost single-kernel-image deterministic system either.
> > > > > 
> > > > > and the argument about binary kernels - that's a choice up to vendors
> > > > 
> > > > It is not only binary distribution kernels. I always use my own self
> > > > compiled kernels, but I certainly would not want a special kernel just
> > > > to do something normal that requires good latency (like sound use).
> > > 
> > > for good sound you'll at least need PREEMPT_VOLUNTARY. You'll need 
> > > CONFIG_PREEMPT for certain workloads or pro-audio use.
> > 
> > AFAIK the kernel has quite regressed recently, but that was not true
> > (for reasonable sound) at least for some earlier 2.6 kernels and
> > some of the low latency patchkit 2.4 kernels.
> > 
> > So it is certainly possible to do it without preemption.
> 
> Yes, as Ingo stated many times, addition cond_resched() to
> might_sleep() does achieve the "usable" latencies  -- and obviously
> that's hacky.

But it's the only way to get practial(1)low latency benefit to everybody - 
not just a few selected few who know how to set the right 
kernel options or do other incarnations and willfully give up performance
and stability.

It is basically similar to why we often avoid kernel tunables - the
kernel must work well out of the box.

(1) = not necessarily provable, but good enough at least for jack et.al.

> 
> So, the only question is whether changing (inserting) cond_resched()
> to all points would be acceptable even if it results in a big amount
> of changes...

We've been doing that for years, haven't we. The main criterium
should be not to change code, but to not affect performance considerably.

-Andi
