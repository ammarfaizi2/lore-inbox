Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263113AbVCKCVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbVCKCVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbVCKCVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:21:43 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:15513 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263113AbVCKCTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:19:03 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: AGP bogosities
Date: Thu, 10 Mar 2005 18:18:24 -0800
User-Agent: KMail/1.7.2
Cc: werner@sgi.com, torvalds@osdl.org, davej@redhat.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <200503101804.04371.jbarnes@engr.sgi.com> <16944.65119.216720.79612@cargo.ozlabs.ibm.com>
In-Reply-To: <16944.65119.216720.79612@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503101818.25033.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 10, 2005 6:11 pm, Paul Mackerras wrote:
> What is the relationship in the PCI device tree between the video
> cards and their bridges?  Is there for instance only one AGP bridge
> per host bridge?

I *think* a TIO (numalink<->agp & numalink<->pci) has two AGP busses coming
off of it...

> Interesting, could you post the output from lspci -v on that system?

flatearth:~ # lspci -v
0000:01:01.0 Co-processor: Silicon Graphics, Inc. IOC4 I/O controller (rev 4f)
        Flags: bus master, 66Mhz, medium devsel, latency 255, IRQ 60
        Memory at c00000080f200000 (32-bit, non-prefetchable)

0000:01:03.0 Class 0106: Vitesse Semiconductor VSC7174 PCI/PCI-X Serial ATA Host Bus Controller (rev 01)
        Subsystem: Vitesse Semiconductor VSC7174 PCI/PCI-X Serial ATA Host Bus Controller
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 61
        Memory at c00000080f300000 (64-bit, non-prefetchable)
        Capabilities: [e0] PCI-X non-bridge device.
        Capabilities: [e8] Power Management version 2
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/2 Enable-

0000:01:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
        Subsystem: Silicon Graphics, Inc. SGI IO9/IO10 Gigabit Ethernet (Copper)
        Flags: bus master, 66Mhz, medium devsel, latency 48, IRQ 62
        Memory at c00000080f310000 (64-bit, non-prefetchable)
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

0000:02:01.0 VGA compatible controller: ATI Technologies Inc Rage 128 RE/SG (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Xpert 128
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 63
        Memory at c0000008a4000000 (32-bit, prefetchable) [size=c00000080fe20000]
        I/O ports at c00000080fa00000 [size=256]
        Memory at c00000080fe00000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at 0000000000020000 [disabled]
        Capabilities: [5c] Power Management version 1

0000:02:02.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Orange Micro Root Hub
        Flags: bus master, medium devsel, latency 8, IRQ 64
        Memory at c00000080fe04000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2

0000:02:02.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Orange Micro Root Hub
        Flags: bus master, medium devsel, latency 8, IRQ 65
        Memory at c00000080fe05000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2

0000:02:02.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Orange Micro Root hub
        Flags: bus master, medium devsel, latency 68, IRQ 65
        Memory at c00000080fe06000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2

0000:17:00.0 VGA compatible controller: ATI Technologies Inc R350 NK [Fire GL X2] (rev 80) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0152
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 0, IRQ 67
        Memory at c0000041c8000000 (32-bit, prefetchable) [size=c0000041c0120000]
        I/O ports at c000004023001000 [size=256]
        Memory at c0000041c0100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at 0000000000020000 [disabled]
        Capabilities: [58] AGP version 3.0
        Capabilities: [50] Power Management version 2

0000:17:00.1 Display controller: ATI Technologies Inc: Unknown device 4e6b (rev80)
        Subsystem: ATI Technologies Inc: Unknown device 0153
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 0
        Memory at c0000041d0000000 (32-bit, prefetchable) [size=c0000041c0000000]
        Memory at c0000041c0110000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned>
        Capabilities: [50] Power Management version 2

0000:1b:00.0 VGA compatible controller: ATI Technologies Inc R350 NK [Fire GL X2] (rev 80) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0152
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 0, IRQ 66
        Memory at c00000c1c8000000 (32-bit, prefetchable) [size=c00000c1c0120000]
        I/O ports at c00000c023001000 [size=256]
        Memory at c00000c1c0100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at 0000000000020000 [disabled]
        Capabilities: [58] AGP version 3.0
        Capabilities: [50] Power Management version 2

0000:1b:00.1 Display controller: ATI Technologies Inc: Unknown device 4e6b (rev80)
        Subsystem: ATI Technologies Inc: Unknown device 0153
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 0
        Memory at c00000c1d0000000 (32-bit, prefetchable) [size=c00000c1c0000000]
        Memory at c00000c1c0110000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned>
        Capabilities: [50] Power Management version 2
