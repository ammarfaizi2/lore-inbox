Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTEUVaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 17:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTEUVaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 17:30:23 -0400
Received: from fmr02.intel.com ([192.55.52.25]:59094 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262386AbTEUVaV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 17:30:21 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: userspace irq balancer
Date: Wed, 21 May 2003 14:43:18 -0700
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB5640204334F@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: userspace irq balancer
Thread-Index: AcMfpU3dOwtkQrUWQAq6x//iOSX8ZAAJe2KQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: <jamesclv@us.ibm.com>
Cc: <haveblue@us.ibm.com>, <pbadari@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <gh@us.ibm.com>, <johnstul@us.ibm.com>,
       <mannthey@us.ibm.com>
X-OriginalArrivalTime: 21 May 2003 21:43:18.0788 (UTC) FILETIME=[FE1C5C40:01C31FE1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, since the userland is using /proc/irq/N/smp_affinity, the in-kernel one won't touch whatever settings done by the userlannd. So I don't think we have issues here - if the userland has more knowledge, then it simply uses binding. If not, use the generic but dumb one in the kernel. Same thing as scheduling. If the dumb one has a critical problem, we should fix it.

At the same time, I don't believe a single almighty userland policy exists, either. One might need to write or modify his program to do the best for the system anyway. Or a very simple script might just work fine. 

Jun
> -----Original Message-----
> From: James Cleverdon [mailto:jamesclv@us.ibm.com]
> Sent: Wednesday, May 21, 2003 7:27 AM
> To: David S. Miller; akpm@digeo.com
> Cc: arjanv@redhat.com; haveblue@us.ibm.com; wli@holomorphy.com;
> pbadari@us.ibm.com; linux-kernel@vger.kernel.org; gh@us.ibm.com;
> johnstul@us.ibm.com; mannthey@us.ibm.com
> Subject: Re: userspace irq balancer
> 
> On Tuesday 20 May 2003 05:22 pm, David S. Miller wrote:
> >    From: Andrew Morton <akpm@digeo.com>
> >    Date: Tue, 20 May 2003 02:17:12 -0700
> >
> >    Concerns have been expressed that the /proc interface may be a bit
> racy.
> >    One thing we do need to do is to write a /proc stresstest tool which
> > pokes numbers into the /proc files at high rates, run that under traffic
> > for a few hours.
> >
> > This issue is %100 independant of whether policy belongs in the
> > kernel or not.  Also, the /proc race problem exists and should be
> > fixed regardless.
> >
> >    Nobody has tried improving the current balancer.
> >
> > Policy does not belong in the kernel.  I don't care what algorithm
> > people decide to use, but such decisions do NOT belong in the kernel.
> 
> You keep saying that, but suppose I want to try HW IRQ balancing using the
> TPR
> registers.  How could I do that from userspace?  And if I could, wouldn't
> the
> benefit of real time IRQ routing be lost?
> 
> It seems to me that only long term interrupt policy can be done from
> userland.
> Anything that does fast responses to fluctuating load must be inside the
> kernel.
> 
> At the moment we don't do any fast IRQ policy.  Even the original
> irq_balance
> only looked for idle CPUs after an interrupt was serviced.  However,
> suppose
> you had a P4 with hyperthreading turned on.  If an IRQ is to be delivered
> to
> the main thread but it is busy and its sibling is idle, why shouldn't we
> deliver the interrupt to the idle sibling?  They both share the same
> caches,
> etc, so cache warmth isn't a problem.
> 
> --
> James Cleverdon
> IBM xSeries Linux Solutions
> {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
