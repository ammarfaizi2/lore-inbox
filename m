Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758474AbWLADfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758474AbWLADfJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 22:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758512AbWLADfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 22:35:09 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:6583 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1758474AbWLADfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 22:35:07 -0500
Date: Fri, 1 Dec 2006 07:13:13 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gautham R Shenoy <ego@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, davej@redhat.com,
       dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061201014313.GA25074@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061129152404.GA7082@in.ibm.com> <20061129130556.d20c726e.akpm@osdl.org> <20061130042807.GA4855@in.ibm.com> <20061130063512.GA19492@in.ibm.com> <20061130082934.GB29609@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130082934.GB29609@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 09:29:34AM +0100, Ingo Molnar wrote:
> what lockdep does is it observes actual locking dependencies as they
> happen individually in various contexts, and then 'completes' the
> dependency graph by combining all the possible scenarios how contexts
> might preempt each other. So if lockdep sees independent dependencies
> and concludes that they are circular, there's nothing that saves us from
> the deadlock.

Ingo,

Consider a case where we have three locks A, B and C.
We have very clear locking rule inside the kernel that lock A *should*
be acquired before acquiring either lock B or lock C.

At runtime lockdep detects the two dependency chains,
A --> B --> C

and

A --> C --> B.

Does lockdep issue a circular dependency warning for this ? 
It's quite clear from the locking rule that we cannot have a
circular deadlock, since A acts as a mutex for B->C / C->B callpath.

Just curious :-) [ Well, I might encounter such a scenario in an attempt
		   to make cpufreq cpu-hotplug safe! ]

> 	Ingo

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
