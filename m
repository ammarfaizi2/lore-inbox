Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266903AbTAOS5K>; Wed, 15 Jan 2003 13:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTAOS5K>; Wed, 15 Jan 2003 13:57:10 -0500
Received: from holomorphy.com ([66.224.33.161]:26764 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266903AbTAOS5J>;
	Wed, 15 Jan 2003 13:57:09 -0500
Date: Wed, 15 Jan 2003 11:05:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/7) Finish moving NUMA-Q into subarch, cleanup
Message-ID: <20030115190553.GS940@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	James Cleverdon <jamesclv@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <C8C38546F90ABF408A5961FC01FDBF1912E233@fmsmsx405.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E233@fmsmsx405.fm.intel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 10:29:27AM -0800, Pallipadi, Venkatesh wrote:
> Can these (MAX_IO_APICS, MAX_APICS) be moved to sub-arch too, instead of
> replacing CONFIG NUMA by CONFIG NUMAQ?

Actually, I've also been feeling pain about MAX_IRQ_SOURCES, NR_IRQS,
and HARDIRQ_BITS in addition to MAX_IO_APICS and MAX_APICS. I'll bet
some ppl will have trouble with MAX_MP_BUSSES also, though I don't
have any heavily-populated systems to stress that with.

There are also somewhat deeper issues with vector assignments to
interrupt sources that prevent elevating any of the above to useful
levels and utilizing them. The assumptions based on the vector assignment
algorithm appear to be widely distributed enough to discourage me after
an initial attempt or two to get any kind of useful interrupt routing
for a number of IRQ sources larger than the number of vectors.

I pretty much reprogrammed the IDT to push only the vector and then still
got interrupts on the wrong node(s) despite the physical broadcast RTE's
plus (node, vector) <-> irq accounting and irq number lookup in do_IRQ().


Bill
