Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753540AbWKCVOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbWKCVOl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 16:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753541AbWKCVOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 16:14:40 -0500
Received: from mga05.intel.com ([192.55.52.89]:28785 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1753540AbWKCVOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 16:14:40 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,386,1157353200"; 
   d="scan'208"; a="11387715:sNHT19128123"
Subject: Re: 2.6.19-rc1: x86_64 slowdown in lmbench's fork
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Andi Kleen <ak@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
In-Reply-To: <200611031847.49222.ak@suse.de>
References: <1162485897.10806.72.camel@localhost.localdomain>
	 <1162570216.10806.79.camel@localhost.localdomain>
	 <m1lkmsxwk7.fsf@ebiederm.dsl.xmission.com>  <200611031847.49222.ak@suse.de>
Content-Type: text/plain
Organization: Intel
Date: Fri, 03 Nov 2006 12:25:17 -0800
Message-Id: <1162585517.10806.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 18:47 +0100, Andi Kleen wrote:
> > So unless there is some other array that is sized by NR_IRQs
> > in the context switch path which could account for this in
> > other ways.  It looks like you just got unlucky.
> 
> 
> TLB/cache profiling data might be useful?
> My bet would be more on cache effects.
>  

The TLB miss, cache miss and page walk profiles did not change when I
measured it.

I have a suspicion that the overhead to pin parent and child
processes to specific cpu had something to do with the 
change in time observed.  Lmbench includes this overhead in
the fork time it reported.  I had chosen the lmbench option to
set parent and child process on specific cpu.

When I skip this by picking another lmbench option to let scheduler 
pick the placement of parent and child process. I see that 
the fork time now stays unchanged with this setting.  Wonder if
the increase in time is in sched_setaffinity.

Tim
