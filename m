Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSJOHbg>; Tue, 15 Oct 2002 03:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263281AbSJOHbg>; Tue, 15 Oct 2002 03:31:36 -0400
Received: from [212.3.242.3] ([212.3.242.3]:57588 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S263280AbSJOHbf>;
	Tue, 15 Oct 2002 03:31:35 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.40] Network problem after suspend
Date: Tue, 15 Oct 2002 11:34:37 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210151134.38226.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I've got a little problem here with my network card (cardbus) - using the 
Vortex driver after I've entered suspend on my laptop (dell latitude) and 
revive the machine from it.

After reviving the machine, the dulplex mode and mbits are wrongly 
autodetected. I'm connected to a 100mbit/FD network, and the card goes back 
to the default state of 10mbit/HD.  Disconnecting/reconnecting the cable does 
not help. 

If I remove the module from the kernel, and re-load it, the system hangs 
solid.

After reviving the pc also 'stalls' now and again, approximatively every 15-20 
seconds, for 1-2 seconds.

In my kernel logs i get these messages:

-------------------------
Oct 15 11:16:05 laptop kernel: eth0: command 0x5800 did not complete! 
Status=0xffff
Oct 15 11:16:05 laptop kernel: eth0: command 0x2804 did not complete! 
Status=0xffff
Oct 15 11:16:21 laptop kernel: eth0: command 0x3002 did not complete! 
Status=0xffff
Oct 15 11:16:44 laptop last message repeated 12 times
Oct 15 11:16:46 laptop kernel: Debug: sleeping function called from illegal 
context at slab.c:1374
Oct 15 11:16:46 laptop kernel: eth0: command 0x3002 did not complete! 
Status=0xffff
Oct 15 11:16:48 laptop last message repeated 2 times
Oct 15 11:16:58 laptop kernel: eth0: transmit timed out, tx_status ff status 
ffff.
Oct 15 11:16:58 laptop kernel:   diagnostics: net ffff media ffff dma ffffffff 
fifo ffff
Oct 15 11:16:58 laptop kernel: eth0: Transmitter encountered 16 collisions -- 
network cable problem?
Oct 15 11:16:58 laptop kernel: eth0: Interrupt posted but not delivered -- IRQ 
blocked by another device?
Oct 15 11:16:58 laptop kernel:   Flags; bus-master 1, dirty 0(0) current 16(0)
Oct 15 11:16:58 laptop kernel:   Transmit list ffffffff vs. c03b6200.
Oct 15 11:16:58 laptop kernel: eth0: command 0x3002 did not complete! 
Status=0xffff
Oct 15 11:16:58 laptop kernel:   0: @c03b6200  length 800000ff status 000000ff
Oct 15 11:16:58 laptop kernel:   1: @c03b62a0  length 800000f9 status 000000f9
Oct 15 11:16:58 laptop kernel:   2: @c03b6340  length 800000ff status 000000ff
Oct 15 11:16:58 laptop kernel:   3: @c03b63e0  length 8000005c status 0000005c
Oct 15 11:16:58 laptop kernel:   4: @c03b6480  length 8000005c status 0000005c
Oct 15 11:16:58 laptop kernel:   5: @c03b6520  length 8000005c status 0000005c
Oct 15 11:16:58 laptop kernel:   6: @c03b65c0  length 8000005c status 0000005c
Oct 15 11:16:59 laptop kernel:   7: @c03b6660  length 800000e7 status 000000e7
Oct 15 11:16:59 laptop kernel:   8: @c03b6700  length 800000e7 status 000000e7
Oct 15 11:16:59 laptop kernel:   9: @c03b67a0  length 800000e7 status 000000e7
Oct 15 11:17:00 laptop kernel:   10: @c03b6840  length 800000e7 status 
000000e7
Oct 15 11:17:00 laptop kernel:   11: @c03b68e0  length 800000e7 status 
000000e7
Oct 15 11:17:00 laptop kernel:   12: @c03b6980  length 8000006e status 
0000006e
Oct 15 11:17:00 laptop kernel:   13: @c03b6a20  length 8000006e status 
0000006e
Oct 15 11:17:00 laptop kernel:   14: @c03b6ac0  length 8000006e status 
8000006e
Oct 15 11:17:00 laptop kernel:   15: @c03b6b60  length 8000006e status 
8000006e
Oct 15 11:17:00 laptop kernel: eth0: command 0x5800 did not complete! 
Status=0xffff
Oct 15 11:17:13 laptop kernel: eth0: transmit timed out, tx_status ff status 
ffff.
Oct 15 11:17:13 laptop kernel:   diagnostics: net ffff media ffff dma ffffffff 
fifo ffff
Oct 15 11:17:13 laptop kernel: eth0: Transmitter encountered 16 collisions -- 
network cable problem?
Oct 15 11:17:13 laptop kernel: eth0: Interrupt posted but not delivered -- IRQ 
blocked by another device?
-------------------------

over and over again (with different numbers), until i reboot the machine. 
Networkconnection never gets established.

Card:

06:00.0 Ethernet controller: 3Com Corporation 3c575 [Megahertz] 10/100 LAN 
CardBus (rev 01)
        Subsystem: 3Com Corporation 3C575 Megahertz 10/100 LAN Cardbus PC Card
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 4800 [size=128]
        Region 1: Memory at 11000000 (32-bit, non-prefetchable) [size=128]
        Region 2: Memory at 11000080 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at 10c00000 [size=128K]
        Capabilities: [50] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

DK

-- 
PL/1, "the fatal disease", belongs more to the problem set than to the
solution set.
		-- E. W. Dijkstra

