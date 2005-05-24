Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVEXPn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVEXPn2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVEXPlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:41:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53409 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262116AbVEXPj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:39:56 -0400
Date: Tue, 24 May 2005 17:39:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Voluntary Kernel Preemption, 2.6.12-rc4-mm2
Message-ID: <20050524153937.GA14792@elte.hu>
References: <20050524121541.GA17049@elte.hu> <20050524132105.GA29477@elte.hu> <20050524145636.GA15943@infradead.org> <20050524150950.GA10736@elte.hu> <4293466B.5070200@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4293466B.5070200@yahoo.com.au>
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

> > (then you must be disagreeing with CONFIG_PREEMPT too to a certain 
> > degree i guess?)
> 
> CONFIG_PREEMPT is different in that it explicitly defines and delimits 
> preempt critical sections, and allows maximum possible preemption 
> (whether or not the critical sections themselves are too big is not 
> really a CONFIG_PREEMPT issue).

from a theoretical POV, this categorization into 'preempt critical' vs.  
'preempt-noncritical' sections is pretty arbitrary too.

from a practical POV the amount of code that is non-preemptible is not 
controllable under CONFIG_PREEMPT. So the end-result is that 
CONFIG_PREEMPT is just as nondeterministic.

polling need_resched after reaching a zero preempt_count() is ugly 
(doing cond_resched() in might_sleep() is ugly too) - pretty much the 
only difference is overhead.

> Jamming in cond_resched in as many places as possible seems to work 
> quite well pragmatically, [...]

yes, and that's what matters. It's just a single #ifdef in kernel.h, and 
at least one major distribution would make use of it because it 
significantly improves soft-RT latencies at a minimal cost. We can 
remove it if it's not being used, but right now the only choice that 
distributions have is no preemption or full-blown CONFIG_PREEMPT. Ask 
the kernel maintainers at SuSE why they havent enabled CONFIG_PREEMPT in 
their kernels.

	Ingo
