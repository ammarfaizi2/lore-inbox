Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbUKWA2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbUKWA2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 19:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbUKWA0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 19:26:37 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:12203 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S262469AbUKWAWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 19:22:53 -0500
Message-ID: <41A2862A.2000602@devicelogics.com>
Date: Mon, 22 Nov 2004 17:36:58 -0700
From: "Jeff V. Merkey" <jmerkey@devicelogics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning   and
 sickness
References: <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14> <419E6B44.8050505@devicelogics.com> <419E6B44.8050505@devicelogics.com> <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14> <5.1.0.14.2.20041123094109.04003720@171.71.163.14>
In-Reply-To: <5.1.0.14.2.20041123094109.04003720@171.71.163.14>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale wrote:

> Jeff,
>
> At 04:06 AM 23/11/2004, Jeff V. Merkey wrote:
>
>> I've studied these types of problems for years, and I think it's 
>> possible even for Linux.
>
>
> so you have the source code --if its such a big deal for you, how 
> about you contribute the work to make this possible ?


Bryan Sparks says no to open sourcing this code in Linux. Sorry -- I 
asked. I am allowed to open source any modifications
to public kernel sources like dev.c since we have an obligation to do 
so. I will provide source code enhancements for the kernel
for anyone who purchases our Linux based appliances and asks for the 
source code (so says Bryan Sparks). You can issue a purchase
request to Bryan Sparks (bryan@devicelogics.com) if you want any source 
code changes for the Linux kernel.

>
> the fact is, large-packet-per-second generation fits into two categories:
> (a) script kiddies / haxors who are interested in building DoS tools
> (b) folks that spend too much time benchmarking.
>
> for the (b) case, typically the PPS-generation is only part of it. 
> getting meaningful statistics on reordering (if any) as well as 
> accurate latency and ideally real-world traffic flows is important. 
> there are specialized tools out there to do this: Spirent, Ixia, 
> Agilent et al make them.


There are about four pages of listings of open source tools and scripts 
that do this -- we support all of them.

>> [..]
>> I see no other way for OS to sustain high packet loading about 
>> 500,000 packets per second on Linux
>> or even come close to dealing with small packets or full 10 gigabite 
>> ethernet without such a model.
>
>
> 10GbE NICs are an entirely different beast from 1GbE.
> as you pointed out, with real-world packet sizes today, one can 
> sustain wire-rate 1GbE today (same holds true for 2Gbps Fibre Channel 
> also).
>
> i wouldn't call pushing minimum-packet-size @ 1GbE (which is 46 
> payload, 72 bytes on the wire btw) "real world". and its 1.488M 
> packets/second.
>
I agree. I have also noticed that CISCO routers are not even able to 
withstand these rates with 64 byte packets without dropping them,
so I agree this is not real world. It is useful testing howevr, to 
determine the limits and bottlenecks of where things break.

>> The bus speeds are actually fine for dealing with this on current 
>> hardware.
>
>
> its fine when you have meaningful interrupt coalescing going on & 
> large packets to DMA.
> it fails when you have inefficient DMA (small) with the overhead of 
> setting up & tearing down the DMA and associated arbitration overhead.
>
>

I can sustain full line rate gigabit on two adapters at the tsame time 
with a 12 CLK interpacket gap time and 0 dropped packets at 64
byte sizes from a Smartbits to Linux provided the adapter ring buffer is 
loaded with static addresses. This demonstrates that it is
possible to sustain 64 byte packet rates at full line rate with current 
DMA architectures on 400 Mhz buses with Linux.
(which means it will handle any network loading scenario). The 
bottleneck from my measurements appears to be the
overhead of serializing writes to the adapter ring buffer IO memory. The 
current drivers also perform interrupt
coalescing very well with Linux. What's needed is a method for 
submission of ring buffer entries that can be sent in large
scatter gather listings rather than one at a time. Ring buffers exhibit 
sequential behavior so this method should work well
to support 1Gbe and 10Gbe at full line rate with small packet sizes.

Jeff


>
> cheers,
>
> lincoln.
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
>

