Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbSLVUeM>; Sun, 22 Dec 2002 15:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265266AbSLVUeM>; Sun, 22 Dec 2002 15:34:12 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:12193 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S265250AbSLVUeL>; Sun, 22 Dec 2002 15:34:11 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C1AEC75@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Martin J. Bligh'" <mbligh@aracnet.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Christoph Hellwig <hch@infradead.org>,
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
Date: Sun, 22 Dec 2002 14:41:49 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> > Yes, our feeling it is possible to handle all non-NUMAQ
>>> systems pretty
>>> > generically in terms of APIC setup and interrupt routing. We can use
>>> > either logical clustered or physical destination modes. But
>>> for NUMAQ
>>> > systems, interrupt routing has to know about the local
>>> nodes and have
>>> > necessary logic to do the routing withing local node.
>>>
>>> NUMA-Q doesn't have to know about the local nodes. I set it up to use
>>> physical delivery broadcast, which is a node-local broadcast ... gave
>>> me NUMA affinity for free. I could also use logical clustered
>>> (p3 style)
>>> addressing, and work out all the node locality, but I don't
>>> see the point.
>>
>> I actually meant interrupt distribution (rather than interrupt routing).
>> AFAIK, interrupt distribution right now assumes flat logical setup and
>> tries to distribute the interrupt. And is disabled in case of clustered
>> APIC mode.  I was just thinking loud, about the changes interrupt
>> distribution code should have for systems using clustered APIC/physical
>> mode (NUMAQ and non-NUMAQ).

>Actually, if you're talking about irq_balance, that needs fixing for all
>NUMA systems to get affininity, not just NUMA-Q. It then needs an
>abstraction layer to do "program the IO-APIC with a cpu_bitmask" that's
>different for each apic addressing mode used.

Some platforms (like certain ES7000s) won't tolerate any bit masks
programmed into the RTE because their balancing is done entirely in
hardware, similar to XTPR mechanism for Fosters. For those I suggest to have
an escape door, in the form of boot parameter such as "irq_balance=no". It
was suggested to us by SuSE and worked great - I could turn it off in our
platform code unconditionally. It could also help those who can use irq
balancing as is but might want to implement their own balancing schema.

--Natalie

>M.
