Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbSLWHVz>; Mon, 23 Dec 2002 02:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbSLWHVz>; Mon, 23 Dec 2002 02:21:55 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:64869 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S266686AbSLWHVy> convert rfc822-to-8bit; Mon, 23 Dec 2002 02:21:54 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m ore than 8 CPUs
Date: Sun, 22 Dec 2002 23:29:55 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DA5CE37@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
X-MS-Has-Attach: 
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic cluster APIC support for systems with m ore than 8 CPUs
Thread-Index: AcKp3o+o/zUsXhXQEdeNCQBQi+Bs2AAdVtxw
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       "Andi Kleen" <ak@suse.de>, "Hubert Mantel" <mantel@suse.de>
X-OriginalArrivalTime: 23 Dec 2002 07:29:56.0452 (UTC) FILETIME=[17972A40:01C2AA55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Martin, Couple of days back I have posted a kernel IRQ distribution patch with some discussion. There we tried doing same things as you have interests here. We have made the interval flexible and longer. Also the randomness of the algorithm is removed.
	  Also about the fairness. Scheduler will not be able to solve the fairness issues coming because of the interrupts at all the times. For example, at very interrupts load, some of the CPUs may get 100% busy just servicing the interrupts. Here the scheduler cannot do anything. To get the fairness, we need the interrupts distribution mechanism to move interrupts as required.
	  May be we can add some generic NUMA awareness in it. But I am not fully aware of the way interrupt routing happens in various NUMA systems. If I can get this information I can look into, how can we have the generic NUMA support in the new IRQ distribution code.

Thanks,
Nitin

-----Original Message-----
From: Martin J. Bligh [mailto:mbligh@aracnet.com]
Sent: Sunday, December 22, 2002 9:21 AM
To: Pallipadi, Venkatesh; William Lee Irwin III; Protasevich, Natalie
Cc: Christoph Hellwig; James Cleverdon; Linux Kernel; John Stultz;
Nakajima, Jun; Mallick, Asit K; Saxena, Sunil; Van Maren, Kevin; Andi
Kleen; Hubert Mantel; Kamble, Nitin A
Subject: RE: [PATCH][2.4] generic cluster APIC support for systems with
m ore than 8 CPUs


> I actually meant interrupt distribution (rather than interrupt routing).
> AFAIK, interrupt distribution right now assumes flat logical setup and
> tries to distribute the interrupt. And is disabled in case of clustered
> APIC mode.  I was just thinking loud, about the changes interrupt
> distribution code should have for systems using clustered APIC/physical
> mode (NUMAQ and non-NUMAQ).

Oh, you mean irq_balance? I'm happy to leave that turned off on NUMA-Q
until it does something less random than it does now. Getting some sort
of affinity for interrupts over a longer period is much more interesting
than providing pretty numbers under /proc/interrupts. Giving each of
the frequently used interrupts their own local CPU to process it would
be cool, but I see no purpose in continually moving them around. If you're
concerned about fairness, that's a scheduler problem to account for and
deal with, IMHO.

The provided topology functions should be able to do node_to_cpumask
and cpu_to_node mappings once that's sorted out. Treat each node as a
seperate "system" and balance within that.

M.
