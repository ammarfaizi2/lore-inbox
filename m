Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272492AbTHKKWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 06:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272493AbTHKKWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 06:22:42 -0400
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:11024
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S272492AbTHKKWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 06:22:40 -0400
Date: Mon, 11 Aug 2003 12:22:36 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0test3 problems on Acer TravelMate 260 (ALSA,ACPIvsSynaptics,yenta)
Message-ID: <20030811102236.GA731@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've been evaluating kernel 2.6.0test3 on my Acer TravelMate 260 Laptop, it
is a PIII Movile at 1GHz with intel chipset (i82801+i830M) 256 Megs of RAM.

There are some weird old problems, like the yenta problem, the problem with
the cardbus interface is that you have to insert the card twice so that it
notices the card is in, everything else seems ok, on 2.4 there is the same
problem, so I'm using the pcmcia-cs i82365 driver which is working
perfectly. This is what the 2.6 yenta driver says on startup:

Yenta: CardBus bridge found at 0000:01:09.0 [1025:1024]
Yenta IRQ list 02b8, PCI irq10
Socket status: 30000007

This is what lspci tells about the cardbus interface:

01:09.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
        Subsystem: Acer Incorporated [ALI]: Unknown device 1024
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001
00: 17 12 72 69 87 00 10 04 00 00 07 06 00 a8 02 00
10: 00 10 00 10 a0 00 00 02 01 02 05 b0 00 00 40 10
20: 00 f0 7f 10 00 00 80 10 00 f0 bf 10 01 10 00 00
30: fd 10 00 00 01 14 00 00 fd 14 00 00 0a 01 80 05
40: 25 10 24 10 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

The ALSA problem is new, ALSA for 2.4 (0.9.4) is working perfectly, but the
2.6.0 driver doesn't allow me to hear the beeper sound, the pcm sounds seem
ok, but no matter what I do with the mixer, ALSA doesn't seem to drive the
beeper sound to the speakers. The card driver is the snd_intel8x0 with its
associated snd_ac97_codec, alsamixer says this about it:
Card: Intel 82801CA-ICH3
Chip: Cirrus Logic CS4299 rev 4
And this is what lspci says:

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio
(rev 02)
        Subsystem: Acer Incorporated [ALI]: Unknown device 1024
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at a000 [size=256]
        Region 1: I/O ports at a400 [size=64]
00: 86 80 85 24 05 00 80 02 02 00 01 04 00 00 00 00
10: 01 a0 00 00 01 a4 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 24 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

Also new is the problem that ACPI is causing on the Synaptics touchpad, the
touchpad driver is loosing sync all the time, and I have discovered that
only disabling ACPI this gets solved, there was no problem with ACPI as of
2.4, but there was also no kernel Synaptics driver, however normal driver
with the XFree Driver didn't have this problems. Without ACPI the touchpad
driver works perfectly. I don't know what data can I provide to help
tracking this down :-(

I don't have any problem to test patches or try to provide more info on any
of this things.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
