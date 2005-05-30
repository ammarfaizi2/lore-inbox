Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVE3KgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVE3KgD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 06:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVE3KgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 06:36:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17085 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261320AbVE3Kf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 06:35:57 -0400
Date: Mon, 30 May 2005 12:33:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Takashi Iwai <tiwai@suse.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050530103347.GA13425@elte.hu>
References: <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu> <20050527133122.GF86087@muc.de> <s5hwtpkwz4z.wl@alsa2.suse.de> <20050530095349.GK86087@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530095349.GK86087@muc.de>
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

> > Yes, as Ingo stated many times, addition cond_resched() to
> > might_sleep() does achieve the "usable" latencies  -- and obviously
> > that's hacky.
> 
> But it's the only way to get practial(1)low latency benefit to 
> everybody - not just a few selected few who know how to set the right 
> kernel options or do other incarnations and willfully give up 
> performance and stability.
> 
> It is basically similar to why we often avoid kernel tunables - the 
> kernel must work well out of the box.
> 
> (1) = not necessarily provable, but good enough at least for jack 
> et.al.

FYI, to get good latencies for jack you currently need the -RT tree and 
CONFIG_PREEMPT. (see Lee Revell's and Rui Nuno Capela's extensive tests)

In other words, cond_resched() in might_sleep() (PREEMPT_VOLUNTARY, 
which i announced Jul 9 last year) is _not_ good enough for 
advanced-audio (jack) users. PREEMPT_VOLUNTARY is mostly good enough for 
simple audio playback / gaming.

	Ingo
