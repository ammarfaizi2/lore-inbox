Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbTAOP0K>; Wed, 15 Jan 2003 10:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbTAOP0K>; Wed, 15 Jan 2003 10:26:10 -0500
Received: from holomorphy.com ([66.224.33.161]:34187 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265791AbTAOP0I>;
	Wed, 15 Jan 2003 10:26:08 -0500
Date: Wed, 15 Jan 2003 07:34:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <20030115153453.GK919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030115105802.GQ940@holomorphy.com> <840980000.1042644279@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <840980000.1042644279@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> (2) MAX_IO_APIC's got clobbered in the subarch cleanups.
>> 	-- CONFIG_X86_NUMA was removed, use CONFIG_X86_NUMAQ
>> 	-- this is greppable, folks...

On Wed, Jan 15, 2003 at 07:24:40AM -0800, Martin J. Bligh wrote:
> That wasn't the subarch cleanups that removed it, please be careful
> what you're saying. I plead not guilty to that one.

Eh? You aren't doing all of them. I think we both know who did this
one (with good intentions, even).


At some point in the past, I wrote:
>> (4) PCI bridges get misnumbered children.
>> 	-- Brew up a PCI hook for giving child buses their bus numbers.
>> 	-- Basically, fwd port mbligh's fix for 2.4.x more cleanly.
>> 	-- Okay, not IO-APIC-related, but it annoys me greatly.
>> 	-- ink is at least trying to steer me in the right direction here.

On Wed, Jan 15, 2003 at 07:24:40AM -0800, Martin J. Bligh wrote:
> Additional PCI-PCI bridges (eg starfire cards) have never been supported 
> in non-boot quads. It's not impossible, but don't be suprised if it 
> doesn't work.

It should be fine once the bus numbering, io resources, and IO-APIC's
are dealt with. The bus numbering stuff is out there, io resource stuff
is an open question, and IO-APIC stuff looks uglier than sin (as usual).
Basically, a good chunk of rotorooting appears to be necessary to
assign deal with a number of IRQ sources large enough to make
assign_irq_vector() wrap current_vector, possibly something as
invasive as supporting non-unique vectors for irq_desc's.


At some point in the past, I wrote:
>> (5) Booting with notsc panic()'s.
>> 	-- Remove tsc_disable assignment in the __setup() call.
>> 	-- I'd be much obliged if the SMP TSC issues were at long
>> 	-- last conclusively dealt with. Not IO-APIC-related either,
>> 	-- but also very annoying.

On Wed, Jan 15, 2003 at 07:24:40AM -0800, Martin J. Bligh wrote:
> You don't have PIT support compiled in, and you turned off TSC support,
> leaving yourself with no timer. There's a patch in my tree to force on
> PIT support for NUMA-Q.

Sounds like a conclusive answer to the TSC for me.


Cheers,
Bill
