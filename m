Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263963AbUFFSc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUFFSc6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 14:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUFFSc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 14:32:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:17897 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263963AbUFFSc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 14:32:56 -0400
Date: Sun, 6 Jun 2004 11:32:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: ktech@wanadoo.es, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.6.7-rc1 breaks forcedeth
In-Reply-To: <40C360C4.7010703@pobox.com>
Message-ID: <Pine.LNX.4.58.0406061127200.7010@ppc970.osdl.org>
References: <E1BWmws-0005aN-Nw@mb04.in.mad.eresmas.com>
 <Pine.LNX.4.58.0406051958150.7010@ppc970.osdl.org> <40C360C4.7010703@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jun 2004, Jeff Garzik wrote:
> 
> So by definition it is a driver bug if the hardware is sending irqs 
> outside of when the driver indicates interest in the irq via 
> request_irq...free_irq.

Fair enough. It's sometimes easier to just register the driver irq early, 
though, to take care of all the cases that can happen. In particular, if 
you know you may have pending interrupts, and your irq handler is good at 
clearing them (it had better be), the easiest solution may well be to just 
register early.

> Also, PCI 2.3 devices have an "interrupt disable" bit in PCI_COMMAND 
> they can use, iff (a) it's implemented and (b) the driver isn't using MSI.

Now _this_ will help. However, I suspect it will help three years down the
line, not now. It should have been there originally, it would have solved 
a lot of problems.

		Linus
