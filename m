Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267642AbSKTHVQ>; Wed, 20 Nov 2002 02:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267639AbSKTHUX>; Wed, 20 Nov 2002 02:20:23 -0500
Received: from dp.samba.org ([66.70.73.150]:57811 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267642AbSKTHTt>;
	Wed, 20 Nov 2002 02:19:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: Doug Ledford <dledford@redhat.com>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up... 
In-reply-to: Your message of "Tue, 19 Nov 2002 02:12:54 CDT."
             <Pine.GSO.4.21.0211190116420.27757-100000@steklov.math.psu.edu> 
Date: Wed, 20 Nov 2002 08:29:52 +1100
Message-Id: <20021120072654.3EE7A2C08B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.4.21.0211190116420.27757-100000@steklov.math.psu.edu> you 
write:
> Wrong granularity.  "module had finished initialization" is _not_ a natural
> event wrt stuff exported by that module.

Well, I have to disagree here.  "I have successfully finished my
initialization" is the same logic you're trying to beat into module
author's heads before they commit their interfaces.

> And that's one of the main problems I have with your approach - you
> are trying to make module loader do the stuff that has nothing
> whatsoever with modules.

Or, put another way, I'm trying to ensure that correct code in the
kernel is correct code in a module, by having the module code simulate
the conditions in which the original occurred.

> Moreover, if driver is built into the kernel, you get (at the very least)
> a different mechanism for triggering the same events, if not the outright
> different sequence of events.  Which is a Bad Thing(tm) since it leads to
> a shitload of extra problems with debugging.

Speaking of which, what's the long-term plan for hotplug events at
boot?  Will you get a shitload of "add" events, or rely on userspace
to scan?

> Double freeing.  Forgetting to free.  Dereference after freeing.  Leaving
> timers active.  Leaving pointers to local structures in global arrays.

Hmm, my audit of copy_to/from_user uncovered similar bogosities, and
I've dropped more than one Trivial Patch Monkey patches because they
cleaned up one case in an incurable sewer of problems 8(

The "better to have a bad driver than no driver" becomes less true as
people start copying from it, too.  This is where meta-maintainers
like Jeff Garzik make a definite difference as chief shit-kicker.

> On that background all shite you are so concerned about is a noise.

Perhaps.  But I can't change the world: that's your job.

> What we _can_ do (and that will be on per-subsystem basis) is providing
> APIs that would cut down on the amount of glue needed in driver init.

Fervently agree: it's hard to get one line wrong, *and* almost any
scheme can be implemented on top of it.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
