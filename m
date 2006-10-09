Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932953AbWJIQDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932953AbWJIQDX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932954AbWJIQDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:03:23 -0400
Received: from usea-naimss2.unisys.com ([192.61.61.104]:22544 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S932953AbWJIQDW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:03:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannothandle IRQ -1"
Date: Mon, 9 Oct 2006 11:02:45 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0D18@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <1160408360.3000.227.camel@laptopd505.fenrus.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannothandle IRQ -1"
Thread-Index: AcbruR6uLY8cHgzNR3+RfwqvZCJPMwAALgOQ
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Muli Ben-Yehuda" <muli@il.ibm.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Rajesh Shah" <rajesh.shah@intel.com>, "Andi Kleen" <ak@muc.de>,
       "Luck, Tony" <tony.luck@intel.com>, "Andrew Morton" <akpm@osdl.org>,
       "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Badari Pulavarty" <pbadari@gmail.com>,
       "Roland Dreier" <rdreier@cisco.com>
X-OriginalArrivalTime: 09 Oct 2006 16:02:46.0651 (UTC) FILETIME=[5C986CB0:01C6EBBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2006-10-09 at 10:28 -0500, Protasevich, Natalie wrote:
> 
> > I'd like also to question current policies of user space 
> irqbalanced. 
> > It seems to just go round-robin without much heuristics involved.
> 
> only for the timer interrupt and only because "people" didn't 
> want to see it bound to a specific CPU. For all others 
> there's quite some heuristics actually

Ah, this explains a lot. I was planning to try binding the timer to a
CPU or a node (as soon as get a system for testing).

> 
> >  We are
> > seeing loss of timer interrupts on our systems - and the more 
> > processors the more noticeable it is, but it starts even on 8x 
> > partitions; on 48x system I see about 50% loss, on both ia32 and 
> > x86_64 (haven't checked on
> > ia64 yet). With say 16 threads it is unsettling to see 70% overall 
> > idle time, and still only 40-50% of interrupts go through. System's 
> > time is not affected, so the problem is on the back burner 
> for now :) 
> > It's not clear yet whether this is software or hardware fault,
> 
> I'd call it a hardware fault. But them I'm biased.

It is the main suspect for now, yes (I tend to be biased this way too :)
Those are NUMA machines that run as non-NUMA sometimes, and I still need
to sort out if it happens in both cases, or either and all the aspects
that may have come into play.  
