Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276439AbRJKONg>; Thu, 11 Oct 2001 10:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276370AbRJKON1>; Thu, 11 Oct 2001 10:13:27 -0400
Received: from ns.tasking.nl ([195.193.207.2]:26120 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S276397AbRJKONO>;
	Thu, 11 Oct 2001 10:13:14 -0400
Date: Thu, 11 Oct 2001 16:12:49 +0200
From: Frank van Maarseveen <fvm@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: 8139too: NETDEV WATCHDOG: eth0: transmit timed out
Message-ID: <20011011161249.A6856@espoo.tasking.nl>
Reply-To: frank.van.maarseveen@altium.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Subliminal-Message: Use Linux!
Organization: ALTIUM Software BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seen in 2.4.1[012] and possibly in some older kernels:

Oct 11 15:38:49 imatra kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Oct 11 15:38:49 imatra kernel: eth0: Setting half-duplex based on auto-negotiated partner ability 0000. 
Oct 11 15:39:13 imatra kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Oct 11 15:39:13 imatra kernel: eth0: Setting half-duplex based on auto-negotiated partner ability 0000. 
Oct 11 15:39:14 imatra kernel: nfs: server arezzo not responding, still trying 
Oct 11 15:39:14 imatra kernel: nfs: server arezzo OK 

This occurs with regular interval (especially when the network
load increases) and has been observed on two machines, i.e. bad
cables/hardware is unlikely.

The NFS problem is secondary and caused by eth0 troubles I guess.

lspci -vvvv :

02:08.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev 10)
        Subsystem: Unknown device 1113:1211
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 min, 64 max, 66 set
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 1000
        Region 1: Memory at 40000000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

rtl8139-diag -a 
rtl8139-diag.c:v2.04 8/08/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a SMC1211TX EZCard 10/100 (RealTek RTL8139) adapter at 0x1000.
The RealTek chip appears to be active, so some registers will not be read.
To see all register values use the '-f' flag.
RealTek chip registers at 0x1000
 0x000: f5b51000 00008df1 80000000 00000000 9008a044 9008a083 9008a03c 9008a043
 0x020: 078d4000 078d4600 078d4c00 078d5200 07840000 0d0a0000 1f441f34 0000c07f
 0x040: 74000600 0e00f78e 106c4c1e 00000000 000d1500 00000000 008cc118 00100000
 0x060: 1000b00f 01e1782d 00000000 00000000 00000005 000f77c0 b0f243b9 8a36df43.
  No interrupt sources are pending.
 The chip configuration is 0x15 0x0d, MII half-duplex mode.

rtl8139-diag -mm:
rtl8139-diag.c:v2.04 8/08/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a SMC1211TX EZCard 10/100 (RealTek RTL8139) adapter at 0x1000.
 The RTL8139 does not use a MII transceiver.
 It does have internal MII-compatible registers:
   Basic mode control register   0x782d.
   Basic mode status register    0x1000.
   Autonegotiation Advertisement 0x01e1.
   Link Partner Ability register 0x0000.
   Autonegotiation expansion     0x0000.
   Disconnects                   0x0000.
   False carrier sense counter   0x0000.
   NWay test register            0x0005.
   Receive frame error count     0x0000.
 MII PHY #-1 transceiver registers:
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 0000 0000 0000 0000 0000 0000.
 Basic mode control register 0x0000: Auto-negotiation disabled!
   Speed fixed at 10 mbps, half-duplex.
 Basic mode status register 0x0000 ... 0000.
   Link status: not established.
   Capable of <Warning! No media capabilities>.
   Unable to perform Auto-negotiation, negotiation not complete.
 This transceiver has no vendor identification.
 I'm advertising 0000:
   Advertising no additional info pages.
   Using an unknown (non 802.3) encapsulation.
 Link partner capability is 0000:.
   Negotiation did not complete.


-- 
Frank
