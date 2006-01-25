Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWAYW4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWAYW4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWAYW4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:56:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16850 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932205AbWAYW4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:56:22 -0500
Date: Wed, 25 Jan 2006 23:56:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: dipankar@in.ibm.com, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060125225639.GA1382@elte.hu>
References: <20060124080157.GA25855@elte.hu> <1138090078.2771.88.camel@mindpipe> <20060124081301.GC25855@elte.hu> <1138090527.2771.91.camel@mindpipe> <20060124091730.GA31204@us.ibm.com> <20060124092330.GA7060@elte.hu> <1138095856.2771.103.camel@mindpipe> <20060124162846.GA7139@in.ibm.com> <20060124213802.GC7139@in.ibm.com> <1138224506.3087.22.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138224506.3087.22.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > Here is an updated version of that patch against 2.6.16-rc1. I have
> > sanity-tested it on ppc64 and x86_64 using dbench and kernbench.
> > I have also tested this for OOM situations - open()/close() in
> > a tight loop in my x86_64 which earlier used to reach file limit
> > if I set batch limit to 10 and found no problem. This patch does set 
> > default RCU batch limit to 10 and changes it only when there is an RCU
> > flood.
> 
> OK this seems to work, I can't tell yet whether it help the latency I 
> reported, but rt_run_flush still produces terrible latencies.
> 
> Ingo, should I try the softirq preemption patch + Dipankar's patch + 
> latency tracing patch?

yes, that would be a nice test. (I'm busy now with mutex stuff to be 
able to do a working softirq-preemption patch, but i sent you my current 
patches off-list - if you want to give it a shot. Be warned though, 
there will likely be quite some merging work to do, so it's definitely 
not for the faint hearted.)

	Ingo
