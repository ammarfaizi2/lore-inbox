Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbUCWJPX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 04:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUCWJPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 04:15:23 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24207 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262384AbUCWJPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 04:15:20 -0500
Date: Tue, 23 Mar 2004 14:44:27 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040323091427.GB3676@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de> <20040318110159.321754d8.akpm@osdl.org> <s5hbrmuc6ed.wl@alsa2.suse.de> <20040318221006.74246648.akpm@osdl.org> <s5hznadb03r.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hznadb03r.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 11:30:16AM +0100, Takashi Iwai wrote:
> > The unavoidable worst case is in the RCU callbacks for dcache shrinkage -
> > I've seen 25 millisecond holdoffs on the above machine during filesystem
> > stresstests when RCU is freeing a huge number of dentries in softirq
> > context.
> 
> hmm, this wasn't also evaluated in my tests.
> it's worthy to try.  thanks for the info.

Please do. This would be a very interesting data point.

> 
> > This if Hard To Fix.  Dipankar spent quite some time looking into it and
> > had patches, but I lost track of where they're at.
> 
> couldn't this tasklet be replaced with workqueue or such?

Close. I am using per-cpu kernel threads to hand over the rcu callbacks
if there are too many of them. It depends on CONFIG_PREEMPT on better
latency from there onwards.

I can use a workqueue, but I needed the flexibility experiment with
the kernel thread for now.

Thanks
Dipankar
