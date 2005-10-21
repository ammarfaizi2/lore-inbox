Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVJUH5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVJUH5j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 03:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVJUH5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 03:57:39 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:24505 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964903AbVJUH5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 03:57:39 -0400
Date: Fri, 21 Oct 2005 03:57:20 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <1129880977.16447.116.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.58.0510210355350.3903@localhost.localdomain>
References: <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain> 
 <20051020073416.GA28581@elte.hu>  <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
  <20051020080107.GA31342@elte.hu>  <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain>
  <20051020085955.GB2903@elte.hu>  <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
  <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain> 
 <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain> 
 <1129826750.27168.163.camel@cog.beaverton.ibm.com>  <20051020193214.GA21613@elte.hu>
  <Pine.LNX.4.58.0510210157080.1946@localhost.localdomain>
 <1129880977.16447.116.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Oct 2005, Thomas Gleixner wrote:

> On Fri, 2005-10-21 at 02:03 -0400, Steven Rostedt wrote:
> > On Thu, 20 Oct 2005, Ingo Molnar wrote:
>
> > With rc4-rt13 and changing cycle_t to u64, my machine ran all night
> > without one backward step.  Since it use to show up after a couple of
> > hours, I would say that this is the fix.
> >
> > John, Do you want me to take a crack at changing the periodic_hook into
> > using the ktimer code?  I understand Ingo's kernel much more than you, but
> > you definitely understand the timing code better than I.
>
> Steve,
>
> I think the hook is too complex to move it into the timer interrupt
> context. We still have to reimplement the dynamic priority adjustment of
> the ktimer softirq in a clean way. Once this is done, we can move it
> over and set a proper priority up for that.
>

OK, but the u64 cycle_t should stay.  Even with the dynamic priority of
the softirq, a process with a super high priority that doesn't care about
the timing code can still make the periodic_hook delay for a few seconds.

-- Steve

