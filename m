Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277591AbRJLIkt>; Fri, 12 Oct 2001 04:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277592AbRJLIkh>; Fri, 12 Oct 2001 04:40:37 -0400
Received: from radium.jvb.tudelft.nl ([130.161.76.91]:33541 "HELO
	radium.jvb.tudelft.nl") by vger.kernel.org with SMTP
	id <S277591AbRJLIk1>; Fri, 12 Oct 2001 04:40:27 -0400
Date: Fri, 12 Oct 2001 10:41:53 +0200 (CEST)
From: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>
To: ionut@cs.columbia.edu
Cc: poptix@techmonkeys.org, linux-kernel@vger.kernel.org
Subject: Re: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 /
 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
Message-ID: <Pine.LNX.4.21.0110121025001.26282-100000@radium.jvb.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> >  Bus  2, device   4, function  0:
> >    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 5).
> >                                           ^^^^
>
> Umm, no, that's actually an 82558 rev B. pci.ids should be updated to 
> have "Intel Corporation 8255[7-9]" for this id, because Intel can't make 
> up their minds to change the PCI id when they release a new product.
> rev 1-3 are 82557, rev 4-5 are 82558, rev 6-8 are 82559.

Mine says rev 9 :)

radium:/# lspci -v -d 8086:1229
00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 09)
        Subsystem: Intel Corporation: Unknown device 0011
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at da020000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c800 [size=64]
        Memory at da000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

radium:/# lspci -nv -d 8086:1229
00:0d.0 Class 0200: 8086:1229 (rev 09)
        Subsystem: 8086:0011
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at da020000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c800 [size=64]
        Memory at da000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2


> > eth0: OEM i82557/i82558 10/100 Ethernet, DE:AD:BA:BE:CA:FE, IRQ 10.
> >  Receiver lock-up bug exists -- enabling work-around.
> >  ^^^^^^^^^^^^^^^^^^^^
> The OEM probably forgot to initialized the eeprom correctly, because 
> 82558 rev B and higher don't have this bug. Anyway, the workaround is 
> pretty harmless.

My card DOES NOT have the receiver lock-up bug and also DOES NOT have the
10 Mbit half duplex bug, which was the one I was referring to. The device 
detection for the workaround for the latter bug turned out to be
wrong.

- Robbert

