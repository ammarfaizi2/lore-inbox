Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbVKDGnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbVKDGnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 01:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbVKDGnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 01:43:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52185 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161085AbVKDGnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 01:43:14 -0500
Date: Thu, 3 Nov 2005 22:42:39 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bron@bronze.corp.sgi.com, pbadari@gmail.com, jdike@addtoit.com,
       rob@landley.net, nickpiggin@yahoo.com.au, gh@us.ibm.com, mingo@elte.hu,
       kamezawa.hiroyu@jp.fujitsu.com, haveblue@us.ibm.com, mel@csn.ul.ie,
       mbligh@mbligh.org, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051103224239.7a9aee29.pj@sgi.com>
In-Reply-To: <20051103214807.68a3063c.akpm@osdl.org>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
	<200511021747.45599.rob@landley.net>
	<43699573.4070301@yahoo.com.au>
	<200511030007.34285.rob@landley.net>
	<20051103163555.GA4174@ccure.user-mode-linux.org>
	<1131035000.24503.135.camel@localhost.localdomain>
	<20051103205202.4417acf4.akpm@osdl.org>
	<20051103213538.7f037b3a.pj@sgi.com>
	<20051103214807.68a3063c.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> uh, OK.  If that patch is merged, does that make Bron happy, so I don't
> have to reply to his plaintive email?

In theory yes, that should do it.  I will ack again, by early next
week, after I have verified this further.

And it should also handle some other folks who have plaintive emails
in my inbox, that haven't gotten bold enough to pester you, yet.

It really is, for the users who know my email address (*), job based
memory pressure, not task based, that matters.  Sticking it in a
cpuset, which is the natural job container, is easier, more natural,
and more efficient for all concerned.

It's jobs that are being run in cpusets with dedicated (not shared)
CPUs and Memory Nodes that care about this, so far as I know.

When running a system in a more typical sharing mode, with multiple
jobs and applications competing for the same resources, then the kernel
needs to be master of processor scheduling and memory allocation.

When running jobs in cpusets with dedicated CPUs and Memory Nodes,
then less is being asked of the kernel, and some per-job controls
from userspace make more sense.  This is where a simple hook like
this reclaim rate meter comes into play - passing up to user space
another clue to help it do its job.


> I was kind of thinking that the stats should be per-process (actually
> per-mm) rather than bound to cpusets.  /proc/<pid>/pageout-stats or something.

There may well be a market for these too.  But such stats sound like
more work, and the market isn't one that's paying my salary.

So I will leave that challenge on the table for someone else.


 (*) Of course, there is some self selection going on here.
     Folks not doing cpuset-based jobs are far less likely
     to know my email address ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
