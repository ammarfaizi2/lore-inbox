Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315718AbSFDAnK>; Mon, 3 Jun 2002 20:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSFDAnJ>; Mon, 3 Jun 2002 20:43:09 -0400
Received: from mail313.mail.bellsouth.net ([205.152.58.173]:55508 "EHLO
	imf13bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S315718AbSFDAnH>; Mon, 3 Jun 2002 20:43:07 -0400
Message-ID: <3CFC0D15.9F03AD36@bellsouth.net>
Date: Mon, 03 Jun 2002 20:43:01 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: ethernet tulip misdetected starting 2.5.20
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.19 works while 2.5.20 has mostly correct lspci output (PME- instead of PME+)
but the wrong driver gets detected and fails loading.
Similar to 3c509 vs 3c590 from Anton.
Anyone have any ideas in troubleshooting this?
Config:
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_DE4X5 is not set

              linux-2.5.19
dmesg
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 11 for device 00:0b.0
eth0: ADMtek Comet rev 17 at 0xe800, 00:03:6D:16:4E:39, IRQ 11.


lspci -vv
00:0b.0 Ethernet controller: Bridgecom, Inc: Unknown device 0985 (rev 11)
        Subsystem: Bridgecom, Inc: Unknown device 0574
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 min, 255 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at e3001000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

------------------
             linux-2.5.20
dmesg
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 11 for device 00:0b.0
tulip0:  MII transceiver #1 config 1000 status 786d advertising 01e1.
eth0: Digital DS21140 Tulip rev 17 at 0xe800, EEPROM not present, 00:4C:69:6E:75:79, IRQ 11.

lspci -vv
00:0b.0 Ethernet controller: Bridgecom, Inc: Unknown device 0985 (rev 11)
        Subsystem: Bridgecom, Inc: Unknown device 0574
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 min, 255 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at e3001000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
