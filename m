Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRANBiD>; Sat, 13 Jan 2001 20:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131578AbRANBhx>; Sat, 13 Jan 2001 20:37:53 -0500
Received: from inet-gw2.oracle.com ([205.227.43.29]:4739 "EHLO
	inet-smtp2.oracle.com") by vger.kernel.org with ESMTP
	id <S131415AbRANBhe>; Sat, 13 Jan 2001 20:37:34 -0500
Message-ID: <3A610103.102E9094@oracle.com>
Date: Sun, 14 Jan 2001 02:29:39 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: manfred@colorfullife.com
CC: linux-kernel@vger.kernel.org
Subject: IO-APIC and ne2000 PCI [Manfred's test]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred,

  patch applied, enabled IO-APIC UP support but it doesn't show for my
  ne2k PCI card... this is on 2.4.1-pre3 (plus your patch obviously).

[asuardi@wish asuardi]$ cat /proc/interrupts
           CPU0       
  0:      39630          XT-PIC  timer
  1:        916          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  9:    1321915          XT-PIC  usb-uhci, usb-uhci, eth0
 11:          0          XT-PIC  acpi
 12:         48          XT-PIC  PS/2 Mouse
 14:      14020          XT-PIC  ide0
 15:          6          XT-PIC  ide1
NMI:          0 
ERR:          0

Only stuff I get at boot is this:

[root@wish /root]# dmesg | grep APIC
mapped APIC to ffffe000 (01222000)

ping -f for 1 minute to my laptop, ~190K pings per session, eth0 works.
[so it's a Yes]

Board is a Gigabyte GA7ZM with a K7-800.

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
	Flags: bus master, medium devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=4M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2
00: 06 11 05 03 06 00 10 22 02 00 00 06 00 00 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: dbe00000-dbefffff
	Prefetchable memory behind bridge: d7c00000-d7cfffff
00: 06 11 05 83 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 90 90 00 00
20: e0 db e0 db c0 d7 c0 d7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0
00: 06 11 86 06 87 00 10 02 22 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 86 06
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at ffa0 [size=16]
	Capabilities: [c0] Power Management version 2
00: 06 11 71 05 07 00 90 02 10 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 22 10 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c8 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 04 00 00

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at cc00 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 22 10 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 04 00 00

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Flags: medium devsel
	Capabilities: [68] Power Management version 2
00: 06 11 57 30 00 00 90 02 30 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 20)
	Subsystem: Giga-byte Technology: Unknown device 5348
	Flags: medium devsel, IRQ 10
	I/O ports at d800 [size=256]
	I/O ports at d400 [size=4]
	I/O ports at d000 [size=4]
	Capabilities: [c0] Power Management version 2
00: 06 11 58 30 01 00 10 02 20 00 01 04 00 00 00 00
10: 01 d8 00 00 01 d4 00 00 01 d0 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 48 53
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0a 03 00 00

00:09.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc.: Unknown device 0057
	Flags: fast devsel, IRQ 11
	Memory at de000000 (32-bit, non-prefetchable) [size=32M]
	Memory at d8000000 (32-bit, prefetchable) [size=32M]
	I/O ports at dc00 [size=256]
	Expansion ROM at ddff0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
00: 1a 12 05 00 03 00 90 80 01 00 00 03 00 00 00 00
10: 00 00 00 de 08 00 00 d8 01 dc 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 1a 12 57 00
30: 00 00 ff dd 60 00 00 00 00 00 00 00 0b 01 00 00

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Flags: medium devsel, IRQ 9
	I/O ports at c400 [size=32]
00: ec 10 29 80 03 00 00 02 00 00 00 02 00 00 00 00
10: 01 c4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 29 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00


Anything else I can do, just ask :)

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19p7/2.4.1p3 glibc-2.2 gcc-2.96-69 binutils-2.10.1.0.4
Oracle: Oracle8i 8.1.7.0.0 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
