Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292588AbSCMH3E>; Wed, 13 Mar 2002 02:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292589AbSCMH2z>; Wed, 13 Mar 2002 02:28:55 -0500
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:5760
	"HELO tabriel.tabris.net") by vger.kernel.org with SMTP
	id <S292588AbSCMH2n>; Wed, 13 Mar 2002 02:28:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Schrotenboer <adam@tabris.net>
Organization: Dome-S-Isle Data
To: linux-kernel@vger.kernel.org
Subject: Tulip Bug ?
Date: Wed, 13 Mar 2002 02:28:21 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020313072836.85817FB911@tabriel.tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently running 2.4.18-pre9-mjc2, but this also happens w/ 
2.4.18-pre9 (and 2.4.18-pre7-mjc, maybe others)

I am getting NETDEV Watchdog timeouts

Mar 13 02:12:54 tabriel kernel: NETDEV WATCHDOG: eth1: transmit timed out
Mar 13 02:12:54 tabriel kernel: eth1: 21140 transmit timed out, status 
fc665410, SIA fffffeff ffffffff 1c09fdc0 fffffec8, resetting...
Mar 13 02:12:54 tabriel kernel: eth1: transmit timed out, switching to 
100baseTx-FDX media.
Mar 13 02:13:02 tabriel kernel: NETDEV WATCHDOG: eth1: transmit timed out
Mar 13 02:13:02 tabriel kernel: eth1: 21140 transmit timed out, status 
fc665410, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Mar 13 02:13:02 tabriel kernel: eth1: transmit timed out, switching to 
10baseT media.
Mar 13 02:13:34 tabriel kernel: NETDEV WATCHDOG: eth1: transmit timed out
Mar 13 02:13:34 tabriel kernel: eth1: 21140 transmit timed out, status 
fc665410, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Mar 13 02:13:34 tabriel kernel: eth1: transmit timed out, switching to 
100baseTx-FDX media.


I have been getting this at largely unpredictable intervals. The 
solutions seems to be to ifdown the ethdevs, and rmmod the driver. then 
ifup the ethdevs (which also means I have to stop my PPPoE-DSL 
connection).

eth1, the dev that is timing out is not sharing its interrupt.
These boards are/were marketed under the brand name SVEC. I cannot find 
the box they came in at the moment, so don't have the model number.

Just for reference, here's the relevant lines from lspci -vv

00:09.0 Ethernet controller: Macronix, Inc. [MXIC] MX98713
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at e400 [size=256]
	Region 1: Memory at e0100000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at de000000 [disabled] [size=64K]

00:0c.0 Ethernet controller: Macronix, Inc. [MXIC] MX98713
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B+
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ec00 [size=256]
	Region 1: Memory at e0102000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at df000000 [disabled] [size=64K]


TIA
--
tabris.net
