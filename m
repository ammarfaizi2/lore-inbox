Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbUBBNTD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 08:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265595AbUBBNTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 08:19:03 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:22173 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265511AbUBBNTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 08:19:00 -0500
Date: Mon, 2 Feb 2004 18:52:30 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       dipankar@in.ibm.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core
Message-ID: <20040202132230.GA21772@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040202111224.DE5402C26D@lists.samba.org> <Pine.LNX.4.58.0402020741250.16748@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402020741250.16748@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 07:45:32AM -0500, Ingo Molnar wrote:
> 
> On Mon, 2 Feb 2004, Rusty Russell wrote:
> 
> > Unfortunately the __migrate_task() check won't go away: someone may have
> > asked to move from CPU 0 to 1, and by the time migration thread on 0
> > gets to the request, 1 has gone down.  We don't want all the callers to
> > hold the cpucontrol lock, because now the NUMA scheduler uses migration
> > as a common case 8(
> 
> well, when a CPU goes down it could process the migration request queue as
> well. (this would be a pretty natural thing to do if CPU-down executes in
> the migration-thread context.)


One possibility is the migration request will be in 
CPU 0's queue and not in CPU1's? Hence there won't be anything (in 
CPU1's migration request queue) to process when CPU1 is brought down.
However by the time migration thread on CPU 0 gets around to processing the
request, CPU1 is already down and hence the check.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
