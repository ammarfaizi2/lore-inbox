Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWJBXHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWJBXHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 19:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965510AbWJBXHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 19:07:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:12714 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964977AbWJBXHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 19:07:43 -0400
Subject: 2.6.18-mm2 networking problem + IRQ panic
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, suka@us.ibm.com
Content-Type: multipart/mixed; boundary="=-cBGe2jDbXP+svmfSr4qc"
Date: Mon, 02 Oct 2006 16:07:12 -0700
Message-Id: <1159830432.5039.16.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cBGe2jDbXP+svmfSr4qc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I am having problem bringing up networking on 2.6.18-mm2.
I don't see any interrupts for eth0. I also see "cannot 
handle IRQ" panic on shutdown - wondering if they are related..

           CPU0       CPU1       CPU2       CPU3
  0:     112736     117883     117738     123737    IO-APIC-edge  timer
  1:          0          0          1         10    IO-APIC-edge  i8042
  4:          0          1          0        477    IO-APIC-edge  serial
  6:          0          0          0          5    IO-APIC-edge  floppy
  8:          0          0          0          0    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
 12:          0         42          6         65    IO-APIC-edge  i8042
 14:       4869       1911       3449       6079    IO-APIC-edge  ide0
 15:          0      11051       4806        847    IO-APIC-edge  ide1
 17:      55636          0          5          0   IO-APIC-level  eth0
NMI:        216         40         38         41
LOC:     471992     471992     472046     471481
ERR:          0
MIS:          0


Everything works fine on 2.6.18.

(I saw similar report by Sukadev on 2.6.18-mm1).
dmesg shows (similar messages about unable to allocate messages):

PCI: Cannot allocate resource region 0 of device 0000:08:01.1
PCI: Cannot allocate resource region 0 of device 0000:08:02.1
PCI: Cannot allocate resource region 0 of device 0000:08:03.1
PCI: Cannot allocate resource region 0 of device 0000:08:04.1

Thanks,
Badari


INIT:do_IRQ: cannot handle IRQ -1
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at arch/x86_64/kernel/irq.c:118
invalid opcode: 0000 [1] SMP
last sysfs file: /devices/pci0000:00/0000:00:06.0/irq
CPU 1
Modules linked in: acpi_cpufreq ipv6 thermal processor fan button
battery ac dm_mod floppy parport_pc lp parport
Pid: 1, comm: init Not tainted 2.6.18-mm2 #1
RIP: 0010:[<ffffffff8020ced0>]



--=-cBGe2jDbXP+svmfSr4qc
Content-Disposition: attachment; filename=lspci.out
Content-Type: text/plain; name=lspci.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: fa000000-fa0fffff
	Prefetchable memory behind bridge: e2000000-e20fffff
	Capabilities: [c0] HyperTransport: Slave or Primary Interface
	Capabilities: [f0] HyperTransport: Interrupt Discovery and Configuration

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 LPC
	Flags: bus master, 66MHz, medium devsel, latency 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 IDE
	Flags: bus master, medium devsel, latency 64
	I/O ports at 1020 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 ACPI
	Flags: medium devsel

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
	Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
	Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Flags: fast devsel

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Flags: fast devsel

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel

00:1a.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
	Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:1a.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Flags: fast devsel

00:1a.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Flags: fast devsel

00:1a.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel

00:1b.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
	Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:1b.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Flags: fast devsel

00:1b.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Flags: fast devsel

00:1b.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel

01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at fa000000 (32-bit, non-prefetchable) [size=4K]

01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at fa001000 (32-bit, non-prefetchable) [size=4K]

01:04.0 SCSI storage controller: QLogic Corp. QLA2200 64-bit Fibre Channel Adapter (rev 05)
	Subsystem: QLogic Corp. QLA2200
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 5
	I/O ports at 2000 [size=256]
	Memory at fa002000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at e2000000 [disabled] [size=128K]
	Capabilities: [44] Power Management version 1

