Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030744AbWI0UO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030744AbWI0UO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030751AbWI0UO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:14:57 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:51104 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030744AbWI0UO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:14:56 -0400
Date: Wed, 27 Sep 2006 22:07:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Markus Schoder <lists@gammarayburst.de>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM with 2.6.18: BUG: scheduling while atomic
Message-ID: <20060927200713.GA20282@elte.hu>
References: <200609271444.20845.lists@gammarayburst.de> <20060927124904.1a0d94c2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927124904.1a0d94c2.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50,EXCUSE_3 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.1 EXCUSE_3               BODY: Claims you can be removed from the list
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > Sep 24 13:29:24 gondolin kernel:  [<ffffffff8026ef30>] default_idle+0x0/0x60
> > Sep 24 13:29:24 gondolin kernel:  [<ffffffff8024f276>] cpu_idle+0x96/0xb0
> > Sep 24 13:29:24 gondolin kernel:  [<ffffffff805e5641>] start_secondary+0x4f1/0x500
> 
> This might indicate that some code somewhere forgot to do 
> spin_unlock/preempt_enable/kunmap_atomic/whatever.
> 
> Ingo, do you have a current version of the patch which allows us to 
> locate the culprit?

first the nvidia thing needs to be removed from that kernel. (wouldnt be 
the first time it messes up the preempt count)

i have the PREEMPT_TRACE feature in the latency-tracer patch-queue. I've 
merged it to 2.6.18-mm1 and have uploaded a combo patch to:
	
 http://redhat.com/~mingo/latency-tracing-patches/latency-tracing-2.6.18-mm1.patch

CONFIG_DEBUG_PREEMPT should be enabled, that will activate 
CONFIG_PREEMPT_TRACE. No need to enable latency tracing itself.

	Ingo
