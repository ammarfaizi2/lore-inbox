Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVFOOr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVFOOr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVFOOrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:47:55 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:61103 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261488AbVFOOqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:46:14 -0400
Subject: Re: RT : nvidia driver and perhaps others
From: Steven Rostedt <rostedt@goodmis.org>
To: Valdis.Kletnieks@vt.edu
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Serge Noiraud <serge.noiraud@bull.net>
In-Reply-To: <200506151240.j5FCeO6l027298@turing-police.cc.vt.edu>
References: <1118823704.10717.129.camel@ibiza.btsn.frna.bull.fr>
	 <200506151240.j5FCeO6l027298@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 15 Jun 2005 10:45:54 -0400
Message-Id: <1118846754.4508.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 08:40 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 15 Jun 2005 10:21:45 +0200, Serge Noiraud said:
> 
> > 	I try to compile the nvidia driver for my RT kernel.
> > It does not work anymore.
> 
> You aren't going to get much sympathy here on that one...:)

You do from me :)  I have a NVidia on two machines that I run RT on. But
they are both SMP (well one is just hyper threaded) and I couldn't get
them working with SMP. So I just use the vesa driver when running RT on
those machines :-(  It's been several versions back since I had it
working on UP with NVidia (about a month or two back, which at Ingo's
speed is an eternity).

> 
> > Isn't there a better way to avoid these modifications ?
> > for example to have the external fonction the same than non RT kernel.
> > and have an internal link to the new one or something like that ?
> 
> However, he *does* have a point here - GPL'ed out-of-tree drivers will
> have these same issues.  Yes, I know the standard "get them into the tree"
> refrain here...

Well, if local_irq_disable doesn't turn off irqs and you don't have it
bugging per Esben's patch, it shouldn't be a problem to just recompile
it again.

> 
> > These drivers are proprietary, so I can't modify them.
> 
> Fortunately, NVidia supplies enough pieces to make things work..

But you don't know what those pieces that you don't see do and if they
really need irqs disabled.  I had to hack a little to get interrupts off
to call one of the NVidia's hooks. I don't really remember all that I
did, but I still wasn't able to get it working on SMP.

> 
> > I think we should change :
> > 
> > 1 - local_irq_* to raw_local_irq_*  : is it always true ?
> 
> > 2 - spin_* to raw_spin_*  ?
> 
> Ingo et al - what *is* the recommended magic to make a driver compile and
> work cleanly with or without RT?  Hopefully there's a simple "will work correctly,
> but possibly sub-optimal latency" cookbook scheme....

Hopefully, just compiling the way it is would work.  The idea of Ingo's
magic code is to have what is already in place work with RT.

-- Steve

