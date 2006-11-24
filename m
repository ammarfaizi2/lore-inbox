Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934953AbWKXWrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934953AbWKXWrq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 17:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935100AbWKXWrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 17:47:46 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:27577 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S934953AbWKXWrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 17:47:45 -0500
Message-ID: <456776A3.7070607@candelatech.com>
Date: Fri, 24 Nov 2006 14:48:03 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
References: <20061124170246.GA9956@elte.hu> <200611241813.13205.ak@suse.de> <20061124202514.GA7608@elte.hu>
In-Reply-To: <20061124202514.GA7608@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> nor can the TSC really be synced up properly in the hotplug CPU case, 
> after the fact - what if the app already read out an older TSC value and 
> a new CPU is added. If the TSC isnt sync on SMP then it quickly gets 
> pretty messy, and we should rather take a look at /why/ these apps are 
> using RDTSC.
>   

I've been using RDTSC in pktgen.  For my app, I am just trying to find a 
quick
way to determine if X nano-seconds have elapsed.  If it's occasionally 
off by a small amount,
that is OK as I have higher-level control logic that will correct 
long-term trends.

After poking around, I ended up just exporting sched_clock() and using that
instead of directly using RDTSC, but that was mostly just for convenience.

If RDTSC is not a good choice for the use I describe above, is there a 
better
method that is still very fast (as compared to do_gettimeofday())?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


