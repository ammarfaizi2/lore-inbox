Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSKXWZW>; Sun, 24 Nov 2002 17:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSKXWZV>; Sun, 24 Nov 2002 17:25:21 -0500
Received: from dp.samba.org ([66.70.73.150]:28843 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261732AbSKXWZU>;
	Sun, 24 Nov 2002 17:25:20 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Doug Ledford <dledford@redhat.com>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why /dev/sdc1 doesn't show up... 
In-reply-to: Your message of "Wed, 20 Nov 2002 07:45:20 -0800."
             <Pine.LNX.4.44.0211200737020.12032-100000@home.transmeta.com> 
Date: Mon, 25 Nov 2002 09:30:45 +1100
Message-Id: <20021124223234.67B372C0E3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211200737020.12032-100000@home.transmeta.com> you wr
ite:
> 
> On Wed, 20 Nov 2002, Rusty Russell wrote:
> > 
> > 	Linus, I would like an answer: how does one register two /proc
> > entries?
> 
> I think the answer is simple: you don't.

OK.  Two devices?  A device and a sysfs attribute?  A device and a
filesystem?  A device and a setsockopt?  So I sympathise, but I
disagree here.

> This is what happens with built-in drivers already. Modules are nothing 
> but a convenience. They're not "worthy" of complexity.

Agreed.  Having an invisible "MUST NOT fail beyond this point" line is
leaving a subtle trap for driver writers.

We *already have* a mechanism to isolate a module: we did it to avoid
a two-stage module destroy policy.  We can use the exact same
mechanism to avoid such a two-stage module init policy.

Modulo bugs, I've erred on the side of not breaking the 1500+ modules
in the kernel, and *not* exposing the unload races to them.  Please
consider carefully.

Note 1: Al mentioned he wants to fire off userspace before initcalls
are done, introducing the same races in core kernel init.  Without
seeing reasons, it's hard to tell why he wants this, but this would
require everyone to do two-stage init anyway.

Note 2: If you really want two-stage init, you're best off making it
explicit: ie. two functions: one which can fail (int module_prep()),
and one which can't (void module_start()).  I regarded this as too
invasive a change just for an obscure module race.

Hope that clarifies?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
