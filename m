Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbWAXJoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWAXJoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWAXJoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:44:20 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43142 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030427AbWAXJoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:44:19 -0500
Subject: Re: RCU latency regression in 2.6.16-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060124092330.GA7060@elte.hu>
References: <1138089139.2771.78.camel@mindpipe>
	 <20060124075640.GA24806@elte.hu> <1138089483.2771.81.camel@mindpipe>
	 <20060124080157.GA25855@elte.hu> <1138090078.2771.88.camel@mindpipe>
	 <20060124081301.GC25855@elte.hu> <1138090527.2771.91.camel@mindpipe>
	 <20060124091730.GA31204@us.ibm.com>  <20060124092330.GA7060@elte.hu>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 04:44:15 -0500
Message-Id: <1138095856.2771.103.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 10:23 +0100, Ingo Molnar wrote:
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > > Have not tested yet but it appears that will reduce it substantially:
> > > 
> > > $ grep "dst_destroy (dst_rcu_free)" /proc/latency_trace | wc -l
> > > 3027
> > > 
> > > This implies the latency would be reduced to ~4ms, still not great but
> > > it will be overshadowed by rt_run_flush/rt_garbage_collect.
> > 
> > The other patch to try would be Dipankar Sarma's patch at:
> > 
> > 	http://marc.theaimsgroup.com/?l=linux-kernel&m=113657112726596&w=2
> > 
> > This patch was primarily designed to reduce memory overhead, but given 
> > that it tends to reduce batch size, it should also reduce latency.
> 
> if this solves Lee's problem, i think we should apply this as a fix, and 
> get it into v2.6.16. The patch looks straightforward and correct to me.
> 

Does not compile:

 CC      kernel/rcupdate.o
kernel/rcupdate.c:76: warning: 'struct rcu_state' declared inside parameter list
kernel/rcupdate.c:76: warning: its scope is only this definition or declaration, which is probably not what you want
kernel/rcupdate.c: In function 'call_rcu':
kernel/rcupdate.c:113: error: 'rcu_state' undeclared (first use in this function)
kernel/rcupdate.c:113: error: (Each undeclared identifier is reported only once
kernel/rcupdate.c:113: error: for each function it appears in.)
kernel/rcupdate.c: In function 'call_rcu_bh':
kernel/rcupdate.c:155: error: 'rcu_bh_state' undeclared (first use in this function)
make[1]: *** [kernel/rcupdate.o] Error 1
make: *** [kernel] Error 2

Lee

