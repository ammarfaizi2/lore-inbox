Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWGETk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWGETk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWGETk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:40:29 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:24968 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965005AbWGETk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:40:27 -0400
Date: Wed, 5 Jul 2006 21:35:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-ID: <20060705193551.GA13070@elte.hu>
References: <20060705084914.GA8798@elte.hu> <20060705023120.2b70add6.akpm@osdl.org> <20060705093259.GA11237@elte.hu> <20060705025349.eb88b237.akpm@osdl.org> <20060705102633.GA17975@elte.hu> <20060705113054.GA30919@elte.hu> <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705101059.66a762bf.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5003]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > > >   text            data    bss     dec             filename
> > > >   21172153        6077270 3081864 30331287        vmlinux.x32.after
> > > >   21198222        6077106 3081864 30357192        vmlinux.x32.before
> > > > 
> > > > with 851 callsites that's a 30.6 bytes win per call site (total 26K) - 
> > > > still not bad at all.
> > > 
> > > and that was with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled. With 
> > > optimize-for-size disabled the win goes up to 32.6 bytes (total 28K).
> > 
> > i also tried a config with the best size settings (disabling 
> > FRAME_POINTER, enabling CC_OPTIMIZE_FOR_SIZE), and this gives:
> > 
> >   text            data    bss     dec         filename
> >   20777768        6076042 3081864 29935674    vmlinux.x32.size.before
> >   20748140        6076178 3081864 29906182    vmlinux.x32.size.after
> > 
> > or a 34.8 bytes win per callsite (29K total).
> > 
> 
> With gcc-4.1.0 on i686, uninlining those three functions as per the 
> below patch _increases_ the allnoconfig vmlinux's .text from 833456 
> bytes to 833728.

that's just the effect of CONFIG_REGPARM and CONFIG_CC_OPTIMIZE_FOR_SIZE 
not being set in an allnoconfig. Once i set them the text size evens 
out:

 431348   60666   27276  519290   7ec7a vmlinux.x32.mini.before
 431359   60666   27276  519301   7ec85 vmlinux.x32.mini.after

compiling without CONFIG_REGPARM on i686 (if you care about text size) 
makes little sense. It penalizes function calls artificially.

	Ingo
