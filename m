Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280995AbRKCRft>; Sat, 3 Nov 2001 12:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280996AbRKCRfl>; Sat, 3 Nov 2001 12:35:41 -0500
Received: from [63.193.79.18] ([63.193.79.18]:13807 "HELO mwg.inxservices.lan")
	by vger.kernel.org with SMTP id <S280995AbRKCRfa>;
	Sat, 3 Nov 2001 12:35:30 -0500
Date: Sat, 3 Nov 2001 09:34:45 -0800
From: George Garvey <tmwg-linuxknl@inxservices.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-ac5 D-Link GigE and MSWin transfer timeout
Message-ID: <20011103093445.A857@inxservices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: inX Services, Los Angeles, CA, USA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


   Made a pure 2.4.13-ac5 kernel. Linux system is P3 Asus CUV4X-E with
D-Link DGE550T. MS is an old Compaq P with DGE500T. Switch is 3-Com
3C16468 (copper, unmanaged). Attached is various system information.
   Samba (2.2.2) is used to mount the MS drive on Linux, and to mount
the Linux drive on MS.
   Moving a file from Linux to MS on MS results in a timeout
immediately:
	NETDEV WATCHDOG: eth0: transmit timed out
	eth0: Transmit timed out, TxStatus 570080
	NETDEV WATCHDOG: eth0: transmit timed out
	eth0: Transmit timed out, TxStatus 0000
The last TXStatus of 0000 is repeated until reboot. The first status is
not always the same, although the ?70080 seems consistent.
   Moving a file from Linux to MS on Linux results in a timeout much
later, but the symptom is the same.
   Using 2.4.13-ac3 I can move the file on the Linux system to MS
without problems. Moving it using the MS system always results in an
immediate timeout. The 2.4.13-ac3 always has nVidia's driver loaded, and
has RML's latency patch. The 2.4.13-ac5 was made with no other patches,
and booted without X. The modules loaded in the system are attached.
Kernels compiled with 2.59.3, rest of system with 3.0.1. MTU is 1500.

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpuinfo.out"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 999.759
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1992.29


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="interrupts.out"

           CPU0       
  0:      48247          XT-PIC  timer
  1:       1268          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:         27          XT-PIC  rtc
 10:      18357          XT-PIC  eth0
 11:        796          XT-PIC  cmpci, usb-uhci, usb-uhci
 14:       4503          XT-PIC  ide0
 15:       4073          XT-PIC  ide1
NMI:          0 
LOC:      48190 
ERR:          0
MIS:          0

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lsmod.out"

Module                  Size  Used by
sr_mod                 11456   0  (autoclean) (unused)
usb-storage            41568   0  (unused)
sg                     22864   0  (unused)
ide-scsi                7392   0 
ide-cd                 26432   0 
cdrom                  29344   0  [sr_mod ide-cd]
scsi_mod               77520   3  [sr_mod usb-storage sg ide-scsi]

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.out"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
	Flags: bus master, medium devsel, latency 0
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: ee000000-efdfffff
	Prefetchable memory behind bridge: eff00000-f7ffffff
	Capabilities: [80] Power Management version 2

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Flags: bus master, stepping, medium devsel, latency 32
	I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2

00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Flags: medium devsel
	Capabilities: [68] Power Management version 2

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 11
	I/O ports at b800 [size=256]
	Capabilities: [c0] Power Management version 2

00:06.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
	Subsystem: US Robotics/3Com USR 56k Internal Voice Modem (Model 2976)
	Flags: medium devsel, IRQ 11
	I/O ports at b400 [size=8]
	Capabilities: [dc] Power Management version 2

00:09.0 Ethernet controller: D-Link System Inc: Unknown device 4000 (rev 07)
	Subsystem: D-Link System Inc: Unknown device 4000
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
	I/O ports at b000 [size=256]
	Memory at ed800000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2 GTS) (rev a3) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 5
	Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at efff0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
	Capabilities: [44] AGP version 2.0


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="meminfo.out"

        total:    used:    free:  shared: buffers:  cached:
Mem:  1053556736 143044608 910512128   143360 12038144 81121280
Swap: 2147467264        0 2147467264
MemTotal:      1028864 kB
MemFree:        889172 kB
MemShared:         140 kB
Buffers:         11756 kB
Cached:          79220 kB
SwapCached:          0 kB
Active:          76180 kB
Inact_dirty:     26552 kB
Inact_clean:         0 kB
Inact_target:   209696 kB
HighTotal:      130992 kB
HighFree:        24624 kB
LowTotal:       897872 kB
LowFree:        864548 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB

--45Z9DzgjV8m4Oswq
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--45Z9DzgjV8m4Oswq--
