Return-Path: <linux-kernel-owner+w=401wt.eu-S932931AbWLSUPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbWLSUPp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 15:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932933AbWLSUPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 15:15:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56412 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932931AbWLSUPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 15:15:44 -0500
Date: Tue, 19 Dec 2006 21:12:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: vatsa@in.ibm.com, clameter@sgi.com, tglx@linutronix.de,
       arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch: dynticks: idle load balancing
Message-ID: <20061219201247.GA12648@elte.hu>
References: <20061211155304.A31760@unix-os.sc.intel.com> <20061213224317.GA2986@elte.hu> <20061213231316.GA13849@elte.hu> <20061213150314.B12795@unix-os.sc.intel.com> <20061213233157.GA20470@elte.hu> <20061213151926.C12795@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213151926.C12795@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0041]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


find below another bugfix for the dynticks-sched patch. (this bug caused 
crashed under a stresstest)

	Ingo

---
 kernel/sched.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -3015,6 +3015,8 @@ static void run_rebalance_domains(struct
 restart:
 	if (idle_cpu(local_cpu) && notick.load_balancer == local_cpu) {
 		this_cpu = first_cpu(cpus);
+		if (unlikely(this_cpu >= NR_CPUS))
+			return;
 		this_rq = cpu_rq(this_cpu);
 		cpu_clear(this_cpu, cpus);
 	}

