Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268353AbTCFVFO>; Thu, 6 Mar 2003 16:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268354AbTCFVFO>; Thu, 6 Mar 2003 16:05:14 -0500
Received: from fmr02.intel.com ([192.55.52.25]:17607 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268353AbTCFVFN> convert rfc822-to-8bit; Thu, 6 Mar 2003 16:05:13 -0500
content-class: urn:content-classes:message
Subject: RE: HT and idle = poll
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 6 Mar 2003 13:15:43 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB56401338853@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HT and idle = poll
Thread-Index: AcLkHBDwySW7UZjxTqqnW6VYpkX2XwABh6pQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Linus Torvalds" <torvalds@transmeta.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Mar 2003 21:15:44.0664 (UTC) FILETIME=[8CC81180:01C2E425]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

That's correct. Basically mwait is similar to hlt, but you can avoid IPI to wake up the processor waiting. A write to the address specified by monitor wakes up the processor, unlike hlt.

So our plan is to use monitor/mwait in the idle loop, for example, in the kernel to lower the latency.

Jun

> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@transmeta.com]
> Sent: Thursday, March 06, 2003 12:09 PM
> To: Alan Cox
> Cc: Linux Kernel Mailing List
> Subject: Re: HT and idle = poll
> 
> 
> On 6 Mar 2003, Alan Cox wrote:
> > On Thu, 2003-03-06 at 19:30, Linus Torvalds wrote:
> > > >So, don't use idle=poll with HT when you know your workload has idle
> time!  I
> > > >have not tried oprofile, but it stands to reason that this would be a
> >
> > idle=poll probably needs to be doing "rep nop" in a tight loop.
> 
> We already do that. It's not enough. The HT thing will still steal cycles
> continually, since the "rep nop" is really only equivalent to a
> "sched_yield()".
> 
> Think of "rep nop" as yielding, and "mwait" as a true wait.
> 
> (I don't actually have any real information on "mwait", so I may be wrong
> about the details on the new instructions. They looked obvious enough,
> though).
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
