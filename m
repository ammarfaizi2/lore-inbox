Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268995AbUIMV7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268995AbUIMV7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268992AbUIMV7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:59:23 -0400
Received: from av9-1-sn1.fre.skanova.net ([81.228.11.115]:50874 "EHLO
	av9-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S268993AbUIMV6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:58:52 -0400
To: Linus Torvalds <torvalds@osdl.org>, Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc2
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 13 Sep 2004 23:57:44 +0200
In-Reply-To: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
Message-ID: <m3ekl5de7b.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Gerd Knorr:
>   o v4l: bttv driver update

This patch,

    http://linus.bkbits.net:8080/linux-2.5/cset@4138a998OBJaigDdWZo3Y58C5Brqlg?nav=index.html|ChangeSet@-2w

makes my computer lock up or instantly reboot when I try to do a tv
recording with mplayer.

lspci -vvv:

02:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f80ff000 (32-bit, prefetchable)
        Capabilities: <available only to root>

Output from dmesg with a working kernel: (-rc2 with the above patch reverted)

    Linux video capture interface: v1.00
    bttv: driver version 0.9.15 loaded
    bttv: using 8 buffers with 2080k (520 pages) each for capture
    bttv: Bt8xx card found (0).
    ACPI: PCI interrupt 0000:02:0a.0[A] -> GSI 19 (level, low) -> IRQ 19
    bttv0: Bt878 (rev 17) at 0000:02:0a.0, irq: 19, latency: 64, mmio: 0xf80ff000
    bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
    bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
    bttv0: gpio: en=00000000, out=00000000 in=00fffbff [init]
    bttv0: i2c: checking for MSP34xx @ 0x80... found
    bttv0: pinnacle/mt: id=2 info="PAL+SECAM / stereo" radio=yes
    bttv0: using tuner=33
    bttv0: i2c: checking for MSP34xx @ 0x80... found
    msp3400: Ignoring new-style parameters in presence of obsolete ones
    msp34xx: init: chip=MSP3410G-B11 +nicam +simple +radio
    bttv0: i2c: checking for TDA9875 @ 0xb0... not found
    bttv0: i2c: checking for TDA7432 @ 0x8a... not found
    msp3410: daemon started
    tda9887: Ignoring new-style parameters in presence of obsolete ones
    tda9885/6/7: chip found @ 0x96
    tuner: Ignoring new-style parameters in presence of obsolete ones
    tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
    tuner: type set to 33 (MT20xx universal) by bt878 #0 [sw]
    tuner: microtune: companycode=3cbf part=42 rev=ac
    tuner: microtune MT2050 found, OK
    bttv0: registered device video0
    bttv0: registered device vbi0
    bttv0: registered device radio0
    bttv0: PLL: 28636363 => 35468950 .. ok

When running the crashing kernel, the last line in /var/log/messages
after the crash is:

    bttv0: pinnacle/mt: id=2 info="PAL+SECAM / stereo" radio=yes

Maybe there is more data that doesn't make it to the disk. I can try
again with a serial console if you think that would help.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
