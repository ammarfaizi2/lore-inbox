Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWGKSDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWGKSDx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWGKSDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:03:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55305 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751150AbWGKSDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:03:52 -0400
Date: Tue, 11 Jul 2006 14:03:50 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Matt Helsley <matthltc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>, <tytso@us.ibm.com>,
       Darren Hart <dvhltc@us.ibm.com>, <oleg@tv-sign.ru>,
       Jes Sorensen <jes@sgi.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: SRCU-based notifier chains
In-Reply-To: <20060711173906.GC1288@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0607111357300.18796-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006, Paul E. McKenney wrote:

> Looks sane to me.  A couple of minor comments interspersed.

Okay, I'll submit it with a proper writeup.

> > +/*
> > + *	SRCU notifier chain routines.    Registration and unregistration
> > + *	use a mutex, and call_chain is synchronized by SRCU (no locks).
> > + */
> 
> Hmmm...  Probably my just failing to pay attention, but haven't noticed
> the double-header-comment style before.

As far as I know, I made it up.  It seemed appropriate, since the first 
header applies to the entire group of three routines that follow whereas 
the second header is kerneldoc just for the next function.

> >  /*
> > - * Notifier chains are of three types:
> > + * Notifier chains are of four types:
> 
> Is it possible to subsume one of the other three types?
> 
> Might not be, but have to ask...

In principle we could replace blocking notifiers, but in practice we
can't.

We can't just substitute one for the other for two reasons: SRCU notifiers
need special initialization which the blocking notifiers don't have, and
SRCU notifiers have different time/space tradeoffs which might not be
appropriate for all existing blocking notifiers.

Alan Stern

