Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVBQJAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVBQJAi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 04:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVBQJAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 04:00:38 -0500
Received: from CPE-139-168-157-43.nsw.bigpond.net.au ([139.168.157.43]:20208
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S262278AbVBQJAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 04:00:24 -0500
Message-ID: <42145D23.9060109@eyal.emu.id.au>
Date: Thu, 17 Feb 2005 20:00:19 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: bt8xxx would not reset properly
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a bt848 based TV tuner (see bootlog below) which sometimes
goes on the blink (see failure log below). It will not reset, and a
reboot does not fix it. I need to cycle the power to get it back
online.

I know that 2.6.10 and 2.6.11-rc4 did not restore operation when
booted, and I recall this even on earlier kernels.

I wonder if the reset process is not as extensive as it should be.
Naturally, it is possible that the card, when it fails, is in
a state where a reset is just not possible. It will be nice if this
can be improved though.


Boot log
========
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:03:01.0[A] -> GSI 21 (level, low) -> IRQ 21
bttv0: Bt848 (rev 18) at 0000:03:01.0, irq: 21, latency: 32, mmio: 0xde000000
bttv0: using: STB, Gateway P/N 6000699 (bt848) [card=3,insmod option]
bttv0: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
bttv0: gpio: en=00000000, out=00000000 in=00f0c0fc [init]
tuner: chip found at addr 0xc0 i2c-bus bt848 #0 [sw]
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by insmod option
tuner: The type=<n> insmod option will go away soon.
tuner: Please use the tuner=<n> option provided by
tuner: tv aard core driver (bttv, saa7134, ...) instead.
bttv0: using tuner=2
tuner: type already set to 5, ignoring request for 2
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL can sleep, using XTAL (35468950).
bttv: Bt8xx card found (1).

Typical failure
===============
Feb 17 09:09:33 eyal kernel: bttv0: OCERR @ 37efb000,bits: HSYNC OFLOW OCERR*
Feb 17 09:09:34 eyal last message repeated 14 times
Feb 17 09:09:34 eyal kernel: bttv0: OCERR @ 37efb000,bits: HSYNC OFLOW FDSR OCERR*
Feb 17 09:09:37 eyal last message repeated 66 times
Feb 17 09:09:37 eyal kernel: bttv0: timeout: drop=39 irq=318/321, risc=37efb01c, bits: HSYNC OFLOW
Feb 17 09:09:37 eyal kernel: bttv0: reset, reinitialize
Feb 17 09:09:37 eyal kernel: bttv0: PLL can sleep, using XTAL (35468950).
Feb 17 09:09:37 eyal kernel: bttv0: OCERR @ 37efb000,bits: VSYNC HSYNC OFLOW FDSR OCERR*
Feb 17 09:09:45 eyal last message repeated 200 times
Feb 17 09:09:45 eyal kernel: bttv0: timeout: drop=241 irq=726/729, risc=37efb01c, bits: VSYNC HSYNC OFLOW<6>bttv0: OCERR @ 37efb000,bits: HSYNC OFLOW FBUS FDSR OCERR*
Feb 17 09:09:45 eyal kernel:
Feb 17 09:09:45 eyal kernel: bttv0: reset, reinitialize
Feb 17 09:09:45 eyal kernel: bttv0: PLL can sleep, using XTAL (35468950).
Feb 17 09:09:45 eyal kernel: bttv0: OCERR @ 37efb000,bits: VSYNC HSYNC OFLOW OCERR*
Feb 17 09:09:45 eyal last message repeated 11 times
Feb 17 09:09:45 eyal kernel: bttv0: timeout: drop=242 irq=743/746, risc=37efb01c, <6>bttv0: OCERR @ 37efb000,bits: VSYNC HSYNC OFLOW FBUS OCERR*
Feb 17 09:09:45 eyal kernel: bits: VSYNC HSYNC OFLOW<6>bttv0: OCERR @ 37efb000,bits: VSYNC HSYNC OFLOW OCERR*

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
