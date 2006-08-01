Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWHATKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWHATKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWHATKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:10:34 -0400
Received: from mga05.intel.com ([192.55.52.89]:55052 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751805AbWHATKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:10:33 -0400
X-IronPort-AV: i="4.07,203,1151910000"; 
   d="scan'208"; a="108647631:sNHT44086910"
Date: Tue, 1 Aug 2006 12:00:02 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, vatsa@in.ibm.com, Simon.Derr@bull.net,
       steiner@sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] sched: big numa dynamic sched domain memory corruption
Message-ID: <20060801120002.C9822@unix-os.sc.intel.com>
References: <20060731070734.19126.40501.sendpatchset@v0> <20060731071242.GA31377@elte.hu> <20060731090440.A2311@unix-os.sc.intel.com> <20060801012533.4192c5b4.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060801012533.4192c5b4.pj@sgi.com>; from pj@sgi.com on Tue, Aug 01, 2006 at 01:25:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 01:25:33AM -0700, Paul Jackson wrote:
> I wish you well on any further code improvements you have planned for
> this code.  It's tough to understand, with such issues as many #ifdef's,
> an interesting memory layout of the key sched domain arrays that I
> didn't see described much in the comments, and a variety of memory
> allocation calls that are tough to unravel on error.  Portions of
> the code could use some more comments, explaining what is going on.
> For example, I still haven't figured exactly what 'cpu_power' means.

I will add some info to Documentation/sched-domains.txt aswell as some
comments to the code where appropriate. I did some cleanup of the code
but unfortunately that got dropped because of some issues. I will repost
that cleanup patch aswell.

> 
> The allocations of sched_group_allnodes, sched_group_phys and
> sched_group_core are -big- on our ia64 SN2 systems (1024 CPUs),
> and could fail once a system has been up for a while and is
> getting memory tight and fragmented.

I have to agree with you. I have an idea(basically passing cpu_map info
to functions which determine the group) to solve this issue. Let me work
on it and post a fix.

> It is not obvious to me from the code or comments just how sched
> domains are arranged on various large systems with hyper-threading
> (SMT) and/or multiple cores (MC) and/or multiple processor packages
> per node, and how scheduling is affected by all this.

Enabling SCHED_DOMAIN_DEBUG should atleast show how sched domains
and groups are arranged. Adding an example in Documentation might
be a good idea.

> 
> This was about the third bug that has come by in it -- which I
> in particular notice when it is someone playing with cpu_exclusive
> cpusets who hits the bug.  Any kernel backtrace with 'cpuset' buried in
> it tends to migrate to my inbox.  This latest bug was particularly
> nasty, as is usually the case with random memory corruption bugs,
> costing us a bunch of hours.
> 
> Good luck.
> 
> If you are aware of any other fixes/patches besides the above that us
> big honkin numa iron SLES10 users need for reliable operation, let me
> know.

Will keep you in loop.

thanks,
suresh
