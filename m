Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266179AbSLOBL2>; Sat, 14 Dec 2002 20:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266183AbSLOBL2>; Sat, 14 Dec 2002 20:11:28 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:43469 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S266179AbSLOBL1>;
	Sat, 14 Dec 2002 20:11:27 -0500
Date: Sun, 15 Dec 2002 02:19:20 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212150119.CAA02575@harpo.it.uu.se>
To: marcelo@connectiva.com.br
Subject: 2.4.21-pre1 broke the ide-tape driver
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.21-pre1 broke the ide-tape driver: the driver
now hangs during initialisation. 2.2 kernels (with Andre's
IDE patch) and 2.4 up to 2.4.20 do not have this problem.

My box has a Seagate STT8000A ATAPI tape drive as hdd;
hdc is a Philips CD-RW, and the controller is ICH2 (i850 chipset).

dmesg log from inserting ide-tape as a module:

ide-tape: Dumping ATAPI Identify Device tape parameters
ide-tape: Protocol Type: <6>ATAPI
ide-tape: Device Type: 1 - <6>Streaming Tape Device
ide-tape: Removable: Yes
ide-tape: Command Packet DRQ Type: <6>Accelerated DRQ
ide-tape: Command Packet Size: <6>12 bytes
ide-tape: Model: Seagate STT8000A
ide-tape: Firmware Revision: 5.51
ide-tape: Serial Number: 
ide-tape: Write buffer size: 372736 bytes
ide-tape: DMA: Yes
ide-tape: LBA: Yes
ide-tape: IORDY can be disabled: Yes
ide-tape: IORDY supported: Yes
ide-tape: ATAPI overlap supported: No
ide-tape: PIO Cycle Timing Category: 2
ide-tape: DMA Cycle Timing Category: 2
ide-tape: Single Word DMA supported modes: <6>0 <6>1 <6>2 <6>
ide-tape: Multi Word DMA supported modes: <6>0 <6>1 <6>2 <6>(active) <6>
ide-tape: Enhanced PIO Modes: Mode 3
ide-tape: Minimum Multi-word DMA cycle per word: <6>120 ns
ide-tape: Manufacturer's Recommended Multi-word cycle: <6>120 ns
ide-tape: Minimum PIO cycle without IORDY: <6>120 ns
ide-tape: Minimum PIO cycle with IORDY: <6>120 ns
ide-tape: hdd <-> ht0: Seagate STT8000A rev 5.51
--- long delay here, about a minute or so
hdd: irq timeout: status=0xd0 { Busy }
hdd: DMA disabled
hdd: ATAPI reset complete
--- long delay here, about a minute or so
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
--- long delay here, about a minute or so
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
--- at this point I'm tired of waiting and reboot the machine

/Mikael
