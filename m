Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271196AbTG1Xeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271197AbTG1Xeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:34:46 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:17280 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S271196AbTG1Xen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:34:43 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Mon, 28 Jul 2003 20:34:40 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
cc: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: matroxfb and 2.6.0-test2
Message-ID: <Pine.LNX.4.56.0307281958410.193@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The card is a Matrox Millenium G400 M4A32DG (single head).

2.6.0-test2 is the first 2.5.x I try, so I may be missing
something.

During make modules_install I noticed the following warning
(yes, I installed the latest module-init-tools):

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test2; fi
WARNING: /lib/modules/2.6.0-test2/kernel/drivers/video/matrox/matroxfb_crtc2.ko
needs unknown symbol matroxfb_enable_irq

I don't know if it's serious but then I rebooted from 2.4.21.

My init script contains

if lspci | grep -q 'MGA G400'; then
modprobe matroxfb_base
fi

and /etc/modprobe.conf options matroxfb_base vesa=440

After it the screen became corrupted with a dump of my last
shutdown. All commands still worked. I don't use fbset at all.
The logs don't have anything about matroxfb.

With 2.4.21 I get

Jul 28 19:55:14 pervalidus kernel: matroxfb: Matrox G400 (AGP) detected
Jul 28 19:55:14 pervalidus kernel: matroxfb: MTRR's turned on
Jul 28 19:55:14 pervalidus kernel: matroxfb: 1024x768x24bpp (virtual: 1024x5460)
Jul 28 19:55:14 pervalidus kernel: matroxfb: framebuffer at 0xD8000000, mapped to 0xe0866000, size 33554432
Jul 28 19:55:14 pervalidus kernel: Console: switching to colour frame buffer device 128x48
Jul 28 19:55:14 pervalidus kernel: fb0: MATROX VGA frame buffer device

My .config and dmesg are at
http://www.pervalidus.net/tmp/.config-2.6.0-test2.txt
http://www.pervalidus.net/tmp/dmesg-2.6.0-test2.txt
http://www.pervalidus.net/tmp/dmesg-2.6.0-acpi=off+noapic-test2.txt

lspci -vvv returns

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 32Mb SDRAM
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at da000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at db000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
