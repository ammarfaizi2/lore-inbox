Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287490AbRLaLs4>; Mon, 31 Dec 2001 06:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287488AbRLaLsq>; Mon, 31 Dec 2001 06:48:46 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:23703
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S287490AbRLaLsb>; Mon, 31 Dec 2001 06:48:31 -0500
Date: Mon, 31 Dec 2001 06:55:44 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 with es1370 pci
Message-ID: <20011231065544.A28966@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every few days my es1370 sound board quits working.  The same thing happened
with  2.2.20.  There's absolutely no kernel messages when this happens. 
This has happened while playing sound on 2.2.20.  When I attempt to play any
sound, it just stops.  Here's part of an strace:

open("/dev/dsp", O_WRONLY)              = 4
ioctl(4, SNDCTL_DSP_GETBLKSIZE, 0x806ae1c) = 0
ioctl(4, SNDCTL_DSP_RESET, 0)           = 0
ioctl(4, SOUND_PCM_READ_BITS, 0xbffff880) = 0
ioctl(4, SNDCTL_DSP_STEREO, 0xbffff87c) = 0
ioctl(4, SOUND_PCM_READ_RATE, 0xbffff878) = 0
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 16384) = 16384
write(4, "\7\374\276\0\177\3734\1\372\372\252\1Z\372\377\1\264\371"..., 16384) = 16384
write(4, "\275\366\361\5\1\366\\\5\207\365\334\4\5\365E\4t\364e\3"..., 16384) = 16384
write(4, "\312\v\344\20\370\v\262\21\231\n\256\20P\10\"\16\"\6[\v"..., 16384) = 16384
write(4, "\237\375P\376\23\376\310\376\336\376\306\377\256\377{\0"..., 16384) = 16384
write(4, "\31\0\n\2C\376\266\376G\376\313\375\7\0u\0r\1\332\0028"..., 16384) = 16384
write(4, "\330\374\307\374}\375\330\374\23\376\350\374\22\3765\375"..., 16384) = 16384
write(4, "_\374\343\3734\373\372\372H\3721\372\345\371p\371\301\371"..., 16384) = 16384
write(4, " \376+\376Y\377\32\0V\376\244\376n\375\352\374\n\376d\375"..., 16384

The last write just blocks and nothing is played.  This is very annoying and
I have no clue what's going on.

here's LSPCI -v output:
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
        Flags: bus master, medium devsel, latency 64
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fda00000-feafffff
        Prefetchable memory behind bridge: f1800000-f58fffff

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Flags: medium devsel
        I/O ports at ffa0 [disabled] [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 64, IRQ 15
        I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Flags: medium devsel, IRQ 9

00:10.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at ef00 [size=64]
        Expansion ROM at febe0000 [disabled] [size=64K]

00:11.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 03)
        Subsystem: Adaptec: Unknown device 7895
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at e400 [disabled] [size=256]
        Memory at febfe000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at febd0000 [disabled] [size=64K]

00:11.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 03)
        Subsystem: Adaptec: Unknown device 7895
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at e800 [disabled] [size=256]
        Memory at febff000 (32-bit, non-prefetchable) [size=4K]

00:13.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
        Subsystem: Unknown device 1274:5000
        Flags: bus master, slow devsel, latency 64, IRQ 15
        I/O ports at ee80 [size=64]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at f2000000 (32-bit, prefetchable) [size=32M]
        Memory at feafc000 (32-bit, non-prefetchable) [size=16K]
        Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at feae0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0


The only thing I can see is the fact it's on IRQ 15 with the usb controller.

I honestly don't know why I'm doing this, as no message I ever post gets
answered.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
