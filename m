Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVE3Mkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVE3Mkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 08:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVE3Mkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 08:40:51 -0400
Received: from colin.muc.de ([193.149.48.1]:18180 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261490AbVE3Mkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 08:40:40 -0400
Date: 30 May 2005 14:40:38 +0200
Date: Mon, 30 May 2005 14:40:38 +0200
From: Andi Kleen <ak@muc.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Takashi Iwai <tiwai@suse.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: what is the -RT tree
Message-ID: <20050530124038.GM86087@muc.de>
References: <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu> <20050527133122.GF86087@muc.de> <s5hwtpkwz4z.wl@alsa2.suse.de> <20050530095349.GK86087@muc.de> <20050530103347.GA13425@elte.hu> <20050530105618.GL86087@muc.de> <20050530121031.GA26255@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530121031.GA26255@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 02:10:31PM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@muc.de> wrote:
> 
> > > > > Yes, as Ingo stated many times, addition cond_resched() to
> > > > > might_sleep() does achieve the "usable" latencies  -- and 
> > > > > obviously that's hacky.
> > > >
> > > > But it's the only way to get practial(1) low latency benefit to 
> > > > everybody [...]
> > > > (1) = not necessarily provable, but good enough at least for jack
> > > > et.al.
> > >
> > > FYI, to get good latencies for jack you currently need the -RT tree and 
> > > CONFIG_PREEMPT. (see Lee Revell's and Rui Nuno Capela's extensive tests)
> > 
> > Yeah, but you did a lot of (often unrelated to rt preempt) latency 
> > fixes in RT that are not yet merged into mainline. When they are all 
> > merged things might be very different. And then there can be probably 
> > more fixes.
> 
> your argument above == cond_resched() in might_sleep() [ == VP ] is the
>                        only way to get practical (e.g. jack) latencies.

My argument was basically that we have no other choice than
to fix it anyways, since the standard kernel has to be usable
in this regard.

(it is similar to that we e.g. don't do separate "server VM" and "desktop VM"s
although it would be sometimes tempting. after all one wants a kernel
that works well on a variety of workloads and doesn't need to extensive
hand tuning)

> 
> my argument == i do agree that -VP is a step forward from PREEMPT_NONE
>                (i'd not have written and released it otherwise), but is
>                by no means enough for jack. You need at least the -RT 
>                tree + CONFIG_PREEMPT to achieve good jack latencies.

Ok where are the big issues left? 

Stuff where old-style preempt helps (= not scheduling during long code without
single big lock) can be usually fixed without too much effort with
cond_resched()s.  Don't you agree on that? 

Your argument of it being more ongoing work to fix latencies again
is a good one, but again I see no alternative to it since the 
standard well-performing kernel cannot be "abandoned" in this regard.

> perhaps there's some misunderstanding wrt. what the -RT tree is. The -RT 
> tree is a collection of latency related patches and features: it 
> introduces the VP and PREEMPT_RT features, and it also improves all 
> preemption models (including CONFIG_PREEMPT). Furthermore, it includes 
> (in-kernel) features to measure and debug latencies. It's called -RT 
> because PREEMPT_RT is undoubtedly the 'crown jewel' feature, but that 
> does not mean it's the only goal of the patchset.

Yes, I understand that. But because of that it is not really
fair to compare the standard kernel to RT tree with all bells and whistles
enabled. I think it would be much better if RT was considered
as individual pieces, not all or nothing.

-Andi
