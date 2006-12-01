Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934487AbWLAOi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934487AbWLAOi0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936458AbWLAOi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:38:26 -0500
Received: from dolly.gnuher.de ([212.227.64.154]:15821 "EHLO dolly.gnuher.de")
	by vger.kernel.org with ESMTP id S934487AbWLAOiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:38:25 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Sven Geggus <sven-im-usenet@gegg.us>
Subject: 2.6.19: nfs-related kernel NULL pointer dereference
Date: Fri, 1 Dec 2006 14:38:21 +0000 (UTC)
Organization: Geggus clan, virtual section
Message-ID: <ekpeot$caj$1@ultimate100.geggus.net>
NNTP-Posting-Host: ultimate100.geggus.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ultimate100.geggus.net 1164983901 12627 2001:8d8:81:672::1 (1 Dec 2006 14:38:21 GMT)
X-Complaints-To: usenet@geggus.net
NNTP-Posting-Date: Fri, 1 Dec 2006 14:38:21 +0000 (UTC)
Cancel-Lock: sha1:EG12IC0zl6FxfYYTtFUWyxcl9Qw=
X-TERMINAL: rxvt
X-OS: Debian GNU/Linux (Kernel 2.6.18.2-exsh)
User-Agent: tin/1.8.2-20060425 ("Shillay") (UNIX) (Linux/2.6.18.2-exsh (x86_64))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

while trying to boot Kernel 2.6.19 (vanilla+unionfs) I get the following
NULL pointer dereferences:

--cut--
Linux version 2.6.19-diskless (root@venus) (gcc-Version 3.3.5 (Debian 1:3.3.5-13)) #1 SMP PREEMPT Fri Dec 1 13:54:59 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f6f0000 (usable)
 BIOS-e820: 000000003f6f0000 - 000000003f6fb000 (ACPI data)
 BIOS-e820: 000000003f6fb000 - 000000003f700000 (ACPI NVS)
 BIOS-e820: 000000003f700000 - 000000003f780000 (usable)
 BIOS-e820: 000000003f780000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
119MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f73e0
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   259968
early_node_map[1] active PFN ranges
    0:        0 ->   259968
