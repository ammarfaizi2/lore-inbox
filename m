Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVFWVsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVFWVsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVFWVqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:46:04 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:44817 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S262732AbVFWVjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:39:00 -0400
Message-ID: <42BB2BE8.1050608@superbug.co.uk>
Date: Thu, 23 Jun 2005 22:38:48 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050416)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.demon.co.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: 2.6.12-rc6-mm1 oops on startup.
References: <42B46C18.2030101@superbug.demon.co.uk> <20050621235144.15fc55c6.akpm@osdl.org> <42BB0DBE.3070003@superbug.demon.co.uk>
In-Reply-To: <42BB0DBE.3070003@superbug.demon.co.uk>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010001000405010708070501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010001000405010708070501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

James Courtier-Dutton wrote:
> Andrew Morton wrote:
> 
>>James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
>>
>>
>>>I have used the kernel.org normal kernel, and it compiles and boots fine.
>>>I then use exactly the same .config file for the 2.6.12-rc6-mm1 and it
>>>fails to boot.
>>
>>
>>It's due to the fork notifier code.  Set CONFIG_FORK_CONNECTOR=n and you
>>should be OK.
>>
> 
> 
> 2.6.12-mm1 fails just like previous versions.
> 
> Setting "CONFIG_FORK_CONNECTOR=n" permitted me to boot the kernel, thank
> you.
> 
> James
> 

Ok, it now boots, but I now get a new problem.
after "modprobe yenta-socket", and then "cat /proc/iomem" I get the
attached kernel segfault.

Extract below:
Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c0126fc0
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: yenta_socket rsrc_nonstatic pcmcia_core usbcore
CPU:    0
EIP:    0060:[<c0126fc0>]    Not tainted VLI
EFLAGS: 00010297   (2.6.12-mm1)
EIP is at r_show+0x30/0x90
eax: 00000000   ebx: 00000008   ecx: 00000003   edx: c03ca87c
esi: f7fafaa8   edi: f4f7af78   ebp: f4fabf28   esp: f4fabef8
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 1750, threadinfo=f4faa000 task=f4f55af0)
Stack: f4f7af78 c0389e8b 00000000 c038d590 00000008 3fffc000 00000008
3fffffff
       c03883a3 00000000 f4f7af78 f7fafaa8 f4fabf60 c018b702 f4f7af78
f7fafaa8
       f4fabf44 000001a7 00000000 0000000d 00000000 0000000c 00000000
00000400
Call Trace:
 [<c01040df>] show_stack+0x7f/0xa0
 [<c0104284>] show_registers+0x164/0x1e0
 [<c01044cd>] die+0x10d/0x1a0
 [<c011749c>] do_page_fault+0x4bc/0x6b8
 [<c0103d0f>] error_code+0x4f/0x54
 [<c018b702>] seq_read+0x242/0x2f0
 [<c01667f3>] vfs_read+0xe3/0x1b0
 [<c0166bcb>] sys_read+0x4b/0x80
 [<c01031f9>] syscall_call+0x7/0xb
Code: 53 83 ec 24 8b 7d 08 8b 75 0c 8b 57 40 8b 42 08 3d 00 00 01 00 19
db 89 f0 83 e3 fc 31 c9 83 c3 08 8d 76 00 8d bc 27 00 00 00 00 <8b> 40
10 39 d0 74 06 41 83 f9 04 7e f3 8b 06 ba 85 9e 38 c0 85
 <3>Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c010411e>] dump_stack+0x1e/0x20
 [<c011dd22>] __might_sleep+0xa2/0xb0
 [<c0121901>] profile_task_exit+0x21/0x60
 [<c0123bdd>] do_exit+0x1d/0x490
 [<c0104554>] die+0x194/0x1a0
 [<c011749c>] do_page_fault+0x4bc/0x6b8
 [<c0103d0f>] error_code+0x4f/0x54
 [<c018b702>] seq_read+0x242/0x2f0
 [<c01667f3>] vfs_read+0xe3/0x1b0
 [<c0166bcb>] sys_read+0x4b/0x80
 [<c01031f9>] syscall_call+0x7/0xb
