Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVCKX0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVCKX0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVCKX0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:26:10 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:57302 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261820AbVCKXXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:23:04 -0500
Subject: Re: AGP bogosities
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, werner@sgi.com,
       Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <16946.7941.404582.764637@cargo.ozlabs.ibm.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <200503102002.47645.jbarnes@engr.sgi.com>
	 <1110515459.32556.346.camel@gaston>
	 <200503110839.15995.jbarnes@engr.sgi.com> <1110563965.4822.22.camel@eeyore>
	 <16946.7941.404582.764637@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 16:22:55 -0700
Message-Id: <1110583375.4822.88.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-12 at 09:43 +1100, Paul Mackerras wrote:
> On PPC/PPC64 machines, the host bridges generally do not appear as PCI
> devices either.  *However*, the AGP spec requires a set of registers
> in PCI config space for controlling the target (host) side of the AGP
> bus.  In other words you are required to have a PCI device to
> represent the host side of the AGP bus, with a capability structure in
> its config space which contains the standard AGP registers.

I still don't quite understand this.  If the host bridge is not a
PCI device, what PCI device contains the AGP capability that controls
the host bridge?  I assume you're saying that you are required to
have TWO PCI devices that have the AGP capability, one for the AGP
device and one for the bridge.

HP boxes certainly don't have that (zx6000 sample below).  I guess
it wouldn't be the first time we deviated from a spec ;-)

Can you point me to the relevant section?


0000:00:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 010a
	Flags: bus master, stepping, 66MHz, medium devsel, latency 192, IRQ 255
	Memory at 0000000080000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 0d00 [size=256]
	Memory at 0000000088020000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at 0000000088000000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

0000:80:03.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 128
	Bus: primary=80, secondary=81, subordinate=81, sec-latency=128
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: a0000000-a40fffff
	Capabilities: [dc] Power Management version 1

0000:81:04.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 1293
	Flags: bus master, medium devsel, latency 128
	Memory at 00000000a4032000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2

0000:81:04.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device aa55
	Flags: bus master, medium devsel, latency 128
	Memory at 00000000a4031000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2

0000:81:04.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company: Unknown device aa55
	Flags: bus master, medium devsel, latency 128
	Memory at 00000000a4030000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

0000:81:05.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 1292
	Flags: bus master, stepping, medium devsel, latency 128, IRQ 255
	Memory at 00000000a0000000 (32-bit, prefetchable) [size=64M]
	I/O ports at 4000 [disabled] [size=256]
	Memory at 00000000a4020000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at 00000000a4000000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2

0000:a0:01.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Flags: bus master, medium devsel, latency 128
	Memory at 00000000d0022000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2

0000:a0:01.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Flags: bus master, medium devsel, latency 128
	Memory at 00000000d0021000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2

0000:a0:01.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: NEC Corporation USB 2.0
	Flags: bus master, medium devsel, latency 128
	Memory at 00000000d0020000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

0000:a0:02.0 IDE interface: Silicon Image, Inc. (formerly CMD Technology Inc) PCI0649 (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) PCI0649
	Flags: bus master, medium devsel, latency 64, IRQ 52
	I/O ports at a0e8 [size=8]
	I/O ports at a0f4 [size=4]
	I/O ports at a0e0 [size=8]
	I/O ports at a0f0 [size=4]
	I/O ports at a0d0 [size=16]
	Capabilities: [60] Power Management version 2

0000:a0:03.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device 1274
	Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 51
	Memory at 00000000d0000000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at a080 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

0000:a0:04.0 Multimedia audio controller: Fortemedia, Inc Xwave QS3000A [FM801] (rev b2)
	Subsystem: Fortemedia, Inc: Unknown device 1319
	Flags: bus master, medium devsel, latency 128
	I/O ports at a000 [size=128]
	Capabilities: [dc] Power Management version 1

0000:a0:04.1 Input device controller: Fortemedia, Inc Xwave QS3000A [FM801 game port] (rev b2)
	Subsystem: Fortemedia, Inc: Unknown device 1319
	Flags: bus master, medium devsel, latency 128
	I/O ports at a0c0 [size=16]
	Capabilities: [dc] Power Management version 1

0000:c0:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
	Subsystem: Hewlett-Packard Company: Unknown device 1330
	Flags: bus master, 66MHz, medium devsel, latency 192, IRQ 53
	I/O ports at c000 [size=256]
	Memory at 00000000e0022000 (64-bit, non-prefetchable) [size=1K]
	Memory at 00000000e0020000 (64-bit, non-prefetchable) [size=8K]
	Expansion ROM at 00000000e0000000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2



