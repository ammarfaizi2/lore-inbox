Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263740AbTCUS0B>; Fri, 21 Mar 2003 13:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263732AbTCUSZD>; Fri, 21 Mar 2003 13:25:03 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:9143 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263728AbTCUSYU>;
	Fri, 21 Mar 2003 13:24:20 -0500
Message-ID: <3E7B5B41.2070308@us.ibm.com>
Date: Fri, 21 Mar 2003 10:34:41 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Poor performance with pcnet32 on SMP
References: <Pine.LNX.4.53.0303202346220.3340@skynet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> I have being noticing some seriously poor network performance with SMP
> enabled. The machine is a xSeries 350 with quad xeon procesors. Under UP,
> I get decent transfer rates but with SMP enabled, it won't get over 2kB/s.

I have the same kind of machine.  I've seen the same problems, but
they're intermittent; I haven't been able to really discern a pattern.
I have the feeling that part of the problem may be with the machine on
the other side of the connection.

I have no problems copying between two 2.5.65 machines.  In fact, my
speeds are ~10 MBytes/sec.  (yes, megabytes)

> I tried binding interrupts to one processor with
> 
> echo 1 > /proc/irq/16/smp_affinity
> 
> which, according to mail archives fixed the problem for other people, but
> the result is the same. A CVS checkout from a server on the local lan of a
> source tree less than 1MB took over an hour to complete but under UP
> completes in about 2 seconds. This occurs with both 2.4.20 and 2.5.64.

Yeah, kirq was causing that and it _was_ broken for a bit.  It should
have been fixed by 2.5.64, though.

> In case it is relevant, the dmesg output related to the card on 2.5.64 is
> 
> pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
> pcnet32: PCnet/FAST III 79C975 at 0x2200, 00 02 55 fc 6d 21 assigned IRQ 16.
> eth0: registered as PCnet/FAST III 79C975
> pcnet32: 1 cards_found.
> eth0: link up, 10Mbps, half-duplex, lpa 0x0021
> Module pcnet32 cannot be unloaded due to unsafe usage in include/linux/module.h:457

I'm running on a full-duplex 100Mbps network, so maybe these things have
some kind of issue with 10Mbps.  I'll try plugging an old hub in and see
what happens.

Here's mine:

pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
pcnet32: PCnet/FAST III 79C975 at 0x2240, 00 02 55 fc 43 20 assigned IRQ 16.
eth2: registered as PCnet/FAST III 79C975
pcnet32: 1 cards_found.
eth2: link up, 100Mbps, full-duplex, lpa 0x45E1

-- 
Dave Hansen
haveblue@us.ibm.com

