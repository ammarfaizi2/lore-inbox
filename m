Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWIUHjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWIUHjt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWIUHjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:39:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:1934 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750802AbWIUHjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:39:48 -0400
Date: Thu, 21 Sep 2006 09:31:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060921073130.GB27280@elte.hu>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <20060921065402.GA22089@elte.hu> <20060921071838.GA10337@gnuppy.monkey.org> <20060921072743.GB10337@gnuppy.monkey.org> <20060921072216.GB25835@elte.hu> <20060921073522.GD10337@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921073522.GD10337@gnuppy.monkey.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> On Thu, Sep 21, 2006 at 09:22:16AM +0200, Ingo Molnar wrote:
> > * Bill Huey <billh@gnuppy.monkey.org> wrote:
> > 
> > > Also, triggering a panic() at the beginning of the rt mutex acquire 
> > > was very useful since it made "in_atomic()" violations an explicit 
> > > error stopping the machine. Stack traces started to get really crazy 
> > > in this preemptive kernel with all sorts of things running unlike the 
> > > non-preemptive kernel and it was time consuming to figure out the real 
> > > stuff from the noise in the stack trace.
> > 
> > well you should absolutely have serial console if you effectively want 
> > to hack the Linux kernel. And in the serial console log you should 
> > search for stacktraces top-down, and concentrate on the first one - any 
> > subsequent one might be collateral damage of the first one.
> 
> Of course I did that. I'm not that stupid. :) The stack traces, even 
> with your above suggestions were too many and I had to break it down a 
> bug at a time, stack trace at a time, since I realize problems earlier 
> could clash and trigger other unrelated problems.
> 
> It was even problematic with the serial console on which is why I did 
> that. Maybe it was an artifact of having both the serial console and 
> video consoles on ?

perhaps the real problem was that you got 'intermixed' stackdumps from 
multiple CPUs crashing at once? Or was it simply the myriads of 
stackdumps? The myriads effect is easy to solve: only look at the first 
one, and fix them one by one :-)

	Ingo
