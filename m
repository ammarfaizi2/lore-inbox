Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbTLaGin (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 01:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266142AbTLaGim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 01:38:42 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19760 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S266141AbTLaGiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 01:38:07 -0500
Date: Tue, 30 Dec 2003 23:30:19 -0700 (MST)
From: Cameron Heide <cheide@shaw.ca>
Subject: 2.6.0 hangs during the rebuild of a RAID-5 set
X-X-Sender: heide@derzon.planetcrushers.com
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.58.0312302320480.1187@derzon.planetcrushers.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!  I've encountered a problem which I'm not sure how to go about
debugging, as my efforts so far aren't yielding anything.

Background: This is a P2-400 system with three ATA drives in a
RAID-5 set via the software RAID driver.  Everything works just
fine during normal usage, but if a rebuild of the RAID-5 set starts,
the system soon hangs within a few minutes.  It's not entirely
frozen though, as keyboard input is still echoed to the console and
I can switch VTs, but there's no other response even after waiting
15 minutes.  Disk activity of some sort still seems to occur as the
HD light continues to flicker slightly.  There are no oopses or any
other kernel messages on the console.

I don't know for sure if it's the rebuild itself at fault, as it may
just be things like the I/O load during a rebuild versus normal usage
that actually cause it, but this is the only thing that reliably
triggers it so far.  It's easy to reproduce, at least.

I've tried enabling the Magic SysRq key in order to find out where it's
hung, but hitting Alt-SysRq-p only printed "SysRq : Show Regs" and
nothing else.  Alt-SysRq-b still worked to force a reboot though.

There's also the possibility of bad hardware, but if I boot back to
2.4.22 the rebuild completes without trouble so that seems unlikely,
unless the hardware problem is only tickled by something new in 2.6.0.

I'm not sure what else to do from here; are there any other tools
or tricks I can use to gather more information?  A binary search
through 2.5.x versions?  I admit this isn't exactly a lot to go on.

Thanks!

Additional information: (more detail available upon request, of course)

Kernel: Plain 2.6.0, with preempt enabled
Drives: 2 x WD Caviar 1200BB-22CAA0, 1 x WD Caviar 1200BB-16CAA2
        DMA is enabled on all drives
Motherboard: ASUS P2B-F
Memory: 384M of 133MHz SDRAM
GCC: 3.2.3, and binutils: 2.14.90.0.6

Devices, from lspci:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03)
00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21041
[Tulip Pass 3] (rev 21)
00:0b.0 Ethernet controller: 3Com Corporation 3c450 Cyclone/unknown (rev
30)
01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA TNT2/TNT2
Pro] (rev 15)

Potentially relevant .config entries:

CONFIG_BLK_DEV_IDEDISK=y        (all enabled IDE section entries)
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
