Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTHWEp0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 00:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTHWEp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 00:45:26 -0400
Received: from coffee.creativecontingencies.com ([210.8.121.66]:37329 "EHLO
	coffee.cc.com.au") by vger.kernel.org with ESMTP id S261366AbTHWEpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 00:45:21 -0400
Subject: 2.6.0-test4: ACPI breaks IDE/USB
From: Peter Lieverdink <linux@cafuego.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1061613751.897.12.camel@kahlua>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 23 Aug 2003 14:42:32 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I enable ACPI on 2.6.0-test4 (also on 2.6.0-test3-*), the kernel no
longer recognises my IDE controller and drops down to PIO mode for
harddisk access. Additionally, USB devices don't get detected.

Running a kernel without ACPI solves both these problems.

The system is an Athlon 2400+ on a Gibabyte GA-7VAXP mainboard. (KT400)

This is from dmesg with ACPI (CONFIG_ACPI=y) enabled:
--
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: (ide_setup_pci_device:) Could not enable device.
hda: WDC WD800JB-00ETA0, ATA DISK drive
--

.. and this is with ACPI (# CONFIG_ACPI is not set) disabled:
--
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD800JB-00ETA0, ATA DISK drive
--

I'm happily running without ACPI now, but I guess the kernel just
shouldn't be exhibiting the above behaviour. If whomever is fixing this
bug needs more and/or more detailed info, please email me and I'll
provide it.

Cheers,
- Peter.

