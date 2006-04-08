Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWDHIGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWDHIGV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 04:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWDHIGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 04:06:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:9436 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751400AbWDHIGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 04:06:20 -0400
Date: Sat, 8 Apr 2006 10:03:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
Message-ID: <20060408080349.GA19195@elte.hu>
References: <200604052025.05679.darren@dvhart.com> <20060407091946.GA28421@elte.hu> <20060407103926.GC11706@gnuppy.monkey.org> <200604070756.21625.darren@dvhart.com> <20060407210633.GA15971@gnuppy.monkey.org> <20060408071657.GA11660@elte.hu> <20060408072530.GA14364@elte.hu> <20060408075430.GA19403@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408075430.GA19403@gnuppy.monkey.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> The last time I looked at it I thought it did something pretty 
> simplistic in that it just dumped any RT thread to another CPU but 
> didn't do it in a strict manner with regard to priority. Maybe that's 
> changed or else I didn't pay attention to it that as carefully as I 
> thought.

well as Darren's testcase shows, it might still have some bug - but the 
mechanism is intended to be strict. (the implementation had a couple of 
strictness bugs (they show up as long latencies on SMP) but those were 
ironed out months ago.)

> As far as CPU binding goes, I'm wanting a method of getting around the 
> latency of the rt overload logic in certain cases at the expense of 
> rebalancing. That's what I ment by it.

yeah, that certainly makes sense, and it's one reason why i'm thinking 
about the separate SCHED_FIFO_GLOBAL policy for 'globally scheduled' RT 
tasks, while still keeping the current lightweight non-global RT 
scheduling. Global scheduling either means a global lock, or as in the 
-rt implementation means a "global IPI", but there's always a nontrivial 
"global" cost involved.

	Ingo
