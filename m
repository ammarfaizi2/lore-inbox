Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264868AbSKEWKg>; Tue, 5 Nov 2002 17:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264900AbSKEWKg>; Tue, 5 Nov 2002 17:10:36 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:18834 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264868AbSKEWKe>; Tue, 5 Nov 2002 17:10:34 -0500
Subject: aic7xxx problem.
From: Emmanuel Fuste <e.fuste@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Nov 2002 23:34:46 +0100
Message-Id: <1036535689.3349.36.camel@rafale>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a problem with an adaptec 2940u2w since ... a long time: I tried
to get it working since kernel 2.3.9x.
The board work fine in other computer on Linux.
When I try on mine (old dual cpu i586 asus board) I got this kind of
kernel messages at boot and less than five second later, the computer
lock:
scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x7
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x9
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x7
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase

My computer had always worked with an aic7xxx since 1.3.4x kernels. I
have now an aic7871 (2940uw) and it work well.
But sometimes I have a flood of theses messages in syslog like with the
2940u2w, messages stops and the computer continue to work as if nothing
was appened.
It generaly apened only one time per boot.
My running kernel is 2.4.20-rc1 with alsa 0.9rc5. I already tried all
combinaisons: single CPU mode, noapic, etc...
I think I have a problem with my PCI conf, but I'm not an expert :-(

Output of lspci -v:
00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev
03)
        Flags: bus master, medium devsel, latency 32

00:01.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II]
(rev 01)
        Flags: bus master, medium devsel, latency 0

00:01.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
(prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 32
        I/O ports at e800 [size=16]

00:01.2 USB Controller: Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II]
(rev 01) (prog-if 00 [UHC
I])
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at e400 [size=32]

00:09.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at e000 [disabled] [size=256]
        Memory at e3000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W
[Millennium II] (prog-if 00 [VG
A])
        Subsystem: Matrox Graphics, Inc. MGA-2164W Millennium II
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at e6000000 (32-bit, prefetchable) [size=16M]
        Memory at e2800000 (32-bit, non-prefetchable) [size=16K]
        Memory at e2000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 (rev
01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G200 SD
        Flags: medium devsel, IRQ 16
        Memory at e4000000 (32-bit, prefetchable) [size=16M]
        Memory at e1800000 (32-bit, non-prefetchable) [size=16K]
        Memory at e1000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at e3ff0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1

00:0d.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet
LANCE] (rev 02)
        Flags: bus master, stepping, medium devsel, latency 0, IRQ 19
        I/O ports at d800 [size=32]

The things that choked me are the latency on the isa bridge and the
PCnet controller.
On the other hand, for the pcnet, I could read these in my syslog:

pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
PCI: Setting latency timer of device 00:0d.0 to 64
pcnet32: PCnet/PCI 79C970 at 0xd800, 10 00 5a 5b 55 97 assigned IRQ 19.
eth0: registered as PCnet/PCI 79C970
pcnet32: 1 cards_found.

Who is true ? lspci or the syslog ? is the driver fail to set latency to
64 or lspci wrong ?

For the ISA bridge, is this harmless or should I try to patch the kernel
with a new quirk ? (if my bios is buggy, there is no support for my
board since a long time).

Please Alan (which like old bizare computer) or other, help me. I will
try a 2.5 kernel which seems to have more advanced PCI setup some time
but it is a long operation to compile a kernel on this computer (and
more now since alsa just crashed leaving one cpu stuck a 100% ;-)))

Emmanuel.

PS: Please CC, I only read lklm via web mail archive.
Thanks.







