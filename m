Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWAVHkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWAVHkh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 02:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWAVHkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 02:40:37 -0500
Received: from fluido.speedxs.nl ([83.98.238.192]:39691 "EHLO fluido.as")
	by vger.kernel.org with ESMTP id S1751242AbWAVHkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 02:40:36 -0500
Date: Sun, 22 Jan 2006 08:40:34 +0100
From: "Carlo E. Prelz" <fluido@fluido.as>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Message-ID: <20060122074034.GA1315@epio.fluido.as>
References: <20060120123202.GA1138@epio.fluido.as> <20060121010932.5d731f90.akpm@osdl.org> <20060121125741.GA13470@epio.fluido.as> <20060121125822.570b0d99.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_epio-5569-1137915634-0001-2"
Content-Disposition: inline
In-Reply-To: <20060121125822.570b0d99.akpm@osdl.org>
X-operating-system: Linux epio 2.6.14
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_epio-5569-1137915634-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

	Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
	Date: sab 21 gen 06 12:58:22 -0800

Quoting Andrew Morton (akpm@osdl.org):

> If you have a web server somewhere, just upload the .jpg file.  Or send it
> to me and I can do that.

The latest screenshot can be found at
http://www.fluido.as/files/images/screenshot.jpg

> > Calling initcall 0xffffffff8026836c: pci_init+0x0/0x2b()
> > 
> > 
> > And then the machine freezes. I may add that, with 2.6.14.6, I am
> > getting errors like:
> 
> OK, it looks like a PCI initcall went South.  Can you please add this, then
> when it hangs, record the last few lines then send us those, as well as the
> output of `lspci -vx'?

These lines appear at the end of the logfile:

pci_init: 10025950
pci_init: 10025a3f
pci_init: 1002437a
pci_init: 10024379
pci_init: 10024374
pci_init: 10024375
pci_init: 10024373

and 1002:4373 is the USB2 (EHCI) controller. I attach the output of
lspci -vx. Even with 2.6.14.6, I have problems with USB. It did not
work at all, then I downloaded the latest bios, and now, right after
boot, usb works OK. But after some time (possibly after the first APIC
error message), newly inserted USB disks are not detected anymore, and
I had one case in which a mounted disk was not accessible anymore. 

I just bought the motherboard - I did not make too many tests.

> Is this new behaviour?  If so, are you able to pinpoint the latest kernel
> which didn't have such problems?

The motherboard is new. With the previous motherboard (via k8t88
based), using the same processor and most of the same boards, I did
not have any of these problems.

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)

--=_epio-5569-1137915634-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lspciout2

0000:00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 01)
	Subsystem: ATI Technologies Inc RS480 Host Bridge
	Flags: bus master, 66MHz, medium devsel, latency 64
00: 02 10 50 59 06 00 20 22 01 00 00 06 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 50 59
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5a3f (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fde00000-fdefffff
	Prefetchable memory behind bridge: 00000000d8000000-00000000dff00000
	Capabilities: [44] #08 [a803]
	Capabilities: [b0] #0d [0000]
00: 02 10 3f 5a 07 00 30 02 00 00 04 06 00 63 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 44 e1 e1 20 02
20: e0 fd e0 fd 01 d8 f1 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 08 00

0000:00:11.0 IDE interface: ATI Technologies Inc ATI 437A Serial ATA Controller (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ATI Technologies Inc ATI 437A Serial ATA Controller
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	I/O ports at ff00 [size=8]
	I/O ports at fe00 [size=4]
	I/O ports at fd00 [size=8]
	I/O ports at fc00 [size=4]
	I/O ports at fb00 [size=16]
	Memory at fe02f000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at 40000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
00: 02 10 7a 43 07 00 b0 02 00 8f 01 01 08 40 00 00
10: 01 ff 00 00 01 fe 00 00 01 fd 00 00 01 fc 00 00
20: 01 fb 00 00 00 f0 02 fe 00 00 00 00 02 10 7a 43
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 00 00

0000:00:12.0 IDE interface: ATI Technologies Inc ATI 4379 Serial ATA Controller (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ATI Technologies Inc ATI 4379 Serial ATA Controller
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 5
	I/O ports at fa00 [size=8]
	I/O ports at f900 [size=4]
	I/O ports at f800 [size=8]
	I/O ports at f700 [size=4]
	I/O ports at f600 [size=16]
	Memory at fe02e000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at 40080000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
00: 02 10 79 43 07 00 b0 02 00 8f 01 01 08 40 00 00
10: 01 fa 00 00 01 f9 00 00 01 f8 00 00 01 f7 00 00
20: 01 f6 00 00 00 e0 02 fe 00 00 00 00 02 10 79 43
30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 00 00

0000:00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller (prog-if 10 [OHCI])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
00: 02 10 74 43 07 00 b0 02 00 10 03 0c 10 40 80 00
10: 00 d0 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 56 0a
30: 00 00 00 00 d0 00 00 00 00 00 00 00 0a 01 00 00

0000:00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller (prog-if 10 [OHCI])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
00: 02 10 75 43 07 00 b0 02 00 10 03 0c 10 40 00 00
10: 00 c0 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 56 0a
30: 00 00 00 00 d0 00 00 00 00 00 00 00 0a 01 00 00

0000:00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller (prog-if 20 [EHCI])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
	Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
00: 02 10 73 43 17 00 b0 02 00 20 03 0c 10 40 00 00
10: 00 b0 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 56 0a
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 00 00

0000:00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 10)
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: 66MHz, medium devsel
	I/O ports at 0400 [size=16]
	Memory at fe02a000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [b0] #08 [a802]
00: 02 10 72 43 03 04 30 02 10 00 05 0c 00 00 80 00
10: 01 04 00 00 00 a0 02 fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 56 0a
30: 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00

0000:00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE Controller ATI (prog-if 8a [Master SecP PriP])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at f400 [size=16]
	Capabilities: [70] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
00: 02 10 76 43 05 00 30 02 00 8a 01 01 00 40 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 01 f4 00 00 00 00 00 00 00 00 00 00 4b 17 56 0a
30: 00 00 00 00 70 00 00 00 00 00 00 00 ff 01 00 00

0000:00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: bus master, 66MHz, medium devsel, latency 0
00: 02 10 77 43 0f 00 20 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 56 0a
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge (prog-if 01 [Subtractive decode])
	Flags: bus master, VGA palette snoop, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=64
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: fdc00000-fddfffff
	Prefetchable memory behind bridge: fdb00000-fdbfffff
00: 02 10 71 43 27 00 a0 02 00 01 04 06 00 40 81 00
10: 00 00 00 00 00 00 00 00 00 02 03 40 c1 d1 80 22
20: c0 fd d0 fd b0 fd b0 fd 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 Audio Controller (rev 01)
	Subsystem: PC Partner Limited: Unknown device 5215
	Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 17
	Memory at fe029000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
00: 02 10 70 43 07 00 30 04 01 00 01 04 08 40 80 00
10: 00 90 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 15 52
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 02 02 00

0000:01:05.0 VGA compatible controller: ATI Technologies Inc RS480 [Radeon Xpress 200G Series] (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: bus master, 66MHz, medium devsel, latency 255, IRQ 11
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at ee00 [size=256]
	Memory at fdef0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at fde00000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
00: 02 10 54 59 07 00 b0 02 00 00 00 03 08 ff 00 00
10: 08 00 00 d8 01 ee 00 00 00 00 ef fd 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 56 0a
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 08 00

0000:02:05.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
	Subsystem: Technotrend Systemtechnik GmbH Technotrend-Budget / Hauppauge WinTV-NOVA-S DVB card
	Flags: bus master, medium devsel, latency 64, IRQ 16
	Memory at fddff000 (32-bit, non-prefetchable) [size=512]
00: 31 11 46 71 06 00 80 02 01 00 80 04 00 40 00 00
10: 00 f0 df fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c2 13 03 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 0f 26

0000:02:06.0 Multimedia controller: Philips Semiconductors SAA7133 Video Broadcast Decoder (rev d0)
	Subsystem: Pinnacle Systems Inc.: Unknown device 002e
	Flags: bus master, medium devsel, latency 64, IRQ 17
	Memory at fddfe000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [40] Power Management version 2
00: 31 11 33 71 06 00 90 02 d0 00 80 04 00 40 00 00
10: 00 e0 df fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 bd 11 2e 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 54 20

0000:02:07.0 PCI bridge: PicoPower Technology PT86C525 [Nile-II] PCI-to-PCI Bridge (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 64
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fdc00000-fdcfffff
	Prefetchable memory behind bridge: fdb00000-fdbfffff
00: 66 10 04 00 07 00 80 02 01 00 04 06 08 40 01 00
10: 00 00 00 00 00 00 00 00 02 03 03 20 c0 c0 80 02
20: c0 fd c0 fd b0 fd b0 fd 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:02:08.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Flags: bus master, slow devsel, latency 64, IRQ 17
	I/O ports at df00 [size=64]
	Capabilities: [dc] Power Management version 1
00: 74 12 71 13 05 01 10 04 06 00 01 04 00 40 00 00
10: 01 df 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 74 12 71 13
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 0c 80

0000:02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
	Subsystem: PC Partner Limited: Unknown device 8169
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 19
	I/O ports at dc00 [size=256]
	Memory at fddfd000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at fdd00000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
00: ec 10 69 81 17 00 b0 82 10 00 00 02 10 40 00 00
10: 01 dc 00 00 00 d0 df fd 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 69 81
30: 00 00 00 00 dc 00 00 00 00 00 00 00 03 01 20 40

0000:02:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: PC Partner Limited: Unknown device 3044
	Flags: bus master, stepping, medium devsel, latency 64, IRQ 17
	Memory at fddfc000 (32-bit, non-prefetchable) [size=2K]
	I/O ports at de00 [size=128]
	Capabilities: [50] Power Management version 2
00: 06 11 44 30 87 00 10 02 80 10 00 0c 08 40 00 00
10: 00 c0 df fd 01 de 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 44 30
30: 00 00 00 00 50 00 00 00 00 00 00 00 01 01 00 20

0000:03:08.0 SCSI storage controller: Advanced System Products, Inc ABP940-U / ABP960-U (rev 03)
	Subsystem: Advanced System Products, Inc ASC1300 SCSI Adapter
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at ce00 [size=256]
	Memory at fdcff000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at fdb00000 [disabled] [size=64K]
00: cd 10 00 13 07 00 80 02 03 00 00 01 08 40 00 00
10: 01 ce 00 00 00 f0 cf fd 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 3f 00 00 00 cd 10 10 13
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 04 04

0000:03:09.0 Multimedia video controller: Zoran Corporation ZR36057PQC Video cutting chipset (rev 02)
	Subsystem: Iomega Corporation JPEG/TV Card
	Flags: bus master, fast devsel, latency 32, IRQ 18
	Memory at fdcfe000 (32-bit, non-prefetchable) [size=4K]
00: de 11 57 60 06 00 00 00 02 00 00 04 00 20 00 00
10: 00 e0 cf fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ca 13 31 42
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 02 10


--=_epio-5569-1137915634-0001-2--
