Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbWF3JSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWF3JSo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbWF3JSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:18:44 -0400
Received: from [80.247.74.3] ([80.247.74.3]:38091 "EHLO tavolara.isolaweb.it")
	by vger.kernel.org with ESMTP id S1751581AbWF3JSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:18:43 -0400
Message-Id: <7.0.1.0.2.20060630111507.040558a0@tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 7.0.1.0
Date: Fri, 30 Jun 2006 11:18:36 +0200
To: linux-kernel@vger.kernel.org
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Problem with 2.6.16-1.2122_FC5 x86_64
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-IsolaWeb-MailScanner-Information: Please contact the ISP for more information
X-IsolaWeb-MailScanner: Found to be clean
X-MailScanner-From: kernel@tekno-soft.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All on the list,

I have some problem with a dual Intel Xeon HT with Fedora 5 x86_64 
the system reports the log below:

sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device

furthermore the problem is showing in two identical box . The boxes have 4Gb of ECC memory each.
The board is an ASUS NCT-D with two Xeon HT 3,2GHz 2Mb cache.
I've checked: the memory with memcheck and each SATA hdd (4 each box) in hw RAID-5 with the 
controller checking utility but none of those have any problem so far. I guess there's some problem on 
the linux's driver and/or by the handling of the data in the DAC 64bit mode from the controller itself. 

Does anyone have some tips?

Thanks in advance.

uname -a reports
Linux server 2.6.16-1.2122_FC5 #1 SMP Sun May 21 15:01:10 EDT 2006 x86_64 x86_64 x86_64 GNU/Linux

The controller is an Adaptec SATA 2420SA below is relevant part of the boot log:

