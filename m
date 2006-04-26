Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWDZATP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWDZATP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 20:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWDZATP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 20:19:15 -0400
Received: from mga05.intel.com ([192.55.52.89]:16227 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932315AbWDZATO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 20:19:14 -0400
X-IronPort-AV: i="4.04,155,1144047600"; 
   d="scan'208"; a="28569658:sNHT3147930961"
X-IronPort-AV: i="4.04,155,1144047600"; 
   d="scan'208"; a="27759391:sNHT2640118187"
TrustInternalSourcedMail: True
X-IronPort-AV: i="4.04,155,1144047600"; 
   d="scan'208"; a="27785768:sNHT38516751"
Date: Tue, 25 Apr 2006 17:15:21 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] sched: fix evaluation of skip_for_load in move_tasks()
Message-ID: <20060425171521.B24677@unix-os.sc.intel.com>
References: <444D9290.6070706@bigpond.net.au> <20060425092840.A23188@unix-os.sc.intel.com> <444EAF74.8090705@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <444EAF74.8090705@bigpond.net.au>; from pwil3058@bigpond.net.au on Wed, Apr 26, 2006 at 09:23:32AM +1000
X-OriginalArrivalTime: 26 Apr 2006 00:18:26.0425 (UTC) FILETIME=[EFE58E90:01C668C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 09:23:32AM +1000, Peter Williams wrote:
> Siddha, Suresh B wrote:
> > I think we need to change this to
> > 	if (skip_for_load && idx < this_best_prio && idx == busiest_best_prio)
> > 		skip_for_load = !busiest_best_prio_seen;
> > 
> > Otherwise we will reset skip_for_load to '0' even for the tasks whose prio is 
> > less than this_best_prio but not equal to busiest_best_prio.
> 
> And why is that a problem?  The intention of this code is to make sure 
> at least one busiest_best_prio task doesn't get moved as a result of the 
> "skip for reasons of load weight" mechanism being overridden by the "idx 
> < this_best_prio" exception.  I can't see how this intention is being 
> subverted.

There might be scenarios where we will endup moving other priority tasks(
not those with busiest_best_prio) which will still become highest priority
on new queue. This may or may not be bad. But this was not our intention
with the intended code, right?

thanks,
suresh
