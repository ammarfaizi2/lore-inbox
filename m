Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWIUHCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWIUHCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWIUHCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:02:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:26605 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750755AbWIUHCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:02:41 -0400
Date: Thu, 21 Sep 2006 08:54:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060921065402.GA22089@elte.hu>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921065624.GA9841@gnuppy.monkey.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4945]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> On Wed, Sep 20, 2006 at 04:19:07PM +0200, Ingo Molnar wrote:
> > I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded 
> > from the usual place:
> ... 
> > as usual, bugreports, fixes and suggestions are welcome,
> 
> Speaking of which...
> 
> This patch moves put_task_struct() reaping into a thread instead of an 
> RCU callback function [...]

had some time to think about it since yesterday: RCU reaping is done in 
softirqs (check out the softirq-rcu threads on your -rt box), that's why 
i removed the delayed-task-drop code to begin with. Now i dont doubt 
that you saw crashes under 2.6.17 - but did you manage to figure out 
what the reason is for those crashes, and do those reasons really 
necessiate the pushing of task-reapdown into yet another set of kernel 
threads?

	Ingo
