Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWCNW1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWCNW1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWCNW1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:27:12 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:57507 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932536AbWCNW1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:27:11 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH][2/4] sched: add discrete weighted cpu load function
Date: Wed, 15 Mar 2006 09:26:51 +1100
User-Agent: KMail/1.9.1
Cc: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, ck list <ck@vds.kolivas.org>
References: <200603131906.11739.kernel@kolivas.org> <cone.1142290371.837084.5853.501@kolivas.org> <44173F32.9020302@bigpond.net.au>
In-Reply-To: <44173F32.9020302@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603150926.52064.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 March 2006 09:09, Peter Williams wrote:
> Con Kolivas wrote:
> > Peter Williams writes:
> >> Con Kolivas wrote:
> >>> +unsigned long weighted_cpuload(const int cpu)
> >>> +{
> >>> +    return (cpu_rq(cpu)->raw_weighted_load);
> >>> +}
> >>> +
> >>
> >> Wouldn't this be a candidate for inlining?
> >
> > That would make it unsuitable for exporting via sched.h.
>
> If above_background_load() were implemented inside sched.c instead of in
> sched.h there would be no need to export weighted_cpuload() would there?
>   This would allow weighted_cpuload() to be inline and the efficiency
> would be better as above_background_load() doesn't gain a lot by being
> inline

I don't care about above_background_load() being inline; that's done because 
all functions in header files need to be static inline to not become a mess.

> as having weighted_cpulpad() non inline means that it's doing a 
> function call several times in a loop i.e. it may save one function call
> by being inline but requires (up to) one function call for every CPU.

I haven't checked but gcc may well inline weighted_cpuload anyway? We're 
moving away from inlining most things manually since the compiler is doing it 
well these days.

> The other way around the cost would be just one function call.

The way you're suggesting adds a function that is never used by anything but 
swap prefetch which would then need to be 'ifdef'ed out to not be needlessly 
built on every system. Adding ifdefs is frowned upon already, and to have an 
mm/ specific ifdef in sched.c would be rather ugly.

Cheers,
Con