note: cat[1750] exited with preempt_count 1
scheduling while atomic: cat/0x10000001/1750
 [<c010411e>] dump_stack+0x1e/0x20
 [<c0374128>] schedule+0xa58/0xdf0
 [<c0374ddf>] cond_resched+0x2f/0x50
 [<c01553a9>] unmap_vmas+0x159/0x260
 [<c015a48c>] exit_mmap+0x9c/0x190
 [<c011e3d5>] mmput+0x55/0xf0
 [<c01231f1>] exit_mm+0xc1/0x180
 [<c0123c9a>] do_exit+0xda/0x490
 [<c0104554>] die+0x194/0x1a0
 [<c011749c>] do_page_fault+0x4bc/0x6b8
 [<c0103d0f>] error_code+0x4f/0x54
 [<c018b702>] seq_read+0x242/0x2f0
 [<c01667f3>] vfs_read+0xe3/0x1b0
 [<c0166bcb>] sys_read+0x4b/0x80
 [<c01031f9>] syscall_call+0x7/0xb



--------------010001000405010708070501
Content-Type: text/plain;
 name="dmesg-seg-fault"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-seg-fault"

Linux version 2.6.12-mm1 (root@new) (gcc version 3.4.4 (Gentoo 3.4.4, ssp-3.4.4-1.0, pie-8.7.8)) #2 SMP Thu Jun 23 20:21:49 BST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffd0000 (usable)
 BIOS-e820: 000000003ffd0000 - 000000003fff0c00 (reserved)
 BIOS-e820: 000000003fff0c00 - 000000003fffc000 (ACPI NVS)
 BIOS-e820: 000000003fffc000 - 0000000040000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262096
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32720 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f6f80
ACPI: RSDT (v001 HP     HP0890   0x23070420 CPQ  0x00000001) @ 0x3fff0c84
ACPI: FADT (v002 HP     HP0890   0x00000002 CPQ  0x00000001) @ 0x3fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000e) @ 0x3fff6f89
ACPI: DSDT (v001 HP       nc6000 0x00010000 MSFT 0x0100000e) @ 0x00000000
Allocating PCI resources starting at 40000000 (gap: 40000000:c0000000)
Built 1 zonelists
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01816000)
Initializing CPU#0
Kernel command line: BOOT_IMAGE=pxelinux.cfg/vmlinuz ip=dhcp root=/dev/nfs nfsroot=192.168.1.10:/u/netboot/root
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 598.138 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033496k/1048384k available (2522k kernel code, 14068k reserved, 945k data, 208k init, 130880k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1198.28 BogoMIPS (lpj=2396566)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9f9b7 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c00)
CPU0: Intel(R) Pentium(R) M processor 1.60GHz stepping 06
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
---------------------
| migration cost matrix (max_cache_size: 2097152, cpu: 598 MHz):
---------------------
          [00]
