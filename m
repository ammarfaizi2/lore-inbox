Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBOWvD>; Thu, 15 Feb 2001 17:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRBOWux>; Thu, 15 Feb 2001 17:50:53 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:33807 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129066AbRBOWuh>; Thu, 15 Feb 2001 17:50:37 -0500
Date: Thu, 15 Feb 2001 23:50:45 +0100
To: linux-kernel@vger.kernel.org
Cc: florian@void.s.bawue.de
Subject: 2.4.1,-ac9,-ac13: lockup after "now booting the kernel"
Message-ID: <20010215235045.A1332@void.s.bawue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Florian Laws <florian@void.s.bawue.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when trying to boot kernel 2.4.1, 2.4.1-ac9 or 2.4.1-ac13, 
I get lockups right after the message "now booting kernel".
Kernel 2.4.0-test10 ist booting ok on the machine.  

Rik van Riel suspected on #kernelnewbies this might be a bug in
the CPU detection routine.

The system in question has an Intel 430HX chipset (Gigabyte 586HX2 board), 
104 MB RAM und an AMD K6-III CPU, though the old BIOS detects is as an 
ordinary K6. 
Testing vanilla 2.4.1 with or withour MTRR support made no difference.

Snippets of .config, 2.4.0-test10 dmesg, and /proc/cpuinfo are included below.

Any ideas what might be wrong?

Thanks in advance,

Florian

P.S.: Please Cc me in replies, as I am not subscribed to linux-kernel.

--- .config ---
ONFIG_MK6=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
--- ------- ---

--- /proc/cpuinfo ---
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 9
model name      : AMD-K6(tm) 3D+ Processor
stepping        : 1
cpu MHz         : 400.916
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips        : 799.53
--- ------------- ---

--- dmesg ---
Linux version 2.4.0 (florian@void.s.bawue.de) (gcc version 2.95.2 20000220 (Debi
an GNU/Linux)) #1 Thu Jan 18 20:48:28 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000006700000 @ 0000000000100000 (usable)
On node 0 totalpages: 26624
zone(0): 4096 pages.
zone(1): 22528 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=1 ro root=303 BOOT_FILE=/boot/vmlinuz-2.4.0
Initializing CPU#0
Detected 400.916 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 102512k/106496k available (1009k kernel code, 3596k reserved, 382k data,
 196k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
Enabling new style K6 write allocation for 104 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
---------------------------------
