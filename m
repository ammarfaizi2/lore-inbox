Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHKiI>; Thu, 8 Feb 2001 05:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbRBHKh7>; Thu, 8 Feb 2001 05:37:59 -0500
Received: from omecihuatl.rz.Uni-Osnabrueck.DE ([131.173.17.35]:44562 "EHLO
	omecihuatl.rz.uni-osnabrueck.de") by vger.kernel.org with ESMTP
	id <S129032AbRBHKhq>; Thu, 8 Feb 2001 05:37:46 -0500
Date: Thu, 8 Feb 2001 11:34:46 +0100 (MET)
From: ARND BERGMANN <std7652@et.FH-Osnabrueck.DE>
To: linux-kernel@vger.kernel.org
Subject: epic100 in current -ac kernels
Message-ID: <Pine.GSO.4.21.0102081111160.10104-100000@gamma10>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be some movement in the driver and the latest one
is not working for me (again), so I'm giving a subjective status report
for the versions I have tried lately:

Working epic100 drivers:
 - 2.4.0
 - 2.4.0-ac9

Broken epic100 drivers:
 - 2.4.0-ac4
 - 2.4.1-ac2
 - 2.4.1-ac4

I have not yet looked at the source to find the problem, but the other
kernels between that each seem to contain one of the those versions above.
The symptom is always that after 'ifconfig eth0 up', the system slows down
to the point where I can hardly type on the keyboard and even 'ifconfig
eth0 down' takes serveral seconds (on an Athlon-800)!

The boot message is:
eth0: SMSC EPIC/100 83c170 at 0xd091e000, IRQ 11, 00:e0:29:6c:36:6f.
eth0: MII transceiver #3 control 3000 status 7849.
eth0: Autonegotiation advertising 01e1 link partner 0001.
epic100.c:v1.11 1/7/2001 Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/epic100.html
 (unofficial 2.4.x kernel port, version 1.1.6, January 11, 2001)
PCI: Found IRQ 11 for device 00:0d.0
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:09.0                                                      

The device on 00:04:[23] is a VT82C586B USB and on 00:09:0 an
Ensoniq 5880 AudioPCI (rev 02). I can not change the IRQ settings
right now without physical access to the machine (it is locked).

At least with some broken versions, I also got these messages in
syslog (every 4 seconds):
Feb  7 21:10:06 project kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb  7 21:10:06 project kernel: eth0: Transmit timeout using MII device,
Tx status 000b.
Feb  7 21:10:10 project kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb  7 21:10:10 project kernel: eth0: Transmit timeout using MII device,
Tx status 000b.
Feb  7 21:10:14 project kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb  7 21:10:14 project kernel: eth0: Transmit timeout using MII device,
Tx status 000b.          
...

The card is acoording to lspci:

00:0d.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF
(rev 08)
        Subsystem: Standard Microsystems Corp [SMC]: Unknown device a020
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 7000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 9800 [size=256]
        Region 1: Memory at df800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Arnd <><

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
