Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269291AbRHLPCf>; Sun, 12 Aug 2001 11:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269292AbRHLPC0>; Sun, 12 Aug 2001 11:02:26 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:63760 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269291AbRHLPCN>; Sun, 12 Aug 2001 11:02:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: linux-kernel@vger.kernel.org
Subject: SB Live with wrong class / VGA
Date: Sun, 12 Aug 2001 17:04:26 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15Vwku-1ZxoGWC@fmrl00.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I have a two year old Soundblaster Live that seems to have a wrong PCI class 
code and reports itself as a VGA compatible device (see lspci -vv output 
below). I know that there is at least one other soundblaster live with the 
same problem.

XFree 4 seems to probe all VGA devices on the PCI bus. This causes the system 
to hang when a sound driver (ALSA or OSS) is already initialized and I try to 
play something. A simple workaround was to load the sound drivers after 
XFree. Unfortunately it looks like this has changed with XFree 4.1, the 
system now crashes always when playing any sound.

What is the right way to correct this? I have seen drivers/pci/quirks.c, but 
it could only change pci_dev->class. It looks like there is a lot of code 
that uses pci_read_config_dword to get the version. Is it better to change 
the code that uses pci_read_config_dword or to change pci_read_config_dword 
itself to report a more appropriate class?

bye...


lspci -vv:
00:0a.0 VGA compatible unclassified device: Creative Labs SB Live! EMU10000 
(rev 07)
        Subsystem: Creative Labs CT4760 SBLive!
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e000 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0a.1 Input device controller: Creative Labs SB Live! (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at e400 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

lspci -n:
00:0a.0 Class 0001: 1102:0002 (rev 07)
00:0a.1 Class 0980: 1102:7002 (rev 07)



