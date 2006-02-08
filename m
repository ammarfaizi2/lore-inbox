Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbWBHS5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbWBHS5W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbWBHS5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:57:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41681 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030463AbWBHS5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:57:22 -0500
Date: Wed, 8 Feb 2006 10:57:14 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
Message-Id: <20060208105714.15bb4bb2.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602081037240.3590@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
	<20060208103323.7ba3709e.pj@sgi.com>
	<Pine.LNX.4.62.0602081037240.3590@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No it only disables the oom killer for constrained allocations.

But on many big numa systems, the way they are administered,
that affectively disables the oom killer.

> F.e. a sysadmin may mistakenly start a process allocating too much memory
> in a cpuset. The OOM killer will then start randomly shooting other 
> processes one of which may be a critical process.. Ouch.

That same exact claim could be made to justify a patch that
removed mm/oom_kill.c entirely.  And the same exact claim
could be made, dropping the "in a cpuset" phrase, on an UMA
desktop PC.

The basic premise of the oom killer is that, instead of blowing
off the caller, who might innocently have asked for one page
too many after some other hog used up all the available memory,
we try to pick the worst offender.

Get the worst offender, not just who ever finally hit the limit.

> Actually a good Denial of service attack than can be used with cpusets 
> and memory policies.

Nothing special about cpusets there.   The same DOS opportunity
exists on simple one cpu, one node systems.

...

Granted, I am objecting to this patch with mixed feelings.

I've yet to be convinced that the oom killer is our friend,
and half of me (not seriously) is almost wishing it were
gone.

Would another option be to continue to fine tune the heuristics
that the oom killer uses to pick its next victim?

What situation did you hit that motivated this change?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
