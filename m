Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWIUH2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWIUH2D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWIUH2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:28:03 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:15804
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1750739AbWIUH2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:28:01 -0400
Date: Thu, 21 Sep 2006 00:27:43 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <simlo@phys.au.dk>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060921072743.GB10337@gnuppy.monkey.org>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <20060921065402.GA22089@elte.hu> <20060921071838.GA10337@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921071838.GA10337@gnuppy.monkey.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 12:18:40AM -0700, Bill Huey wrote:
> On Thu, Sep 21, 2006 at 08:54:02AM +0200, Ingo Molnar wrote:
> > that you saw crashes under 2.6.17 - but did you manage to figure out 
> > what the reason is for those crashes, and do those reasons really 
> > necessiate the pushing of task-reapdown into yet another set of kernel 
> > threads?
> 
> Unfortunately no. I even used Robert's .config on my machine. I added a
> disk controller and networking device driver just to boot into his
> configuration and I still couldn't replicated any of his kjournald problems
> at all. If I had his hardware I'd have a better way of replicating those
> problems and pound it out.

Robert's stack traces looked completely wrong as well which is why I gave up.
Symbols showing up in this stack traces should have been completely compiled
out.

Also, triggering a panic() at the beginning of the rt mutex acquire was
very useful since it made "in_atomic()" violations an explicit error stopping
the machine. Stack traces started to get really crazy in this preemptive
kernel with all sorts of things running unlike the non-preemptive kernel and
it was time consuming to figure out the real stuff from the noise in the
stack trace.

It made the stack traces smaller and more immediately local to the problem
logic. Then I discovered panic() didn't work correctly in -rt so I fixed that
as well. There were a lot of little breakdowns in 2.6.17-rt...

bill

