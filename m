Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbTAFVob>; Mon, 6 Jan 2003 16:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbTAFVob>; Mon, 6 Jan 2003 16:44:31 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:3762 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267175AbTAFVoW>;
	Mon, 6 Jan 2003 16:44:22 -0500
Date: Mon, 06 Jan 2003 13:45:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ion Badulescu <ionut@badula.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix starfire compiler warning on PAE
Message-ID: <41340000.1041889554@flay>
In-Reply-To: <Pine.LNX.4.44.0301061625020.22375-100000@guppy.limebrokerage.com>
References: <Pine.LNX.4.44.0301061625020.22375-100000@guppy.limebrokerage.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Odd. It seems to work with PAE now. pci_map_single just casts an address
>> though ... are the things you're passing it always allocated from ZONE_NORMAL?
>> I run these all the time on 16Gb machines with 16 processors (ia32 NUMA-Q).
> 
> I get them from the network stack, and I supposed they're guaranteed to be 
> in ZONE_NORMAL as long as the adapter doesn't list NETIF_F_HIGHDMA among 
> its features. So yes, you're right that it will probably work with PAE, 
> but it won't work with a real 64-bit box, methinks.

Well it seems like the Right Thing To Do anyway to make it all 64bit clean ;-)
 
> A few of these are mostly normal, it's the card signalling the driver that 
> it is getting a Tx fifo underrun, and the driver responds by increasing 
> the threshold at which the card starts transmitting the packet.

Can we not print them onto the console if they're normal then?

>> Jan  6 10:12:29 larry kernel: eth0: Increasing Tx FIFO threshold to 448 bytes
>> Jan  6 10:12:29 larry kernel: eth0: Increasing Tx FIFO threshold to 464 bytes
> 
> These are very high, however; it could be that there really is very high
> contention on the PCI bus, but otherwise I can't explain them.
> 
> If they stop before reaching 1500, then it's probably ok and just
> something you're gonna have to live with. Otherwise it's a bug of some
> sort.

I think the card took itself offline at this point, so it smells like a bug.
That's only been happening recently though (I've only noticed in the last
week from a year or two of use).

>> I also recall getting errors like "Something Wicked happened", but I
>> don't seem to be able to find them in the log right now.
> 
> Yeah, the interrupt status (printed right after the messages) would have 
> been helpful...

OK, will try to grab that.

> That said, there is a known race condition in the v1.3.6 of the driver,
> which could cause timeouts and erors under certain circumstances. It's all
> fixed in 1.3.9 (the full 64-bit support version) and 1.4.0 (NAPI support). 
> Both of those will do real 64-bit transfers, without the need for double 
> buffering, so it should help on your 16GB boxes.
> 
> I could forward you one of those versions, if you want to test it. In 
> fact, I'd appreciate some testing! :-)

Sure, send me the patch, these boxes bring out races like dying rich aunts
bring out friendly relatives. And I have a cabinet drawer full of starfire
cards ;-)

M.

