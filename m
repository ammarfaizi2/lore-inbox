Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbUKBQox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbUKBQox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 11:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbUKBQma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 11:42:30 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:56532 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261531AbUKBQYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 11:24:40 -0500
Message-ID: <4187B4C6.5020207@verizon.net>
Date: Tue, 02 Nov 2004 11:24:38 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Jez <dave.jez@seznam.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI & IRQ problems on TI Extensa 600CD
References: <20041023142906.GA15789@stud.fit.vutbr.cz> <417AB69E.8010709@verizon.net> <20041025161945.GA82114@stud.fit.vutbr.cz> <20041029081848.GA5240@stud.fit.vutbr.cz> <41821250.70502@verizon.net> <20041101084211.GA98600@stud.fit.vutbr.cz> <4186334E.40109@verizon.net> <20041101202730.GA49588@stud.fit.vutbr.cz> <4187967D.2090308@verizon.net>
In-Reply-To: <4187967D.2090308@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [68.238.31.6] at Tue, 2 Nov 2004 10:24:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>   It looks that you have same problem and kernel doesn't find IRQ
>> router. So try attached patch (for 2.6.9 and added your bridge) if it 
>> helps.
>> I think that it may help (look at dump_pirq results).
>>   You can try turn on DEBUG (in file arch/i386/pci/pci.h) and see debug
>> messages on screen.
>>
>>   Dave
>>
>>
> 
> That patch comes too late in the PCI init sequence for my machine. 
> pirq_find_router() (where your patch goes) depends on pirq_table being 
> set up by pirq_find_routing_table().  When I put in the debug statement 
> in the attached patch, I got the "PCI: No Interrupt Routing Table found" 
> message.  Since pirq_table wasn't set up, pirq_find_router() is never 
> called.  Let me look at this some more (got vacation this week, so I can 
> finally devote some time to this.)
> 
> Jim
> 

When I used pci=biosirq, this is what I got:


Linux version 2.6.9-Thinkpad (jim@david) (gcc version 3.3.3 20040412 (Red Hat 
Linux 3.3.3-7)) #9 Tue Nov 2 10:29:03 EST 2004

<snip>

PCI: BIOS32 Service Directory structure at 0xc00fd8e0
PCI: BIOS32 Service Directory entry at 0xfd8f0
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=06
PCI: PCI BIOS revision 2.10 entry at 0xfd930, last bus=6
PCI: Using configuration type 1
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe700
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe724, dseg 0xf0000
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Scanning for ghost devices on bus 0
PCI: Peer bridge fixup
PCI: IRQ init
PCI: Fetching IRQ routing table... OK  ret=14, size=48, map=800
PCI: Using BIOS Interrupt Routing Table
00:03 slot=00 0:01/def8 1:00/0000 2:00/0000 3:00/0000
00:05 slot=00 0:01/def8 1:00/0000 2:00/0000 3:00/0000
00:04 slot=00 0:01/def8 1:02/def8 2:03/def8 3:04/def8
PCI: Using BIOS for IRQ routing
PCI: IRQ fixup
0000:00:02.0: ignoring bogus IRQ 255
0000:00:02.1: ignoring bogus IRQ 255
IRQ for 0000:00:02.0:0 -> not found in routing table
IRQ for 0000:00:02.1:1 -> not found in routing table
PCI: Allocating resources
PCI: Resource 10812000-10812fff (f=200, d=0, p=0)
PCI: Resource 10811000-10811fff (f=200, d=0, p=0)
PCI: Resource 08000000-083fffff (f=200, d=0, p=0)
PCI: Resource 08400000-0840ffff (f=200, d=0, p=0)
PCI: Resource 08800000-08bfffff (f=200, d=0, p=0)
PCI: Resource 10810000-108100ff (f=200, d=0, p=0)
PCI: Sorting device list...
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:10' and the driver 'system'
pnp: 00:10: ioport range 0x100-0x107 has been reserved
pnp: 00:10: ioport range 0x26e-0x26f has been reserved
pnp: 00:10: ioport range 0xd00-0xd01 has been reserved
pnp: 00:10: ioport range 0x15e8-0x15ef has been reserved
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found

<snip>

Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
IRQ for 0000:00:02.0:0 -> not found in routing table
PCI: No IRQ known for interrupt pin A of device 0000:00:02.0.
Yenta: CardBus bridge found at 0000:00:02.0 [0000:0000]
Yenta: ISA IRQ mask 0x06b8, PCI irq 0
Socket status: 30000006
IRQ for 0000:00:02.1:1 -> not found in routing table
PCI: No IRQ known for interrupt pin B of device 0000:00:02.1.
Yenta: CardBus bridge found at 0000:00:02.1 [0000:0000]
Yenta: ISA IRQ mask 0x06b8, PCI irq 0
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0820-0x08ff: clean.
cs: IO port probe 0x0800-0x080f: clean.
cs: IO port probe 0x03e0-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0100-0x03af: excluding 0x200-0x207
cs: IO port probe 0x0a00-0x0aff: excluding 0xa68-0xa6f
spurious 8259A interrupt: IRQ7.

It's a BIOS problem.  Linux is capable of retreiving the pirq table using BIOS 
calls, but the table the BIOS returns does not have entries for the Cardbus 
bridge.  I think I might be out of luck.  Lemme go do some research, and see what 
I can dig up.

Jim
