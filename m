Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbSLVRNY>; Sun, 22 Dec 2002 12:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbSLVRNY>; Sun, 22 Dec 2002 12:13:24 -0500
Received: from franka.aracnet.com ([216.99.193.44]:20645 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265099AbSLVRNX>; Sun, 22 Dec 2002 12:13:23 -0500
Date: Sun, 22 Dec 2002 09:21:12 -0800
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
Message-ID: <19370000.1040577670@titus>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E1B0@fmsmsx405.fm.intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E1B0@fmsmsx405.fm.intel.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

