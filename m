Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWHJUxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWHJUxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWHJUxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:53:35 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:22973 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932086AbWHJUxd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:53:33 -0400
Date: Thu, 10 Aug 2006 13:54:16 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Stelian Pop <stelian@popies.net>
Cc: Mike Christie <michaelc@cs.wisc.edu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, paulus@au1.ibm.com, anton@au1.ibm.com,
       pradeep@us.ibm.com, mashirle@us.ibm.com
Subject: Re: [PATCH] memory ordering in __kfifo primitives
Message-ID: <20060810205416.GL1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060810003310.GA3071@us.ibm.com> <44DAC892.7000100@cs.wisc.edu> <20060810134135.GB1298@us.ibm.com> <1155220013.1108.4.camel@localhost.localdomain> <20060810153915.GE1298@us.ibm.com> <1155224842.5393.13.camel@localhost.localdomain> <20060810161129.GF1298@us.ibm.com> <1155226984.5393.26.camel@localhost.localdomain> <20060810164752.GG1298@us.ibm.com> <1155241662.5198.11.camel@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1155241662.5198.11.camel@deep-space-9.dsnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 10:27:42PM +0200, Stelian Pop wrote:
> [open-iscsi@googlegroups.com bouncing, removed from CC:]
> 
> Le jeudi 10 août 2006 à 09:47 -0700, Paul E. McKenney a écrit :
> 
> > > Let's take this problem differently: is a memory barrier cheaper than a
> > > spinlock ? 
> > 
> > Almost always, yes.  But a spinlock is cheaper than a spinlock plus
> > a pair of memory barriers.
> 
> Right, but I think we're optimizing too much here. 

That was in fact my point initially -- why not just require locking,
either that registered at kfifo_alloc() time or a separately acquired
lock?

> > > If the answer is yes as I suspect, why should the kfifo API force the
> > > user to take a spinlock ?
> > 
> > My concern is that currently a majority of the calls to __kfifo_{get,put}()
> > are already holding a spinlock.
> > 
> > But if you could send me your tests for lock-free __kfifo_{get,put}(),
> > I would be happy to run them on weak-memory-consistency model machines
> > with the memory barriers.  And without the memory barriers -- we need
> > a test that fails in the latter case to prove that the memory barriers
> > really are in the right place and that all of them are present.
> > 
> > Does this sound reasonable?
> 
> It would sound reasonable if I had any tests to send to you :)
> 
> Since I don't have any and since you're the one proposing the change, I
> guess it's up to you to write them. :)

Ah, but you owe a test debt from your earlier submission of kfifo!  ;-)

						Thanx, Paul
