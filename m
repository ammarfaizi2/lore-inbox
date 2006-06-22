Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWFVHEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWFVHEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 03:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWFVHEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 03:04:37 -0400
Received: from www.osadl.org ([213.239.205.134]:10460 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751711AbWFVHEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 03:04:36 -0400
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Esben Nielsen <nielsen.esben@gogglemail.com>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606212341410.10077@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>
	 <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
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
Content-Type: text/plain
Date: Thu, 22 Jun 2006 09:06:12 +0200
Message-Id: <1150959972.25491.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 00:35 +0100, Esben Nielsen wrote:
> On Wed, 21 Jun 2006, Thomas Gleixner wrote:
> 
> > On Wed, 2006-06-21 at 22:29 +0100, Esben Nielsen wrote:
> >>> Find an version against the code in -mm below. Not too much tested yet.
> >>
> >> What if setscheduler is called from interrup context as in the hrt timers?
> >
> > It simply gets stuff going, nothing else.
> >
> What I mean is that we will then do the full priority inheritance boost 
> with interrupts off.

Only in the case when its called from IRQ context.

> Before setscheduler() was O(1), now it is O(<lock depth of what ever lock 
> the target task might be locked on>).
>
> This is not a problem for your use of setscheduler() as the task involved 
> only can be blocked on kernel mutexes, but when the function is used on a 
> userspace process the lock depth can be deep.

Damn, I missed that this is still in the irq off section, when called
from do_sched_setscheduler().

Good catch. I fix that.

	tglx


