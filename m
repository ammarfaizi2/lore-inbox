Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbTFBPgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTFBPgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:36:47 -0400
Received: from camus.xss.co.at ([194.152.162.19]:45317 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S262473AbTFBPgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:36:11 -0400
Message-ID: <3EDB7207.80300@xss.co.at>
Date: Mon, 02 Jun 2003 17:49:27 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21rc6-ac1
References: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
In-Reply-To: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040009050100010306060002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040009050100010306060002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Alan Cox wrote:
> Linux 2.4.21rc6-ac1
[...]

I found another system where the new ACPI code seems to
have problems: it's an Asus AP1700-S5 server with Asus
PR-DLS533 motherboard, ServerWorks Chipset (GCLE, CSB5
and CIOB-X2), single Xeon 2.4GHz processor (hyperthreaded),
and LSI fusion MPT controller on board.

When booting with ACPI enabled, the fusion driver can't
find the LSI devices, and they are not listed in /proc/pci
either.

When booting with "acpi=off", the system boots fine
from the fusion MPT device and it's also listed in /proc/pci
Also booting 2.4.21-rc4 (with old ACPI code) works fine.

After booting 2.4.21-rc6-ac1 with "acpi=off", I get the following
infos from the system:

root@setup:~ {515} $ lspci -v
00:00.0 Host bridge: ServerWorks CNB20-HE Host Bridge (rev 31)
        Flags: fast devsel

00:00.1 Host bridge: ServerWorks CNB20-HE Host Bridge
        Flags: fast devsel

00:00.2 Host bridge: ServerWorks CNB20-HE Host Bridge
        Flags: fast devsel

00:02.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
        Subsystem: Intel Corp. 82540EM Gigabit Ethernet Controller
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
        Memory at fd800000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at d800 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 8008
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 46
        Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at d400 [size=256]
        Memory at fb800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at febe0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
        Subsystem: ServerWorks CSB5 South Bridge
        Flags: bus master, medium devsel, latency 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 8a [Master SecP PriP])
        Subsystem: ServerWorks CSB5 IDE Controller
        Flags: bus master, medium devsel, latency 64
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at a800 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at fb000000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
        Subsystem: ServerWorks: Unknown device 0230
        Flags: bus master, medium devsel, latency 0

00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
        Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 22
        I/O ports at a000 [size=256]
        Memory at fa000000 (64-bit, non-prefetchable) [size=64K]
        Memory at f9800000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fe900000 [disabled] [size=1M]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [68]
02:04.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
        Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 23
        I/O ports at 9800 [size=256]
        Memory at f9000000 (64-bit, non-prefetchable) [size=64K]
        Memory at f8800000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fe800000 [disabled] [size=1M]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [68]
03:02.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet Controller (LOM) (rev 02)
        Subsystem: Intel Corp.: Unknown device 110d
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
        Memory at f8000000 (64-bit, non-prefetchable) [size=128K]
        Memory at f7800000 (64-bit, non-prefetchable) [size=128K]
        I/O ports at 9400 [size=32]
        Expansion ROM at fe7e0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

root@setup:~ {516} $ cat /proc/interrupts
           CPU0       CPU1
  0:      82918      84043    IO-APIC-edge  timer
  1:          1          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:          8         12    IO-APIC-edge  serial
 15:          1          1    IO-APIC-edge  ide1
 18:       1312       1292   IO-APIC-level  eth0
 22:     336561     341911   IO-APIC-level  ioc0
 23:         24         18   IO-APIC-level  ioc1
NMI:          0          0
LOC:      66734      66733
ERR:          0
MIS:          0

root@setup:~ {517} $ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2392.123
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4771.02

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2392.123
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4771.02

root@setup:~ {518} $ lsmod
Module                  Size  Used by    Not tainted
nfsd                   67696   8  (autoclean)
nfs                    69784   1  (autoclean)
lockd                  47984   1  (autoclean) [nfsd nfs]
sunrpc                 65596   1  (autoclean) [nfsd nfs lockd]
e1000                  50028   1  (autoclean)
softdog                 1692   1  (autoclean)
serverworks             7736   1
ext3                   61924   2  (autoclean)
jbd                    40152   2  (autoclean) [ext3]
raid5                  17704   1  (autoclean)
md                     57440   2  (autoclean) [raid5]
xor                     8884   0  (autoclean) [raid5]
sd_mod                 10844  18  (autoclean)
isense                 32436   0  (autoclean) (unused)
mptctl                 19116   0  (autoclean) (unused)
mptscsih               29696   9  (autoclean)
mptbase                32640   5  (autoclean) [isense mptctl mptscsih]
unix                   15664  29  (autoclean)
ext2                   34176   4  (autoclean)
scsi_mod               96068   2  (autoclean) [sd_mod mptscsih]