Adaptec aacraid driver (1.1-4 May 21 2006 15:27:29)
ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 27 (level, low) -> IRQ 18
AAC0: kernel 5.1-0[8373]
AAC0: monitor 5.1-0[8373]
AAC0: bios 5.1-0[8373]
AAC0: serial 4fe049
AAC0: 64bit support enabled.
AAC0: 64 Bit DAC enabled
scsi0 : aacraid
  Vendor: Adaptec   Model: Main              Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 1757157376 512-byte hdwr sectors (899665 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
SCSI device sda: 1757157376 512-byte hdwr sectors (899665 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi removable disk sda

lspci -v reports

00:00.0 Host bridge: Intel Corporation E7525 Memory Controller Hub (rev 0c)
        Subsystem: ASUSTeK Computer Inc. Unknown device 814a
        Flags: bus master, fast devsel, latency 0
        Capabilities: [40] Vendor Specific Information

00:00.1 Class ff00: Intel Corporation E7525/E7520 Error Reporting Registers (rev 0c)
        Subsystem: ASUSTeK Computer Inc. Unknown device 814a
        Flags: fast devsel

00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port A (rev 0c) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
        Capabilities: [64] Express Root Port (Slot-) IRQ 0
        Capabilities: [100] Advanced Error Reporting

00:03.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port A1 (rev 0c) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: d7a00000-d7afffff
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
        Capabilities: [64] Express Root Port (Slot-) IRQ 0
        Capabilities: [100] Advanced Error Reporting

00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B (rev 0c) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d7b00000-d7bfffff
        Prefetchable memory behind bridge: 00000000d8000000-00000000dff00000
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
        Capabilities: [64] Express Root Port (Slot-) IRQ 0
        Capabilities: [100] Advanced Error Reporting

00:1c.0 PCI bridge: Intel Corporation 6300ESB 64-bit PCI-X Bridge (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 64
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: d7c00000-d7efffff
        Capabilities: [50] PCI-X bridge device

00:1d.0 USB Controller: Intel Corporation 6300ESB USB Universal Host Controller (rev 02) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 8117
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at 9880 [size=32]

00:1d.1 USB Controller: Intel Corporation 6300ESB USB Universal Host Controller (rev 02) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 8117
        Flags: bus master, medium devsel, latency 0, IRQ 21
        I/O ports at 9c00 [size=32]

00:1d.4 System peripheral: Intel Corporation 6300ESB Watchdog Timer (rev 02)
        Subsystem: ASUSTeK Computer Inc. Unknown device 8117
        Flags: medium devsel
        Memory at d79ff800 (32-bit, non-prefetchable) [size=16]

00:1d.5 PIC: Intel Corporation 6300ESB I/O Advanced Programmable Interrupt Controller (rev 02) (prog-if 20 [IO(X)-APIC])
        Subsystem: ASUSTeK Computer Inc. Unknown device 8117
        Flags: bus master, fast devsel, latency 0
        Capabilities: [50] PCI-X non-bridge device

00:1d.7 USB Controller: Intel Corporation 6300ESB USB2 Enhanced Host Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 8117
        Flags: bus master, medium devsel, latency 0, IRQ 19
        Memory at d79ffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 0a) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: d7f00000-d7ffffff
        Prefetchable memory behind bridge: c2000000-c20fffff

00:1f.0 ISA bridge: Intel Corporation 6300ESB LPC Interface Controller (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 6300ESB PATA Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. Unknown device 8117
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at fc00 [size=16]
        Memory at c2100000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation 6300ESB SMBus Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc. Unknown device 8117
        Flags: medium devsel, IRQ 5
        I/O ports at 0400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation 6300ESB AC'97 Audio Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc. Unknown device 80b0
        Flags: bus master, medium devsel, latency 0, IRQ 24
        I/O ports at 9400 [size=256]
        I/O ports at 9800 [size=64]
        Memory at d79ff400 (32-bit, non-prefetchable) [size=512]
        Memory at d79ff000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751 Gigabit Ethernet PCI Express (rev 11)
        Subsystem: ASUSTeK Computer Inc. Unknown device 814b
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at d7af0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
        Capabilities: [d0] Express Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [13c] Virtual Channel
03:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)] (prog-if 00 [VGA])
        Subsystem: ASUSTeK Computer Inc. Unknown device 0082
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at c000 [size=256]
        Memory at d7be0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at d7bc0000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Express Endpoint IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [100] Advanced Error Reporting

03:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
        Subsystem: ASUSTeK Computer Inc. Unknown device 0083
        Flags: bus master, fast devsel, latency 0
        Memory at d7bf0000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Express Endpoint IRQ 0

04:02.0 RAID bus controller: Adaptec AAC-RAID (Rocket) (rev 02)
        Subsystem: Adaptec ASR-2420SA
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
        Memory at d7c00000 (64-bit, non-prefetchable) [size=2M]
        Memory at d7eff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at d7ee0000 [disabled] [size=32K]
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/2 Enable-
        Capabilities: [58] PCI-X non-bridge device
        Capabilities: [60] Vital Product Data

05:01.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 10)
        Subsystem: 3Com Corporation 3C941 Gigabit LOM Ethernet Adapter
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 22
        Memory at d7ffc000 (32-bit, non-prefetchable) [size=16K]
        I/O ports at e800 [size=256]
        Expansion ROM at c2000000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data

05:02.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 814c
        Flags: bus master, medium devsel, latency 64, IRQ 22
        I/O ports at e480 [size=32]
        Capabilities: [80] Power Management version 2

05:02.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 814c
        Flags: bus master, medium devsel, latency 64, IRQ 23
        I/O ports at ec00 [size=32]
        Capabilities: [80] Power Management version 2

05:02.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 63) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 814c
        Flags: bus master, medium devsel, latency 64, IRQ 20
        Memory at d7ffbc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

05:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Flags: bus master, medium devsel, latency 64, IRQ 23
        Memory at d7ffb000 (32-bit, non-prefetchable) [size=2K]
        Memory at d7ff4000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

Roberto Fichera. 


Roberto Fichera. 

