Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUJDUGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUJDUGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 16:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268282AbUJDUGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 16:06:39 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:51587 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268260AbUJDUGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 16:06:32 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.9-rc3-mm[12]: x86-64-clustered-apic-support.patch problem
Date: Mon, 4 Oct 2004 22:09:02 +0200
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410042209.02303.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The patch x86-64-clustered-apic-support.patch causes the 2.6.9-rc3-mm[12] 
kernel to crash at startup on a single-CPU AMD64 box :

Bootdata ok (command line is root=/dev/hdc6 vga=792 resume=/dev/hdc3 
pci=routeirq nmi_watchdog=0 console=ttyS0,57600)
Linux version 2.6.9-rc3-mm2 (rafael@albercik) (gcc version 3.3.3 (SuSE Linux)) 
#3 Mon Oct 4 20:48:34 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff40000 (usable)
 BIOS-e820: 000000001ff40000 - 000000001ff50000 (ACPI data)
 BIOS-e820: 000000001ff50000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
No mptable found.
PCI bridge 00:0a from 10de found. Setting "noapic". Overwrite with "apic"
  >>> ERROR: Invalid checksum
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  <6>Product ID: L5D          <6>APIC at: 0xFEE00000
Processor #0 15:4 APIC version 16
I/O APIC #1 Version 17 at 0xFEC00000.
Processors: 1
Checking aperture...
CPU 0: aperture @ e8000000 size 128 MB
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hdc6 vga=792 resume=/dev/hdc3 pci=routeirq 
nmi_watchdog=0 console=ttyS0,57600
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1795.388 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 509288k/523520k available (2916k kernel code, 13684k reserved, 1152k 
data, 164k init)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 0a
ACPI: IRQ9 SCI: Edge set to Level Trigger.
Unable to handle kernel NULL pointer dereference at 0000000000000018 RIP:
<ffffffff80597e17>{setup_local_APIC+23}
PML4 0
Oops: 0000 [1] PREEMPT
CPU 0
Modules linked in:
Pid: 1, comm: swapper Tainted: G   M  2.6.9-rc3-mm2
RIP: 0010:[<ffffffff80597e17>] <ffffffff80597e17>{setup_local_APIC+23}
RSP: 0000:000001001fe13ef8  EFLAGS: 00010212
RAX: 0000000000000000 RBX: 0000000000040010 RCX: ffffffff805093e0
RDX: 0000000000000000 RSI: 0000000001000000 RDI: ffffffff803f2baf
RBP: 0000000000000010 R08: 000000000063999d R09: 0000000000000005
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff80583140(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000018 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo 000001001fe12000, task 000001001fe111b0)
Stack: 0000000000000000 0000000000000000 0000000000000000 ffffffff8059801b
       0000000000000001 0000000000000000 0000000000000800 ffffffff8010c0e5
       ffffffff804489a0 0000000000000800
Call Trace:<ffffffff8059801b>{APIC_init_uniprocessor+139} 
<ffffffff8010c0e5>{init+37}
       <ffffffff80111a23>{child_rip+8} <ffffffff8010c0c0>{init+0}
       <ffffffff80111a1b>{child_rip+0}

Code: ff 50 18 85 c0 75 0c 0f 0b ef 2c 3f 80 ff ff ff ff 4f 01 48
RIP <ffffffff80597e17>{setup_local_APIC+23} RSP <000001001fe13ef8>
CR2: 0000000000000018
 <0>Kernel panic - not syncing: Attempted to kill init!

At the same time, on a dual-Opteron box w/ NUMA the kernel starts just fine.

The one-processor .config for 2.6.9-rc3-mm2 is available at:
http://www.sisk.pl/kernel/041004/2.6.9-rc3-mm2-1CPU.config
The corresponding dual-CPU .config is available at:
http://www.sisk.pl/kernel/041004/2.6.9-rc3-mm2-NUMA.config

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
