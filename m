Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266678AbSLWHoX>; Mon, 23 Dec 2002 02:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266693AbSLWHoX>; Mon, 23 Dec 2002 02:44:23 -0500
Received: from franka.aracnet.com ([216.99.193.44]:17628 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266678AbSLWHoW>; Mon, 23 Dec 2002 02:44:22 -0500
Date: Sun, 22 Dec 2002 23:52:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>, Andi Kleen <ak@suse.de>,
       Hubert Mantel <mantel@suse.de>
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m ore than 8 CPUs
Message-ID: <83950000.1040629933@titus>
In-Reply-To: <E88224AA79D2744187E7854CA8D9131DA5CE37@fmsmsx407.fm.intel.com>
References: <E88224AA79D2744187E7854CA8D9131DA5CE37@fmsmsx407.fm.intel.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Martin, Couple of days back I have posted a kernel IRQ distribution patch with some discussion. There we tried doing same things as you have interests here. We have made the interval flexible and longer. Also the randomness of the algorithm is removed.

Yup, saw it, but haven't given it the inspection it really deserves yet.
That code does need some work, and it sounds like you're doing the
right things to it.

> 	  Also about the fairness. Scheduler will not be able to solve the fairness issues coming because of the interrupts at all the times. For example, at very interrupts load, some of the CPUs may get 100% busy just servicing the interrupts. Here the scheduler cannot do anything. To get the fairness, we need the interrupts distribution mechanism to move interrupts as required.

Well, if the scheduler didn't ding the process for time spent in interrupts,
I think it'd work out - it could always run processes on another CPU ;-) 
But that may not be practical to do in reality.

> 	  May be we can add some generic NUMA awareness in it. But I am not fully aware of the way interrupt routing happens in various NUMA systems. If I can get this information I can look into, how can we have the generic NUMA support in the new IRQ distribution code.

Mmm... well it's late and I'm tired, but off the top of my head ... you
need to map from each PCI bus to the closest set of cpus - for me that's
a simple bus_to_node mapping (not sure that bit is added to the topology
infrastructure yet, but it's a trivial patch that's floating around ...
I'll try to dig out out and add it to the 2.5-mjb tree). Then just limit
the distrubtion for an interrupt to the closest set of CPUs (for UMA SMP
would just be cpu_online_map), and have another abstracted function that
sets IO-APIC distribution up to a certain CPU (if doing balancing explicity)
or group thereof. But it's late, so if that makes no sense, I'll take it
all back in the morning ;-)

If you're interested in working on it, I'm very happy to test it ...
(should probably be kept seperate from your other stuff though).
I'll see if I can find someone in our performance team to evaluate 
how your existing patch runs on SMP for us ...

M.

