Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262987AbVDBEF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbVDBEF0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 23:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbVDBEF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 23:05:26 -0500
Received: from fmr22.intel.com ([143.183.121.14]:63447 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262987AbVDBEFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 23:05:18 -0500
Date: Fri, 1 Apr 2005 20:05:10 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       akpm@osdl.org, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [patch] sched: improve pinned task handling again!
Message-ID: <20050401200509.C5598@unix-os.sc.intel.com>
References: <20050401185812.A5598@unix-os.sc.intel.com> <424E0D58.1070700@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <424E0D58.1070700@yahoo.com.au>; from nickpiggin@yahoo.com.au on Sat, Apr 02, 2005 at 01:11:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 01:11:20PM +1000, Nick Piggin wrote:
> How important is this? Any application to real workloads? Even if
> not, I agree it would be nice to improve this more. I don't know
> if I really like this approach - I guess due to what it adds to
> fastpaths.

Ken initially observed with older kernels(2.4 kernel with Ingo's sched), it was 
happening with few hundred processes. 2.6 is not that bad and it improved
with recent fixes. It is not very important. We want to raise the flag
and see if we can comeup with a decent solution.

We changed nr_running from "unsigned long" to "unsigned int". So on 64-bit
architectures, our change to fastpath is not a big deal.

> 
> Now presumably if the all_pinned logic is working properly in the
> first place, and it is correctly causing balancing to back-off, you
> could tweak that a bit to avoid livelocks? Perhaps the all_pinned
> case should back off faster than the usual doubling of the interval,
> and be allowed to exceed max_interval?

Coming up with that number(how much to exceed) will be a big task. It depends
on number of cpus and how fast they traverse the runqueue,...

thanks,
suresh
