Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWBJHCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWBJHCX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 02:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBJHCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 02:02:22 -0500
Received: from fmr21.intel.com ([143.183.121.13]:47295 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751165AbWBJHCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 02:02:22 -0500
Date: Thu, 9 Feb 2006 23:01:45 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, npiggin@suse.de, mingo@elte.hu,
       rostedt@goodmis.org, pwil3058@bigpond.net.au, suresh.b.siddha@intel.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
Message-ID: <20060209230145.A17405@unix-os.sc.intel.com>
References: <20060207142828.GA20930@wotan.suse.de> <200602080157.07823.kernel@kolivas.org> <20060207141525.19d2b1be.akpm@osdl.org> <200602081011.09749.kernel@kolivas.org> <20060207153617.6520f126.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060207153617.6520f126.akpm@osdl.org>; from akpm@osdl.org on Tue, Feb 07, 2006 at 03:36:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 03:36:17PM -0800, Andrew Morton wrote:
> Suresh, Martin, Ingo, Nick and Con: please drop everything, triple-check
> and test this:
> 
> From: Peter Williams <pwil3058@bigpond.net.au>
> 
> This is a modified version of Con Kolivas's patch to add "nice" support to
> load balancing across physical CPUs on SMP systems.

I have couple of issues with this patch.

a) on a lightly loaded system, this will result in higher priority job hopping 
around from one processor to another processor.. This is because of the 
code in find_busiest_group() which assumes that SCHED_LOAD_SCALE represents 
a unit process load and with nice_to_bias calculations this is no longer 
true(in the presence of non nice-0 tasks)

My testing showed that 178.galgel in SPECfp2000 is down by ~10% when run with 
nice -20 on a 4P(8-way with HT) system compared to a nice-0 run.

b) On a lightly loaded system, this can result in HT scheduler optimizations
being disabled in presence of low priority tasks... in this case, they(low
priority ones) can end up running on the same package, even in the presence 
of other idle packages.. Though this is not as serious as "a" above...

thanks,
suresh
