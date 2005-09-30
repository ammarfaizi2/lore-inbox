Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVI3BGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVI3BGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVI3BGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:06:48 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:41164
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750799AbVI3BGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:06:47 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: paulmck@us.ibm.com
Cc: George Anzinger <george@mvista.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Steven Rostedt <rostdt@goodmis.org>,
       Jeff Dike <jdike@addtoit.com>
In-Reply-To: <20050930010041.GS8177@us.ibm.com>
References: <20050818060126.GA13152@elte.hu>
	 <1124470574.17311.4.camel@twins> <1124476205.17311.8.camel@twins>
	 <20050819184334.GG1298@us.ibm.com> <1124566045.17311.11.camel@twins>
	 <20050820212446.GA9822@ccure.user-mode-linux.org>
	 <1127980463.14695.6.camel@twins>  <20050930010041.GS8177@us.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 30 Sep 2005 03:07:29 +0200
Message-Id: <1128042449.15115.375.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 18:00 -0700, Paul E. McKenney wrote:
> > Even with a current -rt (2.6.14-rc2-rt5) UML does not run. The issue is
> > indeed (as jeff pointed out) that VTALRM is never send. The small test
> > programm below illustrates this.
> > 
> > On a non-rt kernel it completed in 1 second.
> > On a -rt kernel it waits at infinitum.
> 
> Will play with it and see what I broke...

Paul, 

you are not the culprit :)

The run_posix_cpu_timers(p) call is #ifdef'd out with PREEMPT_RT. 

Thats a hard to fix issue. 

It can not be run from hardirq context, as it takes a lot of locks
(especially our favorites: tasklist_lock and sighand->siglock). :(

Maybe another playground for rcu, but it might also be solved by some
other mechanism for accounting and delayed execution in the PREEMPT_RT
case.

tglx


