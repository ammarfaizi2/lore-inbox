Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWCDFYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWCDFYj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 00:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWCDFYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 00:24:39 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:17364 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750967AbWCDFYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 00:24:39 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch 2.6.16-rc5-mm2]  sched_cleanup-V17 - task throttling patch 1 of 2
Date: Sat, 4 Mar 2006 16:24:05 +1100
User-Agent: KMail/1.9.1
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       lkml <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
References: <1140183903.14128.77.camel@homer> <4408FC8B.4050802@bigpond.net.au> <1141449654.7703.36.camel@homer>
In-Reply-To: <1141449654.7703.36.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603041624.06656.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 March 2006 16:20, Mike Galbraith wrote:
> On Sat, 2006-03-04 at 13:33 +1100, Peter Williams wrote:
> > >  include/linux/sched.h |    3 -
> > >  kernel/sched.c        |  136
> > > +++++++++++++++++++++++++++++--------------------- 2 files changed, 82
> > > insertions(+), 57 deletions(-)
> > >
> > > --- linux-2.6.16-rc5-mm2/include/linux/sched.h.org	2006-03-01
> > > 15:06:22.000000000 +0100 +++
> > > linux-2.6.16-rc5-mm2/include/linux/sched.h	2006-03-02
> > > 08:33:12.000000000 +0100 @@ -720,7 +720,8 @@
> > >
> > >  	unsigned long policy;
> > >  	cpumask_t cpus_allowed;
> > > -	unsigned int time_slice, first_time_slice;
> > > +	int time_slice;
> >
> > Can you guarantee that int is big enough to hold a time slice in
> > nanoseconds on all systems?  I think that you'll need more than 16 bits.
>
> Nope, that's a big fat bug.

Most ints are 32bit anyway, but even a 32 bit unsigned int overflows with 
nanoseconds at 4.2 seconds. A signed one at about half that. Our timeslices 
are never that large, but then int isn't always 32bit either.

Cheers,
Con
