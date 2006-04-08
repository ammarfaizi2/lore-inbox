Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWDHKC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWDHKC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 06:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWDHKC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 06:02:59 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:656
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751415AbWDHKC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 06:02:58 -0400
Date: Sat, 8 Apr 2006 03:02:43 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: RT task scheduling
Message-ID: <20060408100243.GA20624@gnuppy.monkey.org>
References: <200604052025.05679.darren@dvhart.com> <20060407091946.GA28421@elte.hu> <20060407103926.GC11706@gnuppy.monkey.org> <200604070756.21625.darren@dvhart.com> <20060407210633.GA15971@gnuppy.monkey.org> <20060408071657.GA11660@elte.hu> <20060408072530.GA14364@elte.hu> <20060408075430.GA19403@gnuppy.monkey.org> <20060408080349.GA19195@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408080349.GA19195@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2006 at 10:03:49AM +0200, Ingo Molnar wrote:
> * Bill Huey <billh@gnuppy.monkey.org> wrote:
> > As far as CPU binding goes, I'm wanting a method of getting around the 
> > latency of the rt overload logic in certain cases at the expense of 
> > rebalancing. That's what I ment by it.
> 
> yeah, that certainly makes sense, and it's one reason why i'm thinking 
> about the separate SCHED_FIFO_GLOBAL policy for 'globally scheduled' RT 
> tasks, while still keeping the current lightweight non-global RT 
> scheduling. Global scheduling either means a global lock, or as in the 
> -rt implementation means a "global IPI", but there's always a nontrivial 
> "global" cost involved.

This is an extremely tricky problem which is why I lean toward manual
techniques to resolve the issue. All automatic policies seem to fail for
one reason or another. Significant thought needs to be put to this
problem and you might not be able to effective address all parts of it.

It goes far beyond the conventions of SCHED_FIFO itself and really
forces one to think about what "priority" really is in the context of
the -rt patch, whether the priority range needs to be extended to a much
larger range (0-512 or larger) and other issues regarding that. I see
-rt SCHED_FIFO as a basic building block for other policies (done by
researchers) that can be faked in userspace (like scheduler activations),
but policies vary greatly given a typical load characteritic or demands
of a -rt app. No single policy can fullfill those needs and it's still
largely a research topic in many areas. Rebalancing in allocation
schedulers is still voodoo in SMP environments for example.

Please take this into consideration when thinking about SCHED_FIFO_GLOBAL
and related topics.

bill

