Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbVCWJD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVCWJD7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbVCWJD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:03:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:20188 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262884AbVCWJDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:03:55 -0500
Date: Wed, 23 Mar 2005 10:03:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <peter@programming.kicks-ass.net>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050323090341.GA7960@elte.hu>
References: <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu> <20050323071604.GA32712@elte.hu> <1111566593.14156.2.camel@nspc0585.nedstat.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111566593.14156.2.camel@nspc0585.nedstat.nl>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peter@programming.kicks-ass.net> wrote:

> > i think the 'migrate read-count' method is not adequate either, because
> > all callbacks queued within an RCU read section must be called after the
> > lock has been dropped - while with the migration method CPU#1 would be
> > free to process callbacks queued in the RCU read section still active on
> > CPU#2.
>
> how about keeping the rcu callback list in process context and only
> splice it to a global (per cpu) list on rcu_read_unlock?

hm, that would indeed solve this problem. It would also solve the grace
period problem: all callbacks in the global (per-CPU) list are
immediately processable. Paul?

	Ingo
