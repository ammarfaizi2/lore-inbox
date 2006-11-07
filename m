Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753177AbWKGUaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbWKGUaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbWKGUaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:30:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48068 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1753192AbWKGUax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:30:53 -0500
Date: Tue, 7 Nov 2006 21:29:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Message-ID: <20061107202943.GA4753@elte.hu>
References: <200611032205.kA3M5wmJ003178@shell0.pdx.osdl.net> <20061107073248.GB5148@elte.hu> <Pine.LNX.4.64.0611070943160.3791@schroedinger.engr.sgi.com> <20061107093112.A3262@unix-os.sc.intel.com> <Pine.LNX.4.64.0611070954210.3791@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611070954210.3791@schroedinger.engr.sgi.com>
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

> On Tue, 7 Nov 2006, Siddha, Suresh B wrote:
> 
> > Christoph, DECLARE_TASKLET that you had atleast needs to be per 
> > cpu.. Not sure if there are any other concerns.
> 
> Nope. Tasklets scheduled and executed per cpu. These are the former 
> bottom halves. See tasklet_schedule in kernel/softirq.c

no, they are "task"-lets. Softirqs are the equivalent of former 
bottom-halves.

a tasklet may run on any CPU but its execution is globally serialized - 
it's not what we want to do in the scheduler.

	Ingo
