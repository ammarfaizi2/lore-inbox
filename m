Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUCSRWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 12:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUCSRWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 12:22:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37077 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263040AbUCSRWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 12:22:48 -0500
Date: Fri, 19 Mar 2004 22:52:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, andrea@suse.de, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040319172203.GB4537@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de> <20040318110159.321754d8.akpm@osdl.org> <s5hbrmuc6ed.wl@alsa2.suse.de> <20040318221006.74246648.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318221006.74246648.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 10:10:06PM -0800, Andrew Morton wrote:
> The worst-case latency is during umount, fs/inode.c:invalidate_list() when
> the filesystem has a zillion inodes in icache.  Measured 250 milliseconds
> on a 256MB 2.7GHz P4 here.   OK, so don't do that.
> 
> The unavoidable worst case is in the RCU callbacks for dcache shrinkage -
> I've seen 25 millisecond holdoffs on the above machine during filesystem
> stresstests when RCU is freeing a huge number of dentries in softirq
> context.

What filesystem stresstest was that ? 

> 
> This if Hard To Fix.  Dipankar spent quite some time looking into it and
> had patches, but I lost track of where they're at.

And I am still working on this on a larger scope/scale. Yes, I have
a patch that hands over the rcu callbacks to a per-cpu kernel thread
reducing the softirq time. However this is not really a solution to
the overall problem, IMO. I am collecting some instrumentation
data to understand softirq/rcu behavior during heavy loads and
ways to counter long running softirqs.

Latency isn't the only issue. DoS on route cache is another
issue that needs to be addressed. I have been experimenting
with Robert Olsson's router test and should have some more results
out soon.

Thanks
Dipankar
