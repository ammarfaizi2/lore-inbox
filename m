Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbTBQKnd>; Mon, 17 Feb 2003 05:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbTBQKnd>; Mon, 17 Feb 2003 05:43:33 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:34821 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266970AbTBQKnc>; Mon, 17 Feb 2003 05:43:32 -0500
Date: Mon, 17 Feb 2003 11:53:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Werner Almesberger <wa@almesberger.net>, <kuznet@ms2.inr.ac.ru>,
       <davem@redhat.com>, <kronos@kronoz.cjb.net>,
       <linux-kernel@vger.kernel.org>, <torvalds@tranmseta.com>
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-Reply-To: <20030217030304.5C9AD2C2D3@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0302171112390.1336-100000@serv>
References: <20030217030304.5C9AD2C2D3@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Feb 2003, Rusty Russell wrote:

> There were two major changes in the module code.  The first was to
> simplify the userland interface, from:
> 
> 	sys_create_module(name, size)
> 	sys_query_module(...) (a 5-way multiplexed syscall)
> 	sys_init_module(name, ptr)
> 
> to:
> 	sys_init_module(ptr, len, userargs)
> 
> To argue against this change is a demonstration of lack of
> understanding, or a complete lack of taste.

Maybe you could share a bit of your wisdom?
1. Doing the linking in userspace requires two steps, but I still don't 
know what's so bad about it.
2. This still doesn't explain, why everything has to be moved into kernel, 
why can't we move more into userspace?
3. You simply moved part of the query syscall functionality to 
/proc/modules (which btw is still not enough to fix ksymoops).

> The second change was the speed up one system of module locking in the
> kernel which wasn't racy, and deprecate the other system which was
> racy in 99% of its uses.  That is all.

Well, I'm not against optimizing the module locking (*), as we won't get 
rid of it in the near feature, but it still has problems.
1. It's adding complexity (however you implement it), I explained it in 
detail and you still haven't told me, where I'm wrong.
2. The module interface is incompatible with other kernel interfaces, I 
tried to explain that in the mail from saturday, if you think I'm wrong, 
your input is very welcome, but _please_ answer to that mail.

> Did it solve all the races in the kernel?  Of course not.  But it's
> simple to use, already well understood in the kernel, and avoids
> massive changes.  It also allows connection tracking to be properly
> modularized, which was my long-lost original purpose.

It's too much fun to quote Al here:
"And no, I don't buy arguments about poor interface-writers.  You do some
infrastructure intended to be used by driver-writers - you are supposed
to have a clue.  'Cause having rabid monkeys on crack on *both* sides of
an interface is a recipe for disaster and on the driver side you are
guaranteed to have a bunch of them.

We need to have interfaces cleaned up.  No silver bullets there.  There's
maybe a dozen of interfaces that cover 99% of all drivers out there.  Remaining
1% can and should fend for itself - you do something really tricky, you
are responsible for getting it right."

> I've repeated this enough now, I think.

Yes, you repeated your "executive summaries" now often enough, maybe you 
can impress some manager with it, but it's highly offensive to kernel 
hackers. Could you _please_ come up with some arguments now?

bye, Roman

(*) BTW I have patch that would make the unload path usable again, it 
would only be required to add a single smp_mb() to the fast path.

