Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270643AbTGURmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270639AbTGURlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:41:36 -0400
Received: from main.gmane.org ([80.91.224.249]:55527 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270640AbTGURkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:40:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: nick black <dank@suburbanjihad.net>
Subject: Re: 2.6.0-test1 + matroxfb = unuusable VC
Date: Mon, 21 Jul 2003 17:45:02 +0000 (UTC)
Message-ID: <bfh8qt$bbn$1@main.gmane.org>
References: <200307182239.h6IMdhM6008840@jebril.pi.be>
Reply-To: dank@reflexsecurity.com
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michel Eyckmans (MCE) assumed the extended riemann hypothesis and showed:
> I'm using (or rather: trying to use) matroxfb on 2.6.0-test1 (2.5.72 had 
> the same problems) and am seeing the following:
> 
>  - The initial boot console works fine, but all other consoles have 
>    scrolling problems. The area to the right of any scrolled text is 
>    most often coloured white, whereas it should be black. When using vi, 
>    it's even worse: white rectangles all over the place.
> 
>  - Right after switching from X to a text console, the fill color is not
>    white, but sort of a folded ghost image of part of my X display;

<snip>

i'm seeing the exact same issues.  i use to see similar problems in late
2.4's with agp turned on, where turning off agp sorted out the issue.
using 2.6 (test1-ac2), it happens whether agp is turned on or not.

some info:  (cmdline, dmesg, config, lspci -v -v for bridge/card):

video=matroxfb:vesa:0x1bb

PCI: No IRQ known for interrupt pin A of device 01:00.0. Please try 
	using pci=biosirq.
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1280x1024x24bpp (virtual: 1280x4368)
matroxfb: framebuffer at 0xD0000000, mapped to 0xe0805000, size 33554432
Console: switching to colour frame buffer device 160x64
fb0: MATROX VGA frame buffer device

CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)
			(prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 Dual Head Max
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
			Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
			<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at d2000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at d3000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,
				D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
				64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
				Rate=x1

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
        Subsystem: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
			Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
			<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [a0] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
				64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
				Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,
				D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

-- 
nick black <dank@reflexsecurity.com>
"np:  nondeterministic polynomial-time
the class of dashed hopes and idle dreams." - the complexity zoo

