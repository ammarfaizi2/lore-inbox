Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSKRV7N>; Mon, 18 Nov 2002 16:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbSKRV5W>; Mon, 18 Nov 2002 16:57:22 -0500
Received: from windsormachine.com ([206.48.122.28]:23564 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S265019AbSKRVzi>; Mon, 18 Nov 2002 16:55:38 -0500
Date: Mon, 18 Nov 2002 17:02:36 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
In-Reply-To: <3DD959D7.5020306@pobox.com>
Message-ID: <Pine.LNX.4.33.0211181657310.27512-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Jeff Garzik wrote:

> > Want me to put this 8139D here into a machine and do an lspci for you?
>
> Sure...   I'm pretty sure of what I will see, but it cannot hurt :)
>
> 	Jeff
>
Ok, I put the 8139D card in, did not work with either the 8139too or
8139cp driver.

Here is the lspci -vvvvvvvvvvv output(i'm lazy)

00:0d.0 Ethernet controller: Unknown device 00ec:8139 (rev 10)
        Subsystem: AOPEN Inc.: Unknown device 0027
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 8000 [size=256]
        Region 1: Memory at d9000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

I went into drivers/net/8139too.c and added a line

        {0x00ec, 0x8139, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },

to the pci_id table with the 00ec:8139 address, and now the card works
with 8139too.

I assume the same fix in pci-skeleton.c would fix it for 8139cp, correct?

I am using the card right now, and seems to be working, although picked up
as a C

eth0: RealTek RTL8139 Fast Ethernet at 0xd0800000, 00:40:f4:64:bd:34, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'

I'll modify pci-sketelon.c the same way, and see if 8139cp works.

Mike

