Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317021AbSFKMn0>; Tue, 11 Jun 2002 08:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSFKMnZ>; Tue, 11 Jun 2002 08:43:25 -0400
Received: from host213-121-105-182.in-addr.btopenworld.com ([213.121.105.182]:57180
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S317021AbSFKMnT>; Tue, 11 Jun 2002 08:43:19 -0400
Subject: [PROBLEM] sundance on d-link dfe-580tx
From: Matthew Hall <matt@ecsc.co.uk>
To: Kernel <linux-kernel@vger.kernel.org>
Cc: becker@scyld.com, jgarzik@mandrakesoft.com
Content-Type: multipart/mixed; boundary="=-UkcPxT1kd0qs2Uo31os2"
Organization: ECSC Ltd.
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 11 Jun 2002 13:43:13 +0100
Message-Id: <1023799395.3064.49.camel@smelly.dark.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UkcPxT1kd0qs2Uo31os2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello lkml, jeff and donald,

I have been testing the D-Link DFE-580TX Quad channel server card (4
port nic), on kernel 2.4.18 with little success. 

Attached are the appropriate results of dmesg, ifconfig, lspci and
modules.conf; aswell as the results of the pci-testing tool found on
scyld.com, however the card does not support mii testing, claiming to
have no MII transceiver.

Specifically, the sundance module can be modprobe'd, and the interfaces
of the 4port nic (eth2->eth5) can be brought up with ifconfig, and to
all intents and purposes *should* be working, however the results of
`tail dmesg` and `tail messages` show a transmit timeout on all the
nic's interfaces and testing the interfaces with ping returns host
unreachable (only on this card, the onboard nic and single port pci card
both work properly).

I would appreciate being informed if there is a fix in a later
version,or if any more debugging information is required I would be
happy to oblige.

Matthew Hall

-- 
Matthew Hall -- matt@ecsc.co.uk -- http://people.ecsc.co.uk/~matt/
Sig: When I was a boy I was told that anybody could become President. Now I'm
beginning to believe it. - Clarence Darrow 

--=-UkcPxT1kd0qs2Uo31os2
Content-Disposition: attachment; filename=ifconfig
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ifconfig; charset=ISO-8859-1

eth0      Link encap:Ethernet  HWaddr 00:C0:9F:05:B5:75 =20
          inet addr:192.168.0.153  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:253 errors:0 dropped:0 overruns:0 frame:0
          TX packets:102 errors:0 dropped:0 overruns:4 carrier:0
          collisions:0 txqueuelen:100=20
          RX bytes:31707 (30.9 Kb)  TX bytes:15077 (14.7 Kb)
          Interrupt:20 Base address:0xd000=20

eth1      Link encap:Ethernet  HWaddr 00:02:B3:9E:62:D6 =20
          inet addr:192.168.0.152  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:20 errors:0 dropped:0 overruns:12 carrier:0
          collisions:0 txqueuelen:100=20
          RX bytes:632 (632.0 b)  TX bytes:1064 (1.0 Kb)
          Interrupt:30 Base address:0xf000=20

eth2      Link encap:Ethernet  HWaddr FE:AB:FE:AB:FE:AB =20
          inet addr:192.168.0.151  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:7434240 errors:0 dropped:28919 overruns:0 frame:0
          TX packets:7908923 errors:10 dropped:0 overruns:0 carrier:0
          collisions:58080 txqueuelen:100=20
          RX bytes:1886929406 (1799.5 Mb)  TX bytes:1886957115 (1799.5 Mb)
          Interrupt:28 Base address:0x5000=20

eth3      Link encap:Ethernet  HWaddr FE:AB:FE:AB:FE:AB =20
          inet addr:192.168.0.150  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:7188480 errors:0 dropped:27963 overruns:0 frame:0
          TX packets:7647471 errors:0 dropped:0 overruns:0 carrier:0
          collisions:56160 txqueuelen:100=20
          RX bytes:2960410694 (2823.2 Mb)  TX bytes:2960437487 (2823.2 Mb)
          Interrupt:29 Base address:0x7000=20

eth4      Link encap:Ethernet  HWaddr FE:AB:FE:AB:FE:AB =20
          inet addr:192.168.0.149  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:7188480 errors:0 dropped:27963 overruns:0 frame:0
          TX packets:7647471 errors:0 dropped:0 overruns:0 carrier:0
          collisions:56160 txqueuelen:100=20
          RX bytes:2960410694 (2823.2 Mb)  TX bytes:2960437487 (2823.2 Mb)
          Interrupt:28 Base address:0x9000=20

eth5      Link encap:Ethernet  HWaddr FE:AB:FE:AB:FE:AB =20
          inet addr:192.168.0.148  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:7188480 errors:0 dropped:27963 overruns:0 frame:0
          TX packets:7647471 errors:0 dropped:0 overruns:0 carrier:0
          collisions:56160 txqueuelen:100=20
          RX bytes:2960410694 (2823.2 Mb)  TX bytes:2960437487 (2823.2 Mb)
          Interrupt:29 Base address:0xb000=20

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:410 errors:0 dropped:0 overruns:0 frame:0
          TX packets:410 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:49480 (48.3 Kb)  TX bytes:49480 (48.3 Kb)


--=-UkcPxT1kd0qs2Uo31os2
Content-Disposition: attachment; filename=lspci
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=lspci; charset=ISO-8859-1

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 48, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 48, cache line size 08

00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (re=
v 08)
	Subsystem: Dell Computer Corporation: Unknown device 010b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at fe123000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at dcc0 [size=3D64]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=3D1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

00:09.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (p=
rog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fd000000-fdffffff
	Prefetchable memory behind bridge: 00000000fa000000-00000000faf00000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D220mA PME(D0-,D1-,D2-,D3hot-,D3c=
old-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
		Bridge: PM- B3+

00:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (re=
v 0d)
	Subsystem: Intel Corporation: Unknown device 1050
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 30
	Region 0: Memory at fe122000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at dc80 [size=3D64]
	Region 2: Memory at fe100000 (32-bit, non-prefetchable) [size=3D128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

00:0b.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (p=
rog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 010b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: I/O ports at d800 [size=3D256]
	Region 2: Memory at fe121000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 92)
	Subsystem: ServerWorks CSB5 South Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92) (prog-if 8a=
 [Master SecP PriP])
	Subsystem: Dell Computer Corporation: Unknown device c10b
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Region 0: I/O ports at 01f0 [size=3D8]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=3D8]
	Region 3: I/O ports at 0374
	Region 4: I/O ports at 08b0 [size=3D16]
	Region 5: I/O ports at 08c0 [size=3D4]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05) =
(prog-if 10 [OHCI])
	Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at fe120000 (32-bit, non-prefetchable) [size=3D4K]

00:0f.3 Host bridge: ServerWorks: Unknown device 0230
	Subsystem: ServerWorks: Unknown device 0230
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0

01:04.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 28
	Region 0: I/O ports at ec80 [size=3D128]
	Expansion ROM at fd000000 [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

01:05.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 29
	Region 0: I/O ports at ec00 [size=3D128]
	Expansion ROM at fd000000 [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

01:06.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 28
	Region 0: I/O ports at e880 [size=3D128]
	Expansion ROM at fd000000 [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

01:07.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 29
	Region 0: I/O ports at e800 [size=3D128]
	Expansion ROM at fd000000 [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-


--=-UkcPxT1kd0qs2Uo31os2
Content-Disposition: attachment; filename=modules.conf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=modules.conf; charset=ISO-8859-1

alias parport_lowlevel parport_pc
alias eth0 eepro100
alias eth1 eepro100
alias eth2 sundance
alias eth3 sundance
alias eth4 sundance
alias eth5 sundance

--=-UkcPxT1kd0qs2Uo31os2
Content-Disposition: attachment; filename=pci-config
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=pci-config; charset=ISO-8859-1

pci-config.c:v2.02 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Device #1 at bus 0 device/function 0/0, 00091166.
Device #2 at bus 0 device/function 0/1, 00091166.
Device #3 at bus 0 device/function 2/0, 12298086.
Device #4 at bus 0 device/function 9/0, 00241011.
Device #5 at bus 0 device/function 10/0, 12298086.
Device #6 at bus 0 device/function 11/0, 47521002.
Device #7 at bus 0 device/function 15/0, 02011166.
Device #8 at bus 0 device/function 15/1, 02121166.
Device #9 at bus 0 device/function 15/2, 02201166.
Device #10 at bus 0 device/function 15/3, 02301166.

--=-UkcPxT1kd0qs2Uo31os2
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dmesg; charset=ISO-8859-1

eth2: D-Link DFE-580TX 4 port Server Adapter at 0xc8cbb000, fe:ab:fe:ab:fe:=
ab, IRQ 29.
eth2: No MII transceiver found!, ASIC status 7fabfe
Override speed=3D100, Full duplex

NETDEV WATCHDOG: eth2: transmit timed out
eth2: Transmit timed out, status 00, resetting...
  Rx ring c53bd000:  00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000=
00000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
  Tx ring c5384000:  80008001 80008005 80008009 8000800d 80008011 80008015 =
80008019 8000801d 80008021 0000 0000 0000 0000 0000 0000 0000

--=-UkcPxT1kd0qs2Uo31os2--

