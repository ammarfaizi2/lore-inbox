Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWGCJNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWGCJNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 05:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWGCJNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 05:13:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750998AbWGCJNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 05:13:02 -0400
Date: Mon, 3 Jul 2006 02:12:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: tglx@linutronix.de, torvalds@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
Message-Id: <20060703021239.7c5fceec.akpm@osdl.org>
In-Reply-To: <20060703090343.GA31274@flint.arm.linux.org.uk>
References: <1151885928.24611.24.camel@localhost.localdomain>
	<20060702173527.cbdbf0e1.akpm@osdl.org>
	<20060703074155.GA28235@flint.arm.linux.org.uk>
	<20060703005542.62df5673.akpm@osdl.org>
	<20060703090343.GA31274@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 10:03:43 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Mon, Jul 03, 2006 at 12:55:42AM -0700, Andrew Morton wrote:
> > On Mon, 3 Jul 2006 08:41:55 +0100
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > 
> > > On Sun, Jul 02, 2006 at 05:35:27PM -0700, Andrew Morton wrote:
> > > > This is not exactly a thing of beauty either.  It's much cleaner to use
> > > > __attribute__((weak)), but that will add an empty call-return to everyone's
> > > > interrupts.
> > > 
> > > Let's not go overboard with the weak stuff - it does not get removed
> > > at link time, so it remains as dead code in the kernel image.
> > 
> > Well.
> > 
> > void handle_dynamic_tick(struct irqaction *action)
> > {
> > }
> > 
> > consumes one byte, doesn't it?  That's not very far overboard ;)
> 
> ROTFL!
> 
> All the word isn't x86.  On ARM it's 3 words for the stack setup and
> one for the tear down, so 16 bytes, assuming the function doesn't
> return a value.  If it does, add another 4 bytes.
> 

Well yes, and there's also compiler-added alignment padding after the
function itself.

It's still pretty small beer.  It's a judgement call, which is why I
recommended it not be used here.

A lot of places where it's used (and useful) are in __init setup code.
