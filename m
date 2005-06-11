Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVFKBHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVFKBHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 21:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVFKBHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 21:07:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:22659 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261496AbVFKBHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 21:07:33 -0400
Date: Fri, 10 Jun 2005 18:07:55 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050611010755.GN1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <1118436338.6423.48.camel@mindpipe> <20050610231647.GK1300@us.ibm.com> <20050610232628.GA23512@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610232628.GA23512@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 04:26:28PM -0700, Bill Huey wrote:
> On Fri, Jun 10, 2005 at 04:16:47PM -0700, Paul E. McKenney wrote:
> > Sounds like I need to add "antisocial hardware" to the list of
> > things that need to be inspected to validate realtime latencies.
> 
> And anti-social memory controllers (cough G5 Macs)

OK, the list now reads:

	Each of the following categories of code might need to be
	inspected:

	a.	The low-level interrupt-handing code.

	b.	The realtime process scheduler.

	c.	Any code that disables interrupts.

	d.	Any code that disables preemption.

	e.	Any code that holds a lock, mutex, semaphore, or other
		resource that is needed by the code implementing your
		new feature.

	f.	Any code that manipulates hardware that can stall the
		bus, delay interrupts, or otherwise interfere with
		forward progress.  Note that it is also necessary to
		inspect user-level code that directly manipulates such
		hardware.

I added point "f".  Does that cover it?

						Thanx, Paul