[00]:     -   
--------------------------------
| cacheflush times [1]: 0.0 (-1)
| calibration delay: 0 seconds
--------------------------------
softlockup thread 0 started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C045] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [8086/3340] 000600 00
PCI: Calling quirk c024dc40 for 0000:00:00.0
PCI: Calling quirk c047ab50 for 0000:00:00.0
PCI: Calling quirk c024e180 for 0000:00:00.0
PCI: Calling quirk c02ef1d0 for 0000:00:00.0
PCI: Calling quirk c02ef3f0 for 0000:00:00.0
PCI: Calling quirk c02ef5b0 for 0000:00:00.0
PCI: Found 0000:00:01.0 [8086/3341] 000604 01
PCI: Calling quirk c024dc40 for 0000:00:01.0
PCI: Calling quirk c024e180 for 0000:00:01.0
PCI: Calling quirk c02ef1d0 for 0000:00:01.0
PCI: Calling quirk c02ef3f0 for 0000:00:01.0
PCI: Calling quirk c02ef5b0 for 0000:00:01.0
PCI: Found 0000:00:1d.0 [8086/24c2] 000c03 00
PCI: Calling quirk c024dc40 for 0000:00:1d.0
PCI: Calling quirk c024e180 for 0000:00:1d.0
PCI: Calling quirk c02ef1d0 for 0000:00:1d.0
PCI: Calling quirk c02ef3f0 for 0000:00:1d.0
PCI: Calling quirk c02ef5b0 for 0000:00:1d.0
PCI: Found 0000:00:1d.1 [8086/24c4] 000c03 00
PCI: Calling quirk c024dc40 for 0000:00:1d.1
PCI: Calling quirk c024e180 for 0000:00:1d.1
PCI: Calling quirk c02ef1d0 for 0000:00:1d.1
PCI: Calling quirk c02ef3f0 for 0000:00:1d.1
PCI: Calling quirk c02ef5b0 for 0000:00:1d.1
PCI: Found 0000:00:1d.2 [8086/24c7] 000c03 00
PCI: Calling quirk c024dc40 for 0000:00:1d.2
PCI: Calling quirk c024e180 for 0000:00:1d.2
PCI: Calling quirk c02ef1d0 for 0000:00:1d.2
PCI: Calling quirk c02ef3f0 for 0000:00:1d.2
PCI: Calling quirk c02ef5b0 for 0000:00:1d.2
PCI: Found 0000:00:1d.7 [8086/24cd] 000c03 00
PCI: Calling quirk c024dc40 for 0000:00:1d.7
PCI: Calling quirk c024e180 for 0000:00:1d.7
PCI: Calling quirk c02ef1d0 for 0000:00:1d.7
PCI: Calling quirk c02ef3f0 for 0000:00:1d.7
PCI: Calling quirk c02ef5b0 for 0000:00:1d.7
PCI: Found 0000:00:1e.0 [8086/2448] 000604 01
PCI: Calling quirk c024dc40 for 0000:00:1e.0
PCI: Calling quirk c024e180 for 0000:00:1e.0
PCI: Calling quirk c02ef1d0 for 0000:00:1e.0
PCI: Calling quirk c02ef3f0 for 0000:00:1e.0
PCI: Calling quirk c02ef5b0 for 0000:00:1e.0
PCI: Found 0000:00:1f.0 [8086/24cc] 000601 00
PCI: Calling quirk c024d6a0 for 0000:00:1f.0
PCI: Calling quirk c024dc40 for 0000:00:1f.0
PCI: Calling quirk c047ad20 for 0000:00:1f.0
PCI: Enabled i801 SMBus device
PCI: Calling quirk c024e180 for 0000:00:1f.0
PCI: Calling quirk c02ef1d0 for 0000:00:1f.0
PCI: Calling quirk c02ef3f0 for 0000:00:1f.0
PCI: Calling quirk c02ef5b0 for 0000:00:1f.0
PCI: Found 0000:00:1f.1 [8086/24ca] 000101 00
PCI: Calling quirk c024dc40 for 0000:00:1f.1
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Calling quirk c024e180 for 0000:00:1f.1
PCI: Calling quirk c02ef1d0 for 0000:00:1f.1
PCI: Calling quirk c02ef3f0 for 0000:00:1f.1
PCI: Calling quirk c02ef5b0 for 0000:00:1f.1
PCI: Found 0000:00:1f.3 [8086/24c3] 000c05 00
PCI: Calling quirk c024dc40 for 0000:00:1f.3
PCI: Calling quirk c024e180 for 0000:00:1f.3
PCI: Calling quirk c02ef1d0 for 0000:00:1f.3
PCI: Calling quirk c02ef3f0 for 0000:00:1f.3
PCI: Calling quirk c02ef5b0 for 0000:00:1f.3
PCI: Found 0000:00:1f.5 [8086/24c5] 000401 00
PCI: Calling quirk c024dc40 for 0000:00:1f.5
PCI: Calling quirk c024e180 for 0000:00:1f.5
PCI: Calling quirk c02ef1d0 for 0000:00:1f.5
PCI: Calling quirk c02ef3f0 for 0000:00:1f.5
PCI: Calling quirk c02ef5b0 for 0000:00:1f.5
PCI: Found 0000:00:1f.6 [8086/24c6] 000703 00
PCI: Calling quirk c024dc40 for 0000:00:1f.6
PCI: Calling quirk c024e180 for 0000:00:1f.6
PCI: Calling quirk c02ef1d0 for 0000:00:1f.6
PCI: Calling quirk c02ef3f0 for 0000:00:1f.6
PCI: Calling quirk c02ef5b0 for 0000:00:1f.6
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 0
PCI: Scanning bus 0000:01
PCI: Found 0000:01:00.0 [1002/4e50] 000300 00
PCI: Calling quirk c024dc40 for 0000:01:00.0
PCI: Calling quirk c024e180 for 0000:01:00.0
PCI: Calling quirk c02ef1d0 for 0000:01:00.0
PCI: Calling quirk c02ef5b0 for 0000:01:00.0
Boot video device is 0000:01:00.0
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
PCI: Scanning behind PCI bridge 0000:00:1e.0, config 050200, pass 0
PCI: Scanning bus 0000:02
PCI: Found 0000:02:04.0 [168c/0013] 000200 00
PCI: Calling quirk c024dc40 for 0000:02:04.0
PCI: Calling quirk c024e180 for 0000:02:04.0
PCI: Calling quirk c02ef1d0 for 0000:02:04.0
PCI: Calling quirk c02ef5b0 for 0000:02:04.0
PCI: Found 0000:02:06.0 [1217/7223] 000607 02
PCI: Calling quirk c024dc40 for 0000:02:06.0
PCI: Calling quirk c024e180 for 0000:02:06.0
PCI: Calling quirk c02ef1d0 for 0000:02:06.0
PCI: Calling quirk c02ef5b0 for 0000:02:06.0
PCI: Found 0000:02:06.1 [1217/7223] 000607 02
PCI: Calling quirk c024dc40 for 0000:02:06.1
PCI: Calling quirk c024e180 for 0000:02:06.1
PCI: Calling quirk c02ef1d0 for 0000:02:06.1
PCI: Calling quirk c02ef5b0 for 0000:02:06.1
PCI: Found 0000:02:06.2 [1217/7110] 000880 00
PCI: Calling quirk c024dc40 for 0000:02:06.2
PCI: Calling quirk c024e180 for 0000:02:06.2
PCI: Calling quirk c02ef1d0 for 0000:02:06.2
PCI: Calling quirk c02ef5b0 for 0000:02:06.2
PCI: Found 0000:02:06.3 [1217/7223] 000607 02
PCI: Calling quirk c024dc40 for 0000:02:06.3
PCI: Calling quirk c024e180 for 0000:02:06.3
PCI: Calling quirk c02ef1d0 for 0000:02:06.3
PCI: Calling quirk c02ef5b0 for 0000:02:06.3
PCI: Found 0000:02:0e.0 [14e4/165e] 000200 00
PCI: Calling quirk c024dc40 for 0000:02:0e.0
PCI: Calling quirk c024e180 for 0000:02:0e.0
PCI: Calling quirk c02ef1d0 for 0000:02:0e.0
PCI: Calling quirk c02ef5b0 for 0000:02:0e.0
PCI: Fixups for bus 0000:02
PCI: Transparent bridge - 0000:00:1e.0
PCI: Scanning behind PCI bridge 0000:02:06.0, config 030302, pass 0
PCI: Scanning behind PCI bridge 0000:02:06.1, config 040402, pass 0
PCI: Scanning behind PCI bridge 0000:02:06.3, config 050502, pass 0
PCI: Scanning behind PCI bridge 0000:02:06.0, config 030302, pass 1
PCI: Scanning behind PCI bridge 0000:02:06.1, config 040402, pass 1
PCI: Scanning behind PCI bridge 0000:02:06.3, config 050502, pass 1
PCI: Bus scan for 0000:02 returning with max=0e
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 1
PCI: Scanning behind PCI bridge 0000:00:1e.0, config 0e0200, pass 1
PCI: Bus scan for 0000:00 returning with max=0e
ACPI: PCI Interrupt Routing Table [\_SB_.C045._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C045.C046._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C045.C057._PRT]
ACPI: Embedded Controller [C0E8] (gpe 16)
ACPI: Power Resource [C16E] (on)
ACPI: Power Resource [C13E] (on)
ACPI: Power Resource [C185] (on)
ACPI: Power Resource [C18C] (on)
ACPI: Power Resource [C196] (on)
ACPI: Power Resource [C0E7] (on)
ACPI: PCI Interrupt Link [C0C2] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0C3] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0C4] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0C5] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0C6] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0C7] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0C8] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C0C9] (IRQs *10 11)
ACPI: Power Resource [C202] (off)
ACPI: Power Resource [C203] (off)
ACPI: Power Resource [C204] (off)
ACPI: Power Resource [C205] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 16 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
  got res [47000000:470003ff] bus [47000000:470003ff] flags 200 for BAR 5 of 0000:00:1f.1
