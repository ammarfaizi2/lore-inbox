Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262629AbREZKPN>; Sat, 26 May 2001 06:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262632AbREZKPD>; Sat, 26 May 2001 06:15:03 -0400
Received: from [194.97.50.131] ([194.97.50.131]:4269 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S262629AbREZKOy>;
	Sat, 26 May 2001 06:14:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: "Kernel-Mailingliste" <linux-kernel@vger.kernel.org>
Subject: [2.4.4ac11-17] lasting problems with stat or link
Date: Sat, 26 May 2001 11:58:20 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01052500061100.01519@athlon>
In-Reply-To: <01052500061100.01519@athlon>
MIME-Version: 1.0
Message-Id: <01052611582000.11785@athlon>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo all,

I get the mentioned error as often as longer the system is running. E.g.:
$ ls kviewshell/.libs/libkmultipage.so

The following is what strace say's:

[....]
3795  lstat("kviewshell/.libs/libkmultipage.so", 0xbffff718) = -1 EIO
(Input/output error)
[...]

The file really exists and is correct!

Another example is:
umount /boot

That's what strace is saying:
[...]

3762  open("/etc/mtab~3762", O_WRONLY|O_CREAT, 0) = 4
3762  close(4)                          = 0
3762  link("/etc/mtab~3762", "/etc/mtab~") = -1 ENOENT (No such file or
directory)
3762  unlink("/etc/mtab~3762")          = 0
[....]

I've got no problems with 2.4.4ac9 and ac10. The Problems start with ac11 and 
can be found until the actual ac17.


Versions:
Linux athlon 2.4.4-ac16 #1 Don Mai 24 22:47:31 CEST 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.76.1
binutils               2.9.5.0.12
util-linux             2.10s
mount                  2.10s
modutils               2.4.5
e2fsprogs              1.19
PPP                    2.4.0b1
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.2
Net-tools              1.56
Kbd                    0.96
Sh-utils               2.0g
Modules Loaded         ext2 nfs lockd sunrpc 8139too sis900 serial
parport_pc lp parport unix

I'm using reiserfs, 3.5.x disk format.


$ lspci -v

00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
	Flags: bus master, medium devsel, latency 0
	Memory at d6000000 (32-bit, prefetchable) [size=32M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [PCI-PCI Bridge] (prog-if 
00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d4000000-d5ffffff
	Prefetchable memory behind bridge: d0000000-d3ffffff
	Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) 
(prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at d000 [size=16]
	Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) 
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d400 [size=32]
	Capabilities: <available only to root>

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
30)
	Flags: medium devsel, IRQ 9
	Capabilities: <available only to root>

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo 
Super AC97/Audio] (rev 20)
	Subsystem: VIA Technologies, Inc.: Unknown device 4511
	Flags: medium devsel, IRQ 5
	I/O ports at dc00 [size=256]
	I/O ports at e000 [size=4]
	I/O ports at e400 [size=4]
	Capabilities: <available only to root>

00:08.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 02)
	Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet Adapter
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at e800 [size=256]
	Memory at d9000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at ec00 [size=256]
	Memory at d9001000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if 
00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 10
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	I/O ports at c000 [size=256]
	Memory at d5000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>



Regards,
Andreas Hartmann
