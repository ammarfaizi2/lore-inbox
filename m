Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288704AbSADSDZ>; Fri, 4 Jan 2002 13:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288708AbSADSDR>; Fri, 4 Jan 2002 13:03:17 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:57999 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S288704AbSADSDL>;
	Fri, 4 Jan 2002 13:03:11 -0500
Message-ID: <3C35E359.4000004@candelatech.com>
Date: Fri, 04 Jan 2002 10:16:09 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Michael Klose <mkmail@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: eepro100 kernel freeze / ISDN
In-Reply-To: <3C35DDFC.50700@gmx.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is probably the eepro connected to the 10bt device.  10bt
seems to lock things up much more often than a 100bt network connection.

Unfortunately, the only work-around I found for this problem so far
is to change the hardware to a non intel NIC, or to use the e100 module
from Intel...

Ben

Michael Klose wrote:

> I know there have been mails on this in this list before, the last I 
> heard was a month ago and I saw many fixes going into recent kernels.
> 
> My contribution is just to say that the problem has gotten worse.
> 
> In 2.4.15pre5 (in my opinion one of the most stable 2.4 kernels I have 
> tested) it "only" crashed after transferring about 2-3 GB of data via my 
> laptop SMB share over the 100MBit switch to the linux server.
> 2.4.17 crashes after 100-200 GB of data transfer.
> 
> By crash I mean total freeze. Nothing in the logs at all. Only a reset 
> or poweroff will help.
> The server is running on a dual Pentium II BX board (only one PII 266 in 
> it though) with 256MB RAM. Also, SMP support is currently NOT compiled in.
> 
> I have two intel eepro100 cards in there.
> 
> (2.4.17 kernel output)
> 
> Jan  4 17:27:34 linux kernel: eth0: OEM i82557/i82558 10/100 Ethernet, 
> 00:50:8B:04:6F:CD, IRQ 12.
> Jan  4 17:27:34 linux kernel:   Receiver lock-up bug exists -- enabling 
> work-around.
> Jan  4 17:27:34 linux kernel:   Board assembly 702536-008, Physical 
> connectors present: RJ45
> Jan  4 17:27:34 linux kernel:   Primary interface chip i82555 PHY #1.
> Jan  4 17:27:34 linux kernel:   General self-test: passed.
> Jan  4 17:27:34 linux kernel:   Serial sub-system self-test: passed.
> Jan  4 17:27:34 linux kernel:   Internal registers self-test: passed.
> Jan  4 17:27:34 linux kernel:   ROM checksum self-test: passed 
> (0x24c9f043).
> Jan  4 17:27:34 linux kernel:   Receiver lock-up workaround activated.
> Jan  4 17:27:34 linux kernel: PCI: Found IRQ 10 for device 00:12.0
> Jan  4 17:27:34 linux kernel: eth1: Intel Corp. 82557 [Ethernet Pro 100] 
> (#2), 00:A0:C9:B5:0C:E6, IRQ 10.
> Jan  4 17:27:34 linux kernel:   Receiver lock-up bug exists -- enabling 
> work-around.
> Jan  4 17:27:34 linux kernel:   Board assembly 682704-002, Physical 
> connectors present: RJ45
> Jan  4 17:27:34 linux kernel:   Primary interface chip i82555 PHY #1.
> Jan  4 17:27:34 linux kernel:   General self-test: passed.
> Jan  4 17:27:35 linux kernel:   Serial sub-system self-test: passed.
> Jan  4 17:27:35 linux kernel:   Internal registers self-test: passed.
> Jan  4 17:27:35 linux kernel:   ROM checksum self-test: passed Jan  4 
> 17:26:20 linux fsck: reiserfsprogs 3.x.0j
> Jan  4 17:27:35 linux kernel:   Receiver lock-up workaround activated.
> 
> In between rc.sysinit was running, setting up the clock, atd and 
> starting to check filesystems, but I took out those bits of the log.
> 
> eth0 is connected to the 100MBit switch which connects to the LAN.
> eth1 is just connected to a DSL modem (10 MBit link).
> 
> I have tried switching around the cards, doesn't work.
> 
> Apart from that the system runs stable. A two day run of constantly 
> compiling kernels while copying several gigabytes between hard disks 
> over and over again at the same time did not seem to crash it.
> 
> It crashed immediately though as soon as you have HIGH network traffic. 
> By that I mean copying several hundred Megabyte to the server. As soon 
> as you do this, it crashes every time.
> 
> On 2.4.15pre5 it required a lot more data to be transferred to be 
> crashed, usually in the 1-2 gigabyte range.
> 
> I have an unrelated problem with an ISDN card USR sportster in the 
> latest release. It no longer works. It has been working happily for 
> years on a 2.0.36 until I upgraded to the new server. It has been 
> running fine sinde 2.4.5 (I didn't try earlier kernels on that machine) 
> and it still worked fine in 2.4.15pre5. I am not much interested in ISDN 
> anymore since I have DSL since a week now. I just wanted to mention it:
> 
> Jan  4 17:12:06 linux kernel: ISDN subsystem Rev: 
> 1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1/none/1.1.4.1 loaded
> Jan  4 17:12:06 linux kernel: HiSax: Linux Driver for passive ISDN cards
> Jan  4 17:12:06 linux kernel: HiSax: Version 3.5 (module)
> Jan  4 17:12:06 linux kernel: HiSax: Layer1 Revision 1.1.4.1
> Jan  4 17:12:06 linux kernel: HiSax: Layer2 Revision 1.1.4.1
> Jan  4 17:12:06 linux kernel: HiSax: TeiMgr Revision 1.1.4.1
> Jan  4 17:12:06 linux kernel: HiSax: Layer3 Revision 1.1.4.1
> Jan  4 17:12:06 linux kernel: HiSax: LinkLayer Revision 1.1.4.1
> Jan  4 17:12:06 linux kernel: HiSax: Approval certification failed 
> because of
> Jan  4 17:12:06 linux kernel: HiSax: unauthorized source code changes
> Jan  4 17:12:06 linux kernel: HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
> Jan  4 17:12:06 linux kernel: HiSax: USR Sportster driver Rev. 1.1.4.1
> Jan  4 17:12:06 linux kernel: HiSax: USR Sportster config irq:10 cfg:0x258
> Jan  4 17:12:06 linux kernel: Sportster: ISAC version (0): 2086/2186 V1.1
> Jan  4 17:12:06 linux kernel: Sportster: HSCX version A: V2.1  B: V2.1
> Jan  4 17:12:06 linux kernel: USR Sportster: IRQ 10 count 0
> Jan  4 17:12:06 linux kernel: USR Sportster: IRQ 10 count 0
> Jan  4 17:12:06 linux kernel: USR Sportster: IRQ(10) getting no 
> interrupts during init 1
> Jan  4 17:12:06 linux kernel: USR Sportster: IRQ 10 count 0
> Jan  4 17:12:06 linux isdn: Loading ISDN modules succeeded
> Jan  4 17:12:06 linux kernel: USR Sportster: IRQ(10) getting no 
> interrupts during init 2
> Jan  4 17:12:06 linux kernel: USR Sportster: IRQ 10 count 0
> Jan  4 17:12:06 linux kernel: USR Sportster: IRQ(10) getting no 
> interrupts during init 3
> Jan  4 17:12:06 linux kernel: HiSax: Card USR Sportster not installed !
> 
> 
> If the ISDN thing is a RTFM  thing that I just need to upograde some 
> userland tools, then don't worry about it. I no longer need it so I 
> doidn't put much research into it. It was just working fine till the new 
> driver version came in in 2.4.17.
> 
> I am concerned about the eepro issue. I normally love intel network 
> cards, they are damn fast and give excellent throughput on Windows NT 
> servers and Windows desktop machines. But constantly crashing my server 
> is not a good thing.
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

