Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291080AbSBGClC>; Wed, 6 Feb 2002 21:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291085AbSBGCky>; Wed, 6 Feb 2002 21:40:54 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:6918 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S291080AbSBGCkr>; Wed, 6 Feb 2002 21:40:47 -0500
Date: Thu, 7 Feb 2002 03:40:46 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: status on northbridge disconnection apm saving?
In-Reply-To: <Pine.LNX.4.40.0202061449280.8336-100000@hades.uni-trier.de>
Message-ID: <Pine.LNX.4.44.0202070329290.1072-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Daniel Nofftz wrote:

> i am working on an patch which performs power saving on athlon cpu's with
> the acpi function of the kernel ... at the moment only via's kt 133/133a
> and kt266/266a chipsets are supported, but other will follow soon (amd
> 760) ...
> if you want, you could try my patch.
> you can get it under:
> http://cip.uni-trier.de/nofftz/linux/amd_cool.diff
> 
> it is a patch against the 2.4.17 kernel .
> 
> you have to enable acpi-processor idle states in the kernel and you have
> to activate the patch at the kernel boot prompt with "amd_disconnect=yes".
> this is cause there are several problems known with the power saving
> function of the athlon/duron cpus ... i am working on this ....
> 
> there is also a newer testing version which reads a special register on
> the cpu and shows the value at booting time ... if you have problems with
> the patch, or ... better ... if you have no problems with the patch, it
> would be verry nice if you could mail me the value it shows at boot :)
> 
> the newer version is:
> http://cip.uni-trier.de/nofftz/linux/amd_cool_new.diff
> 
> there is no big difference between the to versions ... the new version
> only reads the register (and ... if you say force_amd_clk=yes at the boot
> prompt it modifys the register, but at the moment it is not clear whether
> this function does write the right value ... so use this with care ... )

I just flashed my BIOS today (upgrading my Asus A7V133-C from BIOS 
rev. 1005A to rev. 1007). Suddenly I begin to experience the sound-skips 
reported by other people. The CPU is a TB (9x133, 1200MHz, family 6, 
model 4, stepping 2).

Before flashing I had no trouble at all and the CPU cooled just fine, so 
it might not only be a chipset issue.

I tried the new version of the patch and get:

CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Applying VIA southbridge workaround.
Athlon/Duron CLK_Ctrl Value found : fff0d22f
Athlon/Duron CLK_Ctrl Value set to : fff0d22f
Enabling disconnect in VIA northbridge: KT133/KX133 chipset found

I have no idea, what those register values were before flashing. When 
using the patch from www.vcool.de I experience the same problem - it was 
not present before either. I also experience the problem when running 
the user-land tool from www.vcool.de. It does not matter whether I 
specify force_amd_clk=yes or not.

No hardware changes nor kernel config changes were made.

I send output of lspci along if it might help.

Regards
Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
[...] Note that 120 sec is defined in the protocol as the maximum
possible RTT.  I guess we'll have to use something other than TCP
to talk to the University of Mars.
----------------------------------[ moffe at amagerkollegiet dot dk ] --

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 8042
        Flags: bus master, medium devsel, latency 8
        Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d6000000-d7cfffff
        Prefetchable memory behind bridge: d7f00000-e3ffffff
        Capabilities: [80] Power Management version 2

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 8042
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 8042
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2

00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
        Subsystem: Unknown device 4942:4c4c
        Flags: bus master, slow devsel, latency 32, IRQ 5
        I/O ports at a400 [size=64]

00:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at d5800000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at a000 [size=64]
        Memory at d5000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

00:0c.0 SCSI storage controller: Advanced System Products, Inc ABP940-U / ABP960-U (rev 03)
        Subsystem: Advanced System Products, Inc ASC1300 SCSI Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at 9800 [size=256]
        Memory at d4800000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: nVidia Corporation NV11 DDR (rev b2) (prog-if 00 [VGA])
        Subsystem: Micro-star International Co Ltd: Unknown device 8261
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at d7ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0

