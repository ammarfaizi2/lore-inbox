Return-Path: <linux-kernel-owner+w=401wt.eu-S1422687AbWLUNCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWLUNCq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 08:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbWLUNCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 08:02:46 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51173 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422687AbWLUNCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 08:02:45 -0500
Date: Thu, 21 Dec 2006 14:00:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Len Brown <len.brown@intel.com>
Subject: Re: [patch] sched: fix bad missed wakeups in the i386, x86_64, ia64, ACPI and APM idle code
Message-ID: <20061221130012.GA21854@elte.hu>
References: <20061221121656.GA9263@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221121656.GA9263@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> CPU idle wakeup very much depends on ordered memory ops, the clearing 
> of the TS_POLLING flag must always be done before we test 
> need_resched() and hit the idle instruction(s). [Symmetrically, the 
> wakeup code needs to set NEED_RESCHED before it tests the TS_POLLING 
> flag, so memory ordering is paramount.]

Btw., this means that an smp_rmb() ought to be enough too. (I sent such 
a test-patch to Fernando.) Also, i'd like the change to smp_rmb() be 
done separately from the fix so that we have the most-conservative 
variant in and thus it becomes bisectable. I'd like to avoid another few 
months of latency for fixing yet another bug in this area...

	Ingo
