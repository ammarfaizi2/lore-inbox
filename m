Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSLWJgU>; Mon, 23 Dec 2002 04:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbSLWJgT>; Mon, 23 Dec 2002 04:36:19 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:47740
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261561AbSLWJgS>; Mon, 23 Dec 2002 04:36:18 -0500
Date: Mon, 23 Dec 2002 04:46:05 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: "Kamble, Nitin A" <nitin.a.kamble@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
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
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m
 ore than 8 CPUs
In-Reply-To: <83950000.1040629933@titus>
Message-ID: <Pine.LNX.4.50.0212230424340.1942-100000@montezuma.mastecende.com>
References: <E88224AA79D2744187E7854CA8D9131DA5CE37@fmsmsx407.fm.intel.com>
 <83950000.1040629933@titus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Dec 2002, Martin J. Bligh wrote:

> > 	  May be we can add some generic NUMA awareness in it. But I am not fully aware of the way interrupt routing happens in various NUMA systems. If I can get this information I can look into, how can we have the generic NUMA support in the new IRQ distribution code.
>
> Mmm... well it's late and I'm tired, but off the top of my head ... you
> need to map from each PCI bus to the closest set of cpus - for me that's
> a simple bus_to_node mapping (not sure that bit is added to the topology
> infrastructure yet, but it's a trivial patch that's floating around ...
> I'll try to dig out out and add it to the 2.5-mjb tree). Then just limit
> the distrubtion for an interrupt to the closest set of CPUs (for UMA SMP
> would just be cpu_online_map), and have another abstracted function that
> sets IO-APIC distribution up to a certain CPU (if doing balancing explicity)
> or group thereof. But it's late, so if that makes no sense, I'll take it
> all back in the morning ;-)

How about using logical destination mode when programming the IOAPIC?
Currently we do physical in io_apic.c (the reason why it breaks on NUMAQ)
This way we can get node affinity just by setting the Destination Field
for an IOREDTBL to APIC_BROADCAST_ID and also targetting single cpus on a
node becomes node generic.

Cheers,
	Zwane Mwaikambo

PS This suggestion also comes with a possible nonsense disclaimer as i'm
also about to go to bed ;)

-- 
function.linuxpower.ca
