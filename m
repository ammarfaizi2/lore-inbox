Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVF2PLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVF2PLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVF2PLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:11:44 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:8868 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261324AbVF2PLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:11:31 -0400
Date: Wed, 29 Jun 2005 17:10:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Arjan van de Ven <arjan@infradead.org>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
Message-ID: <20050629151053.GC2130@wohnheim.fh-wedel.de>
References: <200506291402.18064.vda@ilport.com.ua> <1120045024.3196.34.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain> <200506291714.32990.vda@ilport.com.ua> <20050629142317.GB2130@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0506291046020.22775@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0506291046020.22775@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 June 2005 10:53:10 -0400, Steven Rostedt wrote:
> On Wed, 29 Jun 2005, Jörn Engel wrote:
> > On Wed, 29 June 2005 17:14:32 +0300, Denis Vlasenko wrote:
> > >
> > > This is why I always use _irqsave. Less error prone.
> > > And locking is a very easy to get 'slightly' wrong, thus
> > > I trade 0.1% of performance for code simplicity.
> >
> > But sometimes you get lucky and trade 100ms latency for code
> > simplicity.  Of course, the audio people don't mind anymore, now that
> > we have all sorts of realtime patches.  Everyone's happy!
> >
> 
> God! If you are holding a spin_lock for 100ms, something is terribly
> wrong, especialy since you better not schedule holding that spin_lock.
> Spinlocks are _suppose_ to be for quick things.  The difference in latency
> between a *_lock and *_lock_irqsave only effects UP, on SMP both will give
> the same latency, since another CPU might be busy spinning while waiting
> for that lock, heck, on SMP the latency of *_lock can actually be higher,
> since, as I already said, the other CPU will even have to wait while the
> CPU that has the lock is servicing interrupts.

All nice and well.  But still, for the sake of simplicity and me not
wanting to think, I prefer always using spin_lock_irqsave for
everything.  Since when should I stop and think about my own code?

In fact, why don't we all sit down and start using KCSP for kernel
hacking? ;)

Jörn

-- 
I can say that I spend most of my time fixing bugs even if I have lots
of new features to implement in mind, but I give bugs more priority.
-- Andrea Arcangeli, 2000
