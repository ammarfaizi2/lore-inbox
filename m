Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267306AbTAWWC7>; Thu, 23 Jan 2003 17:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTAWWC6>; Thu, 23 Jan 2003 17:02:58 -0500
Received: from relay-4.fastweb.it ([213.140.2.43]:16004 "EHLO
	mailres.fastwebnet.it") by vger.kernel.org with ESMTP
	id <S267306AbTAWWC4> convert rfc822-to-8bit; Thu, 23 Jan 2003 17:02:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Antonello Iunco <etn@libero.it>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.21-pre3: still problems with ALiMagik and Video Capture Cards
Date: Fri, 24 Jan 2003 00:10:50 +0100
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301240010.02300."etn@libero.it">
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
I'm still having problems with my bttv-based video capture card for use under 
Linux, despite the changelog for 2.4.21 says that a workaround was introduced 
for my specific hardware configuration.
I own an Asus A7A266 motherboard based on AliMagik1 chipset, and a Hauppage 
WinTV card (lspci details below).
Using overlay capture, the whole system freezes immediately (with xawtv and 
qtvision, same result) and there's no way to take control over the system 
again. I tried using the same kernel with the same TV board on a Via based 
board and overlay capture works perfectly.
The only way to use the card is to use "grabdisplay" feature under xawtv, but 
it's slow, poor on resolution and, notably, worked on less recent kernels as 
well (2.4.18)
The same problem was reported by people using the same hardware under Windows, 
and it was solved by an ALi chipset driver update. It seems that the 
workaround in 2.4.21 doesn't work around so much :).
I updated by BIOS to the latest version, followed directions published on 
Hauppage's home page in order to let the card work.

Any help greatly appreciated.
Antonello Iunco

lspci output:
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1647 Northbridge [MAGiK 1 / 
MobileMAGiK 1] (rev 04)
        Flags: bus master, medium devsel, latency 0
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [b0] AGP version 2.0
        Capabilities: [a4] Power Management version 1

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] PCI to AGP Controller 
(prog-if 00 [Normal decode])
        Flags: bus master, slow devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: f2000000-f27fffff
        Prefetchable memory behind bridge: f3f00000-f7ffffff

[snip]

00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) 
(prog-if fa)
        Subsystem: Asustek Computer, Inc. A7A66 Motherboard IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at b400 [size=16]
        Capabilities: [60] Power Management version 2

[snip]

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV]
        Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA 
Bridge
        Flags: bus master, medium devsel, latency 0
        Capabilities: [a0] Power Management version 1

[snip]

00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at f3000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
11)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Flags: bus master, medium devsel, latency 8, IRQ 9
        Memory at f2800000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
        Flags: medium devsel

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x 
TMDS (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage Fury Pro
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at f4000000 (32-bit, prefetchable) [size=64M]
        I/O ports at d800 [size=256]
        Memory at f2000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at f3fe0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
        Capabilities: [5c] Power Management version 2

dmesg output:

[snip]
Linux video capture interface: v1.00
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.96 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
bttv: Host bridge is Acer Laboratories Inc. [ALi] M1647 Northbridge [MAGiK 1 / 
MobileMAGiK 1]
bttv: Host bridge needs ETBF enabled.
bttv: Bt8xx card found (0).
PCI: Found IRQ 9 for device 00:0d.0
PCI: Sharing IRQ 9 with 00:05.0
PCI: Sharing IRQ 9 with 00:0d.1
bttv0: Bt878 (rev 17) at 00:0d.0, irq: 9, latency: 8, mmio: 0xf3000000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: BT878(Hauppauge (bt878)) [card=10,autodetected]
bttv0: enabling EPCI: Setting latency timer of device 00:0d.0 to 64
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: Hauppauge eeprom: model=44804, tuner=LG TP18PSB11D (29), radio=no
bttv0: using tuner=29
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951)
i2c-core.o: driver generic i2c audio driver registered.
i2c-core.o: driver i2c TV tuner driver registered.
tuner: probing bt848 #0 i2c adapter [id=0x10005]
tuner: chip found @ 0xc2
bttv0: i2c attach [client=LG PAL_BG (TPI8PSB11D),ok]
i2c-core.o: client [LG PAL_BG (TPI8PSB11D)] registered to adapter [bt848 
#0](pos. 0).
bttv0: registered device video0
bttv0: registered device vbi0
i2c-core.o: driver i2c msp3400 driver registered.
bttv0: PLL: 28636363 => 35468950 ... ok

Interesting messages in /var/log/messages:
Jan 23 23:29:29 starseeker kernel: cmpci: version $Revision: 5.64 $ time 
22:38:18 Jan 23 2003
Jan 23 23:29:29 starseeker kernel: PCI: Found IRQ 9 for device 00:05.0
Jan 23 23:29:29 starseeker kernel: PCI: Sharing IRQ 9 with 00:0d.0
Jan 23 23:29:29 starseeker kernel: PCI: Sharing IRQ 9 with 00:0d.1
Jan 23 23:29:29 starseeker kernel: cmpci: found CM8738 adapter at io 0xb000 
irq 9

(there's IRQ sharing here, but even disabling the audio driver, lockup is 
still around)
