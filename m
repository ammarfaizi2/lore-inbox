Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbUBFJxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUBFJxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:53:48 -0500
Received: from joel.ist.utl.pt ([193.136.198.171]:28108 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S265351AbUBFJxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:53:44 -0500
Date: Fri, 6 Feb 2004 09:53:39 +0000 (WET)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: [Linux 2.6.2] bttv0: skipped frame. no signal? high irq latency?
Message-ID: <Pine.LNX.4.58.0402060923560.19743@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gerd Knorr,

I've the dmesg full of this warnings (last 149 messages right now),
although I didn't notice anything unusual in tvtime. I don't recall seeing
those warnings with 2.4.x. Should I just ignore them? Is there anything I
could try?

~> dmesg | sort | uniq
bttv0: skipped frame. no signal? high irq latency? [main=43e5000,o_vbi=43e5018,o_field=603b000,rc=603b01c]
bttv0: skipped frame. no signal? high irq latency? [main=43e5000,o_vbi=43e5018,o_field=8cd7000,rc=8cd701c]
bttv0: skipped frame. no signal? high irq latency? [main=43e5000,o_vbi=43e5018,o_field=967a000,rc=967a01c]
bttv0: skipped frame. no signal? high irq latency? [main=43e5000,o_vbi=43e5018,o_field=a05b000,rc=a05b01c]


* Messages when the modules are loaded:

Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 4 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:0d.0, irq: 11, latency: 32, mmio: 0xe7000000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=44344, tuner=LG TPI8PSB11D (29), radio=no
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp34xx: init: chip=MSP3415G-B8 +nicam +simple +radio
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok

As you can see, I'm using "options bttv gbuffers=4" on /etc/modprobe.conf


* Relevant "lspci -vv" output:

00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e7000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e6800000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


You could find my .config at http://joel.ist.utl.pt/~rmps/config-2.6.2 and
if you need more info, just ask.


Regards,
  Rui Saraiva
