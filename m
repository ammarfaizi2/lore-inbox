Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756023AbWKQXPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023AbWKQXPx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 18:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756025AbWKQXPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 18:15:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3483 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756023AbWKQXPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:15:53 -0500
Date: Fri, 17 Nov 2006 18:15:43 -0500
From: Alan Cox <alan@redhat.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Alan Cox <alan@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>, Jeff Dike <jdike@addtoit.com>
Subject: Re: TTY layer locking design
Message-ID: <20061117231543.GE20362@devserv.devel.redhat.com>
References: <200611172311.38744.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611172311.38744.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 12:11:38AM +0200, Blaisorblade wrote:
> *) who is maintaining this aspect of code ? The only name found in MAINTAINERS 
> and CREDITS is the one of James Simmons.

There is no one maintainer. I did some of the documentation and buffering
abstraction. Paul Fulghum wrote the SMP aware and clever locking bits
for the buffer handling. Since then other people have worked on the 
reference locking and the current->tty races and fixed those
 
> *) is the current design reputed solid? I'm not only talking about the big 
> kernel lock, but also about whether drivers need to reinvent (incorrectly) 
> the wheel for their locking. UML drivers are very bad on this, but I've found 
> difficulty both at reading the code and at finding documentation.

As of 2.6.19-rc I think the majority of the big issues are sorted

> *) there is no generic way to handle tty's which are also consoles, except 
> drivers/char/vt.c - that code is written as if it were the only case where 
> that applies. Instead, UML drivers are an exception to this - UML cannot use 
> virtual terminals.

Untrue - many serial drivers support being consoles

> I'm trying to establish whether it is possible, for instance, for ->close to 
> be called in parallel to ->write and such; in other driver layer this is 

Close/Write cannot occur in parallel. The VFS guarantees this

> Also, since write must use a spinlock because it must protect from interrupt 
> races, and open cannot, must we use both a mutex and a spinlock in ->write 
> and similar methods? This can be avoided in other drivers.

See the existing drivers. Open can use spinlocks

