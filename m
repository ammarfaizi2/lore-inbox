Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTETQO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 12:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTETQO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 12:14:57 -0400
Received: from fmr01.intel.com ([192.55.52.18]:63467 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262720AbTETQOz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 12:14:55 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: userspace irq balancer
Date: Tue, 20 May 2003 08:41:31 -0700
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB56402043344@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: userspace irq balancer
Thread-Index: AcMe2O1TBJICkhTxSiu7bfdhfHryLAAC/kAA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "David S. Miller" <davem@redhat.com>
Cc: <haveblue@us.ibm.com>, <wli@holomorphy.com>, <arjanv@redhat.com>,
       <pbadari@us.ibm.com>, <linux-kernel@vger.kernel.org>, <gh@us.ibm.com>,
       <johnstul@us.ibm.com>, <jamesclv@us.ibm.com>, <akpm@digeo.com>,
       <mannthey@us.ibm.com>
X-OriginalArrivalTime: 20 May 2003 15:41:32.0834 (UTC) FILETIME=[49F0E020:01C31EE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The in-kernel load balance does not move IRQs that are bound to particular CPUs. If the user-level can do it better, just set affinity, and I believe that is the current implementation.

The in-kernel one is simply trying to emulate functionality in the chipset, thus it's not so intelligent, of course. The major reason we need to do it in software is that x86 Linux does not update TPR(s).

Thanks,
Jun

> -----Original Message-----
> From: Martin J. Bligh [mailto:mbligh@aracnet.com]
> Sent: Tuesday, May 20, 2003 7:01 AM
> To: David S. Miller
> Cc: haveblue@us.ibm.com; wli@holomorphy.com; arjanv@redhat.com;
> pbadari@us.ibm.com; linux-kernel@vger.kernel.org; gh@us.ibm.com;
> johnstul@us.ibm.com; jamesclv@us.ibm.com; akpm@digeo.com;
> mannthey@us.ibm.com
> Subject: Re: userspace irq balancer
> 
> > How does the in-kernel IRQ load balancing measure "load" and
> > "busyness"?  Herein lies the most absolutely fundamental problem with
> > this code, it fails to recognize that we end up with most of our
> > networking "load" from softint context.
> 
> OK, that's a great observation, and probably fixable. What were the
> author's comments when you told him that?
> 
> > rm -rf in-kernel-irqbalance;
> 
> It's *very* late in the day to be ripping out such chunks of code.
> 1. Prove new code works better for you => make it a config option.
> 2. Prove new code works better for everyone => rip it out.
> 
> I think we're at 1, not 2.
> 
> Note that the userspace stuff doesn't even require that the kernel
> stuff be disabled ... it should just override it (I can believe
> there maybe is a bug that needs fixing, but it works by design).
> 
> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
