Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266625AbUGVCc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266625AbUGVCc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 22:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266678AbUGVCc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 22:32:59 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:17089 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266625AbUGVCc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 22:32:57 -0400
Date: Wed, 21 Jul 2004 22:32:35 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040722023235.GB3298@yoda.timesys>
References: <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721184308.GA27034@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721184308.GA27034@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 08:43:08PM +0200, Ingo Molnar wrote:
> * Scott Wood <scott@timesys.com> wrote:
> > What aspects of it do you find unnecessary?  The second thread is
> > needed to maintain the current high/low priority semantics (without
> > that, you'll either starve regular tasks with a lot of softirqs, or
> > starve softirqs with a busy userspace, depending on how you set the
> > priority of the softirq thread).
> 
> what high/low semantics do you mean, other than the ordering of softirq
> sources? (which is currently implemented via the __do_softirq() loop
> first looking at the highest prio softirq.) So splitting up ksoftirqd
> into two pieces seems like a separate issue.

I meant the current split between immediate-context softirqs (which
are repesented in the patch by the high-priority ksoftirqd) and the
low-priority thread which is used to avoid starvation while allowing
softirqs to continue running if the system's otherwise more or less
idle.

> > BTW, it was my patch; Yarroll only submitted it to the list (as he
> > stated at the time).
> 
> ok - sorry about the misattribution!

It's OK; I just don't want him to be blamed for my bugs. :-)

-Scott
