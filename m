Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbUA0AJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265683AbUA0AJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:09:51 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:49331 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265667AbUA0AJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:09:49 -0500
Date: Mon, 26 Jan 2004 16:09:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Theurer <habanero@us.ibm.com>, Nick Piggin <piggin@cyberone.com.au>
cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU
Message-ID: <35060000.1075162177@flay>
In-Reply-To: <200401261740.12657.habanero@us.ibm.com>
References: <20040125235431.7BC192C0FF@lists.samba.org> <315060000.1075134874@[10.10.2.4]> <40159C41.9030707@cyberone.com.au> <200401261740.12657.habanero@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Call me crazy, but why not let the topology be determined via userspace at a 
> more appropriate time?  When you hotplug, you tell it where in the scheduler 
> to plug it.  Have structures in the scheduler which represent the 
> nodes-runqueues-cpus topology (in the past I tried a node/rq/cpu structs with 
> simple pointers), but let the topology be built based on user's desires thru 
> hotplug.  

Well, I agree with the "at a more appropriate time" bit. But there's no
real need to make a bunch of complicated stuff out in userspace for this - 
we're trying to lay out the scheduler domains according to the hardware
topology of the machine. It's not a userspace namespace or anything.
Having userspace fishing down way deep in hardware specific stuff is
silly - the kernel is there as a hardware abstraction layer.

Now if you wanted to use sched domains for workload management or something
and involve userspace, then yes ... that'd be more appropriate.
 
> For example, you boot on just the boot cpu, which by default is in the first 
> node on the first runqueue.  All other cpus, whether being "booted" for the 
> for the first time or hotplugged (maybe now there's really no difference), 
> the hotplugging tells where the cpu should be, in what node and what 
> runqueue.  HT cpus work even better, because you can hotplug siblings, once 
> at a time if you wanted, to the same runqueue.  Or you have cpus sharing a 
> die, same thing, lots of choices here.  This removes any per-arch updates to 
> the kernel for things like scheduler topology, and lets them go somewhere 
> else more easily changes, like userspace. 

Ummm ... but *none* of that is dictated as policy stuff - it's all just
the hardware layout of the machine. You cannot "decide" as the sysadmin
which node a CPU is in, or which HT sibling it has. It's just there ;-)
The only thing you could possibly dictate is the CPU number you want 
assigned to the new CPU, which frankly, I think is pointless - they're
arbitrary tags, and always have been.

M.

