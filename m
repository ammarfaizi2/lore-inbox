Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTELSFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbTELSFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:05:16 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:33327 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262524AbTELSE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:04:27 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, stern@rowland.harvard.edu,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com
In-Reply-To: <20030512180112.GA28675@kroah.com>
References: <1052402187.1995.13.camel@diemos>
	 <20030508122205.7b4b8a02.akpm@digeo.com> <1052503920.2093.5.camel@diemos>
	 <1052512235.2997.8.camel@diemos> <20030509142828.59552d0a.akpm@digeo.com>
	 <1052747862.1996.9.camel@diemos> <20030512162454.GA27939@kroah.com>
	 <1052759300.1995.4.camel@diemos> <20030512173023.GB28381@kroah.com>
	 <1052761769.1995.27.camel@diemos>  <20030512180112.GA28675@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052763305.1995.36.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 May 2003 13:15:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-12 at 13:01, Greg KH wrote:
> On Mon, May 12, 2003 at 12:49:29PM -0500, Paul Fulghum wrote:
> > 
> > How about some sort of sanity check (as you mentioned
> > earlier), so this is not shooting off all of the time
> > during normal operation.
> 
> That's the proper thing to do.  Also possibly blacklisting your
> motherboard's USB controller.  What does lspci -v show?

If both can be accomplished (state check to qualify delay
and blacklisting), that would be optimal.

The machine is the HP Netserver LC3 which does not
officially have USB (but apparently has a vestigial
controller), so blacklisting should be a no brainer.

Output of lspci:

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(AGP disabled) (rev 02)
	Flags: bus master, medium devsel, latency 64
	Memory at <unassigned> (32-bit, prefetchable) [size=256M]

00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 32
	I/O ports at fcb0 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at fce0 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Flags: medium devsel, IRQ 9

00:07.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 02)
(prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 57
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=36
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: feb00000-febfffff
	Prefetchable memory behind bridge: 00000000fbf00000-00000000fbf00000

00:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 05)
	Subsystem: Hewlett-Packard Company NetServer 10/100TX
	Flags: bus master, medium devsel, latency 66, IRQ 16
	Memory at fecfc000 (32-bit, prefetchable) [size=4K]
	I/O ports at fcc0 [size=32]
	Memory at fed00000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 1

00:09.0 Communication controller: Microgate Corporation: Unknown device
0030 (rev 01)
	Subsystem: Microgate Corporation: Unknown device 0030
	Flags: medium devsel, IRQ 17
	Memory at fecfd400 (32-bit, non-prefetchable) [size=128]
	I/O ports at fc00 [size=128]
	Memory at fecfd800 (32-bit, non-prefetchable) [size=512]
	Memory at fec80000 (32-bit, prefetchable) [size=256K]
	Memory at fecfdc00 (32-bit, non-prefetchable) [size=16]

00:0a.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
	Subsystem: Adaptec AIC-7880P Ultra/Ultra Wide SCSI Chipset
	Flags: bus master, medium devsel, latency 64, IRQ 19
	I/O ports at f800 [disabled] [size=256]
	Memory at fecff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1

00:0d.0 VGA compatible controller: Cirrus Logic GD 5446 (rev 45)
(prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0001
	Flags: medium devsel
	Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Memory at fecfe000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=32K]

01:02.0 Communication controller: Microgate Corporation: Unknown device
0020 (rev 01)
	Subsystem: Microgate Corporation: Unknown device 0020
	Flags: medium devsel, IRQ 18
	Memory at febff800 (32-bit, non-prefetchable) [size=128]
	I/O ports at ec00 [size=128]
	I/O ports at ecfc [size=4]

01:03.0 Communication controller: Microgate Corporation: Unknown device
0210 (rev 02)
	Subsystem: Microgate Corporation: Unknown device 0210
	Flags: medium devsel, IRQ 19
	Memory at febff400 (32-bit, non-prefetchable) [size=128]
	I/O ports at e880 [size=128]
	I/O ports at ece8 [size=8]
	Memory at fbf80000 (32-bit, prefetchable) [size=256K]

01:04.0 Communication controller: Microgate Corporation SyncLink WAN
Adapter (rev 01)
	Subsystem: Microgate Corporation SyncLink WAN Adapter
	Flags: medium devsel, IRQ 16
	Memory at febfe800 (32-bit, non-prefetchable) [size=128]
	I/O ports at e800 [size=128]
	I/O ports at ecf0 [size=8]
	Memory at fbf40000 (32-bit, prefetchable) [size=256K]



-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


