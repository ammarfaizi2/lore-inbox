Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270398AbTGMUTe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270399AbTGMUTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:19:34 -0400
Received: from webbox110.server-home.net ([62.208.70.32]:1450 "EHLO
	webbox110.server-home.net") by vger.kernel.org with ESMTP
	id S270398AbTGMUTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:19:31 -0400
Message-ID: <3F11C243.9060907@ng.h42.de>
Date: Sun, 13 Jul 2003 22:34:11 +0200
From: Lars Ehrhardt <0703@ng.h42.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.4.21-bk9 with new radeonfb causes console to stay blank 
X-Enigmail-Version: 0.76.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having problems with the new radeonfb driver (0.1.8-ben and
0.1.6-ben) on my IBM ThinkPad A30m with linux 2.4.21-bk9 with the latest
linux/driver/radeonfb.h from rsync.penguinppc.org.
Everything works fine if I just work on a console. I can switch between
different consoles, I can put the machine into suspend mode and resume
it without problems. However, when I switch to KDE on XFree 4.3.0 and
switch back to a console the console stays blank. Working within XFree
is still possible, but I have to reboot if I want to work on a console
again.

If I use the old radeonfb driver everything works as expected.

modprobe radeonfb (0.1.8-ben) with DEBUG 1 returns:

 kernel: PCI: Found IRQ 11 for device 01:00.0
 kernel: PCI: Sharing IRQ 11 with 00:1d.0
 kernel: PCI: Sharing IRQ 11 with 02:00.0
 kernel: radeonfb: ref_clk=2700, ref_div=60, xclk=16600 from BIOS
 kernel: radeonfb: probed DDR SGRAM 16384k videoram
 kernel: BIOS 4 scratch = 1000004
 kernel: FP_GEN_CNTL: 1c20000, FP2_GEN_CNTL: 8
 kernel: TMDS_TRANSMITTER_CNTL: 10000082, TMDS_CNTL: 1000000,
         LVDS_GEN_CNTL: 83dffa5
 kernel: DAC_CNTL: ff606002, DAC_CNTL2: 10f80, CRTC_GEN_CNTL: 2000200
 kernel: radeonfb: panel ID string: Samsung LTN150P1-L02
 kernel: radeonfb: detected LCD panel size from BIOS: 1400x1050
 kernel: hStart = 1440, hEnd = 1552, hTotal = 1688
 kernel: vStart = 1050, vEnd = 1053, vTotal = 1063
 kernel: h_total_disp = 0xae00d2^I   hsync_strt_wid = 0xe059a
 kernel: v_total_disp = 0x4190426^I   vsync_strt_wid = 0x30419
 kernel: pixclock = 9259
 kernel: freq = 10800
 kernel: post div = 0x2
 kernel: fb_div = 0x1e0
 kernel: ppll_div_3 = 0x101e0
 kernel: hStart = 1440, hEnd = 1552, hTotal = 1688
 kernel: vStart = 1050, vEnd = 1053, vTotal = 1063
 kernel: h_total_disp = 0xae00d2^I   hsync_strt_wid = 0xe059a
 kernel: v_total_disp = 0x4190426^I   vsync_strt_wid = 0x30419
 kernel: pixclock = 9259
 kernel: freq = 10800
 kernel: post div = 0x2
 kernel: fb_div = 0x1e0
 kernel: ppll_div_3 = 0x101e0
 kernel: Console: switching to colour frame buffer device 175x65
 kernel: radeonfb: ATI Radeon M6 LY DDR SGRAM 16 MB
 kernel: radeonfb: DVI port LCD monitor connected
 kernel: radeonfb: CRT port no monitor connected
 kernel: radeonfb_pci_register END

lspci -vv:

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
M6 LY (prog-if 00 [VGA])
        Subsystem: IBM ThinkPad A30p (2653-64G)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
                 ParErr- Stepping+ SERR+ FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
                <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at c0100000 (32-bit, non-prefetchable)
                  [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
                        HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW-
                         Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
                       PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Please cc me, as I am not subscribed.

bye lars

-- 
Send an email with the subject "Send: Key" for my GPG-Key
or get key 0xF0A0FD55 from a public keyserver

