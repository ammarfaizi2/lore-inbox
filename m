Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbVI3GQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVI3GQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 02:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVI3GQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 02:16:52 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:37326
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932396AbVI3GQw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 02:16:52 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: paulmck@us.ibm.com
Cc: George Anzinger <george@mvista.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Steven Rostedt <rostdt@goodmis.org>,
       Jeff Dike <jdike@addtoit.com>
In-Reply-To: <20050930014636.GV8177@us.ibm.com>
References: <20050818060126.GA13152@elte.hu>
	 <1124470574.17311.4.camel@twins> <1124476205.17311.8.camel@twins>
	 <20050819184334.GG1298@us.ibm.com> <1124566045.17311.11.camel@twins>
	 <20050820212446.GA9822@ccure.user-mode-linux.org>
	 <1127980463.14695.6.camel@twins> <20050930010041.GS8177@us.ibm.com>
	 <1128042449.15115.375.camel@tglx.tec.linutronix.de>
	 <20050930014636.GV8177@us.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 30 Sep 2005 08:17:36 +0200
Message-Id: <1128061056.15115.388.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 18:46 -0700, Paul E. McKenney wrote:
> > you are not the culprit :)
> 
> Woo-hoo!!!  Exonerated!!!  This time, anyway...  ;-)

My pleasure :)


> > It can not be run from hardirq context, as it takes a lot of locks
> > (especially our favorites: tasklist_lock and sighand->siglock). :(
> > 
> > Maybe another playground for rcu, but it might also be solved by some
> > other mechanism for accounting and delayed execution in the PREEMPT_RT
> > case.
> 
> Certainly check_thread_timers() and check_process_timers() are playing
> with a number of task_struct fields, so it is not immediately clear
> to me how to safely replace tasklist_lock with RCU, at least not with
> a simple and small patch.
> 
> What did you have in mind for delayed execution?

Do only the time check in hard irq context and defer the lock protected
operations to a softirq context. Have to look deeper at the details
though.

tglx




