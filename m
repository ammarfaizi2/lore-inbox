Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272255AbTG3VEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272257AbTG3VEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:04:46 -0400
Received: from [65.244.37.61] ([65.244.37.61]:25639 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S272255AbTG3VEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:04:06 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A920234CD69@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PROBLEM]: CPUs not responding after warm boot (2.6.0-test1-G2, x
	86)
Date: Wed, 30 Jul 2003 17:03:25 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Occasionally on a warm boot, one or more CPU's do not respond. This
always occurs after the following message appears after 'shutdown -r':

Jul 30 16:18:58 musrum kernel: rpciod: active tasks at shutdown?!

There are no warnings or errors other than this in any of the log files.
A message is displayed on the console, which unfortunately I don't have,
but it is something about entering the power down state.  This is the
last message displayed, and the machine never powers down.  A warm reset
will now always cause one or more CPU's to fail with the following messages,
(or ones like it) in /var/syslog.

Jul 30 16:19:48 musrum kernel: CPU #1 not responding - cannot use it.
Jul 30 16:19:48 musrum kernel: Booting processor 1/2 eip 2000

There is also a noticable (about 1 sec.) pause after the 'Booting processor'
message above; this pause normally does not occur.  The only way to recover
from this problem is a cold restart.  A longer excerpt of the syslog is at
the end of this email.  The boot process proceeds normally, and the system
comes up.  The only noticable symptom in this state is that there are only
3 CPUs (sometimes only 2).  Of course, that's a Good Thing!

Kernel 2.6.0-test1-G2, Based on Slackware 9.0, with upgrades for 2.5.x
operations. HT enabled.  I have seen this on occasion since 2.5.67 which
was the earliest 2.5.x I ran extensively on this machine.

If there is anything I can do/provide, please let me know.

---- /proc/cpuinfo ---------------------------------------------

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 7
cpu MHz		: 2392.938
cache size	: 512 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 4718.59

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 7
cpu MHz		: 2392.938
cache size	: 512 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 4767.74

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 7
cpu MHz		: 2392.938
cache size	: 512 KB
physical id	: 3
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 4767.74

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 7
cpu MHz		: 2392.938
cache size	: 512 KB
physical id	: 3
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 4767.74

----- lspci ------------------------------------


00:00.0 Host bridge: Intel Corp.: Unknown device 2550 (rev 03)
	Subsystem: Dell Computer Corporation: Unknown device 012d
	Flags: bus master, fast devsel, latency 0
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [40] #09 [0104]
	Capabilities: [a0] AGP version 3.0

