Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbTHSUyc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTHSUtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:49:01 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:12675
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261418AbTHSUpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:45:10 -0400
Date: Tue, 19 Aug 2003 16:43:10 -0500 (CDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       <linux-pcmcia@lists.infradead.org>
Subject: Re: [CFT] Clean up yenta_socket
In-Reply-To: <20030819124238.A18205@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308191534530.4010-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, Russell King wrote:

> On Mon, Aug 18, 2003 at 09:31:20PM -0500, Thomas Molina wrote:
> > My laptop is a Presario 12XL325 and I use an SMC 2632W wireless ethernet 
> > adapter in the PCMCIA slot.  
> 
> Thanks.  However, it'd help to know the type of your cardbus controller.

here is the lspci output for the cardbus controller on my laptop:

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus 
Controller (rev 01)
        Subsystem: Compaq Computer Corporation: Unknown device b103
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 04
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite+
        16-bit legacy interface ports at 0001


Following is the relevant dmesg output during bootup for 2.6.0-test3-mm2 
with your patchset applied

PCI: Assigned IRQ 9 for device 0000:00:0a.0
Yenta: CardBus bridge found at 0000:00:0a.0 [0e11:b103]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0018, PCI irq9
Socket status: 30000010
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x220-0x22f
0x378-0x37f 0x388-0x38f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and
others)
eth0: Station identity 001f:0003:0000:0008
eth0: Looks like an Intersil firmware version 0.8.3
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:04:E2:2A:29:58
eth0: Station name "Prism  I"
eth0: ready
eth0: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f


