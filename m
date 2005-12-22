Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbVLVNBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbVLVNBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbVLVNBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:01:24 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:8614 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965006AbVLVNBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:01:23 -0500
Date: Thu, 22 Dec 2005 14:00:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 9/9] mutex subsystem, XFS namespace collision fixes
Message-ID: <20051222130038.GA21998@elte.hu>
References: <20051222114308.GJ18878@elte.hu> <20051222120052.GC30964@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222120052.GC30964@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > -#define mutex_init(lock, type, name)		sema_init(lock, 1)
> > -#define mutex_destroy(lock)			sema_init(lock, -99)
> > -#define mutex_lock(lock, num)			down(lock)
> > -#define mutex_trylock(lock)			(down_trylock(lock) ? 0 : 1)
> > -#define mutex_unlock(lock)			up(lock)
> > +#define xfs_mutex_init(lock, type, name)	sema_init(lock, 1)
> > +#define xfs_mutex_destroy(lock)			sema_init(lock, -99)
> > +#define xfs_mutex_lock(lock, num)		down(lock)
> > +#define xfs_mutex_trylock(lock)			(down_trylock(lock) ? 0 : 1)
> > +#define xfs_mutex_unlock(lock)			up(lock)
> 
> Again, this should really be using the mutex primitives (obviously 
> ;-)).

yeah - but i didnt want to impact something so large as XFS. Such a 
change has to be tested and validated - so i wanted to get the namespace 
collision out of the way first. But i'd be happy to add an XFS 
conversion patch ontop of these, provided someone tests it.

> While we're at it, maybe we should a mutex_destroy aswell?  it would 
> be non-mandatory and allow that a lock is gone for the debugging 
> variant.

right now the lock is gone from the debugging state once it's unlocked.  
I'll add mutex_destroy(), it should be rather easy (it can e.g. destroy 
mutex->magic).

	Ingo