PCI: moved device 0000:00:1f.1 resource 5 (200) to 47000000
  got res [90320000:9033ffff] bus [90320000:9033ffff] flags 7202 for BAR 6 of 0000:01:00.0
PCI: moved device 0000:01:00.0 resource 6 (7202) to 90320000
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: 90300000-903fffff
  PREFETCH window: 98000000-9fffffff
  got res [46000000:4600ffff] bus [46000000:4600ffff] flags 7200 for BAR 6 of 0000:02:0e.0
PCI: moved device 0000:02:0e.0 resource 6 (7200) to 46000000
PCI: Bus 3, cardbus bridge: 0000:02:06.0
  IO window: 00004000-00004fff
  IO window: 00005000-00005fff
  PREFETCH window: 40000000-41ffffff
  MEM window: 40000000-41ffffff
PCI: Bus 7, cardbus bridge: 0000:02:06.1
  IO window: 00006000-00006fff
  IO window: 00007000-00007fff
  PREFETCH window: 42000000-43ffffff
  MEM window: 42000000-43ffffff
PCI: Bus 11, cardbus bridge: 0000:02:06.3
  IO window: 00008000-00008fff
  IO window: 00009000-00009fff
  PREFETCH window: 44000000-45ffffff
  MEM window: 44000000-45ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-9fff
  MEM window: 90000000-902fffff
  PREFETCH window: 40000000-46ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [C0C4] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [C0C4] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt 0000:02:06.1[A] -> Link [C0C4] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt 0000:02:06.3[A] -> Link [C0C4] -> GSI 10 (level, low) -> IRQ 10
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:00' and the driver 'system'
pnp: match found with the PnP device '00:0c' and the driver 'system'
pnp: match found with the PnP device '00:0d' and the driver 'system'
pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0d: ioport range 0x1000-0x107f could not be reserved
pnp: 00:0d: ioport range 0x1100-0x113f has been reserved
pnp: 00:0d: ioport range 0x1200-0x121f has been reserved
pnp: match found with the PnP device '00:0f' and the driver 'system'
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
inotify device minor=63
Initializing Cryptographic API
PCI: Calling quirk c024db10 for 0000:00:00.0
PCI: Calling quirk c024db10 for 0000:00:01.0
PCI: Calling quirk c024db10 for 0000:00:1d.0
PCI: Calling quirk c024db10 for 0000:00:1d.1
PCI: Calling quirk c024db10 for 0000:00:1d.2
PCI: Calling quirk c024db10 for 0000:00:1d.7
PCI: Calling quirk c024db10 for 0000:00:1e.0
PCI: Calling quirk c024db10 for 0000:00:1f.0
PCI: Calling quirk c024db10 for 0000:00:1f.1
PCI: Calling quirk c024db10 for 0000:00:1f.3
PCI: Calling quirk c024db10 for 0000:00:1f.5
PCI: Calling quirk c024db10 for 0000:00:1f.6
PCI: Calling quirk c024db10 for 0000:01:00.0
PCI: Calling quirk c024db10 for 0000:02:04.0
PCI: Calling quirk c024db10 for 0000:02:06.0
PCI: Calling quirk c024db10 for 0000:02:06.1
PCI: Calling quirk c024db10 for 0000:02:06.3
PCI: Calling quirk c024db10 for 0000:02:06.2
PCI: Calling quirk c024db10 for 0000:02:0e.0
ACPI: AC Adapter [C135] (off-line)
ACPI: Battery Slot [C138] (battery present)
ACPI: Battery Slot [C137] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C13A]
ACPI: Lid Switch [C139]
ACPI: Fan [C206] (off)
ACPI: Fan [C207] (off)
ACPI: Fan [C208] (off)
ACPI: Fan [C209] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random: RNG not detected
[drm] Initialized drm 1.0.0 20040925
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:0b' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303:C193,PNP0f13:C194] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:02' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [C0C3] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 11 (level, low) -> IRQ 11
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
tg3.c:v3.31 (June 8, 2005)
ACPI: PCI Interrupt Link [C0C6] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:0e.0[A] -> Link [C0C6] -> GSI 11 (level, low) -> IRQ 11
eth0: Tigon3 [partno(BMC5705mA3) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:0d:9d:91:74:15
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
eth0: dma_rwctrl[763f0000]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0C4] -> GSI 10 (level, low) -> IRQ 10
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x3c20-0x3c27, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x3c28-0x3c2f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HTS424030M9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4243N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1739KiB Cache, CHS=58140/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
TCP htcp registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Sending DHCP requests .<6>tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
., OK
IP-Config: Got DHCP answer from 192.168.1.10, my address is 192.168.1.215
IP-Config: Complete:
      device=eth0, addr=192.168.1.215, mask=255.255.255.0, gw=192.168.1.6,
     host=192.168.1.215, domain=home.com, nis-domain=(none),
     bootserver=192.168.1.10, rootserver=192.168.1.10, rootpath=
