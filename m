Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263722AbUJ3A2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbUJ3A2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263677AbUJ3AXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:23:05 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:35216 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263739AbUJ3AWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:22:30 -0400
Subject: Re: [PATCH, 2.6.9] improved load_balance() tolerance for pinned
	tasks
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: John Hawkes <hawkes@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       John Hawkes <hawkes@google.engr.sgi.com>,
       John Hawkes <hawkes@oss.sgi.com>, Ingo Molnar <mingo@elte.hu>,
       Jesse Barnes <jbarnes@sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <001c01c4baac$056ae7d0$6700a8c0@comcast.net>
References: <200410201936.i9KJa4FF026174@oss.sgi.com>
	 <200410221938.MAA52152@google.engr.sgi.com>
	 <00ee01c4b870$030b80f0$6700a8c0@comcast.net>
	 <4179DDA3.1020405@yahoo.com.au>
	 <001c01c4baac$056ae7d0$6700a8c0@comcast.net>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1099095666.25180.1.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 29 Oct 2004 17:21:07 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 09:02, John Hawkes wrote:
> From: "Nick Piggin" <nickpiggin@yahoo.com.au>
> > > From: "John Hawkes" <hawkes@google.engr.sgi.com>
> > > Actually, there is another related problem that arises in
> > > active_load_balance() with a runqueue that holds hundreds of pinned
> processes.
> > > I'm seeing a migration_thread perpetually consuming 70% of its CPU.
> >
> > That's what I was worried about, but in your most recent
> > patch you just sent, the all_pinned path should skip over
> > the active load balance completely... basically it shouldn't
> > be running at all, and if it is then it is a bug I think?
> 
> To reiterate:  this is probably reproducible on smaller SMP systems, too.
> Just do a 'runon' (using sys_sched_setaffinity) of ~200 (or more) small
> computebound processes on a single CPU.
> 
> My patch -- that has load_balance() skip over (busiest->active_balance = 1)
> trigger that starts up active_load_balance() -- does seem to reduce the
> frequency of bursts of long-running activity of the migration thread, but
> those burst of activity are still there, with migration_thread consuming
> 75-95% of its CPU for several seconds (as observed by 'top').  I have not yet
> determined what's happening.  It might be an artifact of how long it takes to
> do those 'runon' startups of the computebound processes.

You may want to try these tests again with linux-2.6.10-rc1-mm2.  It's
got 2 patches to fix some broken behavior of active_load_balance().  The
version of active_load_balance() in 2.6.9 was not considering a great
many CPUs as potential recipients of tasks due to some small logic
problems in the code.

Cheers!

-Matt

