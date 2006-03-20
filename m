Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWCTUqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWCTUqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 15:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWCTUqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 15:46:21 -0500
Received: from mail-a02.ithnet.com ([217.64.83.97]:25792 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S1030244AbWCTUqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 15:46:20 -0500
X-Sender-Authentication: net64
Date: Mon, 20 Mar 2006 21:46:09 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel@vger.kernel.org
Subject: Problem with 2.6.16, HP Netserver e800, 3c59x driver
Message-Id: <20060320214609.12a77953.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I ran into a problem trying to upgrade some old boxes (namely HP Netserver
e800) from 2.4 to 2.6. I have tried some 2.6.15.X up to 2.6.16, there is no
difference.
The simple problem is: network does not work.
The box in terms of hw looks like this:

# lspci -vv
00:00.0 Host bridge: Broadcom CNB20LE Host Bridge (rev 05)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 48, Cache Line Size 08

00:00.1 Host bridge: Broadcom CNB20LE Host Bridge (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08

00:02.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100]
(rev 08)
        Subsystem: Hewlett-Packard Company NetServer 10/100TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at fd100000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 1880 [size=64]
        Region 2: Memory at fd000000 (32-bit, non-prefetchable) [size=1M]
        [virtual] Expansion ROM at 20000000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:03.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1
ISDN [Fritz] (rev 02)
        Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH FRITZ!Card
ISDN Controller
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd101000 (32-bit, non-prefetchable) [size=32]
        Region 1: I/O ports at 18c0 [size=32]

00:06.0 Ethernet controller: 3Com Corporation 3c905B Deluxe Etherlink
10/100/BNC [Cyclone]
        Subsystem: 3Com Corporation 3c905B Deluxe Etherlink 10/100/BNC
[Cyclone]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 1800 [size=128]
        Region 1: Memory at fd101400 (32-bit, non-prefetchable) [size=128]
        [virtual] Expansion ROM at 20100000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 65)
(prog-if 00 [VGA])
        Subsystem: Hewlett-Packard Company: Unknown device 10e1
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), Cache Line Size 08
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 1400 [size=256]
        Region 2: Memory at fd102000 (32-bit, non-prefetchable) [size=4K]
        [virtual] Expansion ROM at 20120000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: Broadcom OSB4 South Bridge (rev 4f)
        Subsystem: Broadcom OSB4 South Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:0f.1 IDE interface: Broadcom OSB4 IDE Controller (prog-if 8a [Master SecP
PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at 18e0 [size=16]

00:0f.2 USB Controller: Broadcom OSB4/CSB5 OHCI USB Controller (rev 04)
(prog-if 10 [OHCI])
        Subsystem: Broadcom OSB4/CSB5 OHCI USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at fd103000 (32-bit, non-prefetchable) [size=4K]

05:03.0 Ethernet controller: 3Com Corporation 3c905B Deluxe Etherlink
10/100/BNC [Cyclone]
        Subsystem: 3Com Corporation 3c905B Deluxe Etherlink 10/100/BNC
[Cyclone]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 2400 [size=128]
        Region 1: Memory at fd110000 (32-bit, non-prefetchable) [size=128]
        [virtual] Expansion ROM at 20140000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53C896/897 (rev 07)
        Subsystem: Hewlett-Packard Company: Unknown device 60e0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 16000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: Memory at fd110400 (64-bit, non-prefetchable) [size=1K]
        Region 3: Memory at fd112000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:05.1 SCSI storage controller: LSI Logic / Symbios Logic 53C896/897 (rev 07)
        Subsystem: Hewlett-Packard Company: Unknown device 60e0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 16000ns max), Cache Line Size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 2000 [size=256]
        Region 1: Memory at fd110800 (64-bit, non-prefetchable) [size=1K]
        Region 3: Memory at fd114000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


The cards (two 3com 3c905B) look correctly configured with ethtool:

Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full 
                                100baseT/Half 100baseT/Full 
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full 
                                100baseT/Half 100baseT/Full 
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 24
        Transceiver: internal
        Auto-negotiation: on
        Current message level: 0x00000001 (1)
        Link detected: yes

Settings for eth1:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full 
                                100baseT/Half 100baseT/Full 
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full 
                                100baseT/Half 100baseT/Full 
        Advertised auto-negotiation: Yes
        Speed: 10Mb/s
        Duplex: Half
        Port: MII
        PHYAD: 24
        Transceiver: internal
        Auto-negotiation: on
        Current message level: 0x00000001 (1)
        Link detected: yes

Yes, eth1 should really be a 10M/hd link.

And interrupts:
# cat /proc/interrupts 
           CPU0       
  0:     490304          XT-PIC  timer
  1:       1883          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  ohci_hcd:usb1, eth1
  8:          2          XT-PIC  rtc
  9:        505          XT-PIC  acpi, eth2
 10:      36044          XT-PIC  sym53c8xx, eth0
 11:         33          XT-PIC  sym53c8xx, HiSax
 12:        104          XT-PIC  i8042
NMI:          0 
ERR:          0

Modules:
Module                  Size  Used by
eepro100               24208  0 
3c59x                  35752  0 
nls_cp437               5760  2 
nls_utf8                2048  2 
smbfs                  50680  3 
speedstep_lib           3844  0 
freq_table              3588  0 
usbserial              24524  0 
nfsd                   74728  9 
exportfs                4224  1 nfsd
lockd                  49128  2 nfsd
sunrpc                114340  8 nfsd,lockd
thermal                10888  0 
processor              17600  1 thermal
fan                     3588  0 
button                  5136  0 
battery                 7812  0 
ac                      3716  0 
af_packet              14472  4 
ppp_generic            20884  2 
edd                     8032  0 
hisax                 122840  2 
ohci_hcd               15492  0 
usbcore                93984  3 usbserial,ohci_hcd
generic                 4100  0 [permanent]
ide_core               95748  1 generic
i2c_piix4               7312  0 
i2c_core               15120  1 i2c_piix4
mii                     4480  2 eepro100,3c59x
isdn                  111840  5 hisax
slhc                    5632  2 ppp_generic,isdn
parport_pc             31472  1 
lp                      8256  0 
parport                27208  2 parport_pc,lp
loop                   11272  2 



Kernel, as said, is a stock 2.6.16 but 2.6.15.4 or the like is just the same.

Now for the weirdos:
- Neither eth0 nor eth1 works
- Both work flawlessly with kernel 2.4.30 (same box!)
- But: the same harddisk plugged into another box of about the same age (namely
Dell) with two 3c905B _works_.
- acpi=off does not help
- noapic does not help
- pci=routeirq does not help
- everything else in the box including the onboard intel network does work
without the slightest problems.
- it's all the same with about a dozen of those netservers.

I _guess_ it has something to do with the interrupts but I can't nail it down.
In rare cases eth0 looks like working, but then ping shows strange latencies
(around 7 ms) for LAN and compared to onboard intel with 0,276 ms.

If you need further info, feel free to ask, I ran out of ideas right now ...

-- 
Regards,
Stephan

