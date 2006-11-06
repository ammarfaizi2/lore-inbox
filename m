Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753814AbWKFVSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbWKFVSK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbWKFVSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:18:10 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:65486 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1753814AbWKFVSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:18:09 -0500
Date: Mon, 6 Nov 2006 16:17:56 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linus Torvalds <torvalds@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
In-Reply-To: <1162846433.28571.341.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0611061609340.22166@gandalf.stny.rr.com>
References: <20061105193457.GA3082@oleg>  <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
  <1162803471.28571.303.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0611060732020.14553@gandalf.stny.rr.com>
 <1162846433.28571.341.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Nov 2006, Benjamin Herrenschmidt wrote:

> On Mon, 2006-11-06 at 07:35 -0500, Steven Rostedt wrote:
>
> > It is relevant.  In powerpc, can one write happen before another write?
> >
> >
> >   x = 1;
> >   barrier();  (only compiler barrier)
> >   b = 2;
> >
> >
> > And have CPU 2 see b=2 before seeing x=1?
>
> Yes. Definitely.

OK, I see in powerpc, that spin lock calls isync. This just clears the
pipeline. It doesn't touch the loads and stores, right?

So basically saying this:

   x=1;
   asm ("isync");
   b=2;

Would that have the same problem too?  Where another CPU can see x=1
before seeing b=2?

Thanks!

-- Steve

