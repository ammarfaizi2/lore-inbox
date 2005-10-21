Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbVJUGDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVJUGDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 02:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVJUGDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 02:03:24 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:51190 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964878AbVJUGDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 02:03:23 -0400
Date: Fri, 21 Oct 2005 02:03:13 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: john stultz <johnstul@us.ibm.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <20051020193214.GA21613@elte.hu>
Message-ID: <Pine.LNX.4.58.0510210157080.1946@localhost.localdomain>
References: <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain>
 <20051020073416.GA28581@elte.hu> <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
 <20051020080107.GA31342@elte.hu> <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain>
 <20051020085955.GB2903@elte.hu> <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
 <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain>
 <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain>
 <1129826750.27168.163.camel@cog.beaverton.ibm.com> <20051020193214.GA21613@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Oct 2005, Ingo Molnar wrote:

>
> * john stultz <johnstul@us.ibm.com> wrote:
>
> > > > John, would this cause any problems to keep cycle_t at s64?
> > >
> > > I mean at u64.
> >
> > Performance would be the only concern. It had been a u64 before I
> > started optimizing the code a bit.
>
> no, this is really a bad optimization that causes unrobustness.
> Correctness and robustness comes first. It is so easy to cause a
> 500-1000msec delay in the kernel, due to a bad driver or anything. The
> timekeeping code should not break like that.
>


FYI,

With rc4-rt13 and changing cycle_t to u64, my machine ran all night
without one backward step.  Since it use to show up after a couple of
hours, I would say that this is the fix.

John, Do you want me to take a crack at changing the periodic_hook into
using the ktimer code?  I understand Ingo's kernel much more than you, but
you definitely understand the timing code better than I.


Cheers,

-- Steve
