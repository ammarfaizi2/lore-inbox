Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbTAEBIg>; Sat, 4 Jan 2003 20:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbTAEBIg>; Sat, 4 Jan 2003 20:08:36 -0500
Received: from 218-bem-2.acn.waw.pl ([62.121.81.218]:20488 "EHLO
	woland.michal.waw.pl") by vger.kernel.org with ESMTP
	id <S262326AbTAEBIe>; Sat, 4 Jan 2003 20:08:34 -0500
Date: Sun, 5 Jan 2003 02:17:08 +0100
From: Michal Kochanowicz <michal@michal.waw.pl>
To: linux-kernel@vger.kernel.org
Subject: Can IDE work efficiently _without_ an IRQ?
Message-ID: <20030105011708.GA20748@woland.michal.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Happy GNU/Linux Users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

After some hardware upgrade (2x more RAM, new motherboard with ~3x
faster CPU) I found out that performance of HDD degraded heavilly.
Looking for the reason I found out that kernel is unable to assign IRQ
to IDE controller:
------------------------------------------------------------------------
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
------------------------------------------------------------------------

pci=biosirq has no effect.

lspci -vv gives such info for IDE controller:

------------------------------------------------------------------------
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR
- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        Region 4: I/O ports at a000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
------------------------------------------------------------------------

Can this be a reason for HDD performance degradation? And if so, what
can I do about this?

I use 2.4.20-rc4 kernel with XFS patch. This is my h/w as reported by
lspci:
------------------------------------------------------------------------
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
                                                    ^^^^^
This one is quite strange - according to manual this motherboard has
KT333 chipset.

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT333 AGP]
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:09.0 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:09.1 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
00:0f.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If [Radeon 9000] (rev 01)
------------------------------------------------------------------------

Regards
-- 
--= Michal Kochanowicz =--==--==BOFH==--==--= michal@michal.waw.pl =--
--= finger me for PGP public key or visit http://michal.waw.pl/PGP =--
--==--==--==--==--==-- Vodka. Connecting people.--==--==--==--==--==--
A chodzenie po górach SSIE!!!
