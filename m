Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbSLVRQr>; Sun, 22 Dec 2002 12:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSLVRQr>; Sun, 22 Dec 2002 12:16:47 -0500
Received: from franka.aracnet.com ([216.99.193.44]:29096 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265102AbSLVRQq>; Sun, 22 Dec 2002 12:16:46 -0500
Date: Sun, 22 Dec 2002 09:23:57 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
cc: Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>, Andi Kleen <ak@suse.de>,
       Hubert Mantel <mantel@suse.de>,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m
 ore than 8 CPUs
Message-ID: <21980000.1040577837@titus>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E1B0@fmsmsx405.fm.intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E1B0@fmsmsx405.fm.intel.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Yes, our feeling it is possible to handle all non-NUMAQ
>> systems pretty
>> > generically in terms of APIC setup and interrupt routing. We can use
>> > either logical clustered or physical destination modes. But
>> for NUMAQ
>> > systems, interrupt routing has to know about the local
>> nodes and have
>> > necessary logic to do the routing withing local node.
>>
>> NUMA-Q doesn't have to know about the local nodes. I set it up to use
>> physical delivery broadcast, which is a node-local broadcast ... gave
>> me NUMA affinity for free. I could also use logical clustered
>> (p3 style)
>> addressing, and work out all the node locality, but I don't
>> see the point.
>
> I actually meant interrupt distribution (rather than interrupt routing).
> AFAIK, interrupt distribution right now assumes flat logical setup and
> tries to distribute the interrupt. And is disabled in case of clustered
> APIC mode.  I was just thinking loud, about the changes interrupt
> distribution code should have for systems using clustered APIC/physical
> mode (NUMAQ and non-NUMAQ).

Actually, if you're talking about irq_balance, that needs fixing for all
NUMA systems to get affininity, not just NUMA-Q. It then needs an
abstraction layer to do "program the IO-APIC with a cpu_bitmask" that's
different for each apic addressing mode used.

M.

