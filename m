Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbRAPWPr>; Tue, 16 Jan 2001 17:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130159AbRAPWPh>; Tue, 16 Jan 2001 17:15:37 -0500
Received: from sandy.surfsouth.com ([216.128.200.25]:7952 "EHLO
	sandy.surfsouth.com") by vger.kernel.org with ESMTP
	id <S129819AbRAPWP1>; Tue, 16 Jan 2001 17:15:27 -0500
Date: Tue, 16 Jan 2001 17:16:23 -0500
From: Chad Miller <cmiller@surfsouth.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: G400 behavior different, 2.2.18->2.4.0
Message-ID: <20010116171623.A623@cahoots.surfsouth.com>
In-Reply-To: <12C5A55170A3@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <12C5A55170A3@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Tue, Jan 16, 2001 at 10:40:51PM +0000
X-mrl-nonsense: It's better to be Pavlov's Dog than Schrodenger's Cat.
X-key-info: GPG key at http://web.chad.org/home/gpgkey
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 10:40:51PM +0000, Petr Vandrovec wrote:
> [X] Output under 2.2.x is correct: '/25' for 32MB range. I have no idea
> why X complains about region D6000000-D7FFFFFF - can you look at
> '... regions behind bridge' when you boot 2.2.x (they are on 0:01.0
> device, AFAIK) ? Under 2.4.x you showed that prefetchable region is 
> D6000000-D8FFFFFF, which correctly covers 2.2.x framebuffer address
> (although it is not power of 2, but who knows...).

Here's the full 2.2 output of 'lspci -v':

#00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
#	Flags: bus master, medium devsel, latency 0
#	Memory at d0000000 (32-bit, prefetchable)
#	Capabilities: [a0] AGP version 2.0
#
#00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP]  (prog-if \
#00 [Normal decode])
#	Flags: bus master, 66Mhz, medium devsel, latency 0
#	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
#	Memory behind bridge: d4000000-d6ffffff
#	Prefetchable memory behind bridge: d7000000-d8ffffff
#	Capabilities: [80] Power Management version 2
#
#00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] \
#(rev 22)
#	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
#	Flags: bus master, stepping, medium devsel, latency 0
#
#00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) \
#(prog-if 8a [Master SecP PriP])
#	Flags: bus master, medium devsel, latency 32
#	I/O ports at e000
#	Capabilities: [c0] Power Management version 2
#
#00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] \
#(rev 30)
#	Flags: medium devsel
#	Capabilities: [68] Power Management version 2
#
#00:09.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] \
#(rev 08)
#	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
#	Flags: bus master, medium devsel, latency 32, IRQ 11
#	Memory at da100000 (32-bit, non-prefetchable)
#	I/O ports at ec00
#	Memory at da000000 (32-bit, non-prefetchable)
#	Capabilities: [dc] Power Management version 2
#
#01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP \
#(rev 05) (prog-if 00 [VGA])
#	Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
#	Flags: bus master, VGA palette snoop, medium devsel, latency 32, IRQ 10
#	Memory at d6000000 (32-bit, prefetchable)
#	Memory at d4000000 (32-bit, non-prefetchable)
#	Memory at d5000000 (32-bit, non-prefetchable)
#	Capabilities: [dc] Power Management version 2
#	Capabilities: [f0] AGP version 2.0


The diff from above 2.2.18 to 2.4.0:
3,4c3,4
< 	Memory at d0000000 (32-bit, prefetchable)
< 	Capabilities: [a0] AGP version 2.0
---
> 	Memory at d0000000 (32-bit, prefetchable) [size=64M]
> 	Capabilities: <available only to root>
11c11
< 	Capabilities: [80] Power Management version 2
---
> 	Capabilities: <available only to root>
19,20c19,20
< 	I/O ports at e000
< 	Capabilities: [c0] Power Management version 2
---
> 	I/O ports at e000 [size=16]
> 	Capabilities: <available only to root>
24c24
< 	Capabilities: [68] Power Management version 2
---
> 	Capabilities: <available only to root>
29,32c29,33
< 	Memory at da100000 (32-bit, non-prefetchable)
< 	I/O ports at ec00
< 	Memory at da000000 (32-bit, non-prefetchable)
< 	Capabilities: [dc] Power Management version 2
---
> 	Memory at da100000 (32-bit, non-prefetchable) [size=4K]
> 	I/O ports at ec00 [size=64]
> 	Memory at da000000 (32-bit, non-prefetchable) [size=1M]
> 	Expansion ROM at <unassigned> [disabled] [size=1M]
> 	Capabilities: <available only to root>
36,41c37,42
< 	Flags: bus master, VGA palette snoop, medium devsel, latency 32, IRQ 10
< 	Memory at d6000000 (32-bit, prefetchable)
< 	Memory at d4000000 (32-bit, non-prefetchable)
< 	Memory at d5000000 (32-bit, non-prefetchable)
< 	Capabilities: [dc] Power Management version 2
< 	Capabilities: [f0] AGP version 2.0
---
> 	Flags: bus master, VGA palette snoop, medium devsel, latency 64, IRQ 10
> 	Memory at d8000000 (32-bit, prefetchable) [size=16M]
> 	Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
> 	Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
> 	Expansion ROM at <unassigned> [disabled] [size=64K]
> 	Capabilities: <available only to root>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
