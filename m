Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUBKOT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUBKOT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:19:58 -0500
Received: from mxintern.kundenserver.de ([212.227.126.204]:52675 "EHLO
	mxintern.schlund.de") by vger.kernel.org with ESMTP id S265264AbUBKOTt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:19:49 -0500
Date: Wed, 11 Feb 2004 15:19:48 +0100
From: Anders Henke <anders@schlund.de>
To: linux-kernel@vger.kernel.org
Subject: problem booting into SMP with Compaq DL380 and 2.6.3-rc2
Message-ID: <20040211141948.GA20835@schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Organization: Schlund + Partner AG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm testing 2.6.3-rc2 on an Compaq DL380 (2xP3@733 MHz); when booting
the system in smp-mode, the kernel crashes upon booting when setting
up the CPUs. When passing "nosmp" to the kernel commandline, the system
boots up normally and works fine using that kernel. I previously tested
with 2.6.2-rc2 and 2.6.1, but all failed so far; as I haven't found an
articel on this problem on lkml earlier, I'm summing up my points in
this posting.

The system itself is somehow "out of support" from Compaq's point of view,
but running its latest BIOS release (P17 (12/18/2002)); the host is 
running with 2.4 kernels for years now; maybe it's a strange bug where
the BIOS forgets to setup something correctly and this didn't show up
with 2.4, but however it manages to show up on the 2.6 series now.

As the part which triggers BUG() (arch/i386/kernel/smpboot.c:1012) is
related to APIC initialization, I'm quoting the full bootup log with
all APIC information. Right before the trace occurs, the system notices
'weird, boot CPU (#15) not listed by the BIOS', so it may be related to
some BIOS issue. However, as 2.4 manages to setup both CPUs correctly,
this shouldn't be a problem for 2.6 :)

Please cc: replies, as I'm not a regular subscriber of lkml.

---cut
Linux version 2.6.3-rc2 (root@ista) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Wed Feb 11 14:12:14 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000004fffc000 (usable)
 BIOS-e820: 0000000000100000 - 000000004fffc000 (usable)                       
 BIOS-e820: 000000004fffc000 - 0000000050000000 (ACPI data)                    
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)                     
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)                     
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
383MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 327676
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 98300 pages, LIFO batch:16
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                    ) @ 0x000f4f90
ACPI: RSDT (v001 COMPAQ RACEBAIT 0x00000002 Ò* 0x0000162e) @ 0x4fffc000
ACPI: FADT (v001 COMPAQ MICRO    0x00000002 Ò* 0x0000162e) @ 0x4fffc040
ACPI: MADT (v001 COMPAQ 00000083 0x00000002  0x00000000) @ 0x4fffc100
ACPI: SSDT (v001 COMPAQ     SSDT 0x00000001 MSFT 0x0100000b) @ 0x4ffff800
ACPI: SPCR (v001 COMPAQ SPCR_ROM 0x00000001 Ò* 0x0000162e) @ 0x4fffc180
ACPI: DSDT (v001 COMPAQ     DSDT 0x00000001 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 255
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
Built 1 zonelists
Kernel command line: BOOT_IMAGE=lx ro root=4801 console=tty0 panic=30
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
ACPI:
LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 255
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
Built 1 zonelists
Kernel command line: BOOT_IMAGE=lx ro root=4801 console=tty0 panic=30
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 731.273 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 1293536k/1310704k available (1651k kernel code, 16008k reserved, 601k data, 308k init, 393200k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 261.63 BogoMIPS
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.56 usecs.
task migration cache decay timeout: 1 msecs.
weird, boot CPU (#15) not listed by the BIOS.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
------------[ cut here ]------------                                           
kernel BUG at arch/i386/kernel/smpboot.c:1012!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c033d548>]    Not tainted
EFLAGS: 00010293
EIP is at smp_boot_cpus+0x1a4/0x3c0
eax: 00000001   ebx: c1cf2000   ecx: c02f7624   edx: 00000000
esi: 00000000   edi: 00000000   ebp: 00000008   esp: c1cf3fbc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c1cf2000 task=f7f9f900)
Stack: c1cf2000 00000000 00000000 00000000 00000000 00000000 00000000 c033d76e
       00000008 c01050b9 00000008 c0105084 00000000 c0106ed1 00000000 00000000
       00000000
Call Trace:
 [<c033d76e>] smp_prepare_cpus+0xa/0x10
 [<c01050b9>] init+0x35/0x14c
 [<c0105084>] init+0x0/0x14c
 [<c0106ed1>] kernel_thread_helper+0x5/0xc
                                                                                
Code: 0f 0b f4 03 47 47 2a c0 be 01 00 00 00 31 db 3b 1d 20 71 2f
 <0>Kernel panic: Attempted to kill init!
---cut


Anders
-- 
Schlund + Partner AG              "Use the --force, Luke"
Brauerstrasse 48                  v://49.721.91374.50
D-76135 Karlsruhe                 f://49.721.91374.225
