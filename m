Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbWFVNdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbWFVNdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWFVNdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:33:43 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:10955 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161119AbWFVNdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:33:42 -0400
Date: Thu, 22 Jun 2006 09:33:05 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Thomas Gleixner <tglx@linutronix.de>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Esben Nielsen <nielsen.esben@gogglemail.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <1150959972.25491.40.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0606220930490.15236@gandalf.stny.rr.com>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain> 
 <1150824092.6780.255.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain> 
 <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain> 
 <1150907165.25491.4.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606212226291.7939@localhost.localdomain> 
 <1150922007.25491.24.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606212341410.10077@localhost.localdomain>
 <1150959972.25491.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Jun 2006, Thomas Gleixner wrote:

> On Thu, 2006-06-22 at 00:35 +0100, Esben Nielsen wrote:
> > On Wed, 21 Jun 2006, Thomas Gleixner wrote:
> >
> > > On Wed, 2006-06-21 at 22:29 +0100, Esben Nielsen wrote:
> > >>> Find an version against the code in -mm below. Not too much tested yet.
> > >>
> > >> What if setscheduler is called from interrup context as in the hrt timers?
> > >
> > > It simply gets stuff going, nothing else.
> > >
> > What I mean is that we will then do the full priority inheritance boost
> > with interrupts off.
>
> Only in the case when its called from IRQ context.
>

Uh, Thomas, we can't call rt_mutex_adjust_prio_chain from interrupt
context.  It grabs the wait_lock, which is documented not to be
called by interrupts.  So this can easily deadlock the system.

-- Steve

