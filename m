Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbTAOUIk>; Wed, 15 Jan 2003 15:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTAOUIk>; Wed, 15 Jan 2003 15:08:40 -0500
Received: from holomorphy.com ([66.224.33.161]:48780 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266986AbTAOUIi>;
	Wed, 15 Jan 2003 15:08:38 -0500
Date: Wed, 15 Jan 2003 12:17:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/7) Finish moving NUMA-Q into subarch, cleanup
Message-ID: <20030115201719.GM919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	James Cleverdon <jamesclv@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <3FAD1088D4556046AEC48D80B47B478C022BD907@usslc-exch-4.slc.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C022BD907@usslc-exch-4.slc.unisys.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 01:30:37PM -0600, Protasevich, Natalie wrote:
> ... and one more from me: isn't it time to let IO-APIC id be 8 bit in the
> asm/io_apic.h (make it a union fot both?..)?
> Look what I have to do in io_apic.h to get around it and ... "mister, have a
> heart":

Point taken; it doesn't burn NUMA-Q, but this probably hits Summit (with
its much more recent APIC and IO-APIC revisions). I don't see why not.
The hardware is there, time to drop in the code to handle it.


At some point in the past, I wrote:
>> There are also somewhat deeper issues with vector assignments to
>> interrupt sources that prevent elevating any of the above to useful
>> levels and utilizing them. The assumptions based on the vector assignment
>> algorithm appear to be widely distributed enough to discourage me after
>> an initial attempt or two to get any kind of useful interrupt routing
>> for a number of IRQ sources larger than the number of vectors.

On Wed, Jan 15, 2003 at 01:30:37PM -0600, Protasevich, Natalie wrote:
> I strongly suggest to take a look in IA64 implementation. 
> They have 1:1 correspondence between IRQ and vector and don't seem to be
> able to run out of vectors or IRQs.

Given that almost nothing actually cares what the irq numbers are, it
sounds like a really good idea to encode the node ID in the upper bits
and the vector in the lower bits (SN2 uses cpuid). I'll try it out.


Thanks!
Bill
