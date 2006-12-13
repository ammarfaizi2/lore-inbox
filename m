Return-Path: <linux-kernel-owner+w=401wt.eu-S1751806AbWLMXdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWLMXdz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWLMXdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:33:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37339 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbWLMXdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:33:54 -0500
Date: Thu, 14 Dec 2006 00:31:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: nickpiggin@yahoo.com.au, vatsa@in.ibm.com, clameter@sgi.com,
       tglx@linutronix.de, arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch: dynticks: idle load balancing
Message-ID: <20061213233157.GA20470@elte.hu>
References: <20061211155304.A31760@unix-os.sc.intel.com> <20061213224317.GA2986@elte.hu> <20061213231316.GA13849@elte.hu> <20061213150314.B12795@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213150314.B12795@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> On Thu, Dec 14, 2006 at 12:13:16AM +0100, Ingo Molnar wrote:
> > there's another bug as well: in schedule() resched_cpu() is called with 
> > the current runqueue held in two places, which is deadlock potential. 
> 
> resched_cpu() was getting called after prepare_task_switch() which 
> releases the current runqueue lock. Isn't it?

no, it doesnt release it. The finish stage is what releases it.

the other problem is load_balance(): there this_rq is locked and you 
call resched_cpu() unconditionally.

	Ingo
