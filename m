Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVHKTWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVHKTWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVHKTWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:22:12 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:37899 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S932392AbVHKTWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:22:12 -0400
Message-ID: <42FBA55B.5030306@rainbow-software.org>
Date: Thu, 11 Aug 2005 21:22:03 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bruce <bruce@andrew.cmu.edu>
CC: sclark46@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe> <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu> <20050801204245.GC17258@thunk.org> <42EEFB9B.10508@andrew.cmu.edu> <42EF70BD.7070804@earthlink.net> <42EF947E.1070600@andrew.cmu.edu> <42EF9A8E.8020302@rainbow-software.org> <42F30992.9080605@andrew.cmu.edu>
In-Reply-To: <42F30992.9080605@andrew.cmu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bruce wrote:
> Ondrej Zary wrote:
> 
>> James Bruce wrote:
>>
>>> Stephen Clark wrote:
>>>
>>>> Maybe new desktop systems - but what about the tens of millions of 
>>>> old systems that don't.
>>>
>>>
>>> If it's an old system, it probably doesn't have working ACPI C-states 
>>> though.  Without that, low HZ does not save you anything.  I should 
>>> have said: 99% of desktops with the capability to do ACPI sleep have 
>>> at least one USB device attached (usually a mouse).
>>
>>
>> rainbow@pentium:~$ cat /proc/acpi/processor/CPU0/power
>> active state:            C2
>> max_cstate:              C8
>> bus master activity:     00000000
>> states:
>>     C1:                  type[C1] promotion[C2] demotion[--] 
>> latency[000] usage[00052470]
>>    *C2:                  type[C2] promotion[--] demotion[C1] 
>> latency[090] usage[02699149]
>>
>> This is PCPartner TXB820DS motherboard (Socket 7, i430TX) with 1998 
>> Award BIOS and C-states seem to work fine. I've tested it in Windows 
>> 98 some time ago - the CPU is almost cold when idle with ACPI enabled 
>> and hot with ACPI disabled (that's partly caused by the fact that 
>> Windows 9x does not HLT the CPU when idle). With Pentium 100MHz in the 
>> socket and ACPI enabled, I could even touch the CPU (without heatsink) 
>> without burning my fingers.
> 
> 
> Ok I stand corrected, I had no idea there were machines that old where 
> ACPI worked correctly in Linux.
> 
> Do you see the same kind of heat reduction in Linux as Win98?  What HZ 
> value are you using, as the latency for entering C2 on your machine 
> looks pretty substantial (Your C2 almost looks like a new machine's C3 
> state, which is supposedly the first level where substantial power 
> savings occur on a new machines).
> 
I did some tests:
1. disconnected CPU fan power
2. booted 2.6.12 (compiled with HZ=100) with init=/bin/sh
3. left it idling on the shell prompt and checked CPU heatsink 
temperature (by hand) - only warm
4. rebooted the same kernel with acpi=off init=/bin/sh
5. left it idling on the shell prompt and checked CPU heatsink 
temperature - warm and slowly getting hot
6. rebooted the same kernel with init=/bin/sh again
7. left it idling on the shell prompt and checked CPU heatsink 
temperature - temperature went back to "warm" :)

Result: ACPI C2 state reduces CPU consumption here
