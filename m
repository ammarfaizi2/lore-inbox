Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWFSJca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWFSJca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWFSJca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:32:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14601 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932217AbWFSJc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:32:29 -0400
Date: Mon, 19 Jun 2006 10:32:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: gouji <gouji.masayuki@jp.fujitsu.com>,
       "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: About the fixes of /drivers/serial/8250.C in 2.6.17-rc6 for avoiding habbg-up
Message-ID: <20060619093219.GA26941@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	gouji <gouji.masayuki@jp.fujitsu.com>,
	'LKML' <linux-kernel@vger.kernel.org>
References: <000d01c6934c$f25c9870$f4647c0a@GOUJI> <1150708994.2503.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150708994.2503.3.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 10:23:14AM +0100, Alan Cox wrote:
> Ar Llu, 2006-06-19 am 12:03 +0900, ysgrifennodd gouji:
> > In /drivers/serial/8250.C of 2.6.17-rc6,
> > 
> > these fixes are adapted for avoinding  the problem of hang-up
> > while TTY write and console write from kernel conflicted.
> 
> Yes, there is a bug in this version that was not in the one I submitted,
> someone added an improvement.

I disagree - in the non-oops_in_progress case, your version and the
merged version are 100% identical - see

	http://marc.theaimsgroup.com/?l=linux-kernel&m=114657841432447&w=2

However, you never responded to my answers to your two questions in
that email, which came with the patch which was merged.

> > +   if (oops_in_progress) {
> > +      locked = spin_trylock_irqsave(&up->port.lock, flags);
> > +   } else
> > +      spin_lock_irqsave(&up->port.lock, flags);
> > +
> 
> It could always use spin_trylock_irqsave().  The oops in progress
> optimisation makes some sense initially but there are many console
> printk users that can occur during serial I/O in exceptional cases.
> 
> It's not an easy problem to solve with the current serial locking.

I don't have the initial email from ysgrifennodd gouji, and neither
do the lkml archives.  What's the problem?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