01:05.0 SCSI storage controller: QLogic Corp. QLA2200 64-bit Fibre Channel Adapter (rev 05)
	Subsystem: QLogic Corp. QLA2200
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	I/O ports at 2400 [size=256]
	Memory at fa003000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at e2020000 [disabled] [size=128K]
	Capabilities: [44] Power Management version 1

08:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 99
	Bus: primary=08, secondary=09, subordinate=0e, sec-latency=64
	Memory behind bridge: fa400000-faffffff
	Prefetchable memory behind bridge: 00000000fc000000-00000000fdf00000
	Capabilities: [a0] PCI-X bridge device
	Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration
	Capabilities: [c0] HyperTransport: Slave or Primary Interface

08:01.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD] Unknown device 7450
	Flags: bus master, medium devsel, latency 0
	Memory at e2300000 (64-bit, non-prefetchable) [size=4K]

08:02.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=08, secondary=0f, subordinate=13, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: fb000000-fb0fffff
	Prefetchable memory behind bridge: 00000000e2100000-00000000e2100000
	Capabilities: [a0] PCI-X bridge device
	Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration

08:02.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD] Unknown device 7450
	Flags: bus master, medium devsel, latency 0
	Memory at e2301000 (64-bit, non-prefetchable) [size=4K]

08:03.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=08, secondary=14, subordinate=18, sec-latency=64
	Capabilities: [a0] PCI-X bridge device
	Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration
	Capabilities: [c0] HyperTransport: Slave or Primary Interface

08:03.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD] Unknown device 7450
	Flags: bus master, medium devsel, latency 0
	Memory at e2302000 (64-bit, non-prefetchable) [size=4K]

08:04.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 64
	Memory at fa3e3000 (64-bit, non-prefetchable) [size=4K]
	Bus: primary=08, secondary=19, subordinate=1d, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: fb100000-fb1fffff
	Prefetchable memory behind bridge: 00000000e2200000-00000000e2200000
	Capabilities: [a0] PCI-X bridge device
	Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration
	Capabilities: [90] #0c [000a]
	Capabilities: [98] Power Management version 2

08:04.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD] Unknown device 7450
	Flags: bus master, medium devsel, latency 0
	Memory at e2303000 (64-bit, non-prefetchable) [size=4K]

09:01.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 12) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 99
	Bus: primary=09, secondary=0a, subordinate=0a, sec-latency=69
	Memory behind bridge: fa400000-faffffff
	Prefetchable memory behind bridge: 00000000fc000000-00000000fdf00000
	Capabilities: [80] Power Management version 2
	Capabilities: [90] #06 [0000]
	Capabilities: [a0] Vital Product Data

0a:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450 (rev 85) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G450 Dual Head PCI
	Flags: medium devsel, IRQ 10
	Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Memory at fa400000 (32-bit, non-prefetchable) [size=16K]
	Memory at fa800000 (32-bit, non-prefetchable) [size=8M]
	[virtual] Expansion ROM at fa420000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0

0f:01.0 Fibre Channel: QLogic Corp. QLA2312 Fibre Channel Adapter (rev 02)
	Subsystem: QLogic Corp. Unknown device 0100
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	I/O ports at 3000 [size=256]
	Memory at fb000000 (64-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at e2100000 [disabled] [size=128K]
	Capabilities: [44] Power Management version 2
	Capabilities: [4c] PCI-X non-bridge device
	Capabilities: [54] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
	Capabilities: [64] #06 [0080]

19:01.0 SCSI storage controller: QLogic Corp. QLA2200 64-bit Fibre Channel Adapter (rev 05)
	Subsystem: QLogic Corp. QLA2200
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	I/O ports at 4000 [size=256]
	Memory at fb110000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at e2200000 [disabled] [size=128K]
	Capabilities: [44] Power Management version 1

19:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
	Subsystem: 3Com Corporation 3C996B-T 1000Base-T
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 38
	Memory at fb100000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-


--=-cBGe2jDbXP+svmfSr4qc--

