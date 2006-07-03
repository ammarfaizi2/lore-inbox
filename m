Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWGCHz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWGCHz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 03:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWGCHz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 03:55:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750760AbWGCHzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 03:55:55 -0400
Date: Mon, 3 Jul 2006 00:55:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: tglx@linutronix.de, torvalds@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
Message-Id: <20060703005542.62df5673.akpm@osdl.org>
In-Reply-To: <20060703074155.GA28235@flint.arm.linux.org.uk>
References: <1151885928.24611.24.camel@localhost.localdomain>
	<20060702173527.cbdbf0e1.akpm@osdl.org>
	<20060703074155.GA28235@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 08:41:55 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Sun, Jul 02, 2006 at 05:35:27PM -0700, Andrew Morton wrote:
> > This is not exactly a thing of beauty either.  It's much cleaner to use
> > __attribute__((weak)), but that will add an empty call-return to everyone's
> > interrupts.
> 
> Let's not go overboard with the weak stuff - it does not get removed
> at link time, so it remains as dead code in the kernel image.

Well.

void handle_dynamic_tick(struct irqaction *action)
{
}

consumes one byte, doesn't it?  That's not very far overboard ;)

And we can optimise away that byte by doing what we do with cond_syscall().
