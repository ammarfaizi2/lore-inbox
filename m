Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbREJTrj>; Thu, 10 May 2001 15:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbREJTr3>; Thu, 10 May 2001 15:47:29 -0400
Received: from mercury.ukc.ac.uk ([129.12.21.10]:17641 "EHLO mercury.ukc.ac.uk")
	by vger.kernel.org with ESMTP id <S131244AbREJTrR>;
	Thu, 10 May 2001 15:47:17 -0400
Date: Thu, 10 May 2001 20:46:56 +0100 (BST)
From: Leonid Timochouk <L.A.Timochouk@ukc.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Problem with dmfe
Message-ID: <Pine.GSO.4.21.0105102040080.23395-100000@myrtle.ukc.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have installed Linux 2.4.4 on our remotely-administered dedicated Web
server (600MHz Celeron), and strange effects occurred with the Davicom DM9102
network card. It was active but apparently VERY slow, 85% packet loss in ping.
I could connect to the machine but could not do anything useful. The system had
to be rebooted into the previous configuration (2.2.12) which works fine.

I then examined the kernel logs for 2.4.4 and found the following:

PCI: Using IRQ router PIIX [8086/2420] at 00:1f.0
PCI: Found IRQ 3 for device 00:01.0

eth0: Davicom DM9102 at 0xc000, 00:d0:09:1e:61:51, IRQ 3

Thus, device 00:01.0 (video card) shares IRQ with the net card. Could it be
the source of the problem? Under 2.2.12, pciutils show the following info
for these devices:

00:01.0 VGA compatible controller: Intel Corporation 82810 CGC [Chipset Graphics
Controller] (rev 02) (prog-if 00 [VGA])
        Subsystem: Intel Corporation: Unknown device 7121
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Region 1: Memory at e6000000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:04.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit
(rev 10)
        Subsystem: Unknown device 0291:8212
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 20 min, 40 max, 128 set
        Interrupt: pin A routed to IRQ 3
        Region 0: I/O ports at c000
        Region 1: Memory at e5000000 (32-bit, non-prefetchable) [disabled]
        Expansion ROM at e4000000 [disabled]
        Capabilities: [50] Power Management version 1
                Flags: PMEClk- AuxPwr+ DSI+ D1- D2- PME-
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

Thus, it says IRQ for the VGA card is 0, not 3 (also strange).

Does anyone have an idea what is going on?

Sincerely,
===============================================================
Dr. Leonid A. Timochouk
Computing Laboratory, University of Kent at Canterbury, England
===============================================================

