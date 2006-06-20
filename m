Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWFTUeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWFTUeJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWFTUeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:34:08 -0400
Received: from www.osadl.org ([213.239.205.134]:50625 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750988AbWFTUeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:34:06 -0400
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606201914170.11643@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>
	 <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
	 <1150816429.6780.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
	 <1150821311.6780.240.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606201914170.11643@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 22:35:31 +0200
Message-Id: <1150835732.6780.293.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 22:16 +0100, Esben Nielsen wrote:
> > We had this before and it is horrible.
> 
> "Horrible" in what respect?

Unbound latencies.

> > A nice solution would be to enqueue the timer into the task struct of
> > the thread which is target of the signal, wake that thread in a special
> > state which only runs the callback and then does the signal delivery.
> 
> What if the thread is running?

Well, do it in the return from interrupt path.

> Hmm, a practical thing to do would be to make a system where you can post 
> jobs in a thread. These jobs can then be done in thread context 
> around schedule or just before the task returns to user-space.

Thats basically what I said. But you have to take care of asynchronous
signal delivery. Therefor you need a special state. Also return to
userspace is not enough. You have to do the check in the return from
interrupt path, as you might delay async signals otherwise.

	tglx


