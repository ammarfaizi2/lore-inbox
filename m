Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbTEUNuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 09:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTEUNuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 09:50:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:52876 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262115AbTEUNl7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 09:41:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: userspace irq balancer
Date: Wed, 21 May 2003 06:54:22 -0700
User-Agent: KMail/1.4.3
Cc: <haveblue@us.ibm.com>, <wli@holomorphy.com>, <arjanv@redhat.com>,
       <pbadari@us.ibm.com>, <linux-kernel@vger.kernel.org>, <gh@us.ibm.com>,
       <johnstul@us.ibm.com>, <akpm@digeo.com>, <mannthey@us.ibm.com>
References: <3014AAAC8E0930438FD38EBF6DCEB56402043344@fmsmsx407.fm.intel.com>
In-Reply-To: <3014AAAC8E0930438FD38EBF6DCEB56402043344@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305210654.22987.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 May 2003 08:41 am, Nakajima, Jun wrote:
> The in-kernel load balance does not move IRQs that are bound to particular
> CPUs. If the user-level can do it better, just set affinity, and I believe
> that is the current implementation.
>
> The in-kernel one is simply trying to emulate functionality in the chipset,
> thus it's not so intelligent, of course. The major reason we need to do it
> in software is that x86 Linux does not update TPR(s).
>
> Thanks,
> Jun

It may be time to think about using the TPRs again, and see if HW interrupt 
routing helps Arjan's test case.  Of course for any system using clustered 
APIC mode, we will still need to decide which APIC cluster gets which IRQ....


> > -----Original Message-----
> > From: Martin J. Bligh [mailto:mbligh@aracnet.com]
> > Sent: Tuesday, May 20, 2003 7:01 AM
> > To: David S. Miller
> > Cc: haveblue@us.ibm.com; wli@holomorphy.com; arjanv@redhat.com;
> > pbadari@us.ibm.com; linux-kernel@vger.kernel.org; gh@us.ibm.com;
> > johnstul@us.ibm.com; jamesclv@us.ibm.com; akpm@digeo.com;
> > mannthey@us.ibm.com
> > Subject: Re: userspace irq balancer
> >
> > > How does the in-kernel IRQ load balancing measure "load" and
> > > "busyness"?  Herein lies the most absolutely fundamental problem with
> > > this code, it fails to recognize that we end up with most of our
> > > networking "load" from softint context.
> >
> > OK, that's a great observation, and probably fixable. What were the
> > author's comments when you told him that?
> >
> > > rm -rf in-kernel-irqbalance;
> >
> > It's *very* late in the day to be ripping out such chunks of code.
> > 1. Prove new code works better for you => make it a config option.
> > 2. Prove new code works better for everyone => rip it out.
> >
> > I think we're at 1, not 2.
> >
> > Note that the userspace stuff doesn't even require that the kernel
> > stuff be disabled ... it should just override it (I can believe
> > there maybe is a bug that needs fixing, but it works by design).
> >
> > M.


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

