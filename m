Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbRFTXBv>; Wed, 20 Jun 2001 19:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264667AbRFTXBo>; Wed, 20 Jun 2001 19:01:44 -0400
Received: from thorgal.et.tudelft.nl ([130.161.40.91]:29760 "EHLO
	thorgal.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261651AbRFTXBd>; Wed, 20 Jun 2001 19:01:33 -0400
Mime-Version: 1.0
Message-Id: <a05100306b756d7a9fdac@[130.161.115.44]>
In-Reply-To: <20010620134221.C12357@qcc.sk.ca>
In-Reply-To: <20010620104800.D1174@w-mikek2.des.beaverton.ibm.com>
 <lx66drf04u.fsf@pixie.isr.ist.utl.pt> <20010620134221.C12357@qcc.sk.ca>
Date: Thu, 21 Jun 2001 01:00:19 +0200
To: Charles Cazabon <linux-kernel@discworld.dyndns.org>
From: "J.D. Bakker" <bakker@thorgal.et.tudelft.nl>
Subject: Re: Threads FAQ entry incomplete
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:42 -0600 20-06-2001, Charles Cazabon wrote:
>Rodrigo Ventura <yoda@isr.ist.utl.pt> wrote:
>  > BTW, I have a question: Can the availability of dual-CPU boards for intel
>>  and amd processors, rather then tri- or quadra-CPU boards, be explained with
>>  the fact that the performance degrades significantly for three or more CPUs?
>>  Or is there a technological and/or comercial reason behind?
>
>Commercial reasons.  Cost per motherboard/chipset goes way up as the number of
>CPUs supported goes up.  For each CPU that a chipset supports, it has to add a
>lot of pins/lands, and chipsets are already typically land-limited.

That's not quite accurate. Most modern SMP-able processors have a 
common bus, where going from 1->2 CPUs adds just a handful of extra 
nets (usually bus request, bus grant and some IRQs). The actual 
issues are threefold.

First, most commodity chipsets simply support no more than two CPUs 
at best; most CPUs don't support having more (or any) siblings. 
Adding more is cheap on the ASIC level, but nobody bothers because 
there is no demand.

Second, adding more CPUs on a shared bus decreases the bus bandwidth 
that is available per CPU. This is comparable with having Ethernet 
hubs vs switches. The really expensive multi-CPU boards have crossbar 
switches between CPUs, memory and PCI. Future stuff like RapidIO may 
mitigate this.

Third, the more CPUs a bus holds, the higher the capacitance on the 
bus lines. Higher capacitance means lower maximum bus speed, which 
aggravates point two.

>Motherboard trace complexity (and therefore number of layers) goes up.  Add to
>that that the potential market goes down as CPUs goes up.

True enough.

Regards,

JDB
[working on a SMP PowerPC design]
-- 
LART. 250 MIPS under one Watt. Free hardware design files.
http://www.lart.tudelft.nl/
