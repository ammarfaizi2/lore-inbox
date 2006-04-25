Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWDYVfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWDYVfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWDYVfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:35:20 -0400
Received: from mga07.intel.com ([143.182.124.22]:54096 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751580AbWDYVfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:35:19 -0400
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="27724806:sNHT19849494"
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="27724799:sNHT22921717"
TrustInternalSourcedMail: True
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="27693549:sNHT25810015"
Date: Tue, 25 Apr 2006 14:32:11 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] sched: Avoid unnecessarily moving highest priority task move_tasks()
Message-ID: <20060425143211.A24677@unix-os.sc.intel.com>
References: <44485E21.6070801@bigpond.net.au> <20060421173416.C17932@unix-os.sc.intel.com> <44498771.1030409@bigpond.net.au> <20060424120014.A16716@unix-os.sc.intel.com> <444D5989.3060002@bigpond.net.au> <20060424164800.B16716@unix-os.sc.intel.com> <444D89A8.7070109@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <444D89A8.7070109@bigpond.net.au>; from pwil3058@bigpond.net.au on Tue, Apr 25, 2006 at 12:30:00PM +1000
X-OriginalArrivalTime: 25 Apr 2006 21:35:18.0031 (UTC) FILETIME=[258F29F0:01C668B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:30:00PM +1000, Peter Williams wrote:
> Siddha, Suresh B wrote:
> > And we also need to initialize busiest_best_prio_seen inside this check.
> > (like in my patch)
> > 	if (busiest->expired->nr_active) {
> 
> Why?  It's already initialized.  If the current running task has 
> prio==busiest_best_prio then we know that can_migrate_task() will 
> prevent it from being moved so it's safe to move any other tasks we meet 
> with that priority.
> > And we need to reset busiest_best_prio_seen to '0' whenever we finished
> > the checking of expired list (and move onto active list) and there are
> > no best prio tasks on expired list..
> 
> No we don't.  Once we've skipped one it's OK to move any others that we 
> find.  We'll never move more than one as a result of overriding the skip 
> anyhow .

Ok.

> 
> > 
> >>> @@ -2072,6 +2067,13 @@ static int move_tasks(runqueue_t *this_r
> >>>  	if (busiest->expired->nr_active) {
> >>>  		array = busiest->expired;
> >>>  		dst_array = this_rq->expired;
> >>> +		/*
> >>> +		 * We already have one or more busiest best prio tasks on
> >>> +		 * active list.
> >> This is a pretty bold assertion.  How do we know that this is true.
> > 
> > That comment refers to when 'busiest_best_prio_seen' is initialized to '1'.
> > Comment needs to be fixed.
> 
> But you initialized it to zero.

That comment refers to the assignment code below it..

Anyhow, now that we are going with fixes to your patch, this is a moot point.

thanks,
suresh
