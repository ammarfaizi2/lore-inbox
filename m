Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264127AbTCXGnp>; Mon, 24 Mar 2003 01:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264131AbTCXGnp>; Mon, 24 Mar 2003 01:43:45 -0500
Received: from paris.xisl.com ([193.112.238.192]:3486 "EHLO paris.xisl.com")
	by vger.kernel.org with ESMTP id <S264127AbTCXGnm>;
	Mon, 24 Mar 2003 01:43:42 -0500
Message-ID: <3E7EABB0.9010505@xisl.com>
Date: Mon, 24 Mar 2003 06:54:40 +0000
From: John M Collins <jmc@xisl.com>
Organization: Xi Software Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en-gb
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Query about SIS963 Bridges
References: <3E7E43C3.2080605@xisl.com> <1048467041.10727.100.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Sun, 2003-03-23 at 23:31, John M Collins wrote:
>  
>
>>I've just got a new machine (2.5 GHz pentium lots of RAM and disk space) 
>>which has one of these SIS963 Southbridge creatures and I get the 
>>message on booting a 2.4.19ish sort of kernel.
>>    
>>
>
>The SiS963 is currently a winputer. 
>
>  
>
>>Alas it's very clear that it isn't transparent and I can't get to half 
>>of the PCI stuff - worst of all the built-in Ethernet and any Ethernet 
>>card I plug in. It would seem that it isn't too transparent as the 
>>reported IRQ and IOMEM assignments for the devices are all scrambled.
>>    
>>
>
>One possibility is the system expects ACPI to untangle that mess and set
>up the bridge. You could certainly stuff realistic looking ranges into
>it, set IO/MEM and master and see what happens then
>
>What would be a useful starting point would be to see what 
>lspci -vxx and lspci -vxx -H1 think
>
>  
>
Here are the relevant bits out of "lspci -vxx"

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 
0648 (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8086
        Flags: bus master, medium devsel, latency 32
        Memory at d0000000 (32-bit, non-prefetchable) [size=256M]
        Capabilities: [c0] AGP version 3.0
00: 39 10 48 06 07 00 10 22 02 00 00 06 00 20 80 00
10: 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 86 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP 
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: cf000000-cfffffff
        Prefetchable memory behind bridge: eff00000-febfffff
00: 39 10 01 00 07 00 00 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 d0 00 20
20: 00 cf f0 cf f0 ef b0 fe 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00

00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 
0963 (rev 04)
        Flags: bus master, medium devsel, latency 0
00: 39 10 63 09 0f 00 00 02 04 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

and "lspci -vxx -H1"

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 
0648 (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8086
        Flags: bus master, medium devsel, latency 32
        Memory at d0000000 (32-bit, non-prefetchable) {Only difference here}
        Capabilities: [c0] AGP version 3.0
00: 39 10 48 06 07 00 10 22 02 00 00 06 00 20 80 00
10: 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 86 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP 
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: cf000000-cfffffff
        Prefetchable memory behind bridge: eff00000-febfffff
00: 39 10 01 00 07 00 00 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 d0 00 20
20: 00 cf f0 cf f0 ef b0 fe 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00

00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 
0963 (rev 04)
        Flags: bus master, medium devsel, latency 0
00: 39 10 63 09 0f 00 00 02 04 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

(There's no difference in the output for the SIS963)

I'll have a look at APCI later today.

-- 
John Collins Xi Software Ltd www.xisl.com



