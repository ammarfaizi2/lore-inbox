Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbSLMUeI>; Fri, 13 Dec 2002 15:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbSLMUeI>; Fri, 13 Dec 2002 15:34:08 -0500
Received: from fmr01.intel.com ([192.55.52.18]:28652 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265361AbSLMUeH>;
	Fri, 13 Dec 2002 15:34:07 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D40010F1D1E0@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: jamesclv@us.ibm.com, Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
Date: Fri, 13 Dec 2002 12:41:50 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have performance data when you program TPR? Today, in 2.5, for
example, we are distributing interrupts among CPUs with Ingo's patch in
software. Doing that in software is fine because it's relatively simple, but
the chipset has more information on the on-going interrupt activities. So
using TPR might work better in general.

One issue with lowest priority delivery mode (as well as Ingo's) is that it
could have negative impacts on L2 caches (actually we saw such instances).
So we also have a patch to balance interrupts load (using statistic data)
without moving them around frequently (mostly static) and I think we can
combine that patch and lowest priority delivery mode.

Jun

> -----Original Message-----
> From: James Cleverdon [mailto:jamesclv@us.ibm.com]
> Sent: Thursday, December 12, 2002 7:32 PM
> To: Zwane Mwaikambo; Nakajima, Jun
> Cc: Martin Bligh; John Stultz; Linux Kernel
> Subject: Re: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
> 
> On Thursday 12 December 2002 07:26 pm, Zwane Mwaikambo wrote:
> > On Thu, 12 Dec 2002, Nakajima, Jun wrote:
> > > BTW, we are working on a xAPIC patch that supports more than 8 CPUs in
> a
> > > generic fashion (don't use hardcode OEM checking). We already tested
> it
> > > on two OEM systems with 16 CPUs.
> > > - It uses clustered mode. We don't want to use physical mode because
> it
> > > does not support lowest priority delivery mode.
> >
> > Wouldn't that only be for all including self? Or is the documentation
> > incorrect?
> >
> > Thanks,
> > 	Zwane
> 
> I'm not sure I understand your question.  Lowest Priority delivery mode
> only
> works with logical interrupts.  (I've tried it with physical intrs.  It
> fails
> miserably.)  The "all including self" and "all excluding self" destination
> shorthands don't do lowest priority arbitration.  They always deliver the
> interrupt to the CPUs mentioned in the shortand.
> 
> Lowest priority delivery mode isn't _too_ useful in Linux yet.  It would
> be
> nice to preferentially target idle CPUs with interrupts in real time.
> That
> means changing each CPU's Task Priority Register (TPR) to represent how
> busy
> it is.  I've got some patches to do that, but haven't posted them as
> anything
> more than a RFC.
> 
> --
> James Cleverdon
> IBM xSeries Linux Solutions
> {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com
