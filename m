Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVGMDzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVGMDzD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 23:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVGMDzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 23:55:03 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:36297 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262538AbVGMDzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 23:55:01 -0400
Subject: Re: PREEMPT/PREEMPT_RT question
From: Steven Rostedt <rostedt@goodmis.org>
To: paulmck@us.ibm.com
Cc: shemminger@osdl.org, dipankar@in.ibm.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050713014627.GF1323@us.ibm.com>
References: <20050712163031.GA1323@us.ibm.com>
	 <1121187924.6917.75.camel@localhost.localdomain>
	 <20050712192832.GB1323@us.ibm.com>
	 <1121198657.3548.11.camel@localhost.localdomain>
	 <20050712213426.GD1323@us.ibm.com>
	 <1121212035.3548.34.camel@localhost.localdomain>
	 <20050713014627.GF1323@us.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 23:54:50 -0400
Message-Id: <1121226890.3548.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 18:46 -0700, Paul E. McKenney wrote:

> > If you are talking about scheduler_tick, then yes, it is called by the
> > timer interrupt which is a SA_NODELAY interrupt.  If you don't want to
> > get interrupted by the timer interrupt, then you will need to disable
> > interrupts for both. Since currently, the timer interrupt is the only
> > true hard interrupt in the PREEMPT_RT and that may not change.
> 
> OK, so if I take a spinlock in something invoked from scheduler_tick(),
> then any other acquisitions of that spinlock must disable hardware
> interrupts, right?

Yes, otherwise you could have a local CPU deadlock on a SMP machine. And
I would also say the same is true for any lock that is grabbed by the
timer interrupt or one of the functions it calls.

-- Steve


