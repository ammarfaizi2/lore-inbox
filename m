Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268267AbTAMVBP>; Mon, 13 Jan 2003 16:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268307AbTAMVBP>; Mon, 13 Jan 2003 16:01:15 -0500
Received: from mail.mediaways.net ([193.189.224.113]:57721 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S268267AbTAMVBM>; Mon, 13 Jan 2003 16:01:12 -0500
Subject: system freezes when using udma on promise pdc20268
From: Soeren Sonnenburg <bugreports@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-otmy3GDkl3F3a+kpHx72"
Organization: 
Message-Id: <1042492068.1199.11.camel@sun>
Mime-Version: 1.0
Date: 13 Jan 2003 22:07:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-otmy3GDkl3F3a+kpHx72
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

I experience cold freezes of my new system reproducably (can still
toggle numlock, but on alt+sysrq+t it freezes completely, watchdog_nmi=1
does not help so no printout over serial console) when I enable any 
udma mode >0 using the old or new pdc202xx driver.

However the system seems to work stably (as far I can tell) when using
the mdma0 or pio modes.

The setup is asus a7v8x with sound/ide/firewire onboard. Two 180GB WDC
WD1800JB-00DUA0 on the primary and secondary internal VIA controller and
3 drives on two pdc20268, where the third hard disk is on the secondary
controller (I explain later why!). All harddisk are jumpered to be
master's.
The harddisks on the pdc are Maxtor 4R080J0 (this one is the lonely
secondary one) Maxtor 4D080K4 (primary) Maxtor 4D080H4 (secondary)

Cables are all 80pin, the drives all udma5.

This system has 1.5G ddr333 memory (checked for 2days ~ 17passes)
harddisks were tested with the manufactures tools -> all ok. However
cannot say anything about the cables. Not sure whether they can cause a
system freeze though.

The five disks span a RAID5 (5* 80G partition).

The freeze happens immediately after the raid starts reconstruction when
udma4/5 is used. On udma2 the system freezes immediately when using
bonnie to benchmark the raid (the reconstruction of the raid is
successful though).

This all happens when booting with init=/bin/sh (so no X no nothing).

The pdc's are in slot 3 and 6 of the mainboard, so the first pdc shares
irq's with the agp slot (nvidia card/ but no nvidia module loaded) and
the second shares with Onboard SATA/1394 (no drivers loaded). All other
cards are empty.

I have no ideas how to further narrow down this problem. I am grateful
for any ideas on how to solve this.
 
If you need further infos just tell me.

Now the explanation why one harddisk is used as secondary and not
primary: If I attach the disk to the primary, then it gets correctly
detected as drive x. However when doing fdisk /dev/hdx one of the WDC
drives is shown instead of the maxtor drive.

Both problems occur in kernel version 2.4.19/20/21-pre2/21-pre3.  

Thanks for any suggestions,
Soeren.

--=-otmy3GDkl3F3a+kpHx72
Content-Disposition: attachment; filename=lspci
Content-Type: text/plain; name=lspci; charset=ansi_x3.4-1968
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189
	Subsystem: Asustek Computer, Inc.: Unknown device 807f
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b168 (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d6000000-d75fffff
	Prefetchable memory behind bridge: d7700000-dfffffff
	Capabilities: [80] Power Management version 2

00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Flags: bus master, stepping, medium devsel, latency 128, IRQ 10
	Memory at d5800000 (32-bit, non-prefetchable) [size=2K]
	I/O ports at d800 [size=128]
	Capabilities: [50] Power Management version 2

00:08.0 RAID bus controller: Promise Technology, Inc.: Unknown device 3376 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 809e
	Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 10
	I/O ports at d400 [size=64]
	I/O ports at d000 [size=16]
	I/O ports at b800 [size=128]
	Memory at d5000000 (32-bit, non-prefetchable) [size=4K]
	Memory at d4800000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [60] Power Management version 2

00:09.0 Ethernet controller: BROADCOM Corporation: Unknown device 4401 (rev 01)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a8
	Flags: bus master, fast devsel, latency 132, IRQ 7
	Memory at d4000000 (32-bit, non-prefetchable) [size=8K]
	Expansion ROM at d76f0000 [disabled] [size=16K]
	Capabilities: [40] Power Management version 2

00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra100TX2
	Flags: bus master, 66Mhz, slow devsel, latency 132, IRQ 11
	I/O ports at b400 [size=8]
	I/O ports at b000 [size=4]
	I/O ports at a800 [size=8]
	I/O ports at a400 [size=4]
	I/O ports at a000 [size=16]
	Memory at d3800000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1

00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra100TX2
	Flags: bus master, 66Mhz, slow devsel, latency 132, IRQ 10
	I/O ports at 9800 [size=8]
	I/O ports at 9400 [size=4]
	I/O ports at 9000 [size=8]
	I/O ports at 8800 [size=4]
	I/O ports at 8400 [size=16]
	Memory at d3000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Flags: bus master, medium devsel, latency 132, IRQ 9
	I/O ports at 8000 [size=32]
	Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Flags: bus master, medium devsel, latency 132, IRQ 9
	I/O ports at 7800 [size=32]
	Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Flags: bus master, medium devsel, latency 132, IRQ 9
	I/O ports at 7400 [size=32]
	Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Flags: bus master, medium devsel, latency 132, IRQ 9
	Memory at d2800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Flags: bus master, medium devsel, latency 128
	I/O ports at 7000 [size=16]
	Capabilities: [c0] Power Management version 2

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
	Subsystem: Asustek Computer, Inc.: Unknown device 8095
	Flags: medium devsel, IRQ 9
	I/O ports at e000 [size=256]
	Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4200] (rev a3) (prog-if 00 [VGA])
	Subsystem: Unknown device 17f2:8007
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
	Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Memory at d7800000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at d77e0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0


--=-otmy3GDkl3F3a+kpHx72--

