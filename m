Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSLNRH7>; Sat, 14 Dec 2002 12:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSLNRH7>; Sat, 14 Dec 2002 12:07:59 -0500
Received: from services.cam.org ([198.73.180.252]:16525 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S261318AbSLNRH4>;
	Sat, 14 Dec 2002 12:07:56 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org, "Eric W.Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kexec for 2.5.51....
Date: Sat, 14 Dec 2002 12:15:49 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212141215.49449.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> Linus,
> 
> My apologies for not resending this earlier I've been terribly
> busy with other things..
> 
> No changes are included since the last time I sent this except
> the diff now patches cleanly onto 2.5.51.  If there is some problem
> holler and I will see about fixing it.
> 
> When I bypass the BIOS in booting clients my only current failure
> report is on an IBM NUMAQ and that almost worked.

I applied this to a 2.5.51 kernel with usb and fbcon updated via bk pulls.
Then after rebooting into the new kernel I tried

kexec -l /vmlinux.25 --append="console=tty0 console=ttyS0,38400 video=matrox:mem:32 idebus=33 profile=1"
kexec -ed

This rebooted but hangs at:

drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0

when the boot works I expect to see:

uhci-hcd 00:07.2: VIA Technologies, In USB
uhci-hcd 00:07.2: irq 10, io base 0000a400
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected
mice: PS/2 mouse device common for all mice

following the above message.
 
kexec is version 1.8 built with gcc 2.95.4 and the distrubition is debian unstable.
lspci -v gives:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
        Flags: bus master, medium devsel, latency 16
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e4000000-e7ffffff
        Prefetchable memory behind bridge: e8000000-e9ffffff

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
        Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at a000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at a400 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
        Flags: medium devsel, IRQ 9

00:08.0 Ethernet controller: VIA Technologies, Inc. VT3043 [Rhine] (rev 06)
        Subsystem: D-Link System Inc DFE-530TX rev A
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at a800 [size=128]
        Memory at ed120000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at ea000000 [disabled] [size=64K]

00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
        Subsystem: Promise Technology, Inc. Ultra100
        Flags: bus master, medium devsel, latency 64, IRQ 12
        I/O ports at ac00 [size=8]
        I/O ports at b000 [size=4]
        I/O ports at b400 [size=8]
        I/O ports at b800 [size=4]
        I/O ports at bc00 [size=64]
        Memory at ed100000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at eb000000 [disabled] [size=64K]
        Capabilities: <available only to root>

00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
        Subsystem: Kingston Technologies KNE100TX Fast Ethernet
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at c000 [size=128]
        Memory at ed122000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at ec000000 [disabled] [size=256K]

00:0b.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at ed121000 (32-bit, non-prefetchable) [size=4K]
        Memory at ed000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: <available only to root>

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at e8000000 (32-bit, prefetchable) [size=32M]
        Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
        Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root>

Am I using kexec correctly?  What else can I try?  Is there any debug
info I can gather?

One other datum.  Without the --append line a kernel booted with kexec hangs when
tring to mount the real root - it cannot find the device.

TIA,

Ed Tomlinson

