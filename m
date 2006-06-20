Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWFTRUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWFTRUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWFTRUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:20:17 -0400
Received: from www.osadl.org ([213.239.205.134]:4799 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751437AbWFTRUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:20:15 -0400
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>
	 <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
	 <1150816429.6780.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
	 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 19:21:31 +0200
Message-Id: <1150824092.6780.255.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 19:12 +0100, Esben Nielsen wrote:
> >
> >>
> >> Another complicated design would be to make a task for each priority.
> >> Then the interrupt wakes the highest priority one, which handles the first
> >> callback and awakes the next one etc.
> >
> > Don't think that is necessary.
> 
> Me neither :-) Running sofhtirq-hrt at priority 99 - or whatever is 
> set by chrt - should be sufficient.

It is not, that was the reason, why we implemted it. You get arbitrary
latencies caused by timer storms.

I have to check, whether the priority is propagated when the softirq is
blocked on a lock. If not its a bug and has to be fixed.

	tglx


