Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWDXSMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWDXSMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 14:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWDXSMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 14:12:30 -0400
Received: from spirit.analogic.com ([204.178.40.4]:27910 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751076AbWDXSM2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 14:12:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <444D08A8.3060908@hp.com>
X-OriginalArrivalTime: 24 Apr 2006 18:12:19.0094 (UTC) FILETIME=[9FEF1B60:01C667CA]
Content-class: urn:content-classes:message
Subject: Re: Van Jacobson's net channels and real-time
Date: Mon, 24 Apr 2006 14:12:01 -0400
Message-ID: <Pine.LNX.4.61.0604241405240.24279@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Van Jacobson's net channels and real-time
thread-index: AcZnyp/4IMYJKnXkQ4SSdtdHpBAmoQ==
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk> <200604221529.59899.ioe-lkml@rameria.de> <20060422134956.GC6629@wohnheim.fh-wedel.de> <200604230205.33668.ioe-lkml@rameria.de> <444CFFE5.1020509@intel.com> <Pine.LNX.4.61.0604241254180.24099@chaos.analogic.com> <444D08A8.3060908@hp.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Rick Jones" <rick.jones2@hp.com>
Cc: "Auke Kok" <auke-jan.h.kok@intel.com>, "Ingo Oeser" <ioe-lkml@rameria.de>,
       =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       "Ingo Oeser" <netdev@axxeo.de>, "David S. Miller" <davem@davemloft.net>,
       <simlo@phys.au.dk>, <linux-kernel@vger.kernel.org>, <mingo@elte.hu>,
       <netdev@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2006, Rick Jones wrote:

>>>> Thats right. This will be made a non issue with early demuxing
>>>> on the NIC and MSI (or was it MSI-X?) which will select
>>>> the right CPU based on hardware channels.
>>>
>>> MSI-X. with MSI you still have only one cpu handling all MSI interrupts and
>>> that doesn't look any different than ordinary interrupts. MSI-X will allow
>>> much better interrupt handling across several cpu's.
>>>
>>> Auke
>>> -
>>
>>
>> Message signaled interrupts are just a kudge to save a trace on a
>> PC board (read make junk cheaper still). They are not faster and
>> may even be slower. They will not be the salvation of any interrupt
>> latency problems. The solutions for increasing networking speed,
>> where the bit-rate on the wire gets close to the bit-rate on the
>> bus, is to put more and more of the networking code inside the
>> network board. The CPU get interrupted after most things (like
>> network handshakes) are complete.
>
> if the issue is bus vs network bitrates would offloading really buy that
> much?  i suppose that for minimum sized packets not DMA'ing the headers
> across the bus would be a decent win, but down at small packet sizes
> where headers would be 1/3 to 1/2 the stuff DMA'd around, I would think
> one is talking more about CPU path lengths than bus bitrates.
>
> and up and "full size" segments, since everyone is so fond of bulk
> transfer tests, the transfer saved by not shovig headers across the bus
> is what 54/1448 or ~3.75%
>
> spreading interrupts via MSI-X seems nice and all, but i keep wondering
> if the header field-based distribution that is (will be) done by the
> NICs is putting the cart before the horse - should the NIC essentially
> be telling the system the CPU on which to run the application, or should
> the CPU on which the application runs be telling "networking" where it
> should be happening?
>
> rick jones
>

Ideally, TCP/IP is so mature that one should be able to tell some
hardware state-machine "Connect with 123.555.44.333, port 23" and
it signals via interrupt when that happens. Then one should be
able to say "send these data to that address" or "fill this buffer
with data from that address". All the networking could be done
on the board, perhaps with a dedicated CPU (as is now done) or
all in silicon.

So, the driver end of the networking software just handles
buffers. There are interrupts that show status such as
completions or time-outs, trivial stuff.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