Looking up port of RPC 100003/2 on 192.168.1.10
Looking up port of RPC 100005/1 on 192.168.1.10
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 208k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [C0C4] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:06.0 [103c:0890]
yenta 0000:02:06.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:02:06.0: Preassigned resource 1 busy, reconfiguring...
Yenta O2: res at 0x94/0xD4: ea/00
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x00a8, PCI irq 10
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x9fff
cs: IO port probe 0x4000-0x9fff: clean.
pcmcia: parent PCI bridge Memory window: 0x90000000 - 0x902fffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x46ffffff
ACPI: PCI Interrupt 0000:02:06.1[A] -> Link [C0C4] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:06.1 [103c:0890]
yenta 0000:02:06.1: Preassigned resource 1 busy, reconfiguring...
Yenta: ISA IRQ mask 0x00a8, PCI irq 10
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x9fff
cs: IO port probe 0x4000-0x9fff: clean.
pcmcia: parent PCI bridge Memory window: 0x90000000 - 0x902fffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x46ffffff
ACPI: PCI Interrupt 0000:02:06.3[A] -> Link [C0C4] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:06.3 [103c:0890]
yenta 0000:02:06.3: Preassigned resource 1 busy, reconfiguring...
Yenta: ISA IRQ mask 0x00a8, PCI irq 10
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x9fff
cs: IO port probe 0x4000-0x9fff: clean.
pcmcia: parent PCI bridge Memory window: 0x90000000 - 0x902fffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x46ffffff
Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c0126fc0
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: yenta_socket rsrc_nonstatic pcmcia_core usbcore
CPU:    0
EIP:    0060:[<c0126fc0>]    Not tainted VLI
EFLAGS: 00010297   (2.6.12-mm1) 
EIP is at r_show+0x30/0x90
eax: 00000000   ebx: 00000008   ecx: 00000003   edx: c03ca87c
esi: f7fafaa8   edi: f4f7af78   ebp: f4fabf28   esp: f4fabef8
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 1750, threadinfo=f4faa000 task=f4f55af0)
Stack: f4f7af78 c0389e8b 00000000 c038d590 00000008 3fffc000 00000008 3fffffff 
       c03883a3 00000000 f4f7af78 f7fafaa8 f4fabf60 c018b702 f4f7af78 f7fafaa8 
       f4fabf44 000001a7 00000000 0000000d 00000000 0000000c 00000000 00000400 
