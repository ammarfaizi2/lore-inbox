Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVKRHEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVKRHEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 02:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVKRHEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 02:04:52 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:23264 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932479AbVKRHEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 02:04:51 -0500
Date: Fri, 18 Nov 2005 08:04:40 +0100
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Cc: rajesh.shah@intel.com, kjarvel@home.se, howarth@bromo.msbb.uc.edu
Subject: Re: PCI error on x86_64 2.6.13 kernel
Message-Id: <20051118080440.4aaf4a6d.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-11-18 0:24:51 Rajesh Shah wrote:
>On Wed, Oct 26, 2005 at 11:06:05PM +0200, Niklas Kallman wrote:
>>Jack Howarth wrote:
>>> Has anyone reported the following? For both of the 2.6.13 based
>>> kernels released so far on Fedora Core 4 for x86_64, we are seeing
>>> error messages of the form...
>>> 
>>> Oct  3 11:21:48 XXXXX  kernel:   MEM window: d0200000-d02fffff
>>> Oct  3 11:21:48 XXXXX  kernel:   PREFETCH window: disabled.
>>> Oct  3 11:21:48 XXXXX  kernel: PCI: Failed to allocate mem resource #6:20000 \
>>> f0000000 for 0000:09:00.0 
>
>I ran into a similar problem, and posted a fix, see
>http://marc.theaimsgroup.com/?l=linux-pci&m=113225006603745&w=2
>
>Can you try it to see if this problem goes away?

Even though your patch touched arch/i386/pci/i386.c I tried it in my pure AMD64
environment. No luck... I remember when this PCI error turned up, but since it
was non-fatal I shrugged it off. Early 2.6.13 it was. Booting back on my
non-distro, plain kernel.org notebook I indeed see that 2.6.11.11 and 2.6.12
are fine.

Here the effected device is the builtin nvidia GPU (GeForce FX Go5700 64MB):

[...]
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23) *10, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 16 17 18 19 20 21 22 23) *10, disabled.
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *11, disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *11, disabled.
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 12 14 15) *10
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: Embedded Controller [EC] (gpe 11)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:05: ioport range 0x600-0x60f has been reserved
pnp: 00:05: ioport range 0x1c0-0x1cf has been reserved
pnp: 00:05: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:05: ioport range 0xfe10-0xfe11 could not be reserved
PCI: Failed to allocate mem resource #6:20000@f0000000 for 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: c1000000-c1ffffff
  PREFETCH window: e0000000-efffffff
PCI: Bus 2, cardbus bridge: 0000:00:0b.0
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 88000000-89ffffff
  MEM window: 8a000000-8bffffff
PCI: Bus 6, cardbus bridge: 0000:00:0b.1
  IO window: 00002800-000028ff
  IO window: 00002c00-00002cff
  PREFETCH window: 8c000000-8dffffff
  MEM window: 8e000000-8fffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
[... asf...]

Mvh
Mats Johannesson
--
