Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbTE1ElG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 00:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbTE1ElF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 00:41:05 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.92.226.49]:28890 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S264506AbTE1ElC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 00:41:02 -0400
Date: Wed, 28 May 2003 00:50:54 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.70 - ATI DRM broken
Message-ID: <20030528045054.GA545@andromeda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ATI 128 DRM broke between 2.5.69 and 2.5.70.  I've manually played with
the diff in 'drivers/char/drm/*', but never got .70 to work.  The
problem may not even be in drm/.

Linus' message said he included 'DRM from CVS', so I imagine it'll be
fixed soon enough, but probably someone should make sure .71 has another
CVS update of DRI.

FWIW, a full description of the problem follows.

Everything seems to works well even in FB console mode (x86 processor).
However, if I try to `startx`, then it appears that X loads, and I can
see and move the cursor (not the regular X cursor, but my window
manager's).  The background is never updated by X, so I just see a black
screen with a cursor.  It appears that X doesn't respond to mouse
clicks, as wm menus don't show up.

X doesn't seem to notice a problem as my XFree86.log doesn't show
anything abnormal.  In the console, with gpm, the mouse works fine.

Once I `startx`, I cannot switch back to a console, nor can I exit,
even with Ctrl-Alt-Bkspace.  I have not disabled that key sequence.

Running `X`, the background still doesn't show up, but I am able to exit
with C-A-BS.  The X log shows nothing.  HOWEVER!, if I rerun `X`, I
don't get a cursor; nor can I C-A-BS.

Sometimes it seems X works once or twice, but it never works a third
time.  Seems to be a problem switching between X/console,console/X.

Recompiling without DRM (and running with vesafb) fixes the problem.

More information is available, just tell me what to look for.

Justin Pryzby

PS

Dell Inspiron 4k laptop, relevant `lspci` follows:

...
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fd000000-feffffff
        Prefetchable memory behind bridge: f8000000-fbffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+
...
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility M3
AGP 2x (rev 02) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 00b0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at ec00 [size=256]
        Region 2: Memory at fdffc000 (32-bit, non-prefetchable)
[size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



Relevant `dmesg` output follows:

...
vesafb: framebuffer at 0xf8000000, mapped to 0xc8814000, size 8192k
vesafb: mode is 1024x768x24, linelength=3072, pages=2
vesafb: protected mode interface info at c000:6294
vesafb: scrolling: redraw
EDID checksum failed, aborting
EDID checksum failed, aborting
vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
fb0: VESA VGA frame buffer device
Console: switching to colour frame buffer device 128x48
...
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Intel 440BX chipset
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: AGP aperture is 64M @ 0xf4000000
[drm] Initialized r128 2.3.0 20021029 on minor 0
...
