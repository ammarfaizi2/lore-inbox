Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966326AbWKNUaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966326AbWKNUaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966331AbWKNUaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:30:20 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:54686 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S966326AbWKNUaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:30:18 -0500
Date: Tue, 14 Nov 2006 21:30:17 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Len Brown <lenb@kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org,
       "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061114203016.GA15440@rhlx01.hs-esslingen.de>
References: <EB12A50964762B4D8111D55B764A8454E0DC9D@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB12A50964762B4D8111D55B764A8454E0DC9D@scsmsx413.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 14, 2006 at 10:06:37AM -0800, Pallipadi, Venkatesh wrote:
> >Hmm, hopefully it's easy to research where to enable HPET
> >(if there is one at all!) on an el-cheapo VIA chipset...
> >
> >Many thanks for your patch! (even though currently Intel-only)
> 
> Yes. This should be easy to do for any chipset. It should be documented
> somewhere in the chipset documentation. Atleast it is documented on ICH
> specification :).

OK, I just managed to get hold of both VT8237 *and* VT8235 specs.

VT8237 is documented to have HPET.
The convenient thing is that on VT8235 *exactly* that register space where
8237 has its HPET is marked as "reserved" ;)
(i.e. there's a register hole which has exactly the size of the
HPET range).
IOW, we might be lucky and 8235 already has an initial implementation of
HPET available (which even works??).

OK, so let's provide some more details:
VT8237 has a PCI device 17 function 0 part ("Bus Control and Power Management")
which has a Programmable Chip Select Control block at 0x5D to 0x6B.
Offset 0x68 is HPET Control, RW, which has an Enable bit (default Disabled)
at bit 7 (MSB).
0x69 to 0x6B is HPET Base Address, RW (lower 22 bits, 22-23 "Reserved").
VT8235 has exactly 0x68 to 0x6B "reserved", with valid registers both
before and thereafter.

There's also some register description about APIC timer,
maybe I'll gather something about my C2 headaches from there.

Andreas Mohr
