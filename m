Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318897AbSG1D30>; Sat, 27 Jul 2002 23:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318899AbSG1D30>; Sat, 27 Jul 2002 23:29:26 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:36543 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318897AbSG1D3Z>;
	Sat, 27 Jul 2002 23:29:25 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] scheduler, migration startup fixes, 2.5.29 
In-reply-to: Your message of "Sat, 27 Jul 2002 12:54:33 +0200."
             <Pine.LNX.4.44.0207271254200.13591-100000@localhost.localdomain> 
Date: Sun, 28 Jul 2002 13:16:01 +1000
Message-Id: <20020728033359.5D6D0442E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0207271254200.13591-100000@localhost.localdomain> you
 write:
> 
> the attached patch fixes the scheduler's migration thread startup bug that
> got unearthed by Rusty's recent CPU-startup enhancements.
> 
> the fix is to let a startup-helper thread migrate the migration thread,
> instead of the migration thread calling set_cpus_allowed() itself.  
> Migrating a not running thread is a simple and robust thing, and needs no
> cooperation from migration threads - thus the catch-22 problem of how to
> migrate the migration threads is solved finally.
> 
> the patch is against Rusty's initcall fix/hack which calls
> migration_init() before other CPUs are brought up - this ordering is
> clearly the clean way of doing migration init. [the patch also fixes a UP
> compiliation bug in Rusty's hack.]
> 
> tested on x86 SMP and UP.

This is, AFAICT, overkill (the UP compilation fix appreciated though).

When a new CPU comes up, there is a semaphore which is held through
the notifier, so you can't have two CPUs come up at once.

Therefore, the new migration thread is either started on a completely
active cpu (ie. there's a migration thread on that CPU to use), or
it's already on the new cpu, in which case set_cpus_allowed is a noop.

What am I missing?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
