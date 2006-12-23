Return-Path: <linux-kernel-owner+w=401wt.eu-S1753100AbWLWKaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbWLWKaU (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 05:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbWLWKaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 05:30:20 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41645 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753084AbWLWKaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 05:30:18 -0500
Date: Sat, 23 Dec 2006 11:27:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com,
       suresh.b.siddha@intel.com, kenneth.w.chen@intel.com,
       tony.luck@intel.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sched: improve sched_clock() on i686
Message-ID: <20061223102707.GA20251@elte.hu>
References: <20061222104306.GC1895@frankl.hpl.hp.com> <20061222121920.GA3809@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222121920.GA3809@elte.hu>
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

> it's purely historic - the i686 sched_clock() implementation predates 
> the scheduler's ability to deal with non-synchronous per-CPU clocks. I 
> tried to fix that (a year ago) and it didnt work out - but i've 
> reviewed my old patch and now realize what the mistake was - the patch 
> below should work better.

that patch needs the small fix below as well.

	Ingo

Index: linux/include/asm-i386/bugs.h
===================================================================
--- linux.orig/include/asm-i386/bugs.h
+++ linux/include/asm-i386/bugs.h
@@ -160,7 +160,7 @@ static void __init check_config(void)
  * If we configured ourselves for a TSC, we'd better have one!
  */
 #ifdef CONFIG_X86_TSC
-	if (!cpu_has_tsc)
+	if (!cpu_has_tsc && !tsc_disable)
 		panic("Kernel compiled for Pentium+, requires TSC feature!");
 #endif
 