Call Trace:
 [<c01040df>] show_stack+0x7f/0xa0
 [<c0104284>] show_registers+0x164/0x1e0
 [<c01044cd>] die+0x10d/0x1a0
 [<c011749c>] do_page_fault+0x4bc/0x6b8
 [<c0103d0f>] error_code+0x4f/0x54
 [<c018b702>] seq_read+0x242/0x2f0
 [<c01667f3>] vfs_read+0xe3/0x1b0
 [<c0166bcb>] sys_read+0x4b/0x80
 [<c01031f9>] syscall_call+0x7/0xb
Code: 53 83 ec 24 8b 7d 08 8b 75 0c 8b 57 40 8b 42 08 3d 00 00 01 00 19 db 89 f0 83 e3 fc 31 c9 83 c3 08 8d 76 00 8d bc 27 00 00 00 00 <8b> 40 10 39 d0 74 06 41 83 f9 04 7e f3 8b 06 ba 85 9e 38 c0 85 
 <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c010411e>] dump_stack+0x1e/0x20
 [<c011dd22>] __might_sleep+0xa2/0xb0
 [<c0121901>] profile_task_exit+0x21/0x60
 [<c0123bdd>] do_exit+0x1d/0x490
 [<c0104554>] die+0x194/0x1a0
 [<c011749c>] do_page_fault+0x4bc/0x6b8
 [<c0103d0f>] error_code+0x4f/0x54
 [<c018b702>] seq_read+0x242/0x2f0
 [<c01667f3>] vfs_read+0xe3/0x1b0
 [<c0166bcb>] sys_read+0x4b/0x80
 [<c01031f9>] syscall_call+0x7/0xb
note: cat[1750] exited with preempt_count 1
scheduling while atomic: cat/0x10000001/1750
 [<c010411e>] dump_stack+0x1e/0x20
 [<c0374128>] schedule+0xa58/0xdf0
 [<c0374ddf>] cond_resched+0x2f/0x50
 [<c01553a9>] unmap_vmas+0x159/0x260
 [<c015a48c>] exit_mmap+0x9c/0x190
 [<c011e3d5>] mmput+0x55/0xf0
 [<c01231f1>] exit_mm+0xc1/0x180
 [<c0123c9a>] do_exit+0xda/0x490
 [<c0104554>] die+0x194/0x1a0
 [<c011749c>] do_page_fault+0x4bc/0x6b8
 [<c0103d0f>] error_code+0x4f/0x54
 [<c018b702>] seq_read+0x242/0x2f0
 [<c01667f3>] vfs_read+0xe3/0x1b0
 [<c0166bcb>] sys_read+0x4b/0x80
 [<c01031f9>] syscall_call+0x7/0xb

--------------010001000405010708070501--
