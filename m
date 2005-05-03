Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVECV4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVECV4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 17:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVECV4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 17:56:30 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:36844 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S261834AbVECV4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 17:56:21 -0400
Subject: kernel BUG at fs/sysfs/file.c:381
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: iNES Group
Date: Wed, 04 May 2005 00:56:19 +0300
Message-Id: <1115157379.3441.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

While trying to install an PCI to PCMCIA adapter (an PCI card with an TI
cardbus bridge on it) I stumbled upon this kernel bug and captured it
with an serial console:

Linux version 2.6.11-1.1261_FC4 (bhcompile@decompose.build.redhat.com)
(gcc version 4.0.0 20050412 (Red Hat 4.0.0-0.42)) #1 Fri Apr 22 21:20:13
EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffc0000 (usable)
 BIOS-e820: 000000001ffc0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
Using x86 segment limits to approximate NX protection
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 20000000 (gap: 20000000:dfb80000)
Built 1 zonelists
Kernel command line: ro root=/dev/hda2 selinux=0 console=ttyS0,115200n8 
Initializing CPU#0
CPU 0 irqstacks, hard=c0454000 soft=c0453000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 731.217 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514360k/524032k available (2510k kernel code, 9072k reserved,
690k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e08)
checking if image is initramfs... it is
Freeing initrd memory: 394k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
------------[ cut here ]------------
kernel BUG at fs/sysfs/file.c:381!
invalid operand: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c01cea4b>]    Not tainted VLI
EFLAGS: 00010202   (2.6.11-1.1261_FC4) 
EIP is at sysfs_create_file+0x19/0x39
eax: dfe9c000   ebx: 00000000   ecx: c03e3148   edx: c03d4301
esi: c03d4370   edi: dfe9c148   ebp: 00000002   esp: c14d8e28
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c14d8000 task=c14d9aa0)
Stack: dfe9c0b4 dfe9c03c c02181ac dfe9c100 c038fffd 00000000 00000002
dfc524b8 
       dfc524b8 00000001 dfe9c148 00000001 c0218351 0000ffff dfe9c148
00040000 
       00000001 00000000 0340c148 dfc524b8 dfe9c148 dfe9c15c 00000001
c0218a2f 
Call Trace:
 [<c02181ac>] pci_alloc_child_bus+0x85/0xd8
 [<c0218351>] pci_scan_bridge+0xb0/0x22b
 [<c0218a2f>] pci_scan_child_bus+0x62/0x81
 [<c02184b4>] pci_scan_bridge+0x213/0x22b
 [<c0218a2f>] pci_scan_child_bus+0x62/0x81
 [<c0218be0>] pci_scan_bus_parented+0x17b/0x19b
 [<c02faaa0>] pcibios_scan_root+0x49/0x52
 [<c0247e45>] acpi_pci_root_add+0x198/0x1f7
 [<c024d535>] acpi_bus_driver_init+0x2c/0x88
 [<c024ddcf>] acpi_bus_find_driver+0x12b/0x249
 [<c024e37f>] acpi_bus_add+0x112/0x141
 [<c024e4af>] acpi_bus_scan+0x101/0x153
 [<c0436ff5>] acpi_scan_init+0x48/0x5e
 [<c04227e9>] do_initcalls+0x55/0xb1
 [<c018595e>] kern_mount+0x15/0x19
 [<c0100274>] init+0x0/0xfc
 [<c0100294>] init+0x20/0xfc
 [<c01012a8>] kernel_thread_helper+0x0/0xb
 [<c01012ad>] kernel_thread_helper+0x5/0xb
Code: 00 00 0f 8e b4 04 00 00 89 c8 83 c4 10 5b 5e 5f 5d c3 56 53 89 d6
85 c0 74 29 8b 58 30 85 db 0f 94 c2 85 f6 0f 94 c0 08 c2 74 08 <0f> 0b
7d 01 b6 93 38 c0 b9 04 00 00 00 89 f2 89 d8 5b 5e e9 57 
 <0>Kernel panic - not syncing: Attempted to kill init!
 [<c0120888>] panic+0x45/0x1e2
 [<c01225f0>] profile_task_exit+0x30/0x43
 [<c0124f05>] do_exit+0x4b4/0x510
 [<c010463e>] die+0x22c/0x2c4
 [<c01196ab>] fixup_exception+0xb/0x20
 [<c010490a>] do_invalid_op+0x0/0xab
 [<c01049ac>] do_invalid_op+0xa2/0xab
 [<c01cea4b>] sysfs_create_file+0x19/0x39
 [<c01cde38>] sysfs_get_dentry+0x5f/0x66
 [<c01cf204>] create_dir+0x158/0x3b6
 [<c0121cf8>] release_console_sem+0x96/0x26a
 [<c01cf4a6>] sysfs_create_dir+0x2c/0x68
 [<c020e7b1>] create_dir+0x13/0x37
 [<c0103c7b>] error_code+0x4f/0x54
 [<c01cea4b>] sysfs_create_file+0x19/0x39
 [<c02181ac>] pci_alloc_child_bus+0x85/0xd8
 [<c0218351>] pci_scan_bridge+0xb0/0x22b
 [<c0218a2f>] pci_scan_child_bus+0x62/0x81
 [<c02184b4>] pci_scan_bridge+0x213/0x22b
 [<c0218a2f>] pci_scan_child_bus+0x62/0x81
 [<c0218be0>] pci_scan_bus_parented+0x17b/0x19b
 [<c02faaa0>] pcibios_scan_root+0x49/0x52
 [<c0247e45>] acpi_pci_root_add+0x198/0x1f7
 [<c024d535>] acpi_bus_driver_init+0x2c/0x88
 [<c024ddcf>] acpi_bus_find_driver+0x12b/0x249
 [<c024e37f>] acpi_bus_add+0x112/0x141
 [<c024e4af>] acpi_bus_scan+0x101/0x153
 [<c0436ff5>] acpi_scan_init+0x48/0x5e
 [<c04227e9>] do_initcalls+0x55/0xb1
 [<c018595e>] kern_mount+0x15/0x19
 [<c0100274>] init+0x0/0xfc
 [<c0100294>] init+0x20/0xfc
 [<c01012a8>] kernel_thread_helper+0x0/0xb
 [<c01012ad>] kernel_thread_helper+0x5/0xb
 

I tried various kernel parameters (acpi=off, pci=routeirq,
pci=usepirqmask) but all give the same result.

Is there any workaround for this? 

-- 
Cioby


