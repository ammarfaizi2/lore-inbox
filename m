Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263994AbUDQTLH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 15:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbUDQTLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 15:11:06 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:47578 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263994AbUDQTK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 15:10:59 -0400
From: oschoett@t-online.de (Oliver Schoett)
To: linux-kernel@vger.kernel.org
CC: Dave Jones <davej@redhat.com>
Subject: 2.6.6-rc1: SiS 648 AGP probe of 0000:00:00.0 failed with error -22
References: <1M0f3-7vK-19@gated-at.bofh.it> <1M0f3-7vK-21@gated-at.bofh.it>
	<1M0f3-7vK-23@gated-at.bofh.it> <1M0f3-7vK-25@gated-at.bofh.it>
	<1M0f3-7vK-27@gated-at.bofh.it> <1r3UC-1xw-55@gated-at.bofh.it>
	<1M0f3-7vK-27@gated-at.bofh.it> <1M0f3-7vK-17@gated-at.bofh.it>
Date: 17 Apr 2004 21:08:53 +0200
In-Reply-To: <1M0f3-7vK-17@gated-at.bofh.it>
Message-ID: <s233c72h16i.fsf_-_@oschoett.dialin.t-online.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Seen: false
X-ID: E4xPNYZXQeIw85CyvK2xXeEniTIU0G4zG8usx03we97eVqH745mekN
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oschoett@t-online.de (Oliver Schoett) writes:

 > currently, 2.6.5 runs fine with AGP 3.0 on
 > my SiS 648 chipset

Unfortunately, 2.6.6-rc1 is broken on my hardware:

   Linux agpgart interface v0.100 (c) Dave Jones
   agpgart: Detected SiS 648 chipset
   agpgart: Maximum main memory to use for agp memory: 439M
   agpgart: unable to determine aperture size.
   agpgart: agp_backend_initialize() failed.
   agpgart-sis: probe of 0000:00:00.0 failed with error -22
   ...
   fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
   [fglrx] Maximum main memory to use for locked dma buffers: 433 MBytes.
   [fglrx] module loaded - fglrx 3.7.6 [Mar  5 2004] on minor 0
   [fglrx:firegl_unlock] *ERROR* Process 4612 using kernel context 0

In contrast, 2.6.5 worked fine:

   agpgart: Detected SiS 648 chipset
   agpgart: Maximum main memory to use for agp memory: 439M
   agpgart: AGP aperture is 128M @ 0xd0000000
   ...
   fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
   [fglrx] Maximum main memory to use for locked dma buffers: 432 MBytes.
   [fglrx] module loaded - fglrx 3.7.6 [Mar  5 2004] on minor 0
   [fglrx] AGP detected, AgpState   = 0x1f004e0b (hardware caps of chipset)
   agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
   agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
   agpgart: sis 648 agp fix - giving bridge time to recover
   agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode

Here is my hardware info:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS 645xx (rev 03)
        Subsystem: Silicon Integrated Systems [SiS] SiS 645xx
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=128M]
        Capabilities: [c0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8


01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 NF [Radeon 9700] (prog-if 00 [VGA])
        Subsystem: Hightech Information System Ltd.: Unknown device 8486
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at e8420000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon 9700] (Secondary)
        Subsystem: Hightech Information System Ltd.: Unknown device 8487
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at e0000000 (32-bit, prefetchable) [disabled] [size=128M]
        Region 1: Memory at e8430000 (32-bit, non-prefetchable) [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Regards,

Oliver Schoett

