Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUJLV1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUJLV1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUJLV1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:27:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15568 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267852AbUJLV1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:27:05 -0400
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
	memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Simon Derr <Simon.Derr@bull.net>
Cc: Paul Jackson <pj@sgi.com>, Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <Pine.LNX.4.61.0410121008540.12035@openx3.frec.bull.fr>
References: <20041007072842.2bafc320.pj@sgi.com>
	 <200410071905.i97J57TS014336@owlet.beaverton.ibm.com>
	 <20041009191556.06e09c67.pj@sgi.com> <1097532415.4038.50.camel@arrakis>
	 <Pine.LNX.4.61.0410121008540.12035@openx3.frec.bull.fr>
Content-Type: text/plain; charset=
Organization: IBM LTC
Message-Id: <1097616339.6239.8.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 12 Oct 2004 14:25:40 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 01:50, Simon Derr wrote:
> > One of the cool thing about using sched_domains as your partitioning
> > element is that in reality, tasks run on *CPUs*, not *domains*.  So if
> > you have threads 'a1' & 'a2' running on CPUs 0 & 1 (small job 'a') and
> > threads 'b1' & 'b2' running on CPUs 2 & 3 (small job 'b'), you can
> > suspend threads a1, a2, b1 & b2 and remove the domains they were running
> > in to allow job A (big job with threads A1, A2, A3, & A4) to run on the
> > larger 4 CPU domain.  When you then suspend A1-A4 again to allow the
> > smaller jobs to proceed, you can pretty trivially create the 2 CPU
> > domains underneath the 4 CPU domain and resume the jobs.  Those jobs (a
> > & b) have been suspended on the CPUs they were originally running on,
> > and thus will resume on the same CPUs without any extra effort.  They
> > will simply run on those CPUs, and at load balance time, the domains
> > attached to those CPUs will be consulted to determine where the tasks
> > can be relocated to if there is a heavy load.  The domains will tell the
> > scheduler that the tasks cannot be relocated outside the 2 CPUs in each
> > respective domain.  Viola!  (sorta ;)
> Voilà ;-)

hehe...  My French spelling obviously isn't quite up to par. ;)


> I agree that this looks really smooth from a scheduler point of view.
> 
> From a user point of view, remains the issue of suspending the tasks:
> -find which tasks to suspend : how do you know that job 'a' consists 
> exactly of 'a1' and 'a2'
> -suspend them (btw, how do you achieve this ? kill -STOP ?)
> 
> 
> I've been away from my mail and still trying to catch up, nevermind if the 
> above does not makes sense to you.
> 
> 	Simon.

Paul didn't go into specifics about how to suspend the job, so neither
did I.  Sending SIGSTOP & SIGCONT should work, as you mention...  Those
are implementation details which really aren't *that* important to the
discussion.  We're still trying to figure out the overall framework and
API to work with, so which method of suspending a thread we'll
eventually use can be tackled down the road.  :)

-Matt

