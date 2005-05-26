Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVEZVEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVEZVEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEZVEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:04:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16379 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S261775AbVEZVA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:00:59 -0400
Subject: Re: RT patch acceptance
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: john cooper <john.cooper@timesys.com>
Cc: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <429633B1.5060601@timesys.com>
References: <20050525001019.GA18048@nietzsche.lynx.com>
	 <1116981913.19926.58.camel@dhcp153.mvista.com>
	 <20050525005942.GA24893@nietzsche.lynx.com>
	 <1116982977.19926.63.camel@dhcp153.mvista.com>
	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>
	 <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>
	 <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de>  <429633B1.5060601@timesys.com>
Content-Type: text/plain
Date: Thu, 26 May 2005 14:00:54 -0700
Message-Id: <1117141254.1583.69.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 16:38 -0400, john cooper wrote:
> Andi Kleen wrote:
> > What I dislike with RT mutexes is that they convert all locks.
> > It doesnt make much sense to me to have a complex lock that
> > only protects a few lines of code (and a lot of the spinlock
> > code is like this). That is just a waste of cycles.
> 
> I had brought this up in the dim past in the context
> of adaptive mutexes which could via heuristics decide
> whether to spin/sleep.

> > But I always though we should have a new lock type that is between
> > spinlocks and semaphores and is less heavyweight than a semaphore
> > (which tends to be quite slow due to its many context switches). Something
> > like a spinaphore, although it probably doesnt need full semaphore
> > semantics (rarely any code in the kernel uses that anyways). It could
> > spin for a short time and then sleep.
> 
> Spin if the lock is contended and the owner is active
> on a cpu under the assumption the lock owner's average
> hold time is less than that of a context switch.  There
> are restrictions as once a path holds an adaptive
> mutex as a spin lock it cannot acquire another adaptive
> mutex as a blocking lock.
> 

It might be simpler to get things working with a basic implementation
first, (status quo), and then look into adding something like this. 

I don't see how this approach decreases the complexity of the task at
hand, especially not in regards to concurrency.

> > If you drop irq threads then you cannot convert all locks
> > anymore or have to add ugly in_interrupt()checks. So any conversion like
> > that requires converting locks.
> 
> Yes, I was trying to make that point in an earlier thread.
> 

My original comment was:

> The IRQ threads are actually a separate implementation.
> 
> IRQ threads do not depend on mutexes, nor do they depend
> on any of the more opaque general spinlock changes, so this
> stuff SHOULD be separated out, to eliminate the confusion..
...
> As a logical prerequisite to the Mutex stuff, the IRQ threads,
> if broken out, could allow folks to test the water in the shallow end
> of the pool.

The dependency was STATED: "as a logical prerequisite...". 
The context was: "breaking the IRQ threads into a separate patch"

You misread it, and then commented on that. 



Sven


