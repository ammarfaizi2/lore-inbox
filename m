Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262875AbVCWIbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbVCWIbK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 03:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVCWIbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 03:31:10 -0500
Received: from smtp.nedstat.nl ([194.109.98.184]:20871 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S262875AbVCWIbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 03:31:08 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Peter Zijlstra <peter@programming.kicks-ass.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <20050323071604.GA32712@elte.hu>
References: <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu>
	 <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu>
	 <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu>
	 <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu>
	 <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu>
	 <20050323071604.GA32712@elte.hu>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 09:29:53 +0100
Message-Id: <1111566593.14156.2.camel@nspc0585.nedstat.nl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 08:16 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > That callback will be queued on CPU#2 - while the task still keeps
> > current->rcu_data of CPU#1. It also means that CPU#2's read counter
> > did _not_ get increased - and a too short grace period may occur.
> > 
> > it seems to me that that only safe method is to pick an 'RCU CPU' when
> > first entering the read section, and then sticking to it, no matter
> > where the task gets migrated to. Or to 'migrate' the +1 read count
> > from one CPU to the other, within the scheduler.
> 
> i think the 'migrate read-count' method is not adequate either, because
> all callbacks queued within an RCU read section must be called after the
> lock has been dropped - while with the migration method CPU#1 would be
> free to process callbacks queued in the RCU read section still active on
> CPU#2.
> 
how about keeping the rcu callback list in process context and only
splice it to a global (per cpu) list on rcu_read_unlock?

Kind regrads,

Peter Zijlstra

-- 
Peter Zijlstra <peter@programming.kicks-ass.net>

