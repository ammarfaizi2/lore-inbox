Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVDCXJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVDCXJF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVDCXJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:09:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27836 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261950AbVDCXIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 19:08:44 -0400
Date: Sun, 3 Apr 2005 16:08:07 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050403160807.35381385.pj@engr.sgi.com>
In-Reply-To: <20050403152413.GA26631@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
	<20050403043420.212290a8.pj@engr.sgi.com>
	<20050403071227.666ac33d.pj@engr.sgi.com>
	<20050403152413.GA26631@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> if you create a sched-domains hierarchy (based on the SLIT tables, or in 
> whatever other way) that matches the CPU hierarchy then you'll 
> automatically get the proper distances detected.

Yes - agreed.  I should push in the direction of improving the
SN2 sched domain hierarchy.


Would be a good idea to rename 'cpu_distance()' to something more
specific, like 'cpu_dist_ndx()', and reserve the generic name
'cpu_distance()' for later use to return a scaled integer distance,
rather like 'node_distance()' does now.  For example, 'cpu_distance()'
might, someday, return integer values such as:

	40  217  252  253

as are displayed (in tenths) in the debug line:

---------------------
cacheflush times [4]: 4.0 (4080540) 21.7 (21781380) 25.2 (25259428) 25.3 (25372682)
---------------------

(that is, the integer (long)cost / 100000 - one less zero).

I don't know that we have any use, yet, for this 'cpu_distance()' as a
scaled integer value.  But I'd be more comfortable reserving that name
for that purpose.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
