Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWFBWTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWFBWTs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 18:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWFBWTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 18:19:48 -0400
Received: from mga03.intel.com ([143.182.124.21]:8611 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751501AbWFBWTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 18:19:48 -0400
X-IronPort-AV: i="4.05,205,1146466800"; 
   d="scan'208"; a="45282178:sNHT18947733"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, <linux-kernel@vger.kernel.org>,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 15:19:48 -0700
Message-ID: <000401c68692$a90cbf90$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaGkhVXJGd3BSh4QZmhb5tHgZ7ltgAADOWA
In-Reply-To: <200606030815.22187.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Friday, June 02, 2006 3:15 PM
> On Saturday 03 June 2006 06:53, Chen, Kenneth W wrote:
> > Con Kolivas wrote on Friday, June 02, 2006 3:13 AM
> >
> > > On Friday 02 June 2006 19:53, Chen, Kenneth W wrote:
> > > > Yeah, but that is the worst case though.  Average would probably be a
> > > > lot lower than worst case.  Also, on smt it's not like the current
> > > > logical cpu is getting blocked because of another task is running on
> > > > its sibling CPU. The hardware still guarantees equal share of hardware
> > > > resources for both logical CPUs.
> > >
> > > "Equal share of hardware resources" is exactly the problem; they
> > > shouldn't have equal share since they're sharing one physical cpu's
> > > resources. It's a relative breakage of the imposed nice support and I
> > > disagree with your conclusion.
> >
> > But you keep on missing the point that this only happens in the initial
> > stage of tasks competing for CPU resources.
> >
> > If this is broken, then current smt nice is equally broken with the same
> > reasoning: once the low priority task gets scheduled, there is nothing
> > to kick it off the CPU until its entire time slice get used up.  They
> > compete equally with a high priority task running on the sibling CPU.
> 
> There has to be some way of metering it out and in the absence of cpu based 
> hardware priority support (like ppc64 has) the only useful thing we have to 
> work with is timeslice. Yes sometimes the high priority task is at the start 
> and sometimes at the end of the timeslice but overall it balances the 
> proportions out reasonably fairly.


Good!  Then why special case the initial stage?  Just let task run and it
will even out statistically.  Everyone is happy, less code, less special
case, same end result.

