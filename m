Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTERIh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 04:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbTERIh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 04:37:57 -0400
Received: from pop.gmx.de ([213.165.64.20]:50482 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261241AbTERIh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 04:37:56 -0400
Message-Id: <5.2.0.9.2.20030518103757.00ce93e8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sun, 18 May 2003 10:55:17 +0200
To: "David Schwartz" <davids@webmaster.com>
From: Mike Galbraith <efault@gmx.de>
Subject: RE: Scheduling problem with 2.4?
Cc: "Andrea Arcangeli" <andrea@suse.de>, <dak@gnu.org>,
       <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIELBDAAA.davids@webmaster.com>
References: <20030517235048.GB1429@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:16 PM 5/17/2003 -0700, David Schwartz wrote:

> > I see what you mean, but I still don't think it is a problem. If
> > bandwidth matters you will have to use large writes and reads anyways,
> > if bandwidth doesn't matter the number of ctx switches doesn't matter
> > either and latency usually is way more important with small messages.
>
> > Andrea
>
>         This is the danger of pre-emption based upon dynamic priorities. 
> You can
>get cases where two processes each are permitted to make a very small amount
>of progress in alternation. This can happen just as well with large writes
>as small ones, the amount of data is irrelevent, it's the amount of CPU time
>that's important, or to put it another way, it's how far a process can get
>without suffering a context switch.
>
>         I suggest that a process be permitted to use up at least some 
> portion of
>its timeslice exempt from any pre-emption based solely on dynamic
>priorities.

Cool.

Thank you for the spiffy idea.  I implemented this in my (hack/chop) mm5 
tree in about 30 seconds, and it works just fine.  Very simple 
time_after(jiffies, p->last_run + MIN_TIMESLICE) checks in wake_up_cpu() 
plus the obvious dinky change to schedule(), and it worked 
instantly.  Hmm.. I wonder if this might help some of the other scheduler 
(seemingly) bad behavior as well.

Is there any down-side to not preempting quite as often?  It seems like 
there should be a bandwidth gain.

         -Mike 

