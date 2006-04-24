Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWDXRUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWDXRUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWDXRUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:20:10 -0400
Received: from palrel12.hp.com ([156.153.255.237]:25236 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1750994AbWDXRUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:20:08 -0400
Message-ID: <444D08A8.3060908@hp.com>
Date: Mon, 24 Apr 2006 10:19:36 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, Ingo Oeser <ioe-lkml@rameria.de>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Ingo Oeser <netdev@axxeo.de>, "David S. Miller" <davem@davemloft.net>,
       simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu,
       netdev@vger.kernel.org
Subject: Re: Van Jacobson's net channels and real-time
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk>	<200604221529.59899.ioe-lkml@rameria.de>	<20060422134956.GC6629@wohnheim.fh-wedel.de>	<200604230205.33668.ioe-lkml@rameria.de>	<444CFFE5.1020509@intel.com> <Pine.LNX.4.61.0604241254180.24099@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0604241254180.24099@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>Thats right. This will be made a non issue with early demuxing
>>>on the NIC and MSI (or was it MSI-X?) which will select
>>>the right CPU based on hardware channels.
>>
>>MSI-X. with MSI you still have only one cpu handling all MSI interrupts and
>>that doesn't look any different than ordinary interrupts. MSI-X will allow
>>much better interrupt handling across several cpu's.
>>
>>Auke
>>-
> 
> 
> Message signaled interrupts are just a kudge to save a trace on a
> PC board (read make junk cheaper still). They are not faster and
> may even be slower. They will not be the salvation of any interrupt
> latency problems. The solutions for increasing networking speed,
> where the bit-rate on the wire gets close to the bit-rate on the
> bus, is to put more and more of the networking code inside the
> network board. The CPU get interrupted after most things (like
> network handshakes) are complete.

if the issue is bus vs network bitrates would offloading really buy that 
much?  i suppose that for minimum sized packets not DMA'ing the headers 
across the bus would be a decent win, but down at small packet sizes 
where headers would be 1/3 to 1/2 the stuff DMA'd around, I would think 
one is talking more about CPU path lengths than bus bitrates.

and up and "full size" segments, since everyone is so fond of bulk 
transfer tests, the transfer saved by not shovig headers across the bus 
is what 54/1448 or ~3.75%

spreading interrupts via MSI-X seems nice and all, but i keep wondering 
if the header field-based distribution that is (will be) done by the 
NICs is putting the cart before the horse - should the NIC essentially 
be telling the system the CPU on which to run the application, or should 
the CPU on which the application runs be telling "networking" where it 
should be happening?

rick jones
