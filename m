Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWFHP5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWFHP5s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 11:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWFHP5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 11:57:48 -0400
Received: from www.osadl.org ([213.239.205.134]:38884 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964878AbWFHP5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 11:57:48 -0400
Subject: Re: [PATCH] genirq: Fix missing initializer for unmask in
	no_irq_chip
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060608152926.GA15337@flint.arm.linux.org.uk>
References: <20060517001310.GA12877@elte.hu>
	 <20060517221536.GA13444@elte.hu> <20060519145225.GA12703@elte.hu>
	 <20060607165456.GC13165@flint.arm.linux.org.uk>
	 <1149700829.5257.16.camel@localhost.localdomain>
	 <1149706650.5257.19.camel@localhost.localdomain>
	 <20060608113534.GA5050@flint.arm.linux.org.uk>
	 <1149768256.5257.37.camel@localhost.localdomain>
	 <20060608152926.GA15337@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 17:58:12 +0200
Message-Id: <1149782293.5257.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 16:29 +0100, Russell King wrote:
> > > This doesn't happen with the ARM IRQ subsystem because the "no chip"
> > > handlers are all pointing at a dummy function instead of being NULL.
> > > Could we do the same with genirq ?
> > 
> > We missed to initialize unmask, which causes problems on neponset.
> 
> Okay, with -rc6 + genirq + the following patch,

I uploaded proper fixups for those:
http://tglx.de/projects/armirq/2.6.17-rc6/patch-2.6.17-rc6-armirq3.patches.tar.bz2

>  it appears to work
> provided you don't stress it.  As soon as I load the system up with
> CF activity, a full-sized flood ping and hit "enter" a few times on
> the console, it locks up solid - no oops, no nothing, the machine
> just completely freezes.
> 
> This does not happen with the existing ARM IRQ code.
> 
> I'll try to debug this odd behaviour later today, but first I need to
> resurect my NMI oopser code for this platform.

Thanks,

	tglx