00:01.0 PCI bridge: Intel Corp.: Unknown device 2552 (rev 03) (prog-if 00
[Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fe500000-fe6fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	Capabilities: [60] AGP version 3.5

00:02.0 PCI bridge: Intel Corp.: Unknown device 2553 (rev 03) (prog-if 00
[Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fe100000-fe4fffff

00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01) (prog-if
00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 012d
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at ff80 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01) (prog-if
00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 012d
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at ff60 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01) (prog-if
00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 012d
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at ff40 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01) (prog-if
20 [EHCI])
	Subsystem: Dell Computer Corporation: Unknown device 012d
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at fe700800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81) (prog-if 00
[Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fd000000-fdffffff
	Prefetchable memory behind bridge: f8000000-f87fffff

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01) (prog-if 8a
[Master SecP PriP])
	Subsystem: Dell Computer Corporation: Unknown device 012d
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at ffa0 [size=16]
	Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 012d
	Flags: medium devsel, IRQ 17
	I/O ports at bc80 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5 (rev
01)
	Subsystem: Dell Computer Corporation: Unknown device 012d
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at b800 [size=256]
	I/O ports at bc40 [size=64]
	Memory at fe700400 (32-bit, non-prefetchable) [size=512]
	Memory at fe700000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY
(prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 1b8a
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ
16
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at ec00 [size=256]
	Memory at fe5f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at c1000000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03) (prog-if 20
[IO(X)-APIC])
	Subsystem: Dell Computer Corporation: Unknown device 012d
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Memory at fe1ff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] PCI-X non-bridge device.

02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
(prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fe300000-fe4fffff
	Capabilities: [50] PCI-X non-bridge device.

02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03) (prog-if 20
[IO(X)-APIC])
	Subsystem: Dell Computer Corporation: Unknown device 012d
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Memory at fe1fe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] PCI-X non-bridge device.

02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
(prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
	Capabilities: [50] PCI-X non-bridge device.

03:0e.0 Ethernet controller: Intel Corp.: Unknown device 100f (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 012c
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 24
	Memory at fe3e0000 (64-bit, non-prefetchable) [size=128K]
	I/O ports at dcc0 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-

05:0d.0 VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG
[Mystique] (rev 02) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc.: Unknown device 1000
	Flags: bus master, stepping, medium devsel, latency 64, IRQ 21
	Memory at fdefc000 (32-bit, non-prefetchable) [size=16K]
	Memory at f8000000 (32-bit, prefetchable) [size=8M]
	Memory at fd000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

05:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0c)
	Subsystem: Intel Corp. EtherExpress PRO/100 S Desktop Adapter
	Flags: bus master, medium devsel, latency 64, IRQ 22
	Memory at fdefb000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at ccc0 [size=64]
	Memory at fdec0000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at fdf00000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2


----- excerpt from syslog ------------------------


Jul 30 16:19:41 musrum kernel: Processor #0 15:2 APIC version 20
Jul 30 16:19:41 musrum kernel: Processor #2 15:2 APIC version 20
Jul 30 16:19:42 musrum kernel: Processor #1 15:2 APIC version 20
Jul 30 16:19:42 musrum kernel: Processor #3 15:2 APIC version 20
Jul 30 16:19:43 musrum kernel: IOAPIC[0]: apic_id 4, version 32, address
0xfec00000, IRQ 0-23
Jul 30 16:19:44 musrum kernel: IOAPIC[1]: apic_id 5, version 32, address
0xfec80000, IRQ 24-47
Jul 30 16:19:45 musrum kernel: IOAPIC[2]: apic_id 6, version 32, address
0xfec80800, IRQ 48-71
Jul 30 16:19:46 musrum kernel: Enabling APIC mode:  Flat.  Using 3 I/O APICs
Jul 30 16:19:46 musrum kernel: Building zonelist for node : 0
Jul 30 16:19:47 musrum kernel: Kernel command line: BOOT_IMAGE=linux_6.0-g2
ro root=305
Jul 30 16:19:47 musrum kernel: PID hash table entries: 2048 (order 11: 16384
bytes)
Jul 30 16:19:47 musrum kernel: Detected 2392.923 MHz processor.
Jul 30 16:19:48 musrum kernel: Console: colour VGA+ 80x25
Jul 30 16:19:48 musrum kernel: Calibrating delay loop... 4718.59 BogoMIPS
Jul 30 16:19:48 musrum kernel: Inode-cache hash table entries: 32768 (order:
5, 131072 bytes)
Jul 30 16:19:48 musrum kernel: Mount-cache hash table entries: 512 (order:
0, 4096 bytes)
Jul 30 16:19:48 musrum kernel: POSIX conformance testing by UNIFIX
Jul 30 16:19:48 musrum kernel: CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping
07
Jul 30 16:19:48 musrum kernel: per-CPU timeslice cutoff: 1462.89 usecs.
Jul 30 16:19:48 musrum kernel: task migration cache decay timeout: 2 msecs.
Jul 30 16:19:48 musrum kernel: enabled ExtINT on CPU#0
Jul 30 16:19:48 musrum kernel: ESR value before enabling vector: 00000040
Jul 30 16:19:48 musrum kernel: ESR value after enabling vector: 00000000
Jul 30 16:19:48 musrum kernel: Booting processor 1/1 eip 2000
Jul 30 16:19:48 musrum kernel: Not responding.
Jul 30 16:19:48 musrum kernel: CPU #1 not responding - cannot use it.
Jul 30 16:19:48 musrum kernel: Booting processor 1/2 eip 2000
Jul 30 16:19:48 musrum kernel: masked ExtINT on CPU#1
Jul 30 16:19:48 musrum kernel: ESR value before enabling vector: 00000000
Jul 30 16:19:48 musrum kernel: ESR value after enabling vector: 00000000
Jul 30 16:19:48 musrum kernel: Calibrating delay loop... 4767.74 BogoMIPS
Jul 30 16:19:48 musrum kernel: CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping
07
Jul 30 16:19:48 musrum kernel: Booting processor 2/3 eip 2000
Jul 30 16:19:48 musrum kernel: masked ExtINT on CPU#2
Jul 30 16:19:48 musrum kernel: ESR value before enabling vector: 00000000
Jul 30 16:19:48 musrum kernel: ESR value after enabling vector: 00000000
Jul 30 16:19:48 musrum kernel: Calibrating delay loop... 4767.74 BogoMIPS
Jul 30 16:19:48 musrum kernel: CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping
07
Jul 30 16:19:48 musrum kernel: WARNING: No sibling found for CPU 0.
Jul 30 16:19:48 musrum kernel: cpu_sibling_map[1] = 2
Jul 30 16:19:48 musrum kernel: cpu_sibling_map[2] = 1
Jul 30 16:19:48 musrum kernel: ENABLING IO-APIC IRQs
Jul 30 16:19:50 musrum kernel: Using local APIC timer interrupts.
Jul 30 16:19:51 musrum kernel: calibrating APIC timer ...
Jul 30 16:19:51 musrum kernel: ..... CPU clock speed is 2391.0569 MHz.
Jul 30 16:19:51 musrum kernel: ..... host bus clock speed is 132.0864 MHz.
Jul 30 16:19:51 musrum kernel: checking TSC synchronization across 3 CPUs:
passed.
Jul 30 16:19:51 musrum kernel: Starting migration thread for cpu 0
Jul 30 16:19:51 musrum kernel: Bringing up 1
Jul 30 16:19:51 musrum kernel: CPU 1 IS NOW UP!
Jul 30 16:19:51 musrum kernel: Starting migration thread for cpu 1
Jul 30 16:19:51 musrum kernel: Bringing up 2
Jul 30 16:19:51 musrum kernel: CPU 2 IS NOW UP!
Jul 30 16:19:51 musrum kernel: Starting migration thread for cpu 2
Jul 30 16:19:51 musrum kernel: CPUS done 8
