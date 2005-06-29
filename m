Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVF2Oxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVF2Oxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 10:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVF2Oxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 10:53:52 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:9918 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261224AbVF2Oxu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 10:53:50 -0400
Date: Wed, 29 Jun 2005 10:53:10 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Denis Vlasenko <vda@ilport.com.ua>, Arjan van de Ven <arjan@infradead.org>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
In-Reply-To: <20050629142317.GB2130@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0506291046020.22775@localhost.localdomain>
References: <200506291402.18064.vda@ilport.com.ua> <1120045024.3196.34.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain>
 <200506291714.32990.vda@ilport.com.ua> <20050629142317.GB2130@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Jun 2005, Jörn Engel wrote:

> On Wed, 29 June 2005 17:14:32 +0300, Denis Vlasenko wrote:
> >
> > This is why I always use _irqsave. Less error prone.
> > And locking is a very easy to get 'slightly' wrong, thus
> > I trade 0.1% of performance for code simplicity.
>
> But sometimes you get lucky and trade 100ms latency for code
> simplicity.  Of course, the audio people don't mind anymore, now that
> we have all sorts of realtime patches.  Everyone's happy!
>

God! If you are holding a spin_lock for 100ms, something is terribly
wrong, especialy since you better not schedule holding that spin_lock.
Spinlocks are _suppose_ to be for quick things.  The difference in latency
between a *_lock and *_lock_irqsave only effects UP, on SMP both will give
the same latency, since another CPU might be busy spinning while waiting
for that lock, heck, on SMP the latency of *_lock can actually be higher,
since, as I already said, the other CPU will even have to wait while the
CPU that has the lock is servicing interrupts.

Although I must say that with all the realtime patches I'm happy :-)

-- Steve

