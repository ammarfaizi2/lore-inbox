Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751996AbWI3VoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbWI3VoJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 17:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbWI3VoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 17:44:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:458 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751991AbWI3VoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 17:44:05 -0400
Date: Sat, 30 Sep 2006 23:35:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 08/23] dynticks: prepare the RCU code
Message-ID: <20060930213541.GA13629@elte.hu>
References: <20060929234435.330586000@cruncher.tec.linutronix.de> <20060929234439.721237000@cruncher.tec.linutronix.de> <20060930013641.263a1cc3.akpm@osdl.org> <20060930122514.GC8763@in.ibm.com> <20060930130958.GA12021@elte.hu> <20060930135226.GF8763@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060930135226.GF8763@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dipankar Sarma <dipankar@in.ibm.com> wrote:

> > secondly, i think i saw functionality problems when RCU was not 
> > completed before going idle - for example synchronize_rcu() on 
> > another CPU would hang.
> 
> That is probably because of what I mention above. In the original 
> CONFIG_NO_IDLE_HZ, we don't go into a nohz state if there are RCUs 
> pending in that cpu.

hm. I just tried it and it seems completing RCU processing isnt even 
necessary. I'll drop the RCU hackery. If we need anything then in 
synchronize_rcu [which is a rare and slowpath op]: there (on NO_HZ) we 
should tickle all cpus via an smp_call_function().

	Ingo
