Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVBUFKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVBUFKX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 00:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVBUFKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 00:10:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19887 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261861AbVBUFKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 00:10:14 -0500
Date: Sun, 20 Feb 2005 21:08:29 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au
Subject: Re: [patch] sched: auto-tuning task-migration
Message-Id: <20050220210829.00010ef2.pj@sgi.com>
In-Reply-To: <20041006132930.GA1814@elte.hu>
References: <200410060042.i960gn631637@unix-os.sc.intel.com>
	<20041006132930.GA1814@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A long long time ago (Oct 2004) Ingo wrote:
> the following patch adds a new feature to the scheduler: during bootup
> it measures migration costs and sets up cache_hot value accordingly.

Ingo - what became of this patch?

I made a quick search for it in Linus's bk tree and Andrew's *-mm
patches, but didn't find it.  Perhaps I didn't know what to look for.

The metric it exposes looks like something I might want to expose to
userland, so the performance guys can begin optimizing the placement of
tasks on CPUs, depending on whether they would benefit from, or be
harmed by, sharing cache.  Would the two halves of a hyper threaded core
show up as particularly close on this metric?  I presume so.

It seems to me to be a good complement to the current cpu-memory
distance we have now in node_distance() exposing the ACPI 2.0 SLIT
table distances.

I view the two key numbers here as (1) how fast can a cpu get stuff out
of a memory node (an amalgam of bandwidth and latency), and (2) how much
cache and buses and such do two cpus share (which can be good or bad,
depending on whether the two tasks on those two cpus share much of their
cache footprint).

The SLIT table provides (1) just fine.  Your patch seems to compute a
sensible estimate of (2).

I had one worry - was there a potential O(N**2) cost in computing this
at boottime, where N is the number of nodes?  Us SGI folks are usually
amongst the first to notice such details, when they blow up on us ;).

I never actually saw the original patch -- perhaps if I had, some of
my questions above would have obvious answers.

Thanks.  (and thanks for cpus_allowed -- I've practically made a
profession out of building stuff on top of that one ... ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
