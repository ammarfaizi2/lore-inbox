Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbUCELQL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 06:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbUCELQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 06:16:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:11210 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262572AbUCELQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 06:16:09 -0500
Subject: Re: [PATCH] For test only: pmac_zilog fixes (cups lockup at boot):
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Matthias Urlichs <smurf@smurf.noris.de>,
       =?ISO-8859-1?Q?Martin-=C9ric?= Racine <q-funk@pp.fishpool.fi>
In-Reply-To: <20040305094807.E22156@flint.arm.linux.org.uk>
References: <1078473270.5703.57.camel@gaston>
	 <20040305085838.B22156@flint.arm.linux.org.uk>
	 <1078477504.5700.69.camel@gaston>
	 <20040305092422.C22156@flint.arm.linux.org.uk>
	 <1078478951.5698.82.camel@gaston>
	 <20040305094807.E22156@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1078485287.5698.96.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 22:14:47 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-05 at 20:48, Russell King wrote:
> On Fri, Mar 05, 2004 at 08:29:12PM +1100, Benjamin Herrenschmidt wrote:
> > 
> > > Yes, I know - but the point is its impossible to review, and I think
> > > you at least have an extra level of locking which isn't needed.
> > > 
> > > But I wouldn't know because of the huge number of changes which make
> > > it impossible to read.
> > 
> > That semaphore locking is only used to guard open/close against the
> > power management callback. It greatly simplify the deal with the shared
> > irq (the irq is shared between both ports). It's not used during
> > normal operations.
> 
> Err.  What power management callback?  Are you not using uart_suspend_port
> and uart_resume_port?
>
> These functions do all the locking for you already - using state->sem.

Well... I could, but I have additional crap related to shutting
the SCC down. I need to disable_irq() at the irq controller level
after both ports have been shut down only, since a down SCC would
leave a dangling irq line...

> Like I said, I can't see the twigs for the forest due to the shear
> noise caused by the up -> uap change.

Yah, I know. Difficult to split though. I'd suggest you just look
at the driver as a whole after the patch is applied ;)

Ben.


