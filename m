Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWFBWb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWFBWb5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 18:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWFBWb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 18:31:57 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:53637 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932582AbWFBWb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 18:31:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Sat, 3 Jun 2006 08:31:40 +1000
User-Agent: KMail/1.9.1
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
References: <000401c68692$a90cbf90$df34030a@amr.corp.intel.com>
In-Reply-To: <000401c68692$a90cbf90$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606030831.41117.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 08:19, Chen, Kenneth W wrote:
> Con Kolivas wrote on Friday, June 02, 2006 3:15 PM
>
> > On Saturday 03 June 2006 06:53, Chen, Kenneth W wrote:
> > > Con Kolivas wrote on Friday, June 02, 2006 3:13 AM
> > >
> > > > On Friday 02 June 2006 19:53, Chen, Kenneth W wrote:
> > > > > Yeah, but that is the worst case though.  Average would probably be
> > > > > a lot lower than worst case.  Also, on smt it's not like the
> > > > > current logical cpu is getting blocked because of another task is
> > > > > running on its sibling CPU. The hardware still guarantees equal
> > > > > share of hardware resources for both logical CPUs.
> > > >
> > > > "Equal share of hardware resources" is exactly the problem; they
> > > > shouldn't have equal share since they're sharing one physical cpu's
> > > > resources. It's a relative breakage of the imposed nice support and I
> > > > disagree with your conclusion.
> > >
> > > But you keep on missing the point that this only happens in the initial
> > > stage of tasks competing for CPU resources.
> > >
> > > If this is broken, then current smt nice is equally broken with the
> > > same reasoning: once the low priority task gets scheduled, there is
> > > nothing to kick it off the CPU until its entire time slice get used up.
> > >  They compete equally with a high priority task running on the sibling
> > > CPU.
> >
> > There has to be some way of metering it out and in the absence of cpu
> > based hardware priority support (like ppc64 has) the only useful thing we
> > have to work with is timeslice. Yes sometimes the high priority task is
> > at the start and sometimes at the end of the timeslice but overall it
> > balances the proportions out reasonably fairly.
>
> Good!  Then why special case the initial stage?  Just let task run and it
> will even out statistically.  Everyone is happy, less code, less special
> case, same end result.

Hang on I think I missed something there. What did you conclude I conceded 
there? When I say "work with timeslice" I mean use percentage of timeslice 
the way smt nice currently does.

-- 
-ck
