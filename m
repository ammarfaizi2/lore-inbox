Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131021AbRBHPe7>; Thu, 8 Feb 2001 10:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRBHPet>; Thu, 8 Feb 2001 10:34:49 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:43789 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129031AbRBHPeJ> convert rfc822-to-8bit;
	Thu, 8 Feb 2001 10:34:09 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Thu, 8 Feb 2001 16:32:52 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-2
Content-transfer-encoding: 8BIT
Subject: 2.4.x, drm, g400 and pci_set_master
CC: faith@valinux.com, hulinsky@feld.cvut.cz
X-mailer: Pegasus Mail v3.40
Message-ID: <14E7BDF32379@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  friend of mine bought g400 on my recommendation, and unfortunately,
mga drm driver did not worked for me. I tracked it down to missing
pci_enable_device and pci_set_master in mga* driver. But even after
looking more than hour into that code I have no idea where I should
place this call, as it looks like that mga driver is completely
shielded from seeing pcidev structure :-(
  Does anybody know where I should place pci_enable_device and 
pci_set_master into mga code? I worked around pci_enable_device by 
using matroxfb, but pci_set_master is not invoked by matroxfb, and 
adding this call into matroxfb just to get mga drm driver to work does 
not look correctly to me - although it is what I had done just now.
                                    Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
    Subsystem: Matrox Graphics, Inc. Millennium G400 Dual Head Max
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (4000ns min, 8000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 5
    Region 0: Memory at f4000000 (32-bit, prefetchable) [size=32M]
    Region 1: Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
    Region 2: Memory at fc000000 (32-bit, non-prefetchable) [size=8M]
    Expansion ROM at 80000000 [disabled] [size=64K]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [f0] AGP version 2.0
        Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
        Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1


Linux version 2.4.1 (root@jenik) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 +t ÿno 6 18:14:01 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000000fe9e000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000062000 @ 000000000ff9e000 (reserved)
 BIOS-e820: 0000000000500000 @ 00000000ffb00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000fee00000 (reserved)
...
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Trying generic Intel routines for device id: 2500
agpgart: AGP aperture is 64M @ 0xf0000000
[drm] AGP 0.99 on Intel @ 0xf0000000 64MB
[drm] Initialized mga 2.0.1 20000928 on minor 63
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