Please find kernel boot messages in attached file.

Any ideas?

- - andreas

PS: Another strange thing I noticed on this system: system time
is running about 3 times faster than wall clock time: after 10
minutes of wall clock uptime, the system reports an uptime of
30 minutes (I mean, I find it sometimes hard even to follow real
world speed, but this really feels like Dark Helmet asking for
"Ludicrous Speed"! This is too much, if you ask me... ;-)

PPS: Fusion MPT description in Configure.help states that in
order to boot from a SCSI device attached to a Fusion MPT
controller, you have to compile the device driver into the
kernel. This is only half of the truth: it works perfectly
with MPT driver compiled as modules, as long as you use an
initial ramdisk and load all modules needed to access the
boot device there (just like every sane person does).
This comment in Configure.help is quite misleading...

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+23IExJmyeGcXPhERAkwDAJ9fLr1VnN7nuI0bpaAl+brE82SsQQCeIGCs
7sVubfzTGvRxelQrreMwsgI=
=lLtK
-----END PGP SIGNATURE-----

--------------040009050100010306060002
Content-Type: text/plain;
 name="dmesg.ap1700s5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.ap1700s5"

Jun  2 17:36:23 setup syslogd 1.3-3: restart.
Jun  2 17:36:23 setup kernel: klogd 1.3-3, log source = /proc/kmsg started.
Jun  2 17:36:23 setup kernel: Inspecting /boot/System.map-2.4.21-rc6-ac1
Jun  2 17:36:23 setup kernel: Loaded 17821 symbols from /boot/System.map-2.4.21-rc6-ac1.
Jun  2 17:36:23 setup kernel: Symbols match kernel version 2.4.21.
Jun  2 17:36:23 setup kernel: Loaded 195 symbols from 16 modules.
Jun  2 17:36:23 setup kernel: Linux version 2.4.21-rc6-ac1 (root@install) (gcc version 2.95.3 20010315 (release)) #1 SMP Sat May 31 20:04:18 CEST 2003
Jun  2 17:36:23 setup kernel: BIOS-provided physical RAM map:
Jun  2 17:36:23 setup kernel:  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
Jun  2 17:36:23 setup kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
Jun  2 17:36:23 setup kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jun  2 17:36:23 setup kernel:  BIOS-e820: 0000000000100000 - 000000001fffa000 (usable)
Jun  2 17:36:23 setup kernel:  BIOS-e820: 000000001fffa000 - 000000001ffff000 (ACPI data)
Jun  2 17:36:23 setup kernel:  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
Jun  2 17:36:23 setup kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Jun  2 17:36:23 setup kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jun  2 17:36:23 setup kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Jun  2 17:36:23 setup kernel: 0MB HIGHMEM available.
Jun  2 17:36:23 setup kernel: 511MB LOWMEM available.
Jun  2 17:36:23 setup kernel: ACPI: have wakeup address 0xc0002000
Jun  2 17:36:23 setup kernel: found SMP MP-table at 000f0490
Jun  2 17:36:23 setup kernel: hm, page 000f0000 reserved twice.
Jun  2 17:36:23 setup kernel: hm, page 000f1000 reserved twice.
Jun  2 17:36:23 setup kernel: hm, page 000f0000 reserved twice.
Jun  2 17:36:23 setup kernel: hm, page 000f1000 reserved twice.
Jun  2 17:36:23 setup kernel: On node 0 totalpages: 131066
Jun  2 17:36:23 setup kernel: zone(0): 4096 pages.
Jun  2 17:36:23 setup kernel: zone(1): 126970 pages.
Jun  2 17:36:23 setup kernel: zone(2): 0 pages.
Jun  2 17:36:23 setup kernel: Intel MultiProcessor Specification v1.4
Jun  2 17:36:23 setup kernel:     Virtual Wire compatibility mode.
Jun  2 17:36:23 setup kernel: OEM ID: ASUS     Product ID: PROD00000000 APIC at: 0xFEE00000
Jun  2 17:36:23 setup kernel: Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
Jun  2 17:36:23 setup kernel: Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
Jun  2 17:36:23 setup kernel: I/O APIC #8 Version 17 at 0xFEC00000.
Jun  2 17:36:23 setup kernel: I/O APIC #9 Version 17 at 0xFEC01000.
Jun  2 17:36:23 setup kernel: I/O APIC #10 Version 17 at 0xFEC02000.
Jun  2 17:36:23 setup kernel: Processors: 2
Jun  2 17:36:23 setup kernel: xAPIC support is present
Jun  2 17:36:23 setup kernel: Enabling APIC mode: Flat.^IUsing 3 I/O APICs
Jun  2 17:36:23 setup kernel: Kernel command line: auto BOOT_IMAGE=lx2421rc6ac1 ro root=100 acpi=off
Jun  2 17:36:23 setup kernel: Initializing CPU#0
Jun  2 17:36:23 setup kernel: Detected 2398.857 MHz processor.
Jun  2 17:36:23 setup kernel: Console: colour VGA+ 80x50
Jun  2 17:36:23 setup kernel: Calibrating delay loop... 4771.02 BogoMIPS
Jun  2 17:36:23 setup kernel: Memory: 514868k/524264k available (1113k kernel code, 9008k reserved, 503k data, 112k init, 0k highmem)
Jun  2 17:36:23 setup kernel: Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Jun  2 17:36:23 setup kernel: Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Jun  2 17:36:23 setup kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Jun  2 17:36:23 setup kernel: Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Jun  2 17:36:23 setup kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Jun  2 17:36:23 setup kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jun  2 17:36:23 setup kernel: CPU: L2 cache: 512K
Jun  2 17:36:23 setup kernel: CPU: Physical Processor ID: 0
Jun  2 17:36:23 setup kernel: Intel machine check architecture supported.
Jun  2 17:36:23 setup kernel: Intel machine check reporting enabled on CPU#0.
Jun  2 17:36:23 setup kernel: CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
Jun  2 17:36:23 setup kernel: CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Jun  2 17:36:23 setup kernel: Enabling fast FPU save and restore... done.
Jun  2 17:36:23 setup kernel: Enabling unmasked SIMD FPU exception support... done.
Jun  2 17:36:23 setup kernel: Checking 'hlt' instruction... OK.
Jun  2 17:36:23 setup kernel: POSIX conformance testing by UNIFIX
Jun  2 17:36:23 setup kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Jun  2 17:36:23 setup kernel: mtrr: detected mtrr type: Intel
Jun  2 17:36:23 setup kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jun  2 17:36:23 setup kernel: CPU: L2 cache: 512K
Jun  2 17:36:23 setup kernel: CPU: Physical Processor ID: 0
Jun  2 17:36:23 setup kernel: Intel machine check reporting enabled on CPU#0.
Jun  2 17:36:23 setup kernel: CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
Jun  2 17:36:23 setup kernel: CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Jun  2 17:36:23 setup kernel: CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Jun  2 17:36:23 setup kernel: per-CPU timeslice cutoff: 1462.98 usecs.
Jun  2 17:36:23 setup kernel: task migration cache decay timeout: 10 msecs.
Jun  2 17:36:23 setup kernel: enabled ExtINT on CPU#0
Jun  2 17:36:23 setup kernel: ESR value before enabling vector: 00000000
Jun  2 17:36:23 setup kernel: ESR value after enabling vector: 00000000
Jun  2 17:36:23 setup kernel: Booting processor 1/1 eip 3000
Jun  2 17:36:23 setup kernel: Initializing CPU#1
Jun  2 17:36:23 setup kernel: masked ExtINT on CPU#1
Jun  2 17:36:23 setup kernel: ESR value before enabling vector: 00000000
Jun  2 17:36:23 setup kernel: ESR value after enabling vector: 00000000
Jun  2 17:36:23 setup kernel: Calibrating delay loop... 4771.02 BogoMIPS
Jun  2 17:36:23 setup kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jun  2 17:36:23 setup kernel: CPU: L2 cache: 512K
Jun  2 17:36:23 setup kernel: CPU: Physical Processor ID: 0
Jun  2 17:36:23 setup kernel: Intel machine check reporting enabled on CPU#1.
Jun  2 17:36:23 setup kernel: CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
Jun  2 17:36:23 setup kernel: CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Jun  2 17:36:23 setup kernel: CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Jun  2 17:36:23 setup kernel: Total of 2 processors activated (9542.04 BogoMIPS).
Jun  2 17:36:23 setup kernel: cpu_sibling_map[0] = 1
Jun  2 17:36:23 setup kernel: cpu_sibling_map[1] = 0
Jun  2 17:36:23 setup kernel: ENABLING IO-APIC IRQs
Jun  2 17:36:23 setup kernel: Setting 8 in the phys_id_present_map
Jun  2 17:36:23 setup kernel: ...changing IO-APIC physical APIC ID to 8 ... ok.
Jun  2 17:36:23 setup kernel: Setting 9 in the phys_id_present_map
Jun  2 17:36:23 setup kernel: ...changing IO-APIC physical APIC ID to 9 ... ok.
Jun  2 17:36:23 setup kernel: Setting 10 in the phys_id_present_map
Jun  2 17:36:23 setup kernel: ...changing IO-APIC physical APIC ID to 10 ... ok.
Jun  2 17:36:23 setup kernel: init IO_APIC IRQs
Jun  2 17:36:23 setup kernel:  IO-APIC (apicid-pin) 8-0, 8-5, 8-9, 8-10, 8-12, 9-0, 9-1, 9-4, 9-5, 9-8, 9-9, 9-10, 9-11, 9-12, 9-13, 9-14, 9-15, 10-0, 10-1, 10-2, 10-3, 10-4, 10-5, 10-6, 10-7, 10-8, 10-9, 10-10, 10-11, 10-12, 10-13, 10-15 not connected.
Jun  2 17:36:23 setup kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Jun  2 17:36:23 setup kernel: number of MP IRQ sources: 17.
Jun  2 17:36:23 setup kernel: number of IO-APIC #8 registers: 16.
Jun  2 17:36:23 setup kernel: number of IO-APIC #9 registers: 16.
Jun  2 17:36:23 setup kernel: number of IO-APIC #10 registers: 16.
Jun  2 17:36:23 setup kernel: testing the IO APIC.......................
Jun  2 17:36:23 setup kernel:
Jun  2 17:36:23 setup kernel: IO APIC #8......
Jun  2 17:36:23 setup kernel: .... register #00: 08000000
Jun  2 17:36:23 setup kernel: .......    : physical APIC id: 08
Jun  2 17:36:23 setup kernel: .......    : Delivery Type: 0
Jun  2 17:36:23 setup kernel: .......    : LTS          : 0
Jun  2 17:36:23 setup kernel: .... register #01: 000F0011
Jun  2 17:36:23 setup kernel: .......     : max redirection entries: 000F
Jun  2 17:36:23 setup kernel: .......     : PRQ implemented: 0
Jun  2 17:36:23 setup kernel: .......     : IO APIC version: 0011
Jun  2 17:36:23 setup kernel: .... register #02: 08000000
Jun  2 17:36:23 setup kernel: .......     : arbitration: 08
Jun  2 17:36:23 setup kernel: .... IRQ redirection table:
Jun  2 17:36:23 setup kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Jun  2 17:36:23 setup kernel:  00 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  01 0FF 0F  0    0    0   0   0    1    1    39
Jun  2 17:36:23 setup kernel:  02 002 02  0    0    0   0   0    1    1    31
Jun  2 17:36:23 setup kernel:  03 0FF 0F  0    0    0   0   0    1    1    41
Jun  2 17:36:23 setup kernel:  04 0FF 0F  0    0    0   0   0    1    1    49
Jun  2 17:36:23 setup kernel:  05 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  06 0FF 0F  0    0    0   0   0    1    1    51
Jun  2 17:36:23 setup kernel:  07 0FF 0F  0    0    0   0   0    1    1    59
Jun  2 17:36:23 setup kernel:  08 0FF 0F  0    0    0   0   0    1    1    61
Jun  2 17:36:23 setup kernel:  09 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0a 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0b 0FF 0F  1    1    0   1   0    1    1    69
Jun  2 17:36:23 setup kernel:  0c 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0d 0FF 0F  0    0    0   0   0    1    1    71
Jun  2 17:36:23 setup kernel:  0e 0FF 0F  0    0    0   0   0    1    1    79
Jun  2 17:36:23 setup kernel:  0f 0FF 0F  0    0    0   0   0    1    1    81
Jun  2 17:36:23 setup kernel:
Jun  2 17:36:23 setup kernel: IO APIC #9......
Jun  2 17:36:23 setup kernel: .... register #00: 09000000
Jun  2 17:36:23 setup kernel: .......    : physical APIC id: 09
Jun  2 17:36:23 setup kernel: .......    : Delivery Type: 0
Jun  2 17:36:23 setup kernel: .......    : LTS          : 0
Jun  2 17:36:23 setup kernel: .... register #01: 000F0011
Jun  2 17:36:23 setup kernel: .......     : max redirection entries: 000F
Jun  2 17:36:23 setup kernel: .......     : PRQ implemented: 0
Jun  2 17:36:23 setup kernel: .......     : IO APIC version: 0011
Jun  2 17:36:23 setup kernel: .... register #02: 09000000
Jun  2 17:36:23 setup kernel: .......     : arbitration: 09
Jun  2 17:36:23 setup kernel: .... IRQ redirection table:
Jun  2 17:36:23 setup kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Jun  2 17:36:23 setup kernel:  00 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  01 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  02 0FF 0F  1    1    0   1   0    1    1    89
Jun  2 17:36:23 setup kernel:  03 0FF 0F  1    1    0   1   0    1    1    91
Jun  2 17:36:23 setup kernel:  04 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  05 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  06 0FF 0F  1    1    0   1   0    1    1    99
Jun  2 17:36:23 setup kernel:  07 0FF 0F  1    1    0   1   0    1    1    A1
Jun  2 17:36:23 setup kernel:  08 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  09 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0a 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0b 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0c 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0d 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0e 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0f 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:
Jun  2 17:36:23 setup kernel: IO APIC #10......
Jun  2 17:36:23 setup kernel: .... register #00: 0A000000
Jun  2 17:36:23 setup kernel: .......    : physical APIC id: 0A
Jun  2 17:36:23 setup kernel: .......    : Delivery Type: 0
Jun  2 17:36:23 setup kernel: .......    : LTS          : 0
Jun  2 17:36:23 setup kernel: .... register #01: 000F0011
Jun  2 17:36:23 setup kernel: .......     : max redirection entries: 000F
Jun  2 17:36:23 setup kernel: .......     : PRQ implemented: 0
Jun  2 17:36:23 setup kernel: .......     : IO APIC version: 0011
Jun  2 17:36:23 setup kernel: .... register #02: 0A000000
Jun  2 17:36:23 setup kernel: .......     : arbitration: 0A
Jun  2 17:36:23 setup kernel: .... IRQ redirection table:
Jun  2 17:36:23 setup kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Jun  2 17:36:23 setup kernel:  00 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  01 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  02 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  03 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  04 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  05 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  06 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  07 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  08 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  09 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0a 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0b 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0c 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0d 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel:  0e 0FF 0F  1    1    0   1   0    1    1    A9
Jun  2 17:36:23 setup kernel:  0f 000 00  1    0    0   0   0    0    0    00
Jun  2 17:36:23 setup kernel: IRQ to pin mappings:
Jun  2 17:36:23 setup kernel: IRQ0 -> 0:2
Jun  2 17:36:23 setup kernel: IRQ1 -> 0:1
Jun  2 17:36:23 setup kernel: IRQ3 -> 0:3
Jun  2 17:36:23 setup kernel: IRQ4 -> 0:4
Jun  2 17:36:23 setup kernel: IRQ6 -> 0:6
Jun  2 17:36:23 setup kernel: IRQ7 -> 0:7
Jun  2 17:36:23 setup kernel: IRQ8 -> 0:8
Jun  2 17:36:23 setup kernel: IRQ11 -> 0:11
Jun  2 17:36:23 setup kernel: IRQ13 -> 0:13
Jun  2 17:36:23 setup kernel: IRQ14 -> 0:14
Jun  2 17:36:23 setup kernel: IRQ15 -> 0:15
Jun  2 17:36:23 setup kernel: IRQ18 -> 1:2
Jun  2 17:36:23 setup kernel: IRQ19 -> 1:3
Jun  2 17:36:23 setup kernel: IRQ22 -> 1:6
Jun  2 17:36:23 setup kernel: IRQ23 -> 1:7
Jun  2 17:36:23 setup kernel: IRQ46 -> 2:14
Jun  2 17:36:23 setup kernel: .................................... done.
Jun  2 17:36:23 setup kernel: Using local APIC timer interrupts.
Jun  2 17:36:23 setup kernel: calibrating APIC timer ...
Jun  2 17:36:23 setup kernel: ..... CPU clock speed is 2392.1233 MHz.
Jun  2 17:36:23 setup kernel: ..... host bus clock speed is 132.8955 MHz.
Jun  2 17:36:23 setup kernel: cpu: 0, clocks: 1328955, slice: 442985
Jun  2 17:36:23 setup kernel: CPU0<T0:1328944,T1:885952,D:7,S:442985,C:1328955>
Jun  2 17:36:23 setup kernel: cpu: 1, clocks: 1328955, slice: 442985
Jun  2 17:36:23 setup kernel: CPU1<T0:1328944,T1:442960,D:14,S:442985,C:1328955>
Jun  2 17:36:23 setup kernel: migration_task 0 on cpu=0
Jun  2 17:36:23 setup kernel: migration_task 1 on cpu=1
Jun  2 17:36:23 setup kernel: ACPI: Subsystem revision 20030522
Jun  2 17:36:23 setup kernel: ACPI: Disabled via command line (acpi=off)
Jun  2 17:36:23 setup kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1520, last bus=4
Jun  2 17:36:23 setup kernel: PCI: Using configuration type 1
Jun  2 17:36:23 setup kernel: PCI: Probing PCI hardware
Jun  2 17:36:23 setup kernel: PCI: ACPI tables contain no PCI IRQ routing entries
Jun  2 17:36:23 setup kernel: PCI: Probing PCI hardware (bus 00)
Jun  2 17:36:23 setup kernel: PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
Jun  2 17:36:23 setup kernel: PCI: Discovered primary peer bus 01 [IRQ]
Jun  2 17:36:23 setup kernel: PCI: Discovered primary peer bus 02 [IRQ]
Jun  2 17:36:23 setup kernel: PCI: Discovered primary peer bus 03 [IRQ]
Jun  2 17:36:23 setup kernel: PCI: Discovered primary peer bus 04 [IRQ]
Jun  2 17:36:23 setup kernel: PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
Jun  2 17:36:23 setup kernel: PCI->APIC IRQ transform: (B0,I2,P0) -> 18
Jun  2 17:36:23 setup kernel: PCI->APIC IRQ transform: (B0,I3,P0) -> 46
Jun  2 17:36:23 setup kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 11
Jun  2 17:36:23 setup kernel: PCI->APIC IRQ transform: (B2,I4,P0) -> 22
Jun  2 17:36:23 setup kernel: PCI->APIC IRQ transform: (B2,I4,P1) -> 23
Jun  2 17:36:23 setup kernel: PCI->APIC IRQ transform: (B3,I2,P0) -> 19
Jun  2 17:36:23 setup kernel: Linux NET4.0 for Linux 2.4
Jun  2 17:36:23 setup kernel: Based upon Swansea University Computer Society NET3.039
Jun  2 17:36:23 setup kernel: Initializing RT netlink socket
Jun  2 17:36:23 setup kernel: Starting kswapd
Jun  2 17:36:23 setup kernel: VFS: Disk quotas vdquot_6.5.1
Jun  2 17:36:23 setup kernel: devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
Jun  2 17:36:23 setup kernel: devfs: boot_options: 0x1
Jun  2 17:36:23 setup kernel: Detected PS/2 Mouse Port.
Jun  2 17:36:23 setup kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
Jun  2 17:36:23 setup kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jun  2 17:36:23 setup kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Jun  2 17:36:23 setup kernel: NET4: Frame Diverter 0.46
Jun  2 17:36:23 setup kernel: keyboard: Timeout - AT keyboard not present?(ed)
Jun  2 17:36:23 setup kernel: keyboard: Timeout - AT keyboard not present?(f4)
Jun  2 17:36:23 setup kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Jun  2 17:36:23 setup kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
Jun  2 17:36:23 setup kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun  2 17:36:23 setup kernel: hdc: ASUS CD-S520/A, ATAPI CD/DVD-ROM drive
Jun  2 17:36:23 setup kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun  2 17:36:23 setup kernel: IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
Jun  2 17:36:23 setup kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jun  2 17:36:23 setup kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Jun  2 17:36:23 setup kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Jun  2 17:36:23 setup kernel: TCP: Hash tables configured (established 32768 bind 32768)
Jun  2 17:36:23 setup kernel: Linux IP multicast router 0.06 plus PIM-SM
Jun  2 17:36:23 setup kernel: RAMDISK: Compressed image found at block 0
Jun  2 17:36:29 setup kernel: Freeing initrd memory: 551k freed
Jun  2 17:36:29 setup kernel: VFS: Mounted root (romfs filesystem) readonly.
Jun  2 17:36:29 setup kernel: Mounted devfs on /dev
Jun  2 17:36:29 setup kernel: Freeing unused kernel memory: 112k freed
Jun  2 17:36:29 setup kernel: inserting floppy driver for 2.4.21-rc6-ac1
Jun  2 17:36:29 setup kernel: Floppy drive(s): fd0 is 1.44M
Jun  2 17:36:29 setup kernel: FDC 0 is a National Semiconductor PC87306
Jun  2 17:36:29 setup kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Jun  2 17:36:29 setup kernel: Fusion MPT base driver 2.05.00+
Jun  2 17:36:29 setup kernel: Copyright (c) 1999-2002 LSI Logic Corporation
Jun  2 17:36:29 setup kernel: mptbase: Initiating ioc0 bringup
Jun  2 17:36:29 setup kernel: ioc0: 53C1030: Capabilities={Initiator}
Jun  2 17:36:29 setup kernel: mptbase: Initiating ioc1 bringup
Jun  2 17:36:29 setup kernel: ioc1: 53C1030: Capabilities={Initiator}
Jun  2 17:36:29 setup kernel: mptbase: 2 MPT adapters found, 2 installed.
Jun  2 17:36:29 setup kernel: Fusion MPT SCSI Host driver 2.05.00+
Jun  2 17:36:29 setup kernel: scsi0 : ioc0: LSI53C1030, FwRev=01012e00h, Ports=1, MaxQ=255, IRQ=22
Jun  2 17:36:29 setup kernel: scsi1 : ioc1: LSI53C1030, FwRev=01012e00h, Ports=1, MaxQ=255, IRQ=23
Jun  2 17:36:29 setup kernel: blk: queue c1674a18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
Jun  2 17:36:29 setup kernel:   Vendor: QUANTUM   Model: ATLAS10K3_18_SCA  Rev: 020K
Jun  2 17:36:29 setup kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jun  2 17:36:29 setup kernel: blk: queue c1674818, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
Jun  2 17:36:29 setup kernel:   Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S23C
Jun  2 17:36:29 setup kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jun  2 17:36:29 setup kernel: blk: queue c1674618, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
Jun  2 17:36:29 setup kernel:   Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S23C
Jun  2 17:36:29 setup kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jun  2 17:36:29 setup kernel: blk: queue c1674418, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
Jun  2 17:36:29 setup kernel:   Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S23C
Jun  2 17:36:29 setup kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jun  2 17:36:29 setup kernel: blk: queue c1674218, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
Jun  2 17:36:29 setup kernel:   Vendor: SDR       Model: GEM318            Rev: 0
Jun  2 17:36:29 setup kernel:   Type:   Processor                          ANSI SCSI revision: 02
Jun  2 17:36:29 setup kernel: blk: queue c1674018, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
Jun  2 17:36:29 setup kernel: Fusion MPT misc device (ioctl) driver 2.05.00+
Jun  2 17:36:29 setup kernel: mptctl: Registered with Fusion MPT base driver
Jun  2 17:36:29 setup kernel: mptctl: /dev/mptctl @ (major,minor=10,220)
Jun  2 17:36:29 setup kernel: SCSI-3 Opcodes & ASC/ASCQ Strings 2.05.00+
Jun  2 17:36:29 setup kernel: mptbase: English readable SCSI-3 strings enabled:-)
Jun  2 17:36:29 setup kernel: isense: Registered SCSI-3 Opcodes & ASC/ASCQ Strings
Jun  2 17:36:29 setup kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Jun  2 17:36:29 setup kernel: Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Jun  2 17:36:29 setup kernel: Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Jun  2 17:36:29 setup kernel: Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
Jun  2 17:36:29 setup kernel: SCSI device sda: 35916548 512-byte hdwr sectors (18389 MB)
Jun  2 17:36:29 setup kernel: Partition check:
Jun  2 17:36:29 setup kernel:  /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
Jun  2 17:36:29 setup kernel: SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
Jun  2 17:36:29 setup kernel:  /dev/scsi/host0/bus0/target1/lun0: p1
Jun  2 17:36:29 setup kernel: SCSI device sdc: 71687340 512-byte hdwr sectors (36704 MB)
Jun  2 17:36:29 setup kernel:  /dev/scsi/host0/bus0/target2/lun0: p1
Jun  2 17:36:29 setup kernel: SCSI device sdd: 71687340 512-byte hdwr sectors (36704 MB)
Jun  2 17:36:29 setup kernel:  /dev/scsi/host0/bus0/target3/lun0: p1
Jun  2 17:36:29 setup kernel: Adding Swap: 1953768k swap-space (priority -1)
Jun  2 17:36:29 setup kernel: raid5: measuring checksumming speed
Jun  2 17:36:29 setup kernel:    8regs     :  1061.600 MB/sec
Jun  2 17:36:29 setup kernel:    32regs    :   770.000 MB/sec
Jun  2 17:36:29 setup kernel:    pIII_sse  :  1194.400 MB/sec
Jun  2 17:36:29 setup kernel:    pII_mmx   :  1066.000 MB/sec
Jun  2 17:36:29 setup kernel:    p5_mmx    :  1063.200 MB/sec
Jun  2 17:36:29 setup kernel: raid5: using function: pIII_sse (1194.400 MB/sec)
Jun  2 17:36:29 setup kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jun  2 17:36:29 setup kernel: md: raid5 personality registered as nr 4
Jun  2 17:36:29 setup kernel:  [events: 00000005]
Jun  2 17:36:29 setup last message repeated 2 times
Jun  2 17:36:29 setup kernel: md: autorun ...
Jun  2 17:36:29 setup kernel: md: considering scsi/host0/bus0/target3/lun0/part1 ...
Jun  2 17:36:29 setup kernel: md:  adding scsi/host0/bus0/target3/lun0/part1 ...
Jun  2 17:36:29 setup kernel: md:  adding scsi/host0/bus0/target2/lun0/part1 ...
Jun  2 17:36:29 setup kernel: md:  adding scsi/host0/bus0/target1/lun0/part1 ...
Jun  2 17:36:29 setup kernel: md: created md0
Jun  2 17:36:29 setup kernel: md: bind<scsi/host0/bus0/target1/lun0/part1,1>
Jun  2 17:36:29 setup kernel: md: bind<scsi/host0/bus0/target2/lun0/part1,2>
Jun  2 17:36:29 setup kernel: md: bind<scsi/host0/bus0/target3/lun0/part1,3>
Jun  2 17:36:29 setup kernel: md: running: <scsi/host0/bus0/target3/lun0/part1><scsi/host0/bus0/target2/lun0/part1><scsi/host0/bus0/target1/lun0/part1>
Jun  2 17:36:29 setup kernel: md: scsi/host0/bus0/target3/lun0/part1's event counter: 00000005
Jun  2 17:36:29 setup kernel: md: scsi/host0/bus0/target2/lun0/part1's event counter: 00000005
Jun  2 17:36:29 setup kernel: md: scsi/host0/bus0/target1/lun0/part1's event counter: 00000005
Jun  2 17:36:29 setup kernel: md0: max total readahead window set to 496k
Jun  2 17:36:29 setup kernel: md0: 2 data-disks, max readahead per data-disk: 248k
Jun  2 17:36:29 setup kernel: raid5: device scsi/host0/bus0/target3/lun0/part1 operational as raid disk 2
Jun  2 17:36:29 setup kernel: raid5: device scsi/host0/bus0/target2/lun0/part1 operational as raid disk 1
Jun  2 17:36:29 setup kernel: raid5: device scsi/host0/bus0/target1/lun0/part1 operational as raid disk 0
Jun  2 17:36:29 setup kernel: raid5: allocated 3291kB for md0
Jun  2 17:36:29 setup kernel: raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
Jun  2 17:36:29 setup kernel: RAID5 conf printout:
Jun  2 17:36:29 setup kernel:  --- rd:3 wd:3 fd:0
Jun  2 17:36:29 setup kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:scsi/host0/bus0/target1/lun0/part1
Jun  2 17:36:29 setup kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:scsi/host0/bus0/target2/lun0/part1
Jun  2 17:36:29 setup kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 dev:scsi/host0/bus0/target3/lun0/part1
Jun  2 17:36:29 setup kernel: RAID5 conf printout:
Jun  2 17:36:29 setup kernel:  --- rd:3 wd:3 fd:0
Jun  2 17:36:29 setup kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:scsi/host0/bus0/target1/lun0/part1
Jun  2 17:36:29 setup kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:scsi/host0/bus0/target2/lun0/part1
Jun  2 17:36:29 setup kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 dev:scsi/host0/bus0/target3/lun0/part1
Jun  2 17:36:29 setup kernel: md: updating md0 RAID superblock on device
Jun  2 17:36:29 setup kernel: md: scsi/host0/bus0/target3/lun0/part1 [events: 00000006]<6>(write) scsi/host0/bus0/target3/lun0/part1's sb offset: 35840896
Jun  2 17:36:29 setup kernel: md: scsi/host0/bus0/target2/lun0/part1 [events: 00000006]<6>(write) scsi/host0/bus0/target2/lun0/part1's sb offset: 35840896
Jun  2 17:36:29 setup kernel: md: scsi/host0/bus0/target1/lun0/part1 [events: 00000006]<6>(write) scsi/host0/bus0/target1/lun0/part1's sb offset: 35840896
Jun  2 17:36:29 setup kernel: md: ... autorun DONE.
Jun  2 17:36:29 setup kernel: raid5: switching cache buffer size, 4096 --> 1024
Jun  2 17:36:29 setup kernel: Journalled Block Device driver loaded
Jun  2 17:36:29 setup kernel: kjournald starting.  Commit interval 5 seconds
Jun  2 17:36:29 setup kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,7), internal journal
Jun  2 17:36:29 setup kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun  2 17:36:29 setup kernel: raid5: switching cache buffer size, 1024 --> 4096
Jun  2 17:36:29 setup kernel: kjournald starting.  Commit interval 5 seconds
Jun  2 17:36:29 setup kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,0), internal journal
Jun  2 17:36:29 setup kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun  2 17:36:29 setup kernel: SvrWks CSB5: IDE controller at PCI slot 00:0f.1
Jun  2 17:36:29 setup kernel: SvrWks CSB5: chipset revision 147
Jun  2 17:36:29 setup kernel: SvrWks CSB5: not 100% native mode: will probe irqs later
Jun  2 17:36:29 setup kernel:     ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:pio, hdb:pio
Jun  2 17:36:29 setup kernel:     ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:pio
Jun  2 17:36:29 setup kernel: Software Watchdog Timer: 0.05, timer margin: 60 sec
Jun  2 17:36:29 setup kernel: Intel(R) PRO/1000 Network Driver - version 5.0.43-k1
Jun  2 17:36:29 setup kernel: Copyright (c) 1999-2003 Intel Corporation.
Jun  2 17:36:29 setup kernel: divert: allocating divert_blk for eth0
Jun  2 17:36:29 setup kernel: eth0: Intel(R) PRO/1000 Network Connection
Jun  2 17:36:29 setup kernel: divert: allocating divert_blk for eth1
Jun  2 17:36:29 setup kernel: eth1: Intel(R) PRO/1000 Network Connection
Jun  2 17:36:29 setup kernel: e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
Jun  2 17:36:32 setup kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).


--------------040009050100010306060002--

