Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUATU0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUATU0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:26:07 -0500
Received: from mailrelay03.sunrise.ch ([194.158.229.31]:23205 "EHLO
	obelix.spectraweb.ch") by vger.kernel.org with ESMTP
	id S265766AbUATUZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:25:57 -0500
Subject: Re: Can't boot 2.6.1-mm4 or -mm5
From: Hanspeter Kunz <hkunz@ifi.unizh.ch>
Reply-To: hkunz@ifi.unizh.ch
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200401202145.06005.arvidjaar@mail.ru>
References: <200401202145.06005.arvidjaar@mail.ru>
Content-Type: text/plain
Message-Id: <1074630584.3041.6.camel@septumania>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 21:29:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had exactly the same problem with 2.6.1-mm4 and then 2.6.1-bk5 (didn't
try 2.6.1-mm5) with a different machine tough (Sony Z1). 

If you turn of frame buffer console support AND set vga=normal in
lilo.conf you can see what the problem is. 

At least in my case the problem was cause by the pnp bios support.
Disabling it solved the problem. If somebody is interested I can post a
photograph of the kernel oops.

cheers,
Hp.

On Tue, 2004-01-20 at 19:52, Andrey Borzenkov wrote:
> I can't boot either of them. 2.6.1-mm3 was OK; compiling and booting -mm4 or 
> -mm5 with the same config as before (since 2.5.69 actually). Compiling and 
> booting with VESA framebuffer and vga=788 gives empty screen; booting with 
> vga=normal or compiling without framebuffer support goes as far as
> 
> Uncompressing kernel ... booting
> 
> and that is all. No disk activity either so it seems to have just stopped.
> 
> Compiled on Mandrake 9.2 with gcc 3.3.1:
> 
> {pts/0}% gcc --version
> gcc-3.3.1 (GCC) 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk)
> Copyright (C) 2003 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> system is ASUS CUSL2, i815 chipset, GeForce2 MX videocard. lspci on 2.6.0 
> follows; config for -mm5 is attached. It was produced by using config from 
> -mm3, running make oldconfig and answering N to most new questions. It is 
> possible that there is problem with new CPU selection but I alaways compiled 
> with PentiumIII only before.
> 
> Boot and source directories are different if this matters.
> 
> regards
> 
> -andrey
> 
> {pts/0}% lspci -v
> 00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory 
> Controller Hub (rev 02)
>         Subsystem: Asustek Computer, Inc. TUSL2-C Mainboard
>         Flags: bus master, fast devsel, latency 0
>         Memory at f8000000 (32-bit, prefetchable) [size=64M]
>         Capabilities: <available only to root>
> 
> 00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 02) (prog-if 
> 00 [Normal decode])
>         Flags: bus master, 66Mhz, fast devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         Memory behind bridge: ee000000-efdfffff
>         Prefetchable memory behind bridge: eff00000-f7ffffff
> 
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 01) (prog-if 
> 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
>         I/O behind bridge: 0000c000-0000dfff
>         Memory behind bridge: ed800000-edffffff
>         Prefetchable memory behind bridge: efe00000-efefffff
> 
> 00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 01)
>         Flags: bus master, medium devsel, latency 0
> 
> 00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 01) (prog-if 80 
> [Master])
>         Subsystem: Asustek Computer, Inc. TUSL2-C Mainboard
>         Flags: bus master, medium devsel, latency 0
>         I/O ports at b800 [size=16]
> 
> 00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 01) (prog-if 
> 00 [UHCI])
>         Subsystem: Asustek Computer, Inc.: Unknown device 8027
>         Flags: bus master, medium devsel, latency 0, IRQ 5
>         I/O ports at b400 [size=32]
> 
> 00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 01)
>         Subsystem: Asustek Computer, Inc. TUSL2-C Mainboard
>         Flags: medium devsel, IRQ 10
>         I/O ports at e800 [size=16]
> 
> 00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 01) (prog-if 
> 00 [UHCI])
>         Subsystem: Asustek Computer, Inc.: Unknown device 8027
>         Flags: bus master, medium devsel, latency 0, IRQ 9
>         I/O ports at b000 [size=32]
> 
> 01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 
> 400] (rev a1) (prog-if 00 [VGA])
>         Subsystem: Asustek Computer, Inc. AGP-V7100 Pro
>         Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
>         Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
>         Memory at f0000000 (32-bit, prefetchable) [size=128M]
>         Expansion ROM at efff0000 [disabled] [size=64K]
>         Capabilities: <available only to root>
> 
> 02:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
>         Subsystem: Creative Labs CT4760 SBLive!
>         Flags: bus master, medium devsel, latency 32, IRQ 9
>         I/O ports at d800 [size=32]
>         Capabilities: <available only to root>
> 
> 02:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
> 08)
>         Subsystem: Creative Labs Gameport Joystick
>         Flags: bus master, medium devsel, latency 32
>         I/O ports at d400 [size=8]
>         Capabilities: <available only to root>
> 
> 02:0c.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus 
> DVD Decoder (rev 02)
>         Flags: bus master, medium devsel, latency 32, IRQ 9
>         Memory at ed800000 (32-bit, non-prefetchable) [size=1M]
>         Capabilities: <available only to root>
> 
> 02:0d.0 Serial controller: 5610 56K FaxModem 56K FaxModem Model 5610 (rev 01) 
> (prog-if 02 [16550])
>         Subsystem: 5610 56K FaxModem USR 56k Internal FAX Modem (Model 2977)
>         Flags: medium devsel, IRQ 9
>         I/O ports at d000 [size=8]
>         Capabilities: <available only to root>
> 
> {pts/0}% cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 8
> model name      : Pentium III (Coppermine)
> stepping        : 3
> cpu MHz         : 737.205
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
> pat pse36 mmx fxsr sse
> bogomips        : 1458.17
> 
> 
> 
-- 
Hanspeter Kunz
Artificial Intelligence Lab
Dept. of Information Technology
University of Zurich
+41 1 635 43 06 work
+41 1 635 68 09 fax
www.ifi.unizh.ch/~hkunz


