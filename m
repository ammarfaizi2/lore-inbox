Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVF3BJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVF3BJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 21:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVF3BJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 21:09:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:15277 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262289AbVF3BJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 21:09:49 -0400
Subject: Re: kmalloc without GFP_xxx?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: rostedt@goodmis.org
Cc: Arjan van de Ven <arjan@infradead.org>, Denis Vlasenko <vda@ilport.com.ua>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain>
References: <200506291402.18064.vda@ilport.com.ua>
	 <1120043739.3196.32.camel@laptopd505.fenrus.org>
	 <200506291420.09956.vda@ilport.com.ua>
	 <1120045024.3196.34.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 11:02:53 +1000
Message-Id: <1120093373.31924.39.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-29 at 09:44 -0400, Steven Rostedt wrote:
> 
> On Wed, 29 Jun 2005, Arjan van de Ven wrote:
> > >
> > > but it sets irqs_disabled() IIRC.
> >
> > only spin_lock_irq() and co do.
> > not the simple spin_lock()
> >
> 
> It may be dangerous to use spin_lock with interrupts enabled, since you
> have to make sure that no interrupt ever grabs that lock.  Although I do
> recall seeing a few locks like this.  But even so, you can transfer the
> latency of the interrupts going off while holding that lock to another CPU
> which IMHO is a bad thing.  Also a simple spin_lock would disable
> preemption with CONFIG_PREEMPT set and that would make in_atomic fail.
> But to implement a kmalloc_auto you would always need to have a preempt
> count.

There are cases where using spin_lock instead of _irqsave version is a
matter of correctness. For example, the page table lock beeing always
taking without _irq is important to let the IPIs flow.

Ben.


