Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbUCBEaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 23:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbUCBEaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 23:30:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29838 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261557AbUCBEaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 23:30:15 -0500
Message-ID: <40440DC9.7060507@pobox.com>
Date: Mon, 01 Mar 2004 23:30:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Lee <steve@tuxsoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1 problems with e100 & 3c59x
References: <005b01c3ffd3$54955140$8119fea9@pluto>
In-Reply-To: <005b01c3ffd3$54955140$8119fea9@pluto>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lee wrote:
> I've searched the archives as well as googled around without any luck
> regarding my situation.  BTW, please CC me as I'm no longer subscribed
> (furthering my education has prevented me from keeping up with the
> list).
> 
> Anyways, I have the following two network cards:
> 
> 02:04.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
> (rev 30)
>         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
>         Flags: bus master, medium devsel, latency 32, IRQ 16
>         I/O ports at a000 [size=128]
>         Memory at fb025000 (32-bit, non-prefetchable) [size=128]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: <available only to root>
> 00: b7 10 55 90 07 00 10 02 30 00 00 02 08 20 00 00
> 10: 01 a0 00 00 00 50 02 fb 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
> 30: 00 00 00 00 dc 00 00 00 00 00 00 00 07 01 0a 0a
> 
> 02:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
> (rev 0d)
>         Subsystem: Intel Corp. EtherExpress PRO/100 Server Adapter
>         Flags: bus master, medium devsel, latency 32, IRQ 16
>         Memory at fb024000 (32-bit, non-prefetchable) [size=4K]
>         I/O ports at ac00 [size=64]
>         Memory at fb000000 (32-bit, non-prefetchable) [size=128K]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: <available only to root>
> 00: 86 80 29 12 07 00 90 02 0d 00 00 02 08 20 00 00
> 10: 00 40 02 fb 01 ac 00 00 00 00 00 fb 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 42 10
> 30: 00 00 00 00 dc 00 00 00 00 00 00 00 07 01 08 38
> 
> Using 2.4.x (including the latest stable), I've had no trouble getting
> these cards to work as modules.  However, when I upgraded to 2.6.0 I
> couldn't get them to work as modules, but finally tried compiling them
> into the kernel and all was well until 2.6.4-rc1.  Now, no matter what I
> do, compiled in or as modules, I can not get both cards working.
> 
> The structure of the network is:
> 
> eth0 is the Intel card - internal network (alias eth0 e100)
> eth1 is the 3Com card - cable modem (alias eth1 3c59x)
> 
> When attempting to compile 2.6.4-rc1 with modules, I see this in the
> logs:
> 
> Feb 28 22:31:29 jupiter kernel: 3c59x: Donald Becker and others.
> www.scyld.com/network/vortex.html
> Feb 28 22:31:29 jupiter kernel: 0000:02:04.0: 3Com PCI 3c905B Cyclone
> 100baseTx at 0xa000. Vers LK1.1.19
> Feb 28 22:31:29 jupiter kernel: e100: Intel(R) PRO/100 Network Driver,
> 3.0.15
> Feb 28 22:31:29 jupiter kernel: e100: Copyright(c) 1999-2004 Intel
> Corporation
> Feb 28 22:31:29 jupiter kernel: e100: eth1: e100_probe: addr 0xfb024000,
> irq 16, MAC addr 00:ED:20:7F:3A:55
> 
> As you can see, e100 is coming up as eth1, which is not correct.  I
> assume 3c59x has probably grabbed eth0, which also is not correct.  When
> configured for modules, is eth0 always the first card found?  At any
> rate, I tried switching the cables on the network cards to see if it
> would work like that, but unfortunately it didn't.


The order of ethX is dependent on the link order, when you build modules 
into the kernel.  So, yes, eth0 is always the first card found.

	Jeff



