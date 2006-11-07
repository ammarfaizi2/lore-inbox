Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753169AbWKGUcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbWKGUcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbWKGUcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:32:46 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:17349 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1753169AbWKGUco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:32:44 -0500
Date: Tue, 7 Nov 2006 21:31:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Message-ID: <20061107203147.GB4753@elte.hu>
References: <200611032205.kA3M5wmJ003178@shell0.pdx.osdl.net> <20061107073248.GB5148@elte.hu> <Pine.LNX.4.64.0611070943160.3791@schroedinger.engr.sgi.com> <20061107093112.A3262@unix-os.sc.intel.com> <Pine.LNX.4.64.0611070954210.3791@schroedinger.engr.sgi.com> <20061107095049.B3262@unix-os.sc.intel.com> <Pine.LNX.4.64.0611071113390.4582@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611071113390.4582@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Lameter <clameter@sgi.com> wrote:

> Tasklets are scheduled on the same cpu that triggered the tasklet. 
> They are just moved to other processors if the processor goes down. So 
> that aspect is fine. We just need a tasklet struct per cpu.
> 
> User a per cpu tasklet to schedule rebalancing
> 
> Turns out that tasklets have a flag that only allows one instance to 
> run on all processors. So we need a tasklet structure for each 
> processor.

Per-CPU tasklets are equivalent to softirqs, with extra complexity and 
overhead ontop of it :-)

so please just introduce a rebalance softirq and attach the scheduling 
rebalance tick to it. But i'd suggest to re-test on the 4096-CPU box, 
maybe what 'fixed' your workload was the global serialization of the 
tasklet. With a per-CPU softirq approach we are i think back to the same 
situation that broke your system before.

	Ingo
