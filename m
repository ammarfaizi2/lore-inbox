Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266523AbUGUWPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266523AbUGUWPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266759AbUGUWO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:14:59 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:32776 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S266523AbUGUWOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:14:48 -0400
Date: Wed, 21 Jul 2004 15:14:23 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721221423.GA1774@nietzsche.lynx.com>
References: <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721210051.GA2744@yoda.timesys> <20040721211826.GB30871@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721211826.GB30871@elte.hu>
User-Agent: Mutt/1.5.6+20040523i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 11:18:26PM +0200, Ingo Molnar wrote:
> trying to make softirqs preemptible surely wont fly for 2.6 and it will
> also overly complicate the softirq model. What's so terminally wrong
> about adding preemption checks to the softirq paths? It should solve the
> preemption problem for good. The unbound softirq paths are well-known
> (mostly in the networking code) and already have preemption-alike
> checks.

These folks are tring to make the entire kernel fully preemptable,
possibly, to handle arbitrary preemption at any point during the
execution. It's a noble task to make the kernel preemptable in that
way, but what I've seen is that the use of non-preemptive critical
sections commits all locks below it in the call/lock graph to also
be non-preemptive critical sections and therefore forcing the use
of traditional lock-break and other techniques to lower latency.

Adding preemption points helps with the problems, but isn't something
that can be guaranteed to have a certain latency within N numbers of
context switches and some rescheduling computations, etc...

IMO, this is something that the Linux community should think about
being friendly to or have some kind of consideration for the possibility
of this.

bill

