Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266759AbUGUWco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266759AbUGUWco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266761AbUGUWcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:32:43 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:61960 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S266759AbUGUWcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:32:42 -0400
Date: Wed, 21 Jul 2004 15:31:44 -0700
To: Bill Huey <bhuey@lnxw.com>
Cc: Ingo Molnar <mingo@elte.hu>, Scott Wood <scott@timesys.com>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721223144.GA9303@nietzsche.lynx.com>
References: <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721210051.GA2744@yoda.timesys> <20040721211826.GB30871@elte.hu> <20040721221423.GA1774@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721221423.GA1774@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040523i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 03:14:23PM -0700, Bill Huey wrote:
> On Wed, Jul 21, 2004 at 11:18:26PM +0200, Ingo Molnar wrote:
> > trying to make softirqs preemptible surely wont fly for 2.6 and it will
> > also overly complicate the softirq model. What's so terminally wrong
> > about adding preemption checks to the softirq paths? It should solve the
> > preemption problem for good. The unbound softirq paths are well-known
> > (mostly in the networking code) and already have preemption-alike
> > checks.
> 
> These folks are tring to make the entire kernel fully preemptable,
> possibly, to handle arbitrary preemption at any point during the
> execution. It's a noble task to make the kernel preemptable in that
> way, but what I've seen is that the use of non-preemptive critical
> sections commits all locks below it in the call/lock graph to also
> be non-preemptive critical sections and therefore forcing the use
> of traditional lock-break and other techniques to lower latency.

One thing that would preserve the correctness of this system might be to
use a per-CPU blocking lock to directly back the uses of local_bh_*
functions explicitly. This altered system would be functionally isomorphic,
but would permit preemption in bhs.

This is something I've been thinking about for a while so it could be
off track or wrong and I'm open (pleading) for correction.

It's a radical departure from the current "deferred-everthing" model
that Linux and many other general purpose OSes are currently using.
The overall performance penalty is unknown, but the possiblity of
lowering latency could still be very significant.

bill

