Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSKYFpt>; Mon, 25 Nov 2002 00:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSKYFpt>; Mon, 25 Nov 2002 00:45:49 -0500
Received: from dp.samba.org ([66.70.73.150]:18855 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262430AbSKYFps>;
	Mon, 25 Nov 2002 00:45:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: Module Refcount & Stuff mini-FAQ 
In-reply-to: Your message of "Sun, 24 Nov 2002 23:07:58 -0300."
             <20021124230758.A1549@almesberger.net> 
Date: Mon, 25 Nov 2002 13:27:02 +1100
Message-Id: <20021125055303.484492C055@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021124230758.A1549@almesberger.net> you write:
> Rusty Russell wrote:
> > Q: But the modules' init routine calls my register() routine which
> >    wants to call back into one of the function pointers immediately,
> >    and so try_module_get() fails! (because the module is not finished
> >    initializing yet)
> > A: You're being called from the module, so someone already has a
> >    reference (unless there's a bug), so you don't need a
> >    try_module_get().
> 
> Hmm, I wouldn't call this the answer. How about:
>  - Q: why does it fail ?
>  - A: because you're initializing
>  - solution: but since you're calling from a module, and the call
>    goes back to the same module, you don't have to worry
> 
> This raises the question: why is this a special case ? The
> registration function shouldn't have to know all these details.
> (That's the whole point of try_module_get, isn't it ?)

Yes, this is a fairly rare case: I'm debating it now.  For example,
scsi calls back into the module which just registered, as does the
block layer (to probe for partitions).

> > Well, if we continue to start modules unisolated, I need to rewrite
> > the FAQ anyway...
> 
> Does "unisolated" mean that try_module_get would work ? If yes,
> you've already solved the problem ;-)

At the cost of exposing the module to initialization races.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
