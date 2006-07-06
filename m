Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWGFHaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWGFHaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 03:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWGFHaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 03:30:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:2960 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964947AbWGFHaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 03:30:03 -0400
Date: Thu, 6 Jul 2006 09:25:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, kmannth@gmail.com,
       linux-kernel@vger.kernel.org, tglx@linutronix.de,
       Natalie.Protasevich@UNISYS.com
Subject: Re: 2.6.17-mm6
Message-ID: <20060706072529.GA12317@elte.hu>
References: <20060705155037.7228aa48.akpm@osdl.org> <a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com> <20060705164457.60e6dbc2.akpm@osdl.org> <20060705164820.379a69ba.akpm@osdl.org> <a762e240607051705h33952e5elf6bd09c1ccea8ab4@mail.gmail.com> <20060705172545.815872b6.akpm@osdl.org> <m1u05v2st3.fsf@ebiederm.dsl.xmission.com> <20060705225905.53e61ca0.akpm@osdl.org> <20060705233123.dcb0a10b.akpm@osdl.org> <m17j2r2od0.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17j2r2od0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> What is scary is that at 1K cpus if we wind up using all of the irqs 
> we start consuming 1Gig of RAM.  At only 128 cpus we are still in the 
> 2M-15M territory, so that isn't too scary.  The point is that after a 
> certain put the memory usage for all of those counters goes insane.

we just need to move kernel_stat.irqs out of the per-cpu area and 
alloc_percpu() a counter pointer for each IRQ that is truly set up. If 
someone ends up using more than say 10,000 irqs we can reconsider. With 
10K irqs we'd have 10MB of stat counter footprint - that's reasonable.

	Ingo
