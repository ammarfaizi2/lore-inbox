Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752618AbWKBAbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbWKBAbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbWKBAbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:31:42 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:13477 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752618AbWKBAbl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:31:41 -0500
Subject: Re: [Devel] Re: [ckrm-tech] [RFC] Resource Management -
	Infrastructure choices
From: Matt Helsley <matthltc@us.ibm.com>
To: Kir Kolyshkin <kir@openvz.org>
Cc: devel@openvz.org, vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, dipankar@in.ibm.com,
       rohitseth@google.com, Paul Menage <menage@google.com>,
       Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <45492764.6060700@openvz.org>
References: <20061030103356.GA16833@in.ibm.com>
	 <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	 <20061101173356.GA18182@in.ibm.com> <45490F0D.7000804@nortel.com>
	 <45492764.6060700@openvz.org>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Wed, 01 Nov 2006 16:31:37 -0800
Message-Id: <1162427497.12419.186.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 02:01 +0300, Kir Kolyshkin wrote:
> Chris Friesen wrote:
> > Srivatsa Vaddagiri wrote:
> >
> >>>>        - Support limit (soft and/or hard depending on the resource
> >>>>          type) in controllers. Guarantee feature could be indirectly
> >>>>          met thr limits.
> >
> > I just thought I'd weigh in on this.  As far as our usage pattern is
> > concerned, guarantees cannot be met via limits.
> >
> > I want to give "x" cpu to container X, "y" cpu to container Y, and "z"
> > cpu to container Z.
> >
> > If these are percentages, x+y+z must be less than 100.
> >
> > However, if Y does not use its share of the cpu, I would like the
> > leftover cpu time to be made available to X and Z, in a ratio based on
> > their allocated weights.
> >
> > With limits, I don't see how I can get the ability for containers to
> > make opportunistic use of cpu that becomes available.
> This is basically how "cpuunits" in OpenVZ works. It is not limiting a
> container in any way, just assigns some relative "units" to it, with sum
> of all units across all containers equal to 100% CPU. Thus, if we have

	So the user doesn't really specify percentage but values that feed into
ratios used by the underlying controller? If so then it's not terribly
different from the "shares" of single level of Resource Groups. 

	Resource groups goes one step further and defines a denominator for
child groups to use. This allows the shares to be connected vertically
so that changes don't need to propagate beyond the parent and child
groups.

> cpuunits 10, 20, and 30 assigned to containers X, Y, and Z, and run some
> CPU-intensive tasks in all the containers, X will be given
> 10/(10+20+30), or 20% of CPU time, Y -- 20/50, i.e. 40%, while Z gets

nit: I don't think this math is correct.

Shouldn't they all have the same denominator (60), or am I
misunderstanding something?

If so then it should be:
X = 10/60      16.666...%
Y = 20/60      33.333...%
Z = 30/60      50.0%
Total:        100.0%

> 60%. Now, if Z is not using CPU, X will be given 33% and Y -- 66%. The
> scheduler used is based on a per-VE runqueues, is quite fair, and works
> fine and fair for, say, uneven case of 3 containers on a 4 CPU box.

<snip>

Cheers,
	-Matt Helsley

