Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265587AbUBCBCR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 20:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbUBCBCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 20:02:16 -0500
Received: from dp.samba.org ([66.70.73.150]:42918 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265587AbUBCBCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 20:02:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       dipankar@in.ibm.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core 
In-reply-to: Your message of "Mon, 02 Feb 2004 16:40:40 BST."
             <20040202154040.GA5895@elte.hu> 
Date: Tue, 03 Feb 2004 11:45:22 +1100
Message-Id: <20040203010224.2A2F52C0CB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040202154040.GA5895@elte.hu> you write:
> user-space tasks that rely on running on a specific CPU need a callback
> too. (probably in the form of a signal, which, if unhandled, terminates
> the task.) Eg. if a webserver has a mode to run one thread per CPU, then
> the server needs to adapt to the new situation when a CPU goes away. We
> cannot just unilaterally migrate a task and violate its affinity.

Well, that's what we'd do anyway, to deliver the signal.

This terminating signal idea is simply flawed: affinity is inherited,
so you're killing a process which knows nothing anyway.

If we can't do it well, leave it to userspace to sort out 8)

> another thing: if the migrate-irqs op is done atomically too (together
> with the migrate-tasks op) then the special-cases in idle_balance() and
> rebalance_tick() could go away too.

Exactly.  It simplifies a number of things.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
