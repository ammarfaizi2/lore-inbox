Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVEXQPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVEXQPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVEXQNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:13:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65483 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262125AbVEXQM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:12:26 -0400
Date: Tue, 24 May 2005 18:11:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Voluntary Kernel Preemption, 2.6.12-rc4-mm2
Message-ID: <20050524161145.GA23373@elte.hu>
References: <20050524121541.GA17049@elte.hu> <20050524132105.GA29477@elte.hu> <20050524145636.GA15943@infradead.org> <20050524150950.GA10736@elte.hu> <4293466B.5070200@yahoo.com.au> <20050524153937.GA14792@elte.hu> <42934F4F.2060305@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42934F4F.2060305@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >remove it if it's not being used, but right now the only choice that 
> >distributions have is no preemption or full-blown CONFIG_PREEMPT. Ask 
> >the kernel maintainers at SuSE why they havent enabled CONFIG_PREEMPT in 
> >their kernels.
> >
> 
> I guess it is a number of reasons. Probably the main one had 
> traditionally been the chance of bugs. I guess the next big one is 
> return on overhead (ie. the scheduling latency soon runs into the 
> problem of long critical sections), although thanks to you and others, 
> I understand that is becoming less and less of an issue over time too.
> 
> If a new SUSE kernel branch was started from 2.6.12 with VP turned on 
> rather than PREEMPT then I would probably argue against it a little 
> bit ;)

dont think of scheduling latencies as a binary thing a'ka "do we have 
good preemption latencies". It's a continuum, with almost a continuum 
number of techniques. One thing is sure: close to one end of the 
spectrum we have PREEMPT_NONE, and pretty close to the other end of the 
spectrum we have PREEMPT_RT.

both PREEMPT_VOLUNTARY and CONFIG_PREEMPT are at arbitrary points within 
that continuum, with different cost/benefit tradeoffs. Neither is 
perfect, and both are 'ugly' in the theoretical sense.

now, i dont intend to populate our .config with a continuum number of 
preemption models ;) But clearly the past 4 years have shown that no 
major distro was brave enough to go CONFIG_PREEMPT, so a solution 
inbetween is needed. -VP is precisely such a (very low-impact) solution.  
It has a ridiculously low impact:

 include/linux/kernel.h | 18 +++++++++++----

we already talked an order of magnitude more about this feature than its 
size is (with help text included :). Lets go with it and let people know 
that the water is fine. If it's unused it can be zapped easily.

	Ingo
