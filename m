Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266066AbUAUEim (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUAUEgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:36:11 -0500
Received: from dp.samba.org ([66.70.73.150]:29409 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266052AbUAUEfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:35:53 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Rusty Russell <rusty@au1.ibm.com>,
       vatsa@in.ibm.com, lhcs-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR 
In-reply-to: Your message of "Tue, 20 Jan 2004 09:49:39 -0800."
             <400D6A33.6020108@myrealbox.com> 
Date: Wed, 21 Jan 2004 15:33:16 +1100
Message-Id: <20040121043608.62C342C0C4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <400D6A33.6020108@myrealbox.com> you write:
> (At some point, linux may want to suspend itself after inactivity.  Both 
> RT tasks and some interactive tasks may want to supress that.)  Why not 
> add a SIGPM signal, which is only sent if handles, and which indicates 
> that PM event is happening.  Give usermode some method of responding to 
> it (e.g. handler returns a value, or a new syscall), and let 
> /sbin/hotplug handle events for tasks that either ignore the signal or 
> responded that they were uninterested.  This seems be close to optimal 
> for every case I can think of.

This was my original idea too.  AIX has this, but in reality the
control ends up all in userspace for non-trivial uses.  ie. some
"workload manager" program consults with all the interested parties
*before* telling the kernel what to do.

The async and non-consultive nature of hotplug is policy for good
reason.  Giving someone 30 seconds to respond to a signal can always
fail, and making it configurable is just a bandaid.

I have nothing against SIGRECONFIG (think memory hotplug), but the AIX
guys indicated from their experience it seems that non-toy users don't
use it anyway (they have a hotplug-style script system, too).

So: trying to cover every corner case isn't worthwhile in practice, it
seems.  I like the signal for RC5 challenge etc, but that's about it.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
