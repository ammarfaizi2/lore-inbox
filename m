Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVE3ML5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVE3ML5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 08:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVE3ML5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 08:11:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56015 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261501AbVE3MLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 08:11:39 -0400
Date: Mon, 30 May 2005 14:10:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Takashi Iwai <tiwai@suse.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: what is the -RT tree
Message-ID: <20050530121031.GA26255@elte.hu>
References: <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu> <20050527133122.GF86087@muc.de> <s5hwtpkwz4z.wl@alsa2.suse.de> <20050530095349.GK86087@muc.de> <20050530103347.GA13425@elte.hu> <20050530105618.GL86087@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530105618.GL86087@muc.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@muc.de> wrote:

> > > > Yes, as Ingo stated many times, addition cond_resched() to
> > > > might_sleep() does achieve the "usable" latencies  -- and 
> > > > obviously that's hacky.
> > >
> > > But it's the only way to get practial(1) low latency benefit to 
> > > everybody [...]
> > > (1) = not necessarily provable, but good enough at least for jack
> > > et.al.
> >
> > FYI, to get good latencies for jack you currently need the -RT tree and 
> > CONFIG_PREEMPT. (see Lee Revell's and Rui Nuno Capela's extensive tests)
> 
> Yeah, but you did a lot of (often unrelated to rt preempt) latency 
> fixes in RT that are not yet merged into mainline. When they are all 
> merged things might be very different. And then there can be probably 
> more fixes.

your argument above == cond_resched() in might_sleep() [ == VP ] is the
                       only way to get practical (e.g. jack) latencies.

my argument == i do agree that -VP is a step forward from PREEMPT_NONE
               (i'd not have written and released it otherwise), but is
               by no means enough for jack. You need at least the -RT 
               tree + CONFIG_PREEMPT to achieve good jack latencies.

in that sense your further argument that the -RT tree has more latency
related fixes has no relevance to this point: VP by itself is _not
enough_, having more latency fixes in the -RT tree (which mostly improve
CONFIG_PREEMPT and PREEMPT_RT) does not make VP any better of a solution
for jack's purposes.

[ and yes, those other latency fixes are not necessarily directly
  related to the PREEMPT_RT feature, because the -RT tree is a
  collection of latency related fixes and features, of which PREEMPT_RT
  is the biggest, but not the only one. ]

so my main point still remains: it's wishful thinking to expect the 
'standard' ( < CONFIG_PREEMPT) Linux kernel's latencies to improve well 
enough for jack.

perhaps there's some misunderstanding wrt. what the -RT tree is. The -RT 
tree is a collection of latency related patches and features: it 
introduces the VP and PREEMPT_RT features, and it also improves all 
preemption models (including CONFIG_PREEMPT). Furthermore, it includes 
(in-kernel) features to measure and debug latencies. It's called -RT 
because PREEMPT_RT is undoubtedly the 'crown jewel' feature, but that 
does not mean it's the only goal of the patchset.

	Ingo
