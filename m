Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUA1A7Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 19:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbUA1A56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 19:57:58 -0500
Received: from dp.samba.org ([66.70.73.150]:51629 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265687AbUA1A5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 19:57:46 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU 
In-reply-to: Your message of "Tue, 27 Jan 2004 07:27:11 -0800."
             <368660000.1075217230@[10.10.2.4]> 
Date: Wed, 28 Jan 2004 11:23:59 +1100
Message-Id: <20040128005801.6AFD22C238@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <368660000.1075217230@[10.10.2.4]> you write:
> > Yeah, I talked it over with Rusty some on IRC. I have more of a feeling
> > why he's trying to do it that way now. 
> 
> BTW, Rusty - what are the locking rules for cpu_online_map under hotplug?
> Is it RCU or something? The sched domains usage of it doesn't seem to take 
> any locks.

The trivial usage is to take the cpucontrol sem (down_cpucontrol()).
There's a grace period between taking the cpu offline and actually
killing it too, so for most usages RCU is sufficient.

Fortunately, I've yet to hit a case where this isn't sufficient.  For
the scheduler there's an explicit "move all tasks off the CPU" call
which takes the tasklist lock and walks the tasks.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
