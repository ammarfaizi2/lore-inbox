Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbVLVXb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbVLVXb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVLVXb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:31:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58026 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030374AbVLVXb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:31:56 -0500
Date: Thu, 22 Dec 2005 15:30:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjan@infradead.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjanv@infradead.org, nico@cam.org,
       jes@trained-monkey.org, zwane@arm.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, bcrl@kvack.org, rostedt@goodmis.org,
       hch@infradead.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-Id: <20051222153014.22f07e60.akpm@osdl.org>
In-Reply-To: <1135260709.10383.42.camel@localhost.localdomain>
References: <20051222114147.GA18878@elte.hu>
	<20051222035443.19a4b24e.akpm@osdl.org>
	<20051222122011.GA20789@elte.hu>
	<20051222050701.41b308f9.akpm@osdl.org>
	<1135257829.2940.19.camel@laptopd505.fenrus.org>
	<20051222054413.c1789c43.akpm@osdl.org>
	<1135260709.10383.42.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Iau, 2005-12-22 at 05:44 -0800, Andrew Morton wrote:
> > > semaphores have had a lot of work for the last... 10 years. To me that
> > > is a sign that maybe they're close to their limit already.
> > 
> > No they haven't - they're basically unchanged from four years ago (at
> > least).
> 
> Point still holds

No it does not.

Ingo's work has shown us two things:

a) semaphores use more kernel text than they should and

b) semaphores are less efficient than they could be.

Fine.  Let's update the semaphore implementation to fix those things. 
Nobody has addressed this code in several years.  If we conclusively cannot
fix these things then that's the time to start looking at implementing new
locking mechanisms.

> > It's plain dumb for us to justify a fancy-pants new system based on
> > features which we could have added to the old one, no?
> 
> The old one does one job well. Mutex wakeups are very different in
> behaviour because of the single waker rule and the fact you can do stuff
> like affine wakeups.
> 
> You could make it one function but it would inevitably end up full of
> 
> 	if(mutex) {
> 	}

We'd only need such constructs if we were trying to add all the mutex
runtime debugging features to semaphores.  I don't think that's likely to
be very useful so fine, let's not do that.

> Oh and of course you no doubt break the semaphores while doing it, while
> at least this seperate way as Linus suggested you don't break the
> existing functionality.

Linus would not be averse to a patch which optimises semaphores.

> > There's no need for two sets of behaviour. 
> 
> The fundamental reason for mutexes in terms of performance and
> scalability requires the different wake up behaviours. The performance
> numbers are pretty compelling.

This where I have a bad feeling that I'm missing some vital clue.

An efficient semaphore implementation will wake a single process per up(). 
Just like mutexes.  So why should mutexes have any performance advantage?
