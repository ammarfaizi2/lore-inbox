Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbUBBLMO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 06:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265353AbUBBLMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 06:12:14 -0500
Received: from dp.samba.org ([66.70.73.150]:19393 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265351AbUBBLML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 06:12:11 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core 
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>, dipankar@in.ibm.com,
       vatsa@in.ibm.com
In-reply-to: Your message of "Mon, 02 Feb 2004 04:12:34 CDT."
             <Pine.LNX.4.58.0402020353240.25194@devserv.devel.redhat.com> 
Date: Mon, 02 Feb 2004 21:55:51 +1100
Message-Id: <20040202111224.DE5402C26D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.58.0402020353240.25194@devserv.devel.redhat.com> you write:
> the sched.c bits look good. A question: why is the migrate_all_tasks()
> code nonatomic? If you run this code in the context of the migration
> thread of the downed CPU then all of the migration can be done in one big
> atomic locked section which holds all runqueue locks and just moves all
> tasks off the current CPU. If it were done this way then eg. the
> __migrate_task() race-avoidance check (cpu_is_offline()) could go away and
> the whole thing would be more robust i believe.

Hmm...

I can code it up and we can see what it looks like.

Unfortunately the __migrate_task() check won't go away: someone may
have asked to move from CPU 0 to 1, and by the time migration thread
on 0 gets to the request, 1 has gone down.  We don't want all the
callers to hold the cpucontrol lock, because now the NUMA scheduler
uses migration as a common case 8(

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
