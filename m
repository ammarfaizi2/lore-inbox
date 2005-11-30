Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbVK3Eso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVK3Eso (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 23:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVK3Eso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 23:48:44 -0500
Received: from smtp-8.smtp.ucla.edu ([169.232.47.137]:52939 "EHLO
	smtp-8.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1750992AbVK3Esn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 23:48:43 -0500
Message-ID: <438D2F25.2020707@ucla.edu>
Date: Tue, 29 Nov 2005 20:48:37 -0800
From: Ethan Chen <thanatoz@ucla.edu>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-kernel@vger.kernel.org, thanatoz@ucla.edu,
       Carlos.Pardo@siliconimage.com, jgarzik@pobox.com,
       linux-ide@vger.kernel.org
Subject: Re: SIL_QUIRK_MOD15WRITE workaround problem on 2.6.14
References: <438BD351.60902@ucla.edu> <438D2792.9050105@gmail.com>
In-Reply-To: <438D2792.9050105@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun,

The motherboard is an Iwill DK8X utilizing the AMD 8151+8131+8111 chips.

lspci -nv
00:00.0 Class 0600: 1022:7454 (rev 13)
    Subsystem: 1022:7454
    Flags: bus master, medium devsel, latency 0
    Memory at f8000000 (32-bit, prefetchable) [size=64M]
    Capabilities: [a0] AGP version 3.0
    Capabilities: [c0] HyperTransport: Slave or Primary Interface

00:01.0 Class 0604: 1022:7455 (rev 13)
    Flags: bus master, 66Mhz, medium devsel, latency 32
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
    Memory behind bridge: fc700000-fe7fffff
    Prefetchable memory behind bridge: e4600000-f45fffff

00:06.0 Class 0604: 1022:7460 (rev 07)
    Flags: bus master, 66Mhz, medium devsel, latency 32
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
    I/O behind bridge: 0000a000-0000afff
    Memory behind bridge: fe800000-fe8fffff
    Capabilities: [c0] HyperTransport: Slave or Primary Interface
    Capabilities: [f0] HyperTransport: Interrupt Discovery and Configuration

00:07.0 Class 0601: 1022:7468 (rev 05)
    Subsystem: 1022:7468
    Flags: bus master, 66Mhz, medium devsel, latency 0

00:07.1 Class 0101: 1022:7469 (rev 03) (prog-if 8a [Master SecP PriP])
    Subsystem: 1022:7469
    Flags: bus master, medium devsel, latency 32
    I/O ports at ffa0 [size=16]

00:07.2 Class 0c05: 1022:746a (rev 02)
    Subsystem: 1022:746a
    Flags: medium devsel, IRQ 9
    I/O ports at cc00 [size=32]

00:07.3 Class 0680: 1022:746b (rev 05)
    Subsystem: 1022:746b
    Flags: medium devsel

00:0a.0 Class 0604: 1022:7450 (rev 12)
    Flags: bus master, 66Mhz, medium devsel, latency 32
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
    I/O behind bridge: 0000b000-0000bfff
    Memory behind bridge: fe900000-feafffff
    Capabilities: [a0] PCI-X bridge device.
    Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration
    Capabilities: [c0] HyperTransport: Slave or Primary Interface

00:0a.1 Class 0800: 1022:7451 (rev 01) (prog-if 10)
    Subsystem: 1022:7451
    Flags: bus master, medium devsel, latency 0
    Memory at febff000 (64-bit, non-prefetchable) [size=4K]

00:0b.0 Class 0604: 1022:7450 (rev 12)
    Flags: bus master, 66Mhz, medium devsel, latency 32
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
    Capabilities: [a0] PCI-X bridge device.
    Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration

00:0b.1 Class 0800: 1022:7451 (rev 01) (prog-if 10)
    Subsystem: 1022:7451
    Flags: bus master, medium devsel, latency 0
    Memory at febfe000 (64-bit, non-prefetchable) [size=4K]

00:18.0 Class 0600: 1022:1100
    Flags: fast devsel
    Capabilities: [80] HyperTransport: Host or Secondary Interface
    Capabilities: [a0] HyperTransport: Host or Secondary Interface
    Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:18.1 Class 0600: 1022:1101
    Flags: fast devsel

00:18.2 Class 0600: 1022:1102
    Flags: fast devsel

00:18.3 Class 0600: 1022:1103
    Flags: fast devsel

00:19.0 Class 0600: 1022:1100
    Flags: fast devsel
    Capabilities: [80] HyperTransport: Host or Secondary Interface
    Capabilities: [a0] HyperTransport: Host or Secondary Interface
    Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:19.1 Class 0600: 1022:1101
    Flags: fast devsel

00:19.2 Class 0600: 1022:1102
    Flags: fast devsel

00:19.3 Class 0600: 1022:1103
    Flags: fast devsel

01:00.0 Class 0300: 10de:0281 (rev a1)
    Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 18
    Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
    Memory at e8000000 (32-bit, prefetchable) [size=128M]
    Expansion ROM at fe7e0000 [disabled] [size=128K]
    Capabilities: [60] Power Management version 2
    Capabilities: [44] AGP version 3.0

02:00.0 Class 0c03: 1022:7464 (rev 0b) (prog-if 10)
    Subsystem: 1022:7464
    Flags: bus master, medium devsel, latency 32, IRQ 17
    Memory at fe8fe000 (32-bit, non-prefetchable) [size=4K]

02:00.1 Class 0c03: 1022:7464 (rev 0b) (prog-if 10)
    Subsystem: 1022:7464
    Flags: bus master, medium devsel, latency 32, IRQ 17
    Memory at fe8ff000 (32-bit, non-prefetchable) [size=4K]

02:04.0 Class 0401: 1102:0002 (rev 07)
    Subsystem: 1102:8064
    Flags: bus master, medium devsel, latency 32, IRQ 18
    I/O ports at a880 [size=32]
    Capabilities: [dc] Power Management version 1

02:04.1 Class 0980: 1102:7002 (rev 07)
    Subsystem: 1102:0020
    Flags: bus master, medium devsel, latency 32
    I/O ports at ac00 [size=8]
    Capabilities: [dc] Power Management version 1

02:06.0 Class 0c00: 104c:8023 (prog-if 10)
    Subsystem: 104c:8023
    Flags: bus master, medium devsel, latency 32, IRQ 19
    Memory at fe8fd800 (32-bit, non-prefetchable) [size=2K]
    Memory at fe8f8000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [44] Power Management version 2

02:07.0 Class 0c03: 1033:0035 (rev 43) (prog-if 10)
    Subsystem: 1033:0035
    Flags: bus master, medium devsel, latency 32, IRQ 17
    Memory at fe8f7000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [40] Power Management version 2

02:07.1 Class 0c03: 1033:0035 (rev 43) (prog-if 10)
    Subsystem: 1033:0035
    Flags: bus master, medium devsel, latency 32, IRQ 18
    Memory at fe8fc000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [40] Power Management version 2

02:07.2 Class 0c03: 1033:00e0 (rev 04) (prog-if 20)
    Subsystem: 1033:00e0
    Flags: bus master, medium devsel, latency 32, IRQ 16
    Memory at fe8fd400 (32-bit, non-prefetchable) [size=256]
    Capabilities: [40] Power Management version 2

03:03.0 Class 0200: 11ab:4320 (rev 13)
    Subsystem: 15d4:0047
    Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 17
    Memory at feaf8000 (32-bit, non-prefetchable) [size=16K]
    I/O ports at b000 [size=256]
    Expansion ROM at feac0000 [disabled] [size=128K]
    Capabilities: [48] Power Management version 2
    Capabilities: [50] Vital Product Data

03:05.0 Class 0180: 1095:3114 (rev 02)
    Subsystem: 1095:3114
    Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
    I/O ports at bc00 [size=8]
    I/O ports at b880 [size=4]
    I/O ports at b800 [size=8]
    I/O ports at b480 [size=4]
    I/O ports at b400 [size=16]
    Memory at feaffc00 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at fea00000 [disabled] [size=512K]
    Capabilities: [60] Power Management version 2

Thanks,

-Ethan


Tejun Heo wrote:

> [CC'ing Jeff, Carlos & linux-ide]
>
> Ethan Chen wrote:
>
>> I've got a dual Opteron 242 machine here with 2x Seagate ST3200822AS 
>> SATA drives attached to a Silicon Image SI3114 controller, and after 
>> upgrading to 2.6.14 from 2.6.13, it seems the SIL_QUIRK_MOD15WRITE 
>> workaround for the sata_sil driver isn't being applied anymore. This 
>> caused me trouble in the past before my drive was added to the 
>> blacklist, and this message that comes up when writing (~4GBfiles to 
>> test) files, right before the computer locks up, is the same as before:
>> kernel: ata1: command 0x35 timeout, stat 0xd8 host_stat 0x61
>> In the dmesg, the 'Applying Seagate errata fix' message doesn't 
>> appear anymore as well.
>> Finally, without the fix, write speeds are much higher as well, 
>> before it locks up.
>
>
> Hello, Ethan.
>
> Sometime ago, Silicon Image has confirmed that 3114's and 3512's are 
> not affected by the m15w problem - only 3112's are affected.  So, a 
> patch has made into the tree before 2.6.14 to apply the m15w quirk 
> selectively.
>
> Can you post 'lspci -nv' result?
>