DMI present.
ACPI: PM-Timer IO Port: 0xf008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 2992.717 MHz processor.
Built 1 zonelists.  Total pages: 257937
Kernel command line: rw root=/dev/ram0 initrd=/initrd.cramfs vga=0x317 BOOT_IMAGE=/vmlinuz-test console=ttyS0,9600
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1025324k/1039872k available (2241k kernel code, 13804k reserved, 1107k data, 220k init, 122304k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc044b000 - 0xc0482000   ( 220 kB)
      .data : 0xc03307b3 - 0xc044542c   (1107 kB)
      .text : 0xc0100000 - 0xc03307b3   (2241 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5989.41 BogoMIPS (lpj=11978829)
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5985.45 BogoMIPS (lpj=11970919)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
Total of 2 processors activated (11974.87 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=126
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 952k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd987, last bus=3
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region f000-f07f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region f180-f1bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: Device [PS2M] status [00000008]: functional but not present; setting present
ACPI: Device [LPT] status [00000008]: functional but not present; setting present
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
intel_rng: FWH not detected
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:03.0
  IO window: 4000-4fff
  MEM window: e0100000-e01fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x69 set to 0x1
Machine check exception polling timer started.
cpufreq: No nForce2 chipset.
highmem bounce pool size: 64 pages
fuse init (API version 7.7)
Registering unionfs 1.5pre
unionfs: debugging is not enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xf0000000, mapped to 0xf8880000, using 3072k, total 8000k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
BIOS reported wrong ACPI idfor the processor
ACPI Exception (evxface-0545): AE_NOT_EXIST, Removing notify handler [20060707]
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0c: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 1 RAM disks of 4096K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 7.2.9-k4-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 16
e1000: 0000:02:01.0: e1000_probe: (PCI:33MHz:32-bit) 00:30:05:5a:45:fb
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
PNP: PS/2 Controller [PNP0303:KEYB] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting balanced_irq
Using IPI Shortcut mode
RAMDISK: cramfs filesystem found at block 0
Time: tsc clocksource has been installed.
RAMDISK: Loading 952KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 220k freed
Warning: unable to open an initial console.
Setting up loopback ... done
Setting up eth0 ... e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
10.1.7.38 done
Trying to reach network ... done
Getting hostname: ... terra
Mounting / (nfs) ... done
Mounting /var/etc (nfs) ... done
Mounting /var/lib/alsa (nfs) ... done
Mounting /var/lib/bluetooth (nfs) ... done
Mounting /var/spool/cron (nfs) ... done
Mounting /dev (tmpfs) ... done
Generating /local ... done
Generating /tmp ... done
INIT: version 2.86 booting
Mounting /etc (unionfs) ... doneBUG: unable to handle kernel NULL pointer dereference
Mounting /medi at virtual address 00000004
a (unionfs) ...  printing eip:
done
Mounting /c019a25d
root (unionfs) .*pde = 00000000
.. done
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c019a25d>]    Not tainted VLI
EFLAGS: 00010246   (2.6.19-diskless #1)
EIP is at nfs_lookup+0x14e/0x2ba
eax: 00000000   ebx: 00000000   ecx: f7e35a58   edx: f7efcd74
esi: 00000000   edi: f7efcd74   ebp: 00000000   esp: f7e35afc
ds: 007b   es: 007b   ss: 0068
Process rcS (pid: 942, ti=f7e34000 task=dff2c030 task.ti=f7e34000)
Stack: f7efcd74 c1986b00 f7e35ba0 f7e35b10 00000044 c0140006 c03b26d0 c03b2000 
       00000000 000200d0 00000044 c16f8320 00000001 000081ed 00000001 00000000 
       00000000 000017fa 00000000 00002000 00000000 00000000 00009300 00000000 
Call Trace:
 [<c0140006>] setup_irq+0x112/0x1a5
 [<c019ba81>] nfs_do_access+0x27/0x89
 [<c016fa3b>] d_lookup+0x25/0x48
 [<c016f5eb>] d_alloc+0x16a/0x173
 [<c0167127>] __lookup_hash+0x96/0xb2
 [<c01671c7>] lookup_one_len+0x64/0x71
 [<c01c28ca>] unionfs_lookup_backend+0x31e/0x6fd
 [<c0165cba>] real_lookup+0x61/0xda
 [<c0165f80>] do_lookup+0x67/0xb3
 [<c0166748>] __link_path_walk+0x77c/0xb98
 [<c0169124>] generic_readlink+0x76/0x82
 [<c0166bab>] link_path_walk+0x47/0xba
 [<c014e38b>] do_wp_page+0x398/0x3de
 [<c014f385>] __handle_mm_fault+0x229/0x288
 [<c016695b>] __link_path_walk+0x98f/0xb98
 [<c0166bab>] link_path_walk+0x47/0xba
 [<c014e38b>] do_wp_page+0x398/0x3de
 [<c014f385>] __handle_mm_fault+0x229/0x288
 [<c0166f3e>] do_path_lookup+0x18f/0x1ab
 [<c0167203>] __user_walk_fd+0x2f/0x4b
 [<c0161dd5>] vfs_stat_fd+0x1e/0x52
 [<c014e38b>] do_wp_page+0x398/0x3de
 [<c014f385>] __handle_mm_fault+0x229/0x288
 [<c0161e28>] vfs_stat+0x1f/0x23
 [<c01624db>] sys_stat64+0x18/0x31
 [<c01e03ca>] copy_to_user+0x44/0x4e
 [<c012caff>] sys_rt_sigprocmask+0xda/0xe9
 [<c0102cd7>] syscall_call+0x7/0xb
 [<c032007b>] csum_partial_copy_to_xdr+0xba/0x153
 =======================
Code: 4c 01 00 00 89 0c 24 83 c0 20 89 44 24 04 ff 52 20 83 f8 fe 0f 84 a1 00 00 00 85 c0 89 c5 0f 88 61 01 00 00 8b 94 24 48 01 00 00 <8b> 6b 04 8b 82 a4 00 00 00 8b 54 24 5c 8b b8 74 01 00 00 8b 44 
EIP: [<c019a25d>] nfs_lookup+0x14e/0x2ba SS:ESP 0068:f7e35afc
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c019a25d
*pde = 00000000
Oops: 0000 [#2]
PREEMPT SMP 
Modules linked in:
CPU:    1
EIP:    0060:[<c019a25d>]    Not tainted VLI
EFLAGS: 00010246   (2.6.19-diskless #1)
EIP is at nfs_lookup+0x14e/0x2ba
eax: 00000000   ebx: 00000000   ecx: dfe01ae8   edx: f7d871c4
esi: 00000000   edi: f7d871c4   ebp: 00000000   esp: dfe01b8c
ds: 007b   es: 007b   ss: 0068
Process init (pid: 1, ti=dfe00000 task=c18f5a90 task.ti=dfe00000)
Stack: f7d871c4 c1977d94 dfe01c30 dfe01ba0 c0119df6 c17f0006 00000001 00000000 
       dff6c030 c01122ed 00000001 000000fc 00000005 0000a1ff 00000001 00000000 
       00000000 00000021 00000000 00000000 00000000 00000000 00009300 00000000 
Call Trace:
 [<c0119df6>] activate_task+0x64/0xae
 [<c01122ed>] smp_send_reschedule+0x1e/0x22
 [<c011c18f>] __wake_up_common+0x3f/0x62
 [<c0110000>] speedstep_get_freqs+0x11b/0x13b
 [<c032da3e>] __up+0x1a/0x1c
 [<c016fa3b>] d_lookup+0x25/0x48
 [<c016f5eb>] d_alloc+0x16a/0x173
 [<c0167127>] __lookup_hash+0x96/0xb2
 [<c01671c7>] lookup_one_len+0x64/0x71
 [<c01c28ca>] unionfs_lookup_backend+0x31e/0x6fd
 [<c0165cba>] real_lookup+0x61/0xda
 [<c0165f80>] do_lookup+0x67/0xb3
 [<c0166748>] __link_path_walk+0x77c/0xb98
 [<c016fe0c>] _d_rehash+0x42/0x46
 [<c01733b9>] mntput_no_expire+0x1b/0x70
 [<c0166bab>] link_path_walk+0x47/0xba
 [<c014f251>] __handle_mm_fault+0xf5/0x288
 [<c015e3f6>] get_unused_fd+0xb2/0xbc
 [<c0166f3e>] do_path_lookup+0x18f/0x1ab
 [<c0166faf>] __path_lookup_intent_open+0x3f/0x6f
 [<c0167016>] path_lookup_open+0x37/0x3b
 [<c01677ea>] open_namei+0x9a/0x57d
 [<c0153745>] page_add_file_rmap+0x21/0x24
 [<c014efe9>] do_no_page+0x29b/0x2ce
 [<c015e1e2>] do_filp_open+0x3a/0x50
 [<c014f251>] __handle_mm_fault+0xf5/0x288
 [<c015e3f6>] get_unused_fd+0xb2/0xbc
 [<c015e4ef>] do_sys_open+0x57/0xf3
 [<c015e5b2>] sys_open+0x27/0x2b
 [<c0102cd7>] syscall_call+0x7/0xb
 [<c032007b>] csum_partial_copy_to_xdr+0xba/0x153
 =======================
Code: 4c 01 00 00 89 0c 24 83 c0 20 89 44 24 04 ff 52 20 83 f8 fe 0f 84 a1 00 00 00 85 c0 89 c5 0f 88 61 01 00 00 8b 94 24 48 01 00 00 <8b> 6b 04 8b 82 a4 00 00 00 8b 54 24 5c 8b b8 74 01 00 00 8b 44 
EIP: [<c019a25d>] nfs_lookup+0x14e/0x2ba SS:ESP 0068:dfe01b8c
 <0>Kernel panic - not syncing: Attempted to kill init!
--cut--

Regards

Sven 

-- 
"In my opinion MS is a lot better at making money than it is at making good
operating systems" (Linus Torvalds, August 1997)

/me is giggls@ircnet, http://sven.gegg.us/ on the Web
