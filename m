Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWFXWRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWFXWRt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWFXWRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 18:17:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:65416 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751124AbWFXWRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 18:17:48 -0400
Date: Sun, 25 Jun 2006 00:12:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, john stultz <johnstul@us.ibm.com>
Subject: Re: More weird latency trace output (was Re: 2.6.17-rt1)
Message-ID: <20060624221235.GA23423@elte.hu>
References: <20060618070641.GA6759@elte.hu> <1150937848.2754.379.camel@mindpipe> <1150944663.2754.416.camel@mindpipe> <1151025892.17952.32.camel@mindpipe> <1151187320.2931.191.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151187320.2931.191.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Thu, 2006-06-22 at 21:24 -0400, Lee Revell wrote:
> > On Wed, 2006-06-21 at 22:51 -0400, Lee Revell wrote:
> > > How can the latency tracer be reporting 1898us max latency while the
> > > trace is of a 12us latency?  This must be a bug, correct?
> > 
> > I've found the bug.  The latency tracer uses get_cycles() for
> > timestamping, which uses rdtsc, which is unusable for timing on dual
> > core AMD64 machines due to the well known "unsynced TSCs" hardware bug.
> > 
> > Would a patch to convert the latency tracer to use gettimeofday() be
> > acceptable?
> 
> OK, I tried that and it oopses on boot - presumably the latency tracer 
> runs before clocksource infrastructure is initialized.
> 
> Does anyone have any suggestions at all as to what a proper solution 
> would look like?  Is no one interested in this problem?

does it get better if you boot with idle=poll? [that could work around 
the rdtsc drifting problem] Calling gettimeofday() from within the 
tracer is close to impossible - way too many opportunities for 
recursion. It's also pretty slow that way.

	Ingo
