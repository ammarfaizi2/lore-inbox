Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317809AbSHUEdn>; Wed, 21 Aug 2002 00:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317836AbSHUEdn>; Wed, 21 Aug 2002 00:33:43 -0400
Received: from dp.samba.org ([66.70.73.150]:17093 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317809AbSHUEdm>;
	Wed, 21 Aug 2002 00:33:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       "Vamsi Krishna S ." <vamsi@in.ibm.com>
Subject: Re: [PATCH] (re-xmit): kprobes for i386 
In-reply-to: Your message of "21 Aug 2002 03:29:37 +0200."
             <1029893377.24300.162.camel@ldb> 
Date: Wed, 21 Aug 2002 14:21:30 +1000
Message-Id: <20020820233813.559CD2C0A8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1029893377.24300.162.camel@ldb> you write:
> 
> --=-UkzkmpwPZ3tahG697mpi
> Content-Type: text/plain
> Content-Transfer-Encoding: 7bit
> 
> > > > +	if (kprobe_running() && kprobe_fault_handler(regs, trapnr))
> > > > +		return;
> > > >  	if (!(regs->xcs & 3))
> > > >  		goto kernel_trap;
> > > The kprobe check should be after the kernel_trap label.
> > 
> > No.  The entire *point* of being able to register a kprobe fault
> > handler is to be able to handle any kernel faults yourself if you want
> > to.
> It seems you have misunderstood my point.
> My idea is that since kprobes are only used for kernel mode address, we
> should move the kprobe check in the code that executes after we check
> that the fault is happening in kernel mode.

Ah, I see.  That's true at the moment, but there's an (future)
extension that covers userspace traps as well, which is why it was
done this way.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
