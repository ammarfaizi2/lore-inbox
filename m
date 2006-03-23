Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbWCWFGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWCWFGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbWCWFGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:06:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45540 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965205AbWCWFGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:06:02 -0500
Date: Thu, 23 Mar 2006 06:03:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: cpu scheduler merge plans
Message-ID: <20060323050305.GA28128@elte.hu>
References: <20060322155122.2745649f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322155122.2745649f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50,RISK_FREE autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.2 RISK_FREE              BODY: Risk free.  Suuurreeee....
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> So it's that time again.  We need to decide which of the queued sched 
> patches should be merged into 2.6.17.
> 
> I have:
> 
> sched-fix-task-interactivity-calculation.patch
> small-schedule-microoptimization.patch
> #
> sched-implement-smpnice.patch
> sched-smpnice-apply-review-suggestions.patch
> sched-smpnice-fix-average-load-per-run-queue-calculations.patch
> sched-store-weighted-load-on-up.patch
> sched-add-discrete-weighted-cpu-load-function.patch
> sched-add-above-background-load-function.patch
>
> # Suresh had problems
> # con:
> sched-cleanup_task_activated.patch
> sched-make_task_noninteractive_use_sleep_type.patch
> sched-dont_decrease_idle_sleep_avg.patch
> sched-include_noninteractive_sleep_in_idle_detect.patch
> sched-remove-on-runqueue-requeueing.patch
> sched-activate-sched-batch-expired.patch
> sched-reduce-overhead-of-calc_load.patch
> #
> sched-fix-interactive-task-starvation.patch
> #
> # "strange load balancing problems": pwil3058@bigpond.net.au
> sched-new-sched-domain-for-representing-multi-core.patch
> sched-fix-group-power-for-allnodes_domains.patch
> x86-dont-use-cpuid2-to-determine-cache-info-if-cpuid4-is-supported.patch

strange as it may sound, all of these patches are fine with me. I really 
tried to find a questionable one (out of principle) but failed ;-)

there are two main risk areas: smpnice and the interactivity changes. 
[multi-core support ought to be risk-free] ['risk' here means some 'oh 
sh*t' conceptual problem that could cause big head-scratching shortly 
before 2.6.17 is released, not some easy to fix regression.]

Smpnice got alot of attention (and testing) and it's still a feature 
well worth having. The biggest risk comes from its relative complexity, 
but not doing the merge now wont reduce that risk. The biggest plus 
compared to the previous iteration is that smpnice is now essentially a 
NOP for same-nice-level workloads.

The interactivity changes had less testing (being relatively young), but
they are pretty well split up and they should solve the worst of the
starvation problems. So if any of those causes problems, it will be an
easy revert.

All in one, i'm not worried about any these changes.

> I'm not sure what the "Suresh had problems" comment refers to - 
> perhaps a now-removed patch.

i think that got resolved with a retest.

> afaik, the load balancing problem which Peter observed remains 
> unresolved.

this seems resolved too.

> Has smpnice had appropriate testing for regressions?

it's all green again, and it seems all parties that reported regressions 
before retested and there are no outstanding complaints. Having it in 
-mm longer probably wont cause additional increase in test coverage. (in 
fact bitrot will probably degrade its test status, so i wouldnt wait any 
longer with it. We've got the spotlight on it now, so lets try it 
upstream while it's still hot and in tester's attention span.)

	Ingo
